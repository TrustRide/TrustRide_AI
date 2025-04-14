package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.SOrderDto;

import java.util.List;

public interface SOrderService {

    List<SOrderDto> getCompletedOrdersWithReviewStatus(Integer userId);

}
