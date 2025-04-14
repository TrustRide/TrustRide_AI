package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.CarDto;
import com.fastcampus.gearshift.dto.CarInfoDto;
import com.fastcampus.gearshift.dto.CarListDto;
import com.fastcampus.gearshift.dto.UserDto;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class PHolderDaoImpl implements  PHolderDao {


    private final SqlSession session;
    private static final String namespace = "com.fastcampus.gearshift.";



    @Override
    public UserDto select(Integer userId) throws Exception {
        return session.selectOne(namespace+"select",userId);
    }


    // 차량 목록 조회
    @Override
    public List<CarListDto> carSelect() {
        return session.selectList(namespace+"selectList");
    }


    // 차량 상세 조회
    @Override
    public CarInfoDto carDetailSelect(Integer carInfoId) throws Exception {
        return session.selectOne(namespace+"carSelect",carInfoId);
    }

    // 유저 정보 조회
    @Override
    public UserDto userSelect(Integer userId) throws Exception {
        return session.selectOne(namespace+"userSelect",userId);
    }


    //메인화면 검색
    @Override
    public List<CarListDto> searchCarsByTitle(String title) throws Exception {
        return session.selectList(namespace+"searchCarsByTitle","%"+title+"%");
    }


    //리스트 조회 페이징
    @Override
    public List<CarListDto> carPageSelect(int offset, int pageSize) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return session.selectList(namespace + "selectList", params);
    }
    // 수량 조회
    @Override
    public int getCarCount() {
        return session.selectOne(namespace+"getCarCount");
    }


    @Override
    public List<CarListDto> carselectByCate(String cateCode, int offset, int pageSize) {


        Map<String, Object> params = new HashMap<>();
        params.put("cateCode", cateCode);
        params.put("offset", offset);
        params.put("pageSize", pageSize);
        return session.selectList(namespace + "selectListByCate", params);

    }

    @Override
    public int getCarCountByCate(String cateCode) {
        return session.selectOne(namespace + "getCarCountByCate", cateCode);

    }



}

