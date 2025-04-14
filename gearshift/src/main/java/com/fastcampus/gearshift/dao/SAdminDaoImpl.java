package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.AdminDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class SAdminDaoImpl implements SAdminDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String namespace = "adminMapper.";

    @Override
    public void insertUser(AdminDto user) {
        sqlSession.insert(namespace + "insertUser", user);
    }

    @Override
    public List<AdminDto> selectAllUsers() {
        return sqlSession.selectList(namespace + "selectAllUsers");
    }

    @Override
    public int countAllUsers() {
        return sqlSession.selectOne(namespace + "countAllUsers");
    }

    @Override
    public List<AdminDto> selectUsersWithPaging(int offset, int limit) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        return sqlSession.selectList(namespace + "selectUsersWithPaging", params);
    }

    @Override
    public AdminDto findByEmail(String email) {
        return sqlSession.selectOne(namespace + "findByEmail", email);
    }

    @Override
    public void deleteUser(Integer adminId) {
        sqlSession.delete(namespace + "deleteUser", adminId);
    }

    @Override
    public void activateUser(Integer adminId) {
        sqlSession.update(namespace + "activateUser", adminId);
    }

}
