package com.fastcampus.gearshift.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Getter
@Setter
public class ReviewDto {
    private Integer reviewId;
    private String reviewTitle;
    private String reviewContent;
    private Integer rating;
    private Integer orderId;
    private Integer carInfoId;
    private String modelName;
    private Integer userId;
    private String userName;
    private String userEmail;
    private Boolean isDeleted;
    private Boolean isAnswered;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private String imageUrl;
    private ReviewCommentDto reviewComment;

    public String getFormattedCreatedAt() {
        return createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }

    public String getFormattedUpdatedAt() {
        return updatedAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
    }
}
