package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.CarDto;
import com.fastcampus.gearshift.dto.ImageDto;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class JAdminCarDaoImpl implements JAdminCarDao {

    private final SqlSessionTemplate sqlSession;
    private static final String namespace = "carMapper.";

    @Override
    public List<CarDto> getCarList() {
        return sqlSession.selectList(namespace + "getCarList");
    }

    @Override
    public void insertCarInformation(CarDto carDto) {
        sqlSession.insert(namespace + "insertCarInformation", carDto);
    }

    @Override
    public void insertCarBasicInfo(CarDto carDto) {
        sqlSession.insert(namespace + "insertCarBasicInfo", carDto);
    }

    @Override
    public void insertCarImage(ImageDto carImageDto) {
        sqlSession.insert(namespace + "insertCarImage", carImageDto);
    }

    // ================================
    //         추가된 부분
    // ================================
    @Override
    public CarDto getCarById(Integer carInfoId) {
        return sqlSession.selectOne(namespace + "getCarById", carInfoId);
    }

    @Override
    public void updateCarInformation(CarDto carDto) {
        sqlSession.update(namespace + "updateCarInformation", carDto);
    }

    @Override
    public void updateCarBasicInfo(CarDto carDto) {
        sqlSession.update(namespace + "updateCarBasicInfo", carDto);
    }

    @Override
    public void deleteCar(Integer carInfoId) {

        System.out.println("carInfoId Dao = " + carInfoId);

        sqlSession.update(namespace + "deleteCar", carInfoId);
        sqlSession.update(namespace + "deleteCarInfo", carInfoId);  // 따로 실행
    }

    @Override
    public ImageDto getThumbnailByCarId(Integer carInfoId) {

        return sqlSession.selectOne(namespace + "getThumbnailByCarId", carInfoId);
    }

}
