package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.IssuedCouponDto;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class JIssuedCouponDaoImpl implements JIssuedCouponDao {

    private final SqlSessionTemplate sqlSession;
    private static final String NAMESPACE = "issuedCouponMapper.";

    /** 특정 사용자의 보유 쿠폰 목록 조회 */
    @Override
    public List<IssuedCouponDto> findByUserId(Integer userId) {
        return sqlSession.selectList(NAMESPACE + "findByUserId", userId);
    }

    /** 사용자가 특정 쿠폰을 사용 */
    @Override
    public int useIssuedCoupon(Integer issuedId, Integer userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("issuedId", issuedId);
        params.put("userId", userId);
        return sqlSession.update(NAMESPACE + "useIssuedCoupon", params);
    }

    /** 전체 사용자에게 선택된 쿠폰 지급 (일괄 INSERT) */
    @Override
    public void insertIssuedCoupons(List<IssuedCouponDto> issuedCoupons) {
        sqlSession.insert(NAMESPACE + "insertIssuedCoupons", issuedCoupons);
    }


    // 유저 전체 user_id값(PK)들을 조회 - 쿠폰발급을 위한것
    @Override
    public List<Integer> findAllUserIds() {
        return sqlSession.selectList(NAMESPACE + "findAllUserIds");
    }




}
