package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.NOrderListDto;
import java.util.List;

public interface NOrderListDao {
    List<NOrderListDto> orderList();

    void updateDeliveryStatus(Integer orderId, String deliveryStatus);

}
