package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.*;

import java.util.List;
import java.util.Map;

public interface PHolderDao {


    UserDto select(Integer userId) throws Exception;

    //차량 조회
    List<CarListDto> carSelect();

    //차량 상세 조회
    CarInfoDto carDetailSelect(Integer carInfoId) throws Exception;

    //유저 상세 조회
    UserDto userSelect(Integer userId) throws Exception;

    //메인화면 검색
    List<CarListDto> searchCarsByTitle(String title) throws Exception;

    // 조회
    List<CarListDto> carPageSelect(int offset, int pageSize);

    // 차량 리스트 개수 조회

    int getCarCount();

    List<CarListDto> carselectByCate(String cateCode, int offset, int pageSize);

    int getCarCountByCate(String cateCode);

    //뉴스 작성
    int insert(NewsDto dto) throws Exception;

    //뉴스 전체 조회
    List<NewsDto> selectAll() throws Exception;

    //뉴스 지정된 번호 조회 (상세 조회)
    NewsDto newsSelect(Integer newsId) throws Exception;

    //이미지 뉴스
    int imageInsert(int newsId, String newsImageUrl,boolean isThumbnail);

    List<NewsImageDto> selectByNewsId(int newsId);

    String selectThumbnailByNewsId(int newsId);

    //이미지 삭제
     void deleteNewsImages(int newsId) throws Exception;
     //뉴스 삭제
    void delete(int newsId) throws Exception;

    List<NewsDto> getPagedNewsList(Map<String, Object> params);
    int getNewsCount();
}
