package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.CarDto;
import com.fastcampus.gearshift.dto.CarInfoDto;
import com.fastcampus.gearshift.dto.CarListDto;
import com.fastcampus.gearshift.dto.UserDto;

import java.util.List;

public interface PHolderService {
    UserDto read(Integer userId) throws Exception;

    //차량 리스트 조회
    List<CarListDto> carSelect();

    // 차량 조회
    CarInfoDto carDetailSelect(Integer carInfoId) throws Exception;

    //유저 조회
    UserDto userSelect(Integer userId) throws Exception;

    //제목 검색
    List<CarListDto> searchCarsByTitle(String title) throws Exception;

    //페이징 관련 기능
    List<CarListDto> carPageSelect(int page, int pageSize) throws Exception;
    //전체 갯수 조회
    int getCarCount() throws Exception; //전체 차량 개수 조회

    List<CarListDto> carselectByCate(String cateCode, int page, int pageSize);

    int getCarCountByCate(String cateCode);
}
