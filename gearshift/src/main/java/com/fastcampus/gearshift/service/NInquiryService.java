package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.NInquiryDto;

import java.util.List;

public interface NInquiryService {
    List<NInquiryDto> findByUserId(Integer userId);

    NInquiryDto getById(Integer inquiryId);

    void create(NInquiryDto dto);

    void update(NInquiryDto dto);

    void delete(Integer inquiryId);
}
