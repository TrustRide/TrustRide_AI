package com.fastcampus.gearshift.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RecommendResult {

    @JsonProperty("차종")   // JSON에서 "차종" → 여기에 맵핑
    private String carType;

    @JsonProperty("모델정보")  // JSON에서 "모델정보" → 여기에 맵핑
    private String modelInfo;

    @JsonProperty("이미지")  // JSON에서 "이미지" → 여기에 맵핑
    private String imageUrl;

    @JsonProperty("상세링크")  // JSON에서 "상세링크" → 여기에 맵핑
    private String detailLink;

    @JsonProperty("가격")   // JSON에서 "가격" → 여기에 맵핑
    private int price;

}
