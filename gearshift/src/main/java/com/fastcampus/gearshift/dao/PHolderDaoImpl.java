package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.*;
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

    //뉴스 작성
    @Override
    public int insert(NewsDto dto) throws Exception {
        return session.insert(namespace+"insert",dto);
    }
    //뉴스 전체 조회
    @Override
    public List<NewsDto> selectAll() throws Exception {//전체 조회
        return session.selectList(namespace+"selectAll");
    }

    //뉴스 상세 조회
    @Override
    public NewsDto newsSelect(Integer newsId) throws Exception {
        return session.selectOne(namespace+"newsSelect",newsId);
    }

    @Override
    public int imageInsert(int newsId, String newsImageUrl, boolean isThumbnail) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("newsId", newsId);
        paramMap.put("newsImageUrl", newsImageUrl);
        paramMap.put("isThumbnail", isThumbnail);
        return session.insert(namespace + "imageInsert", paramMap);
    }

    @Override
    public List<NewsImageDto> selectByNewsId(int newsId) {
        return session.selectList(namespace+"selectByNewsId",newsId);
    }

    @Override
    public String selectThumbnailByNewsId(int newsId) {
        return session.selectOne(namespace+"selectThumbnailByNewsId",newsId);

    }

    @Override
    public void deleteNewsImages(int newsId) throws Exception {
        session.delete(namespace+"deleteNewsImages",newsId);
    }

    @Override
    public void delete(int newsId) throws Exception {
    session.delete(namespace+"newsDelete",newsId);
    }

    @Override
    public List<NewsDto> getPagedNewsList(Map<String, Object> params) {
        return session.selectList(namespace+"getPagedNewsList",params);
    }

    @Override
    public int getNewsCount() {
        return session.selectOne(namespace+"getNewsCount");
    }

}

