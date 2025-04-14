package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.CarListDto;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Repository
@RequiredArgsConstructor
public class JWishlistDaoImpl implements JWishlistDao {
    private final SqlSessionTemplate sqlSession;

    private static final String NS = "com.fastcampus.gearshift.wishlistMapper.";

    @Override
    public void insertWishlist(Integer userId, Integer carInfoId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("carInfoId", carInfoId);
        sqlSession.insert(NS + "insertWishlist", map);
    }

    @Override
    public void deleteWishlist(Integer userId, Integer carInfoId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("carInfoId", carInfoId);
        sqlSession.delete(NS + "deleteWishlist", map);
    }

    @Override
    public boolean isWished(Integer userId, Integer carInfoId) {
        Map<String, Object> map = new HashMap<>();
        map.put("userId", userId);
        map.put("carInfoId", carInfoId);
        return sqlSession.selectOne(NS + "isWished", map);
    }

    @Override
    public List<CarListDto> selectWishlistCars(Integer userId) {
        return sqlSession.selectList(NS + "selectWishlistCars", userId);
    }
}

