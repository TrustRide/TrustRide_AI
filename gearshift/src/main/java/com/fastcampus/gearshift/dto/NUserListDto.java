package com.fastcampus.gearshift.dto;

import lombok.*;

import java.sql.Date;

@Getter
@Setter
@RequiredArgsConstructor
@ToString
@AllArgsConstructor
public class NUserListDto {
    private Integer userId;  //회원번호 -- 화면정의서엔 없으나 정렬위해 추가
    private String userName;       // 회원 이름
    private String userAccount;        // 아이디
    private String userPhoneNumber;       // 전화번호
    private String userEmail;         //이메일 -- 화면정의서엔 없으나 그냥 추가함
    private Date createdAt;    // 유저등록일
    private String userGender;   //성별
}
