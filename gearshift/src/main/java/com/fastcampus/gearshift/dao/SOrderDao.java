package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.SOrderDto;

import java.util.List;

public interface SOrderDao {

    List<SOrderDto> selectCompletedOrdersWithReviewStatus(Integer userId);

}
