package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.CarDto;
import com.fastcampus.gearshift.dto.ImageDto;

import java.util.List;

public interface JAdminCarDao {
    List<CarDto> getCarList();

    void insertCarInformation(CarDto carDto);

    void insertCarBasicInfo(CarDto carDto);

    void insertCarImage(ImageDto carImageDto);

    // ================================
    //         추가된 부분
    // ================================
    CarDto getCarById(Integer carInfoId);

    void updateCarInformation(CarDto carDto);

    void updateCarBasicInfo(CarDto carDto);

    void deleteCar(Integer carInfoId);

    ImageDto getThumbnailByCarId(Integer carInfoId);

}
