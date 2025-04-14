package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.SOrderDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SOrderDaoImpl implements SOrderDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String namespace = "orderMapper.";

    @Override
    public List<SOrderDto> selectCompletedOrdersWithReviewStatus(Integer userId) {
        return sqlSession.selectList(namespace + "selectCompletedOrdersWithReviewStatus", userId);
    }

}
