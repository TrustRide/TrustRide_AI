package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.InquiryCommentDto;
import com.fastcampus.gearshift.dto.InquiryDto;
import java.util.List;
// InquiryService.java
public interface InquiryService {
    List<InquiryDto> inquiryList();
    InquiryDto getInquiryById(Integer inquiryId);
    int modify(InquiryDto dto);
    int delete(Integer inquiryId, Integer userId);
    List<InquiryDto> getMyInquiries(Integer userId);   //회원 전용
    int write(InquiryDto dto);  //회원 전용

    int writeComment(InquiryCommentDto dto);  //관리자 전용
    List<InquiryCommentDto> getCommentsByInquiryId(Integer inquiryId);  //관리자전용
}