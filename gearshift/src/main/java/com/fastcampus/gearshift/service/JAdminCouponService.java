package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.CouponDto;

import java.util.List;

public interface JAdminCouponService {
    // 쿠폰 생성
    int createCoupon(CouponDto CouponDto);

    // 쿠폰 수정
    int updateCoupon(CouponDto CouponDto);

    // 쿠폰 삭제
    int deleteCoupon(Integer couponId);

    // 쿠폰 단일 조회
    CouponDto getCouponById(Integer couponId);

    // 쿠폰 전체 조회
    List<CouponDto> getAllCoupons();
}
