package com.fastcampus.gearshift.controller.admin;

import com.fastcampus.gearshift.dto.NewsDto;
import com.fastcampus.gearshift.dto.NewsImageDto;
import com.fastcampus.gearshift.service.PHolderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

@Controller
@RequiredArgsConstructor
public class PNewsController {
    private final PHolderService pHolderService;

    @GetMapping("/news")
    public String write() {
        return "admin/newsRegister";
    }

    @PostMapping("/newsRegister")
    public String write(@ModelAttribute NewsDto newsDto,
                        @RequestParam("imageFiles") List<MultipartFile> imageFiles,
                        HttpSession session) throws Exception {

        // 1. 로그인한 사용자 ID (사용 안 하지만 참고용)
        String writer = (String) session.getAttribute("userId");

        // 2. 뉴스 저장
        int newsId = pHolderService.write(newsDto);

        // 3. 이미지 저장
        int index = 0;
        for (MultipartFile file : imageFiles) {
            if (!file.isEmpty()) {
                String imageUrl = saveImageToServer(file);
                boolean isThumbnail = (index == 0);
                pHolderService.saveNewsImage(newsId, imageUrl, isThumbnail);
                index++;
            }
        }

        //  4. FastAPI 벡터 DB 자동 삽입 요청
        sendNewsToFastAPI(newsId, newsDto.getNewsTitle(), newsDto.getNewsContent());

        return "redirect:/adminNewsList";
    }

    private String saveImageToServer(MultipartFile file) throws IOException {
        String uploadDir = "C:/upload/";
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path filePath = Paths.get(uploadDir + fileName);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        return "/upload/" + fileName;
    }

    private void sendNewsToFastAPI(int newsId, String title, String content) {
        try {
            String apiUrl = "http://localhost:8000/insert-news";
            String json = String.format(
                    "{\"news_id\": %d, \"news_title\": \"%s\", \"news_content\": \"%s\"}",
                    newsId,
                    title.replace("\"", "\\\""),
                    content.replace("\"", "\\\""));

            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(apiUrl))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(json))
                    .build();

            client.sendAsync(request, HttpResponse.BodyHandlers.ofString())
                    .thenAccept(response -> System.out.println(" FastAPI 응답: " + response.body()))
                    .exceptionally(e -> {
                        System.err.println(" FastAPI 요청 실패: " + e.getMessage());
                        return null;
                    });

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @GetMapping("/adminNewsList")
    public String newsList(Model model,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "9") int pageSize) {
        int offset = (page - 1) * pageSize;
        List<NewsDto> list = pHolderService.getPagedNewsList(offset, pageSize);
        int totalNewsCount = pHolderService.getNewsCount();
        int totalPages = (int) Math.ceil((double) totalNewsCount / pageSize);

        model.addAttribute("list", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "admin/adminNewsList";
    }

    @GetMapping("/adminNewsDetail")
    public String read(@RequestParam("newsId") Integer newsId, Model model) throws Exception {
        NewsDto newsDto = pHolderService.newsRead(newsId);
        List<NewsImageDto> imageList = pHolderService.getImagesByNewsId(newsId);

        model.addAttribute("newsDto", newsDto);
        model.addAttribute("imageList", imageList);
        return "admin/adminNewsDetail";
    }

    @GetMapping("/newsDelete")
    public String deleteNews(@RequestParam("newsId") Integer newsId) throws Exception {
        pHolderService.deleteNewsWithImages(newsId);
        return "redirect:/adminNewsList";
    }
}
