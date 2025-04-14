package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.CarListDto;

import java.util.List;

public interface JWishlistDao {
    void insertWishlist(Integer userId, Integer carInfoId);

    void deleteWishlist(Integer userId, Integer carInfoId);

    boolean isWished(Integer userId, Integer carInfoId);

    List<CarListDto> selectWishlistCars(Integer userId);
}
