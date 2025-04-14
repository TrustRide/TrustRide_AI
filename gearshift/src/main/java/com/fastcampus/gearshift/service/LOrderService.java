package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.*;

import java.util.List;

public interface LOrderService {

    // 주문 정보 저장
    int insertOrder(LOrderDTO orderDto);

    // 가장 마지막에 저장된 orderId 가져오기
    int getLastOrderId();

    // 주문 목록 조회
    List<LOrderListDTO> getLOrderList(Integer userId);

    // 자동차 아이디 조회
    int selectCarInfo(Integer orderId);

    // 판매된 제품 판매완료 처리
    int updateOrder(Integer carInfoId);

    // 주문 처리
    void processCashOrder(LOrderDTO lOrderDTO, PaymentProcessDTO paymentProcessDTO, LHolderDTO lHolderDTO, DeliveryDTO deliveryDTO, Integer userId) throws Exception;
}
