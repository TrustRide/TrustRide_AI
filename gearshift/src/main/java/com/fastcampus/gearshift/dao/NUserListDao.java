package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.NUserListDto;
import com.fastcampus.gearshift.dto.UserDto;

import java.util.List;

public interface NUserListDao {
    List<UserDto> userList();

    void deleteUser(Integer userId); // 사용자 탈퇴
}
