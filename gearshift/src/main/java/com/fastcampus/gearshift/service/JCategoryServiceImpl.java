package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.JCategoryDao;
import com.fastcampus.gearshift.dto.CategoryDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class JCategoryServiceImpl implements JCategoryService {
    private final JCategoryDao categoryDao;

    // 대분류 조회
    @Override
    public List<CategoryDto> getLargeCategories() {
        return categoryDao.findByTier(1);
    }

    // 중분류 조회
    @Override
    public List<CategoryDto> getMediumCategories(String parentCode) {
        return categoryDao.findByParentCode(parentCode);
    }

    // 소분류 조회
    @Override
    public List<CategoryDto> getSmallCategories(String parentCode) {
        return categoryDao.findByParentCode(parentCode);
    }
}