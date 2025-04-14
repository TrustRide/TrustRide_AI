package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.CarListDto;

import java.util.List;

public interface JWishlistService {
    void addWishlist(Integer userId, Integer carInfoId);

    void removeWishlist(Integer userId, Integer carInfoId);

    boolean isWished(Integer userId, Integer carInfoId);

    List<CarListDto> getWishlistCars(Integer userId);
}
