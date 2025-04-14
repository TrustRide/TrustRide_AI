package com.fastcampus.gearshift.dto;

import lombok.*;

@Getter
@Setter
@RequiredArgsConstructor
@ToString
@AllArgsConstructor
public class NUserFormDto {
    private Integer userId;  // 회원 코드
    private String userName;  // 회원 이름
    private String userAccount; // 아이디
    private String userPassword; // 비밀번호
    private String userEmail; // 이메일
    private String userPhoneNumber; // 전화번호
}
