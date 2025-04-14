package com.fastcampus.gearshift.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


import java.time.LocalDate;


@Getter
@Setter
@ToString
public class CouponDto {
    private Integer couponId;
    private String couponName;
    private Integer discountValue;
    private Integer minOrderAmount;
    private Integer discountAmount;
    private LocalDate startDate;
    private LocalDate endDate;
    private Boolean isActive;
}
