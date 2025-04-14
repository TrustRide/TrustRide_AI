package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.NOrderListDto;
import java.util.List;

public interface NOrderListService {
    List<NOrderListDto> orderList();

    void updateDeliveryStatus(Integer orderId, String deliveryStatus);
}
