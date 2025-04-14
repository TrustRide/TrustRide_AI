package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.CarDetailDto;

public interface LCarInfoDao {

    // 차량 정보 조회
    CarDetailDto getCarInfo(Integer carInfoId);
}
