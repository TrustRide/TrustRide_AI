package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.LCarInfoDao;
import com.fastcampus.gearshift.dto.CarDetailDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LUserCarInfoServiceImpl implements LUserCarInfoService {

    @Autowired
    private LCarInfoDao carInfoDao;

    @Override
    public CarDetailDto getCarInfo(Integer carInfoId) {

        CarDetailDto carInfo = carInfoDao.getCarInfo(carInfoId);

        int totalPrice = carInfo.getCarPrice()
                + carInfo.getPreviousRegistrationFee()
                + carInfo.getAgencyFee()
                + 0;

        carInfo.setCarAmountPrice(totalPrice);

        return carInfo;

    }
}
