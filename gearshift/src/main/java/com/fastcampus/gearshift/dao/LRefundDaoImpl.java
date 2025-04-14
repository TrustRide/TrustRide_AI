package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.LRefundAbleListDTO;
import com.fastcampus.gearshift.dto.LRefundDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LRefundDaoImpl implements LRefundDao {

    @Autowired
    private SqlSessionTemplate session;
    private static String namespace = "com.fastcampus.gearshift.dao.LRefundMapper.";

    // 환불 가능 목록 조회
    @Override
    public List<LRefundAbleListDTO> getRefundAbleList(Integer userId) {
        return session.selectList(namespace + "getRefundAbleList", userId);
    }

    // 환불할 상품 상세 조회
    @Override
    public LRefundDTO selectRefundProduct(Integer orderId) {
        return session.selectOne(namespace + "selectRefundProduct", orderId);
    }

    // 선택한 상품 환불 등록
    @Override
    public int registerRefund(LRefundDTO refundDto) {
        return session.insert(namespace + "registerRefund", refundDto);
    }

    // 주문 테이블 수정
    @Override
    public int modifyOrder(LRefundDTO refundDto) {
        return session.update(namespace + "modifyOrder", refundDto);
    }

    // 환불 목록 조회
    @Override
    public List<LRefundDTO> getRefundList(Integer userId) {
        return  session.selectList(namespace + "getRefundList", userId);
    }
}
