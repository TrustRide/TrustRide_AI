package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.LDeliveryDao;
import com.fastcampus.gearshift.dto.DeliveryDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LDeliveryServiceImpl implements LDeliveryService {

    @Autowired
    LDeliveryDao deliveryDao;

    // 배송 정보 저장
    @Override
    public int insert(DeliveryDTO deliveryDTO) {

        deliveryDTO.setDeliveryStatus("배송준비중");   // 배송상태 세팅

        return deliveryDao.insert(deliveryDTO);
    }
}
