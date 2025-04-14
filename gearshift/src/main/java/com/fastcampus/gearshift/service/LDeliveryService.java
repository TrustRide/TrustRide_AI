package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.DeliveryDTO;

public interface LDeliveryService {

    // 배송 정보 저장
    int insert(DeliveryDTO deliveryDTO);
}
