package com.fastcampus.gearshift.dto;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RecommendRequest {
    private String brand_type;
    private String budget;
    private String purpose;
    private String passenger;
    private String year_preference;

    // getters, setters
}
