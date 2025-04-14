package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.CategoryDto;
import com.fastcampus.gearshift.dto.LRefundAbleListDTO;
import com.fastcampus.gearshift.dto.LRefundDTO;

import java.util.List;

public interface LRefundService {

    // 환불 가능 목록 조회
    List<LRefundAbleListDTO> getRefundAbleList(Integer userId);

    // 환불할 상품 정보 상세 조회
    LRefundDTO selectRefundProduct(Integer orderId);

    // 선택한 상품 환불 등록
    int registerRefund(LRefundDTO refundDto);

    // 주문 정보 수정
    int modifyOrder(LRefundDTO refundDto);

    // 환불 신청 목록 조회
    List<LRefundDTO> getRefundList(Integer userId);

}
