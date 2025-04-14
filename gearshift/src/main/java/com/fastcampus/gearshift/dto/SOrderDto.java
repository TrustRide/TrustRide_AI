package com.fastcampus.gearshift.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;

//서하님과 겹칠 것 같아서 DTO명 이니셜로 구분하였습니다.
@Getter
@Setter
public class SOrderDto {
    private Integer orderId;
    private LocalDate orderCompletedDate;
    private Integer carInfoId;
    private String modelName;
    private String reviewStatus;
    private String carImageUrl;
    private ReviewDto review;
}
