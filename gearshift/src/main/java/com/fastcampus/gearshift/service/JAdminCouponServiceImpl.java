package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.JAdminCouponDao;
import com.fastcampus.gearshift.dto.CouponDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class JAdminCouponServiceImpl implements JAdminCouponService {

    private final JAdminCouponDao jAdminCouponDao;

    // 쿠폰 생성
    @Override
    public int createCoupon(CouponDto CouponDto) {
        // 추가 검증 로직 등 필요 시 작성
        return jAdminCouponDao.insertCoupon(CouponDto);
    }

    // 쿠폰 수정
    @Override
    public int updateCoupon(CouponDto CouponDto) {
        return jAdminCouponDao.updateCoupon(CouponDto);
    }

    // 쿠폰 삭제
    @Override
    public int deleteCoupon(Integer couponId) {
        return jAdminCouponDao.deleteCoupon(couponId);
    }

    // 쿠폰 단일 조회
    @Override
    public CouponDto getCouponById(Integer couponId) {
        return jAdminCouponDao.findById(couponId);
    }

    // 쿠폰 전체 조회
    @Override
    public List<CouponDto> getAllCoupons() {
        return jAdminCouponDao.getAllCoupons();
    }


}
