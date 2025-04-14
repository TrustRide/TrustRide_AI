package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.LHolderDTO;

public interface LHolderService {

    // 명의자 정보 저장
    int insertHolder(LHolderDTO lHolderDTO);
}
