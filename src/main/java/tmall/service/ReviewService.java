package tmall.service;

import tmall.pojo.Review;

import java.util.List;

public interface ReviewService {

    public List<Review> list(int pid);

    public void add(Review review);

    public void delete(int id);

    public Review get(int id);

    public void update(Review review);

    public int getCount(int pid);
}
