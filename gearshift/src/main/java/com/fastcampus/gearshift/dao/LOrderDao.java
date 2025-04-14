package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.LOrderDTO;
import com.fastcampus.gearshift.dto.LOrderListDTO;

import java.util.List;

public interface LOrderDao {

    // 주문 정보 저장
    int insertOrder(LOrderDTO orderDto);

    // 마지막 주문 ID 조회
    int getLastOrderId();

    // 주문 목록 조회
    List<LOrderListDTO> getLOrderList(Integer userId);

    // 자동차 아이디 조회
    int selectCarInfo(Integer orderId);

    // 판매된 제품 판매완료 처리
    int updateOrder(Integer carInfoId);
}
