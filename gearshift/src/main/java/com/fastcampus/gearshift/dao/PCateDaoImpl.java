package com.fastcampus.gearshift.dao;


import com.fastcampus.gearshift.dto.CategoryDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PCateDaoImpl implements PCateDao {

    private static final String NAMESPACE = "com.fastcampus.gearshift"; // MyBatis 매퍼 네임스페이스

    @Autowired
    private SqlSession sqlSession; // MyBatis의 SqlSession을 주입

    @Override
    public List<CategoryDto> cateList() {
        return sqlSession.selectList(NAMESPACE + ".cateList");
    }
}
