package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.LRefundDao;
import com.fastcampus.gearshift.dto.LRefundAbleListDTO;
import com.fastcampus.gearshift.dto.LRefundDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LRefundServiceImpl implements LRefundService {

    @Autowired
    private LRefundDao refundDao;

    // 환불 가능 목록 조회
    @Override
    public List<LRefundAbleListDTO> getRefundAbleList(Integer userId) {
        return refundDao.getRefundAbleList(userId);
    }

    // 환불할 상품 상세 조회
    @Override
    public LRefundDTO selectRefundProduct(Integer orderId) {
        return refundDao.selectRefundProduct(orderId);
    }

    // 선택한 상품 환불 등록
    @Override
    public int registerRefund(LRefundDTO refundDto) {

        refundDto.setRefundStatus("환불대기중");
        return refundDao.registerRefund(refundDto);
    }

    // 주문 정보 수정
    @Override
    public int modifyOrder(LRefundDTO refundDto) {
        return refundDao.modifyOrder(refundDto);
    }

    // 환불 목록 조회
    @Override
    public List<LRefundDTO> getRefundList(Integer userId) {
        return refundDao.getRefundList(userId);
    }
}
