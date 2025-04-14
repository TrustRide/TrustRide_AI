package com.fastcampus.gearshift.dto;
import lombok.Data;

import java.util.List;


@Data
public class CarDetailDto {
    private Integer carInfoId;  // 자동차 정보 ID
    private String modelName;  // 모델명
    private String carNum;  // 차량 번호
    private String manufactureYear;  // 연식
    private String mileage;  // 주행 거리
    private String fuelType;  // 연료 종류
    private Integer carPrice;  // 차량 가격
    private Integer previousRegistrationFee;  // 이전 등록비
    private Integer maintenanceCost;  // 관리비용
    private Integer agencyFee;  // 등록신청대행
    private Integer deliveryFee;//배송비
    private Integer carAmountPrice;  // 총 차량 금액

    private List<ImageDto> images;
    
    private String ownershipType;
    private Boolean isJointOwnership;
    private String holderName;           // 명의자 이름
    private String holderPhoneNumber;    // 명의자 전화번호
    private String holderResident;        // 명의자 주민등록번호
    private String holderAddr1;          // 명의자 우편번호
    private String holderAddr2;          // 명의자 도로주소
    private String holderAddr3;          // 명의자 상세주소
    private String holderLicense;              // 면허 종류
    private String preferredDate;        // 희망 배송일
    private String deliveryRequest;     // 배송 요청 사항
    private String deliveryDriverName;   // 배송 기사 이름
    private String driverPhoneNumber; // 배송 기사 전화번호
    private String paymentMethod;     // 결제수단
    private Integer userId;           // 유저아이디

    public CarDetailDto(Integer carInfoId, String modelName, String carNum, String manufactureYear, String mileage, String fuelType, Integer carPrice, Integer previousRegistrationFee, Integer maintenanceCost, Integer agencyFee) {
        this.carInfoId = carInfoId;
        this.modelName = modelName;
        this.carNum = carNum;
        this.manufactureYear = manufactureYear;
        this.mileage = mileage;
        this.fuelType = fuelType;
        this.carPrice = carPrice;
        this.previousRegistrationFee = previousRegistrationFee;
        this.maintenanceCost = maintenanceCost;
        this.agencyFee = agencyFee;
    }

}
