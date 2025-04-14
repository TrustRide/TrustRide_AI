package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.JIssuedCouponDao;
import com.fastcampus.gearshift.dto.IssuedCouponDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class JIssuedCouponServiceImpl implements JIssuedCouponService {

    private final JIssuedCouponDao issuedCouponDAO;


//    private final JUserDao userDao; // (가정) 전체 유저 목록 조회용


    // 특정 사용자의 보유 쿠폰 목록 조회

    @Override
    public List<IssuedCouponDto> getUserCoupons(Integer userId) {
        return issuedCouponDAO.findByUserId(userId);
    }


    // 사용자가 특정 쿠폰을 사용
    @Transactional
    @Override
    public void useCoupon(Integer issuedId, Integer userId) {
        int updatedRows = issuedCouponDAO.useIssuedCoupon(issuedId, userId);
        if (updatedRows == 0) {
            throw new IllegalStateException("쿠폰 사용에 실패했습니다.");
        }
    }



    // (추가) 전체 사용자에게 선택된 쿠폰 발급
    // couponId를 받아서, 모든 유저에게 IssuedCouponDto 만들어 insert

    @Transactional
    @Override
    public void issueCouponToAllUsers(Integer couponId) {
        // 1) 전체 유저 ID 조회 (가정: userDao.findAllUserIds())
        List<Integer> allUserIds = issuedCouponDAO.findAllUserIds();

        System.out.println("allUserIds 전체 유저 ID 조회 = " + allUserIds);

        // 2) IssuedCouponDto 리스트 생성
        //    (issueDate/isUsed/usedDate는 DB에서 기본 처리)
        List<IssuedCouponDto> issuedCoupons = new ArrayList<>();
        for (Integer userId : allUserIds) {
            IssuedCouponDto dto = new IssuedCouponDto();
            dto.setCouponId(couponId);
            dto.setUserId(userId);
            // orderId, issueDate, usedDate, isUsed 등은 DB default 처리
            issuedCoupons.add(dto);
        }

        // 3) DAO 호출 (일괄 insert)
        issuedCouponDAO.insertIssuedCoupons(issuedCoupons);
    }


}

