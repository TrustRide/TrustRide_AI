package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.DeliveryDTO;

public interface LDeliveryDao {

    // 배송 정보 저장
    int insert(DeliveryDTO deliveryDTO);
}
