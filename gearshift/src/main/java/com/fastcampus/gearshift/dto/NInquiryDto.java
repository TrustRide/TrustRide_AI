package com.fastcampus.gearshift.dto;

import lombok.*;

import java.sql.Timestamp;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class NInquiryDto {
    private Integer inquiryId;
    private String inquiryStatus;     // enum('처리대기','처리완료')
    private String inquiryType;       // enum('상품문의','주문문의','배송문의','환불문의','기타')
    private String inquiryName;
    private String inquiryContent;
    private Integer userId;
    private String modelName;
    private String userName;
    private Boolean isDeleted;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // 댓글 포함용
    private List<InquiryCommentDto> comments;
}


