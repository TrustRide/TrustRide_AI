package com.fastcampus.gearshift.dto;

import lombok.*;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CarInfoDto {

    private Integer carInfoId;  // 자동차 정보 ID (Primary Key, AUTO_INCREMENT)
    private String modelName;  // 모델명 (Car Model Name)
    private String carNum;  // 차량 번호 (Car Number)
    private String manufactureYear;  // 제조 연도 (Manufacture Year)
    private String mileage;  // 주행 거리 (Mileage)
    private String fuelType;  // 연료 종류 (Fuel Type: Gasoline, Diesel, etc.)
    private String engineCapacity;  // 엔진 배기량 (Engine Capacity)
    private String transmission;  // 변속기 유형 (Transmission Type: Automatic, Manual)
    private String color;  // 차량 색상 (Car Color)
    private Integer carPrice;  // 차량 가격 (Car Price)
    private Integer previousRegistrationFee; // 이전 등록비 (Previous Registration Fee)
    private Integer maintenanceCost;  // 유지보수 비용 (Maintenance Cost)
    private Integer agencyFee;  // 등록대행수수료 (agency Fee)
    private Integer carAmountPrice;  // 총 차량 금액 (Total Car Amount Price)
    private List<ImageDto> images;
    private String description;  // 차량 설명 (Car Description)
    private String offerReportNumber;  // 제안 보고서 번호 (Offer Report Number)
    private String vinNumber;  // 차량 식별 번호 (Vehicle Identification Number, VIN)
    private Integer deliveryFee;//배송비
    private String ownershipType;// 명의자 타입
    private Boolean isJointOwnership;//명의자 불리언
    private String carLocation;//차량 위치

    // DB와 상관x 있어도 다른거에 영향x
    private Boolean isWished;





    public void setDeliveryFee(Integer deliveryFee) {
        this.deliveryFee = 0;
    }


}
