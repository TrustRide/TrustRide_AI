package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.LOrderDTO;
import com.fastcampus.gearshift.dto.LOrderListDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class LOrderDaoImpl implements LOrderDao{

    @Autowired
    private SqlSessionTemplate session;
    private static String namespace = "com.fastcampus.gearshift.dao.LOrderMapper.";

    // 주문 정보 저장
    public int insertOrder(LOrderDTO orderDto){
        return session.insert(namespace+"insertOrder", orderDto);
    }

    // 마지막 주문 ID 조회
    public int getLastOrderId() {
        return session.selectOne(namespace + "getLastOrderId");
    }

    // 주문 목록 조회
    public List<LOrderListDTO>  getLOrderList(Integer userId) {
        return session.selectList(namespace + "getLOrderList", userId);
    }

    // 자동차 아이디 조회
    @Override
    public int selectCarInfo(Integer orderId) {
        return session.selectOne(namespace + "selectCarInfo", orderId);
    }

    // 상품 판매 후 판매완료 처리
    @Override
    public int updateOrder(Integer  carInfoId) {
        return session.update(namespace + "updateOrder", carInfoId);
    }

}
