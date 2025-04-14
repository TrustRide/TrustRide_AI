package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.LHolderDTO;

public interface LHolderDao {

    // 명의자 정보 저장
    int insertHolder(LHolderDTO  lHolderDTO);
}
