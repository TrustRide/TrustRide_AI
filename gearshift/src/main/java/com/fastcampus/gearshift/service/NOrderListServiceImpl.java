package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.NOrderListDao;
import com.fastcampus.gearshift.dto.NOrderListDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NOrderListServiceImpl implements NOrderListService {

    @Autowired
    private NOrderListDao orderListDao;

    @Override
    public List<NOrderListDto> orderList() {
        return orderListDao.orderList();
    }

    public void updateDeliveryStatus(Integer orderId, String deliveryStatus){
        orderListDao.updateDeliveryStatus(orderId, deliveryStatus);
    };



}

