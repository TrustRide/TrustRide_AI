package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.LHolderDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LHolderDaoImpl implements LHolderDao {

    @Autowired
    private SqlSessionTemplate session;
    private static String namespace = "com.fastcampus.gearshift.dao.LHolderMapper.";

    // 명의자 정보 저장
    @Override
    public int insertHolder(LHolderDTO holderDTO) {
        return session.insert(namespace + "insertHolder", holderDTO);
    }
}
