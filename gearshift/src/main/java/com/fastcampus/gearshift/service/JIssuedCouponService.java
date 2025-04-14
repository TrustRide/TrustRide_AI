package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.IssuedCouponDto;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface JIssuedCouponService {
    List<IssuedCouponDto> getUserCoupons(Integer userId);

    // 사용자가 특정 쿠폰을 사용
    @Transactional
    void useCoupon(Integer issuedId, Integer userId);

    @Transactional
    void issueCouponToAllUsers(Integer couponId);
}
