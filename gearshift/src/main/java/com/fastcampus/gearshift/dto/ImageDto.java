package com.fastcampus.gearshift.dto;

import lombok.Data;

@Data
public class ImageDto {
    private Integer imageId;
    private String imageUuid;
    private String imageUrl;
    private String imageType;
    private Integer carInfoId;
    private Integer reviewId;
    private Integer inquiryId;

    private Boolean isThumbnail; // 썸네일 여부
}