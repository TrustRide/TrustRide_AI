package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.CategoryDto;

import java.util.List;

public interface JCategoryService {
    // 대분류 조회
    List<CategoryDto> getLargeCategories();

    // 중분류 조회
    List<CategoryDto> getMediumCategories(String parentCode);

    // 소분류 조회
    List<CategoryDto> getSmallCategories(String parentCode);
}
