package tmall.service;

import tmall.pojo.Product;
import tmall.pojo.PropertyValue;

import java.util.List;

public interface PropertyValueService {

    public void init(Product product);

    public PropertyValue get(int pid, int ptid);

    public List<PropertyValue> list(int pid);

    public void update(PropertyValue propertyValue);
}
