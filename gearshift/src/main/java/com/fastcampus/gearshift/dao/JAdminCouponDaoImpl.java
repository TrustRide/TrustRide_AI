package com.fastcampus.gearshift.dao;
import com.fastcampus.gearshift.dto.CouponDto;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class JAdminCouponDaoImpl implements JAdminCouponDao {

    private final SqlSessionTemplate sql;
    String namespace = "couponMapper."; // couponMapper.xml의 namespace와 동일하게

    // 쿠폰 생성
    @Override
    public int insertCoupon(CouponDto CouponDto) {
        return sql.insert(namespace + "insertCoupon", CouponDto);
    }

    // 쿠폰 수정

    @Override
    public int updateCoupon(CouponDto CouponDto) {
        return sql.update(namespace + "updateCoupon", CouponDto);
    }

    // 쿠폰 삭제

    @Override
    public int deleteCoupon(Integer couponId) {
        return sql.delete(namespace + "deleteCoupon", couponId);
    }

    // 쿠폰 단일 조회

    @Override
    public CouponDto findById(Integer couponId) {
        return sql.selectOne(namespace + "findById", couponId);
    }

    // 모든 쿠폰 조회

    @Override
    public List<CouponDto> getAllCoupons() {
        return sql.selectList(namespace + "findAll");
    }





}

