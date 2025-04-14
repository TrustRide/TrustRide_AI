package com.fastcampus.gearshift.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

// 결제
@Data
@NoArgsConstructor
public class PaymentProcessDTO {

    private String paymentMethod;  //결제수단
    private int orderId;       // 주문아이디
    private String paymentStatus;  // 결제상태

    public PaymentProcessDTO(String paymentMethod) {

        this.paymentMethod = paymentMethod;

    }

}
