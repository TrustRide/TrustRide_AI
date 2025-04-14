package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.NInquiryCommentDao;
import com.fastcampus.gearshift.dao.NInquiryDao;
import com.fastcampus.gearshift.dto.InquiryCommentDto;
import com.fastcampus.gearshift.dto.NInquiryDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NInquiryServiceImpl implements NInquiryService {

    @Autowired
    private NInquiryDao nInquiryDao;

    // 새로 만든 댓글 Dao
    @Autowired
    private NInquiryCommentDao nInquiryCommentDao;

    @Override
    public NInquiryDto getById(Integer inquiryId) {
        // 1) 문의 정보 조회
        NInquiryDto inquiry = nInquiryDao.findById(inquiryId);

        if (inquiry != null) {
            // 2) 댓글 목록 추가로 불러오기
            List<InquiryCommentDto> comments
                    = nInquiryCommentDao.getCommentsByInquiryId(inquiryId);
            inquiry.setComments(comments);
        }

        return inquiry;
    }

    @Override
    public List<NInquiryDto> findByUserId(Integer userId) {
        return nInquiryDao.findByUserId(userId);
    }

    @Override
    public void create(NInquiryDto dto) {
        System.out.println("NInquiryDto 서비스 = " + dto);
        nInquiryDao.insert(dto);
    }

    @Override
    public void update(NInquiryDto dto) {
        nInquiryDao.update(dto);
    }

    @Override
    public void delete(Integer inquiryId) {
        nInquiryDao.delete(inquiryId);
    }
}
