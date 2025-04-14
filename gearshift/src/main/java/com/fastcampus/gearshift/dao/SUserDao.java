package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.UserDto;

public interface SUserDao {
    void insertUser(UserDto user);
    UserDto findByEmail(String email);
}
