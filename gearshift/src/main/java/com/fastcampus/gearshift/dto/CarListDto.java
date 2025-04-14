package com.fastcampus.gearshift.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;


@Data
public class CarListDto {
    private Integer carInfoId;
    private String modelName;
    private String manufactureYear;
    private String mileage;
    private String fuelType;
    private Integer carPrice;

    private List<ImageDto> images;
    private String thumbnailUrl;
    private Integer thumbnailImageId;



    // 찜 여부 필드 추가
    private Boolean isWished;
}
