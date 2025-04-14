package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.InquiryDto;
import java.util.List;

public interface InquiryDao {
    List<InquiryDto> inquiryList();
    InquiryDto getInquiryById(Integer inquiryId);  //관리자
    int modify(InquiryDto dto);
    int delete(Integer inquiryId, Integer userId);
    List<InquiryDto> getMyInquiries(Integer userId);  //사용자전용
    int write(InquiryDto dto);
    int updateStatus(Integer inquiryId, String status);   // 댓글 등록시 처리완료로 변경

}

