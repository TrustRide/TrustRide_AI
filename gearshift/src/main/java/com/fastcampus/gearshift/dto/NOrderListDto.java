package com.fastcampus.gearshift.dto;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@RequiredArgsConstructor
@ToString
@AllArgsConstructor
public class NOrderListDto {
    private String userName;       // 회원 이름
    private Integer userId;        // 회원 코드
    private Integer orderId;       // 주문 코드
    private Integer totalPrice;    // 주문 가격
    private String orderStatus;    // 주문 상태
    private Date orderCompletedDate;   // 주문 일자 (order_completed_date)

    private String deliveryStatus;


}

