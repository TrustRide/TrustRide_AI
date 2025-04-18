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
    public String write(){
        return "admin/newsRegister";
    }


    @PostMapping("/newsRegister")
    public String write(@ModelAttribute NewsDto newsDto,
                        @RequestParam("imageFiles") List<MultipartFile> imageFiles,
                        HttpSession session) throws Exception {

        // 1. 로그인한 사용자 ID (필요 시 사용)
        String writer = (String) session.getAttribute("userId");

        // 2. 뉴스 저장 → newsId 자동 생성 후 반환됨
        int newsId = pHolderService.write(newsDto); // insert 후 newsDto에 newsId가 세팅됨

        // 3. 이미지 저장
        int index = 0;
        for (MultipartFile file : imageFiles) {
            if (!file.isEmpty()) {
                String imageUrl = saveImageToServer(file); // 파일 시스템 저장
                boolean isThumbnail = (index == 0); // 썸네일
                pHolderService.saveNewsImage(newsId, imageUrl, isThumbnail); // DB 저장
                index++;
            }
        }

        return "redirect:/adminNewsList";
    }



    private String saveImageToServer(MultipartFile file) throws IOException {
        String uploadDir = "C:/upload/"; // 저장 경로
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs(); // 디렉토리 없으면 생성
        }

        // 고유한 파일 이름 생성
        String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path filePath = Paths.get(uploadDir + fileName);

        // 파일 저장
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        // 클라이언트에서 접근 가능한 경로 리턴
        return "/upload/" + fileName;
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
    //상세 조회
    @GetMapping("/adminNewsDetail")
    public String read(@RequestParam("newsId") Integer newsId, Model model) throws Exception {
        NewsDto newsDto = pHolderService.newsRead(newsId);
        List<NewsImageDto> imageList = pHolderService.getImagesByNewsId(newsId); // ✅ 다중 이미지 조회

        model.addAttribute("newsDto", newsDto);
        model.addAttribute("imageList", imageList);

        return "admin/adminNewsDetail";
    }

    @GetMapping("/newsDelete")
    public String deleteNews(@RequestParam("newsId") Integer newsId) throws Exception{
        pHolderService.deleteNewsWithImages(newsId);
        return "redirect:/adminNewsList";
    }
}
