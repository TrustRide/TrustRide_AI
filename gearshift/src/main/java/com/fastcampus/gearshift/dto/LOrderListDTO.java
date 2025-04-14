package com.fastcampus.gearshift.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.Date;

@Data
public class LOrderListDTO {

    private String orderCompletedDate;  // 주문 완료 날짜
    private String carInfoId;           // pk
    private String modelName;           // 모델명
    private Integer totalAmount;          // 총 가격
    private String deliveryStatus;      // 배송 상태
    private String arrivalDate;         // 배송 도착 예정일
    private String arrivalDay;        // 배송 도착 요일
    private String thumbnailImageUrl;   // 이미지 썸네일
}
