package com.fastcampus.gearshift.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

// 배송
@Data
@NoArgsConstructor
public class DeliveryDTO {

    private Integer deliveryFee; // 배송비
    private String driverPhoneNumber; // 배송기사 전화번호
    private String deliveryRequest;      // 배송요청 사항
    private String preferredDate; // 희망배송일
    private String deliveryDriverName; // 배송기사 이름
    private Integer orderId;           // 주문 번호
    private String deliveryStatus; // 배송상태

    public DeliveryDTO(Integer deliveryFee, String driverPhoneNumber, String deliveryRequest, String preferredDate, String deliveryDriverName) {
        this.deliveryFee = deliveryFee;
        this.driverPhoneNumber = driverPhoneNumber;
        this.deliveryRequest = deliveryRequest;
        this.preferredDate = preferredDate;
        this.deliveryDriverName = deliveryDriverName;
    }


}
