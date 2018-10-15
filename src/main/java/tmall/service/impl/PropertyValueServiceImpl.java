package tmall.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tmall.mapper.PropertyValueMapper;
import tmall.pojo.Product;
import tmall.pojo.Property;
import tmall.pojo.PropertyValue;
import tmall.pojo.PropertyValueExample;
import tmall.service.PropertyService;
import tmall.service.PropertyValueService;

import java.util.List;

@Service
public class PropertyValueServiceImpl implements PropertyValueService {

    @Autowired
    private PropertyValueMapper propertyValueMapper;

    @Autowired
    private PropertyService propertyService;

    @Override
    public void init(Product product) {
        List<Property> properties = propertyService.list(product.getCid());
        for(Property property : properties) {
            PropertyValue propertyValue = get(product.getId(), property.getId());
            if(null == propertyValue){
                propertyValue = new PropertyValue();
                propertyValue.setPid(product.getId());
                propertyValue.setPtid(property.getId());
                propertyValueMapper.insert(propertyValue);
            }
        }
    }

    @Override
    public PropertyValue get(int pid, int ptid) {
        PropertyValueExample example = new PropertyValueExample();
        example.createCriteria().andPidEqualTo(pid).andPtidEqualTo(ptid);
        example.setOrderByClause("id desc");
        List<PropertyValue> propertyValues = propertyValueMapper.selectByExample(example);
        if(!propertyValues.isEmpty())
            return propertyValues.get(0);
        else
            return null;
    }

    @Override
    public List<PropertyValue> list(int pid) {
        PropertyValueExample example = new PropertyValueExample();
        example.createCriteria().andPidEqualTo(pid);
        example.setOrderByClause("id desc");
        List<PropertyValue> propertyValues = propertyValueMapper.selectByExample(example);

        for(PropertyValue propertyValue : propertyValues) {
            Property property = propertyService.get(propertyValue.getPtid());
            propertyValue.setProperty(property);
        }

        return propertyValues;
    }

    @Override
    public void update(PropertyValue propertyValue) {
        propertyValueMapper.updateByPrimaryKeySelective(propertyValue);
    }
}
