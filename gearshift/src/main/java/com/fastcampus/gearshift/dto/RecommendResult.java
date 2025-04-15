package com.fastcampus.gearshift.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class RecommendResult {

    @JsonProperty("차종")
    private String carType;

    @JsonProperty("모델정보")
    private String modelInfo;

    @JsonProperty("이미지")
    private String imageUrl;

    @JsonProperty("상세링크")
    private String detailLink;

    @JsonProperty("가격")
    private int price;

}
