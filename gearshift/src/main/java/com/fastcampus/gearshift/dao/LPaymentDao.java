package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.PaymentProcessDTO;

public interface LPaymentDao {

    // 결제 정보 저장
    int insert(PaymentProcessDTO paymentProcessDTO);
}
