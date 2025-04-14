package com.fastcampus.gearshift.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class LRefundAbleListDTO {

    private String modelName;
    private Integer orderId;
    private String thumbnailImageUrl;   // 이미지 썸네일

}
