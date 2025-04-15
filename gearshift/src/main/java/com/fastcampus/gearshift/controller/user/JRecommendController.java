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
    private String pythonApiUrl;

    private final RestTemplate restTemplate = new RestTemplate();

    // 설문 폼
    @GetMapping("/survey/form")
    public String showSurveyForm() {
        return "user/surveyForm"; // JSP 경로
    }

    // 설문 폼 제출 → FastAPI로 추천 요청
    @PostMapping("/survey/submit")
    public String processSurvey(@ModelAttribute RecommendRequest form, Model model) {
        try {
            // 1. 요청 헤더
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

            // 2. 요청 바디 구성
            MultiValueMap<String, String> body = new LinkedMultiValueMap<>();
            body.add("brand_type", form.getBrand_type());
            body.add("budget", form.getBudget());
            body.add("purpose", form.getPurpose());
            body.add("passenger", form.getPassenger());
            body.add("year_preference", form.getYear_preference());

            HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(body, headers);

            // 3. FastAPI 호출
            ResponseEntity<String> response = restTemplate.exchange(
                    pythonApiUrl,
                    HttpMethod.POST,
                    requestEntity,
                    String.class
            );

            // 4. JSON 결과 파싱
            ObjectMapper mapper = new ObjectMapper();
            List<RecommendResult> resultList =
                    Arrays.asList(mapper.readValue(response.getBody(), RecommendResult[].class));

            // 5. 결과 뷰로 전달
            model.addAttribute("results", resultList);
            return "user/recommendResult"; // 결과 JSP

        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("results", Collections.emptyList());
            model.addAttribute("error", "추천 요청 중 오류가 발생했습니다.");
            return "user/recommendResult";
        }
    }
}
