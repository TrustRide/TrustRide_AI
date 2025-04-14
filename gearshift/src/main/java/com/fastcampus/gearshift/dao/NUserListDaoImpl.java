package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.NUserListDto;
import com.fastcampus.gearshift.dto.UserDto;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class NUserListDaoImpl implements NUserListDao {

    private static final String NAMESPACE = "adminUserList";

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public List<UserDto> userList() {
        return sqlSession.selectList(NAMESPACE + ".userList");
    }

    @Override
    public void deleteUser(Integer userId) {

        int result = sqlSession.delete(NAMESPACE + ".deleteUser", userId);
        System.out.println("[관리자 삭제] userId: " + userId + ", 삭제 결과: " + result);  //테스트 로그
    }
}
