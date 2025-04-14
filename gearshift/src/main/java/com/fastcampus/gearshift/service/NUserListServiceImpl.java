package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.NUserListDao;
import com.fastcampus.gearshift.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NUserListServiceImpl implements NUserListService {

    @Autowired
    private NUserListDao userListDao;

    @Override
    public List<UserDto> userList() {
        return userListDao.userList();
    }

    @Override
    public void deleteUser(Integer userId) {
        userListDao.deleteUser(userId);
    }
}
