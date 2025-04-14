package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.SOrderDao;
import com.fastcampus.gearshift.dto.SOrderDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SOrderServiceImpl implements SOrderService {

    @Autowired
    SOrderDao orderDao;

    @Override
    public List<SOrderDto> getCompletedOrdersWithReviewStatus(Integer userId) {
        return orderDao.selectCompletedOrdersWithReviewStatus(userId);
    }

}
