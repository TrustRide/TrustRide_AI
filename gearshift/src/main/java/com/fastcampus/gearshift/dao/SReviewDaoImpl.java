package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.ImageDto;
import com.fastcampus.gearshift.dto.ReviewCommentDto;
import com.fastcampus.gearshift.dto.ReviewDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class SReviewDaoImpl implements SReviewDao {

    @Autowired
    private SqlSession sqlSession;

    private static final String namespace = "reviewMapper.";


    @Override
    public int countAllReviews() {
        return sqlSession.selectOne(namespace + "countAllReviewsFiltered");
    }

    //MyBatis에서 파라미터 두 개 이상 넘길 때 자주 쓰는 방식
    //@Param("offset") int offset, @Param("limit") int limit도 가능
    @Override
    public List<ReviewDto> selectReviewsWithPagingFiltered(int offset, int limit, Boolean isAnswered) {
        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("limit", limit);
        params.put("isAnswered", isAnswered);
        return sqlSession.selectList(namespace + "selectReviewsWithPagingFiltered", params);
    }

    @Override
    public ReviewDto findById(Integer id) {
        return sqlSession.selectOne(namespace + "findById", id);
    }

    @Override
    public void insertReview(ReviewDto reviewDto) {
        sqlSession.insert(namespace + "insertReview", reviewDto);
    }

    @Override
    public void deleteReview(Integer reviewId) {
        sqlSession.update(namespace + "deleteReview", reviewId);
    }

    @Override
    public void deleteReviewCommentByReviewId(Integer reviewId) {
        sqlSession.update(namespace + "deleteReviewCommentByReviewId", reviewId);
    }

    @Override
    public void deleteImageByReviewId(Integer reviewId) {
        sqlSession.update(namespace + "deleteImageByReviewId", reviewId);
    }

    @Override
    public void insertComment(ReviewCommentDto reviewCommentDto) {
        sqlSession.insert(namespace + "insertComment", reviewCommentDto);
    }

    @Override
    public void deleteComment(Integer reviewCommentId) {
        sqlSession.delete(namespace + "deleteComment", reviewCommentId);
    }


    @Override
    public Integer selectReviewId(ReviewDto reviewDto) {
        return sqlSession.selectOne(namespace + "findReviewId", reviewDto);
    }

    @Override
    public void insertReviewImage(ImageDto imageDto) {
        sqlSession.insert(namespace + "insertReviewImage", imageDto);
    }

}
