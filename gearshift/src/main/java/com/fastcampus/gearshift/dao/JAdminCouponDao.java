package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.CouponDto;

import java.util.List;

public interface JAdminCouponDao {
    // 쿠폰 생성
    int insertCoupon(CouponDto CouponDto);

    int updateCoupon(CouponDto CouponDto);

    int deleteCoupon(Integer couponId);

    CouponDto findById(Integer couponId);

    List<CouponDto> getAllCoupons();
}
