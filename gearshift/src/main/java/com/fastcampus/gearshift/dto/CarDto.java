package com.fastcampus.gearshift.dto;


import lombok.Data;
import java.util.List;

@Data
public class CarDto {
    // car_information 테이블의 컬럼 (CAR_INFORMATION Table Columns)
    private Integer carInfoId;  // 자동차 정보 ID (Primary Key, AUTO_INCREMENT)
    private String offerReportNumber;  // 제안 보고서 번호 (Offer Report Number)
    private String vinNumber;  // 차량 식별 번호 (Vehicle Identification Number, VIN)
    private String description;  // 차량 설명 (Car Description)
    private String soldStatus;  // 판매 여부

    // 카테고리 관련 정보 (코드 및 이름)
    private String largeCateCode;  // 대분류 코드 (INSERT용)

    private String largeCateName;  // 대분류 명 (조회용)

    private String mediumCateCode; // 중분류 코드 (INSERT용)

    private String mediumCateName; // 중분류 명 (조회용)

    private String smallCateCode;  // 소분류 코드 (INSERT용, 기존 cateCode 역할)

    private String smallCateName;  // 소분류 명 (조회용)

    // information 테이블의 컬럼 (INFORMATION Table Columns)
    private String modelName;  // 모델명 (Car Model Name)
    private String mileage;  // 주행 거리 (Mileage)
    private String engineCapacity;  // 엔진 배기량 (Engine Capacity)
    private String fuelType;  // 연료 종류 (Fuel Type: Gasoline, Diesel, etc.)
    private String transmission;  // 변속기 유형 (Transmission Type: Automatic, Manual)
    private String color;  // 차량 색상 (Car Color)
    private String manufactureYear;  // 제조 연도 (Manufacture Year)
    private Integer previousRegistrationFee;  // 이전 등록비 (Previous Registration Fee)
    private Integer maintenanceCost;  // 유지보수 비용 (Maintenance Cost)
    private Integer agencyFee;  // 등록대행수수료 (agency Fee)
    private String carLocation;  // 차량 위치 (Car Location)
    private Integer ownerChangeCount;  // 소유주 변경 횟수 (Owner Change Count)
    private Integer carPrice;  // 차량 가격 (Car Price)
    private String carNum;  // 차량 번호 (Car Number)
    private Integer carAmountPrice;  // 총 차량 금액 (Total Car Amount Price)

    // 이미지 리스트 (선택적으로 등록) (List of Car Images, optional)
    private List<ImageDto> images;

    // 썸네일
    private String thumbnailUrl;
    private Integer thumbnailImageId;

    // DB와 상관x 있어도 다른거에 영향x
    private Boolean isWished;

}
