package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.NUserListDto;
import com.fastcampus.gearshift.dto.UserDto;

import java.util.List;

public interface NUserListService {
    List<UserDto> userList();
    void deleteUser(Integer userId);
}
