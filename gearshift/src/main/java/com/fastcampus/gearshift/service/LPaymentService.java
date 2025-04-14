package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.PaymentProcessDTO;

public interface LPaymentService {

    // 결제 정보 저장
    int insert(PaymentProcessDTO paymentProcessDTO);
}
