package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.InquiryCommentDto;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class NInquiryCommentDaoImpl implements NInquiryCommentDao {
    @Autowired
    private SqlSessionTemplate sqlSession;

    // inquiryComment.xml에 namespace="inquiryComment"
    private final String NAMESPACE = "inquiryComment";

    @Override
    public List<InquiryCommentDto> getCommentsByInquiryId(Integer inquiryId) {
        return sqlSession.selectList(NAMESPACE + ".getCommentsByInquiryId", inquiryId);
    }
}
