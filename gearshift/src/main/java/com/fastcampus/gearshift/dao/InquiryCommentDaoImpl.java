package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.InquiryCommentDto;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class InquiryCommentDaoImpl implements InquiryCommentDao {
    private static final String NAMESPACE = "inquiryComment";

    @Autowired
    private SqlSessionTemplate sqlSession;

    public int insertComment(InquiryCommentDto dto) {
        return sqlSession.insert(NAMESPACE + ".insertComment", dto);
    }

    public List<InquiryCommentDto> getCommentsByInquiryId(Integer inquiryId) {
        return sqlSession.selectList(NAMESPACE + ".getCommentsByInquiryId", inquiryId);
    }
}
