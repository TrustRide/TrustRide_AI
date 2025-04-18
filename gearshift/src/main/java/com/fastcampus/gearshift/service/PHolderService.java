package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.*;

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

    //뉴스 작성
    int write(NewsDto newsDto) throws Exception;

    //뉴스 전체 조회
    List<NewsDto> getList() throws Exception;

    NewsDto newsRead(Integer newsId) throws Exception;//상세 조회

    void saveNewsImage(int newsId, String newsImageUrl, boolean isThumbnail) throws Exception;

    List<NewsImageDto> getImagesByNewsId(int newsId) throws Exception;

    String getThumbnailByNewsId(int newsId) throws Exception;

    //이미지 삭제
    void deleteNewsWithImages(int newsId) throws Exception;

    List<NewsDto> getPagedNewsList(int offset, int pageSize); // 추가
    int getNewsCount(); // 전체 개수 반환
}
