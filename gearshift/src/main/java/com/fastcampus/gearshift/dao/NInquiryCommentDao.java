package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.InquiryCommentDto;

import java.util.List;

public interface NInquiryCommentDao {
    List<InquiryCommentDto> getCommentsByInquiryId(Integer inquiryId);
}
