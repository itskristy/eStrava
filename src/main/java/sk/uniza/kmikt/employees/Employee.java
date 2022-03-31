package sk.uniza.kmikt.employees;

public class Employee {
    private int id, phoneNumber;
    private String identificationNumber, firstName, lastName, address, role;

    public Employee(int id, int phoneNumber, String identificationNumber, String firstName, String lastName, String address, String role) {
        this.id = id;
        this.phoneNumber = phoneNumber;
        this.identificationNumber = identificationNumber;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.role = role;
    }

    public Employee(int phoneNumber, String identificationNumber, String firstName, String lastName, String address, String role) {
        this.phoneNumber = phoneNumber;
        this.identificationNumber = identificationNumber;
        this.firstName = firstName;
        this.lastName = lastName;
        this.address = address;
        this.role = role;
    }

    public Employee(String identificationNumber, int phoneNumber) {
        this.identificationNumber = identificationNumber;
        this.phoneNumber = phoneNumber;
    }

    public int getId() { return id; }

    public void setId(int id) { this.id = id; }

    public String getIdentificationNumber() { return identificationNumber; }

    public void setIdentificationNumber(String identificationNumber) { this.identificationNumber = identificationNumber; }

    public int getPhoneNumber() { return phoneNumber; }

    public void setPhoneNumber(int phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getFirstName() { return firstName; }

    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }

    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getAddress() { return address; }

    public void setAddress(String address) { this.address = address; }

    public String getRole() { return role; }

    public void setRole(String role) { this.role = role; }
}
