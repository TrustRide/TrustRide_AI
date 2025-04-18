package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.RecommendRequest;
import com.fastcampus.gearshift.dto.RecommendResult;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Slf4j
@Controller
@PropertySource("classpath:recommend.properties")
public class JRecommendController {

    @Value("${recommend.api.url}")
    private String pythonApiUrl;                 // e.g. http://localhost:8000/recommend

    private final RestTemplate restTemplate = new RestTemplate();

    /** 설문 폼 페이지 */
    @GetMapping("/survey/form")
    public String showSurveyForm() {
        return "user/surveyForm";
    }

    /** 설문 제출 → FastAPI 추천 요청 → 결과 JSP */
    @PostMapping("/survey/submit")
    public String processSurvey(@ModelAttribute RecommendRequest form, Model model) {

        try {
            /* 1) 헤더 */
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

            /* 2) 바디 (FastAPI가 요구하는 필드만) */
            MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
            body.add("age",        form.getAge());        // ✨ 추가
            body.add("gender",     form.getGender());     // ✨ 추가
            body.add("budget",     form.getBudget());
            body.add("purpose",    form.getPurpose());
            body.add("brand_type", form.getBrand_type());

            /* 3) 요청 */
            HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(body, headers);
            ResponseEntity<String> response = restTemplate.exchange(
                    pythonApiUrl, HttpMethod.POST, entity, String.class);

            /* 4) 결과 파싱 */
            ObjectMapper mapper = new ObjectMapper();
            List<RecommendResult> results = Arrays.asList(
                    mapper.readValue(response.getBody(), RecommendResult[].class));

            model.addAttribute("results", results);
            return "user/recommendResult";

        } catch (Exception e) {
            log.error("🚨 추천 요청 실패", e);
            model.addAttribute("results", Collections.emptyList());
            model.addAttribute("error", "추천 요청 중 오류가 발생했습니다.");
            return "user/recommendResult";
        }
    }
}
