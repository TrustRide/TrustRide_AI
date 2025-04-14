package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.JAdminCarDao;
import com.fastcampus.gearshift.dao.PCateDao;
import com.fastcampus.gearshift.dao.PHolderDao;
import com.fastcampus.gearshift.dto.CarDto;
import com.fastcampus.gearshift.dto.CategoryDto;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PCateServiceImpl implements PCateService {

    private final PCateDao cateDao;

    private final PHolderDao pHolderDao;


    @Override
    public List<CategoryDto> cateList() {
        return cateDao.cateList();
    }


}
