package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.InquiryCommentDao;
import com.fastcampus.gearshift.dao.InquiryDao;
import com.fastcampus.gearshift.dto.InquiryCommentDto;
import com.fastcampus.gearshift.dto.InquiryDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class InquiryServiceImpl implements InquiryService {

    @Autowired
    private InquiryDao inquiryDao;
    @Autowired
    private InquiryCommentDao inquiryCommentDao;

    public List<InquiryDto> inquiryList() {
        return inquiryDao.inquiryList();
    }

    public InquiryDto getInquiryById(Integer inquiryId) {
        InquiryDto dto = inquiryDao.getInquiryById(inquiryId);
        dto.setComments(inquiryCommentDao.getCommentsByInquiryId(inquiryId));
        return dto;
    }

    public int modify(InquiryDto dto) {
        return inquiryDao.modify(dto);
    }

    public int delete(Integer inquiryId, Integer userId) {
        return inquiryDao.delete(inquiryId, userId);
    }

    public List<InquiryDto> getMyInquiries(Integer userId) {
        return inquiryDao.getMyInquiries(userId);
    }

    public int write(InquiryDto dto) {
        return inquiryDao.write(dto);
    }

    public int writeComment(InquiryCommentDto dto) {
        int result = inquiryCommentDao.insertComment(dto);
        // 댓글 등록이 성공하면 문의 상태를 '처리완료'로 업데이트
        if(result > 0){
            inquiryDao.updateStatus(dto.getInquiryId(),("처리완료"));
        }
        return result;
    }

    public List<InquiryCommentDto> getCommentsByInquiryId(Integer inquiryId) {
        return inquiryCommentDao.getCommentsByInquiryId(inquiryId);
    }
}


