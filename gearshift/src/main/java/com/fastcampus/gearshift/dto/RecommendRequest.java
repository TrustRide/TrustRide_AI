package com.fastcampus.gearshift.dto;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RecommendRequest {
    private String age;        // 연령대
    private String gender;     // 성별
    private String budget;     // 예산
    private String purpose;    // 사용 목적
    private String brand_type; // 브랜드 선호
}