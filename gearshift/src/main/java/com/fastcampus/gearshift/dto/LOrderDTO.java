package com.fastcampus.gearshift.dto;

import lombok.Data;
import lombok.NoArgsConstructor;

// 주문
@Data
@NoArgsConstructor
public class LOrderDTO {

    private Integer orderId;            // 주문ID (PK)
    private Integer carInfoId;          // 상품 ID (PK)
    private Integer orderAmount;        // 주문 금액(필요)
    private Integer discountAmount;   // 할인된 금액
    private Integer totalAmount;      // 총 주문 가격 (할인 적용된 금액
    private String ownershipType;      // 소유유형
    private Boolean isJointOwnership; // 공동 명의 여부
    private String orderStatus;       // 주문상태
    private Integer userId;           // 유저 아이디
    private Integer holderId;         // 명의자 아이디
    private Integer carAmountPrice;   // 차량 총가격
    private String soldStatus;           // 판매상태


    public LOrderDTO (Integer carInfoId, Integer orderAmount, Integer discountAmount,
                 String ownershipType, Boolean isJointOwnership, String orderStatus, Integer userId, Integer holderId) {
        this.carInfoId = carInfoId;
        this.orderAmount = orderAmount;
        this.discountAmount = discountAmount;
        this.totalAmount = orderAmount + discountAmount; // 생성자에서 계산
        this.ownershipType = ownershipType;
        this.isJointOwnership = isJointOwnership;
        this.orderStatus = orderStatus;
        this.userId = userId;
        this.holderId = holderId;
    }
}
