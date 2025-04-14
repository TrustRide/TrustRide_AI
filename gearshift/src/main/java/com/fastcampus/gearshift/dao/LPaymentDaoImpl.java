package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.PaymentProcessDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LPaymentDaoImpl implements LPaymentDao{

    @Autowired
    private SqlSessionTemplate session;
    private static String namespace = "com.fastcampus.gearshift.dao.LPaymentMapper.";

    // 결제 정보 저장
    @Override
    public int insert(PaymentProcessDTO paymentProcessDTO) {

        return session.insert(namespace + "insert", paymentProcessDTO);
    }


}
