package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.LPaymentDao;
import com.fastcampus.gearshift.dto.PaymentProcessDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class LPaymentServiceImpl implements LPaymentService {

    @Autowired
    LPaymentDao paymentDao;

    // 결제 정보 저장
    @Override
    public int insert(PaymentProcessDTO paymentProcessDTO) {

        paymentProcessDTO.setPaymentStatus("결제완료");  // 결제상태 세팅

        return paymentDao.insert(paymentProcessDTO);
    }
}
