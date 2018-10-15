package tmall.service;

import tmall.pojo.Property;

import java.util.List;

public interface PropertyService {

    public List<Property> list(int cid);

    public void add(Property property);

    public void delete(int id);

    public Property get(int id);

    public void update(Property property);
}
