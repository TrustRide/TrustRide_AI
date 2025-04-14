package com.fastcampus.gearshift.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class IssuedCouponDto {
    private Integer issuedId;
    private Date issueDate;
    private Boolean isUsed;
    private Date usedDate;
    private Integer couponId;
    private Integer userId;

    // 추가 필드
    private String couponName;
    private Integer discountAmount;
    private Integer minOrderAmount;
}
