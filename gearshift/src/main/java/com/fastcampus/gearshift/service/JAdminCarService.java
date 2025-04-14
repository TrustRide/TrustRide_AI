package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.CarDto;
import com.fastcampus.gearshift.dto.ImageDto;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface JAdminCarService {
    // 차량 목록 조회
    List<CarDto> getCarList();

    // 차량 등록 + 파일등록
    @Transactional
    void registerCarWithFiles(CarDto carDto, List<MultipartFile> imageFiles, Integer thumbnailIndex);

    // 차량 상세 조회
    CarDto getCarById(Integer carInfoId);

    // 차량 수정
    @Transactional
    void updateCar(CarDto carDto);

    // 차량 삭제
    @Transactional
    void deleteCar(Integer carInfoId);

;

}
