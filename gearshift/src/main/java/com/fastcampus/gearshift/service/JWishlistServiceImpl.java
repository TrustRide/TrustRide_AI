package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.JWishlistDao;
import com.fastcampus.gearshift.dto.CarListDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class JWishlistServiceImpl implements JWishlistService {

    private final JWishlistDao wishlistDao;

    @Override
    public void addWishlist(Integer userId, Integer carInfoId) {
        // 중복 체크를 원하는 경우
        if(!wishlistDao.isWished(userId, carInfoId)) {
            wishlistDao.insertWishlist(userId, carInfoId);
        }
    }

    @Override
    public void removeWishlist(Integer userId, Integer carInfoId) {
        if(wishlistDao.isWished(userId, carInfoId)) {
            wishlistDao.deleteWishlist(userId, carInfoId);
        }
    }

    @Override
    public boolean isWished(Integer userId, Integer carInfoId) {
        return wishlistDao.isWished(userId, carInfoId);
    }

    @Override
    public List<CarListDto> getWishlistCars(Integer userId) {
        return wishlistDao.selectWishlistCars(userId);
    }
}
