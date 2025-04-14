package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.CategoryDto;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class JCategoryDaoImpl implements JCategoryDao {

    private final SqlSessionTemplate sqlSession;

    private static final String NAMESPACE = "categoryMapper.";

    @Override
    public List<CategoryDto> findByTier(Integer tier) {
        return sqlSession.selectList(NAMESPACE + "findByTier", tier);
    }

    @Override
    public List<CategoryDto> findByParentCode(String parentCode) {
        return sqlSession.selectList(NAMESPACE + "findByParentCode", parentCode);
    }

}