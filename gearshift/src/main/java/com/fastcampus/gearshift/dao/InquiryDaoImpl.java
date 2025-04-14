package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.InquiryDto;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class InquiryDaoImpl implements InquiryDao {
    private static final String NAMESPACE = "inquiry";

    @Autowired
    private SqlSessionTemplate sqlSession;

    public List<InquiryDto> inquiryList() {
        return sqlSession.selectList(NAMESPACE + ".inquiryList");
    }

    public InquiryDto getInquiryById(Integer inquiryId) {
        return sqlSession.selectOne(NAMESPACE + ".getInquiryById", inquiryId);
    }

    public int modify(InquiryDto dto) {
        return sqlSession.update(NAMESPACE + ".modify", dto);
    }

    public int delete(Integer inquiryId, Integer userId) {
        Map<String, Object> param = new HashMap<>();
        param.put("inquiryId", inquiryId);
        param.put("userId", userId);
        return sqlSession.update(NAMESPACE + ".delete", param);
    }

    public List<InquiryDto> getMyInquiries(Integer userId) {
        return sqlSession.selectList(NAMESPACE + ".getMyInquiries", userId);
    }

    public int write(InquiryDto dto) {
        return sqlSession.insert(NAMESPACE + ".write", dto);
    }

    @Override
    public int updateStatus(Integer inquiryId, String status) {
        Map<String, Object> param = new HashMap<>();
        param.put("inquiryId", inquiryId);
        param.put("status", status);
        return sqlSession.update(NAMESPACE + ".updateStatus", param);
    }

}


