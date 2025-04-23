
package com.fastcampus.gearshift.dto;

import lombok.Data;

@Data
public class CarPredictRequestDto {
    private String model_name;
    private String trim_summary;
    private String brand;
    private String fuel_type;
    private String vehicle_type;
    private int year;
    private int km_driven;

    // Getter/Setter 자동 생성됨 (Lombok @Data)
}

