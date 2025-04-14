package com.fastcampus.gearshift.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PaymentDTO {

    private String paymentMethod;  //결제수단
    private String modelName; // 차량 모델명
    private String carNum;   // 차량 번호판
    private String manufactureYear;  // 연식
    private String mileage;          // 주행거리
    private String fuelType;         // 연료타입
    private Integer carPrice;           // 차량 가격
    private Integer previousRegistrationFee;    // 이전등록비
    private Integer maintenanceCost;    // 관리비용
    private Integer deliveryFee;        // 배송비
    private String driverPhoneNumber;   // 배송기사 전화번호
    private String deliveryRequest;     // 배송 요청 사항
    private String preferredDate;       // 희망 배송일
    private String deliveryDriverName;  // 배송기사 이름
    private Integer carAmountPrice;     // 차량 총가격
    private String imageUrl;        // 이미지 경로
    private Integer userId;         // 유저 아이디

}
