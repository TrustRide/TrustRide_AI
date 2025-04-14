package com.fastcampus.gearshift.dto;

import com.fastcampus.gearshift.dto.InquiryCommentDto;
import lombok.*;


import java.util.List;

// InquiryDto.java
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class InquiryDto {
    private Integer inquiryId;
    private String inquiryStatus;
    private String inquiryType;
    private String inquiryName;
    private String inquiryContent;

    private Integer carInfoId;
    private String modelName;
    private Integer userId;
    private String userName;
    private String userEmail;

    private Boolean isDeleted;
    private String createdAt;
    private String updatedAt;

    // 댓글 포함용
    private List<InquiryCommentDto> comments;
}




