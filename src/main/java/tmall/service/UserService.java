package tmall.service;

import tmall.pojo.User;

import java.util.List;

public interface UserService {

    public List<User> list();

    public void add(User user);

    public void delete(int id);

    public User get(int id);

    public void update(User user);

    public boolean isExists(String name);

    public User get(String name, String password);
}
