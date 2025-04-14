package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.UserDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SUserDaoImpl implements SUserDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String namespace = "userMapper.";

    @Override
    public void insertUser(UserDto user) {
        sqlSession.insert(namespace + "insertUser", user);
    }

    @Override
    public UserDto findByEmail(String email) {
        return sqlSession.selectOne(namespace + "findByEmail", email);
    }

}
