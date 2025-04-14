package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.PHolderDao;
import com.fastcampus.gearshift.dto.CarDto;
import com.fastcampus.gearshift.dto.CarInfoDto;
import com.fastcampus.gearshift.dto.CarListDto;
import com.fastcampus.gearshift.dto.UserDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class  PHolderServiceImpl implements PHolderService {


    private final PHolderDao pHolderDao;


    @Override
    public UserDto read(Integer userId) throws Exception {
        UserDto userDto = pHolderDao.select(userId);
        return userDto;
    }


    //차량 리스트 조회
    @Override
    public List<CarListDto> carSelect() {
        return pHolderDao.carSelect();
    }

    //상품 조회
    @Override
    public CarInfoDto carDetailSelect(Integer carInfoId) throws Exception {
        CarInfoDto carInfoDto = pHolderDao.carDetailSelect(carInfoId);
        return carInfoDto;
    }


    //유저 조회
    @Override
    public UserDto userSelect(Integer userId) throws Exception {
        UserDto userDto =pHolderDao.userSelect(userId);
        return userDto;
    }

    // 제목 검색
    @Override
    public List<CarListDto> searchCarsByTitle(String title) throws Exception {
        return pHolderDao.searchCarsByTitle(title);
    }


    // 자동차 조회 페이징
    @Override
    public List<CarListDto> carPageSelect(int page, int pageSize) throws Exception {
        int offset = (page -1) * pageSize;

        return pHolderDao.carPageSelect(offset,pageSize);
    }

    //상품 개수
    @Override
    public int getCarCount() throws Exception {
        return pHolderDao.getCarCount();
    }


    @Override
    public List<CarListDto> carselectByCate(String cateCode, int page, int pageSize) {

        System.out.println("cateCode 서비스 = " + cateCode);

        int offset = (page - 1) * pageSize;
        return pHolderDao.carselectByCate(cateCode, offset, pageSize);
    }

    @Override
    public int getCarCountByCate(String cateCode) {
        return pHolderDao.getCarCountByCate(cateCode);
    }


}
