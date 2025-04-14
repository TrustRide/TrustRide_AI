package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.InquiryCommentDto;

import java.util.List;

public interface InquiryCommentDao {
    int insertComment(InquiryCommentDto dto);
    List<InquiryCommentDto> getCommentsByInquiryId(Integer inquiryId);
}
