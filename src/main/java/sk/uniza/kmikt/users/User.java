package sk.uniza.kmikt.users;

public class User {
    private int id;
    private String email, password, role, username, identificationNumber;

    public User(int id, String identificationNumber, String email, String password, String role, String username) {
        this.id = id;
        this.identificationNumber = identificationNumber;
        this.email = email;
        this.password = password;
        this.role = role;
        this.username = username;
    }

    public User(String username, String email, String password, String role, String identificationNumber) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
        this.identificationNumber = identificationNumber;
    }

    public User(int id, String email, String password) {
        this.id = id;
        this.email = email;
        this.password = password;
    }

    public String getUsername() { return username; }

    public void setUsername(String username) { this.username = username; }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getIdentificationNumber() { return identificationNumber; }

    public void setIdentificationNumber(String identificationNumber) { this.identificationNumber = identificationNumber; }
}
