package tmall.util;

public class Page {

    private int start;
    private int count;
    private int total;
    private String param;
    private static final int defaultCount = 5;

    public Page() {
        this.count = defaultCount;
    }
    public Page(int start, int count) {
        this.start = start;
        this.count = count;
    }

    @Override
    public String toString() {
        return "Page [start=" + start + ", count=" + count + ", total=" + total + ", getStart()=" + getStart()
                + ", getCount()=" + getCount() + ", isHasPrevious()=" + isHasPrevious() + ", isHasNext()="
                + isHasNext() + ", getTotalPage()=" + getTotalPage() + ", getLast()=" + getLast() + "]";
    }

    public int getLast() {
        int last;
        if(total % count == 0)
            last = total - count;
        else
            last = total - total % count;
        last = last > 0 ? last : 0;

        return last;
    }

    public int getTotalPage() {
        int totalPage;
        if(total % count == 0)
            totalPage = total / count;
        else
            totalPage = total / count + 1;
        totalPage = totalPage == 0 ? 1 : totalPage;

        return totalPage;
    }

    public boolean isHasPrevious() {
        return start <= 0 ? false : true;
    }
    public boolean isHasNext() {
        return start >= getLast() ? false : true;
    }

    public int getStart() {
        return start;
    }
    public void setStart(int start) {
        this.start = start < 0 ? 0 : start;
    }
    public int getCount() {
        return count;
    }
    public void setCount(int count) {
        this.count = count;
    }
    public int getTotal() {
        return total;
    }
    public void setTotal(int total) {
        this.total = total;
    }
    public String getParam() {
        return param;
    }
    public void setParam(String param) {
        this.param = param;
    }
}
