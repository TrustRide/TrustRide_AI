package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.CarDetailDto;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LCarInfoDaoImpl implements LCarInfoDao {

    @Autowired
    private SqlSessionTemplate session;
    private static String namespace = "com.fastcampus.gearshift.dao.CarInfoMapper.";


    // 차량 정보 조회
    @Override
    public CarDetailDto getCarInfo(Integer carInfoId) {

        return session.selectOne(namespace + "getCarInfo", carInfoId);
    }


}
