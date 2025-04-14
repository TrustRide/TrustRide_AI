package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.DeliveryDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LDeliveryDaoImpl implements LDeliveryDao {

    @Autowired
    private SqlSessionTemplate session;

    private static String namespace = "com.fastcampus.gearshift.dao.DeliveryMapper.";


    // 배송 정보 저장
    @Override
    public int insert(DeliveryDTO deliveryDTO) {
        return session.insert(namespace+"insert", deliveryDTO);

    }
}
