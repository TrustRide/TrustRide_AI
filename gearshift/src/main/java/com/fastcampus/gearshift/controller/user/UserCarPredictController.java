package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.CarPredictRequestDto;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.*;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.UUID;

@Slf4j
@Controller
public class UserCarPredictController {

    private final RestTemplate restTemplate;

    public UserCarPredictController() {
        this.restTemplate = new RestTemplate();
        this.restTemplate.getMessageConverters().add(0, new StringHttpMessageConverter(StandardCharsets.UTF_8));
    }

    @GetMapping("/carpredict")
    public String showForm(Model model) {
        model.addAttribute("request", new CarPredictRequestDto());
        return "user/carPredict";
    }

    @PostMapping("/carpredict")
    public String handlePrediction(
            @RequestParam("model_name") String modelName,
            @RequestParam("trim_summary") String trimSummary,
            @RequestParam("brand") String brand,
            @RequestParam("fuel_type") String fuelType,
            @RequestParam("vehicle_type") String vehicleType,
            @RequestParam("year") int year,
            @RequestParam("km_driven") int kmDriven,
            @RequestParam("file") MultipartFile file,
            Model model
    ) throws IOException {

        // ✅ 파일 이름: 고유 UUID + 원본 확장자 유지
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String filename = UUID.randomUUID().toString() + extension;

        log.info("저장된 파일명: " + filename);

        // ✅ C:/upload/ 경로에 저장
        String uploadPath = "C:/upload/";
        File destFile = new File(uploadPath + filename);
        file.transferTo(destFile);  // Spring이 저장

        //  FastAPI에 보낼 이미지 파일 byte
        byte[] imageBytes = java.nio.file.Files.readAllBytes(destFile.toPath());
        ByteArrayResource imageResource = new ByteArrayResource(imageBytes) {
            @Override
            public String getFilename() {
                return filename;
            }
        };

        //  FastAPI로 전송할 HTTP 요청 구성
        String fastApiUrl = "http://localhost:8000/carpredict";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        headers.setAcceptCharset(Collections.singletonList(StandardCharsets.UTF_8));

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("file", imageResource);
        body.add("model_name", modelName);          // 따로 전송
        body.add("trim_summary", trimSummary);      // 따로 전송
        body.add("brand", brand);
        body.add("fuel_type", fuelType);
        body.add("vehicle_type", vehicleType);
        body.add("year", year);
        body.add("km_driven", kmDriven);

        HttpEntity<MultiValueMap<String, Object>> httpEntity = new HttpEntity<>(body, headers);

        //  FastAPI 호출
        ResponseEntity<String> response = restTemplate.postForEntity(fastApiUrl, httpEntity, String.class);

        //  JSON 응답 파싱
        ObjectMapper mapper = new ObjectMapper();
        JsonNode json = mapper.readTree(response.getBody());

        String returnedFilename = json.get("filename").asText();
        int predictedPrice = json.get("predicted_price").asInt();
        String damageLevel = json.get("damage_level").asText();
        int priceLoss = json.get("price_loss").asInt();
        int finalPrice = json.get("final_price").asInt();
        String reason = json.has("deduction_reason") ? json.get("deduction_reason").asText() : "";
        String modelSummary = json.get("model_summary").asText();

        // 가격 단위를 만원 -> 원 단위로 변환
        predictedPrice *= 10000;
        priceLoss *= 10000;
        finalPrice *= 10000;

        // JSP로 전달
        model.addAttribute("filename", returnedFilename);
        model.addAttribute("predictedPrice", predictedPrice);
        model.addAttribute("damageLevel", damageLevel);
        model.addAttribute("priceLoss", priceLoss);
        model.addAttribute("finalPrice", finalPrice);
        model.addAttribute("deductionReason", reason);
        model.addAttribute("modelSummary", modelSummary);

        return "user/carPredictResult";
    }

    @GetMapping("/sellcar")
    public String showSellCarForm() {
        return "user/sellCar";
    }

}



