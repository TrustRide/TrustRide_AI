package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.NUserFormDao;
import com.fastcampus.gearshift.dto.UserDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NUserFormServiceImpl implements NUserFormService {

    @Autowired
    private NUserFormDao userFormDao;

    @Override
    public List<UserDto> userForm() {
        return userFormDao.userForm();
    }

    @Override
    public UserDto getUserFormById(Integer userId) {
        return userFormDao.getUserFormById(userId);
    }

    @Override
    public void updateUserForm(Integer userId, UserDto updatedUserForm) {
        updatedUserForm.setUserId(userId);

        // ✅ 비밀번호가 비어 있으면 null 처리 (기존 비밀번호 유지 목적)
        if (updatedUserForm.getUserPassword() == null || updatedUserForm.getUserPassword().trim().isEmpty()) {
            updatedUserForm.setUserPassword(null); // DB 반영 방지
        }
        userFormDao.updateUserForm(userId,updatedUserForm);
    }

    @Override
    public void deleteUser(Integer userId) {
        System.out.println("[Service] deleteUser() 호출됨 - userId: " + userId);   //테스트용 로그
        userFormDao.deleteUser(userId);
    }
}
