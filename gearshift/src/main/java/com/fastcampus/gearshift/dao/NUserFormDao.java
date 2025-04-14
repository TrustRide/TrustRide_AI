package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.NUserFormDto;
import com.fastcampus.gearshift.dto.UserDto;

import java.util.List;

public interface NUserFormDao {
    List<UserDto> userForm();
    UserDto getUserFormById(Integer userId); // 사용자 정보 조회
    void updateUserForm(Integer userId, UserDto updatedUserForm); // 사용자 정보 수정
    void deleteUser(Integer userId); // 사용자 탈퇴
}
