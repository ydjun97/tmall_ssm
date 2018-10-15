package tmall.pojo;

public class User {
    private Integer id;

    private String name;

    private String password;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getAnonymousName() {
        if(null == name)
            return null;
        if(1 == name.length())
            return "*";
        if(2 == name.length())
            return name.substring(0, 1) + "*";

        char[] cs = name.toCharArray();
        for(int i = 1; i < cs.length; i++){
            cs[i] = '*';
        }
        return new String(cs);
    }
}