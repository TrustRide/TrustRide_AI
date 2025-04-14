package com.fastcampus.gearshift.dto;
import lombok.*;


// InquiryCommentDto.java
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class InquiryCommentDto {
    private Integer inquiryCommentId;
    private String commentContent;
    private Integer inquiryId;
    private Integer adminId;
    private Boolean isDeleted;
    private String createdAt;
    private String updatedAt;
}