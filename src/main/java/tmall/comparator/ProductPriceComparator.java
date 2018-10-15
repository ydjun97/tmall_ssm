package tmall.comparator;

import tmall.pojo.Product;

import java.util.Comparator;

public class ProductPriceComparator implements Comparator<Product> {
    @Override
    public int compare(Product o1, Product o2) {
        float priceDifference = o2.getPromotePrice() - o1.getPromotePrice();
        return priceDifference > 0 ? 1 : (int) priceDifference;
    }
}
