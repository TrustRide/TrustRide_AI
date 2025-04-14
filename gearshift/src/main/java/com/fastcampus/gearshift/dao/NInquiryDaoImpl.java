package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.NInquiryDto;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class NInquiryDaoImpl implements NInquiryDao {
    private static final String NAMESPACE = "nInquiry";

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public List<NInquiryDto> findByUserId(Integer userId) {
        return sqlSession.selectList(NAMESPACE + ".findByUserId", userId);
    }

    @Override
    public NInquiryDto findById(Integer inquiryId) {
        return sqlSession.selectOne(NAMESPACE + ".findById", inquiryId);
    }

    @Override
    public int insert(NInquiryDto dto) {
        return sqlSession.insert(NAMESPACE + ".insert", dto);
    }

    @Override
    public int update(NInquiryDto dto) {
        return sqlSession.update(NAMESPACE + ".update", dto);
    }

    @Override
    public int delete(Integer inquiryId) {
        return sqlSession.update(NAMESPACE + ".delete", inquiryId);
    }
}
