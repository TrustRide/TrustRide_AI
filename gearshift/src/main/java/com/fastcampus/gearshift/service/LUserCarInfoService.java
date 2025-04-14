package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.CarDetailDto;

public interface LUserCarInfoService {


    // 차량 정보 조회
    CarDetailDto getCarInfo(Integer carInfoId);
}
