package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.LHolderDao;
import com.fastcampus.gearshift.dto.LHolderDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LHolderServiceImpl implements LHolderService {

    @Autowired
    private LHolderDao holderDao;

    // 명의자 정보 저장
    @Override
    public int insertHolder(LHolderDTO lHolderDTO) {
        return holderDao.insertHolder(lHolderDTO);
    }
}
