package com.fastcampus.gearshift.controller.admin;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@Slf4j
@Controller
public class BAdController {

    @Value("${ad.api.url:http://localhost:8000/generate_ad}")
    private String apiUrl;

    private final RestTemplate restTemplate = new RestTemplate();

    @GetMapping("/admin/carAd")
    public String showAdForm(){
       return "admin/carAdForm";
    }
    @PostMapping("/ad/generate")
    public String generateAd(@RequestParam String keyword,
                             @RequestParam String category,
                             Model model) {

        try {
            // 1. 요청 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

            // 2. 요청 바디 설정
            MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
            body.add("keyword", keyword);
            body.add("category", category);

            // 3. 요청 객체 생성
            HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(body, headers);

            // 4. FastAPI 호출
            ResponseEntity<Map> response = restTemplate.postForEntity(apiUrl, request, Map.class);

            if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
                String adText = (String) response.getBody().getOrDefault("ad_text", "문구 없음");
                model.addAttribute("result", adText);
            } else {
                model.addAttribute("result", "⚠️ 서버 응답 오류");
            }

        } catch (Exception e) {
            log.error("광고 문구 생성 오류", e);
            model.addAttribute("result", "🚨 광고 문구 생성 중 오류가 발생했습니다.");
        }

        return "admin/carAdForm"; // JSP 파일 위치
    }
}
