package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.IssuedCouponDto;

import java.util.List;

public interface JIssuedCouponDao {

    List<IssuedCouponDto> findByUserId(Integer userId);

    int useIssuedCoupon(Integer issuedId, Integer userId);

    void insertIssuedCoupons(List<IssuedCouponDto> issuedCoupons);

    List<Integer> findAllUserIds();

}
