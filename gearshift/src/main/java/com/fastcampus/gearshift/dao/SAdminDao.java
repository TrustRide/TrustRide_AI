package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.AdminDto;

import java.util.List;

public interface SAdminDao {
    void insertUser(AdminDto user);
    List<AdminDto> selectAllUsers();
    int countAllUsers();
    List<AdminDto> selectUsersWithPaging(int offset, int limit);
    AdminDto findByEmail(String email);
    void deleteUser(Integer adminId);
    void activateUser(Integer adminId);
}
