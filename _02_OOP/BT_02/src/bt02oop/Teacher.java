package bt02oop;

public class Teacher extends Person {
    private int salary;

    public Teacher() {
        // TODO Auto-generated constructor stub
    }

    public Teacher(String name, int age, String address,int salary) {
        super(name, age, address);
        this.salary=salary;
        // TODO Auto-generated constructor stub
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    @Override
    public String toString() {
        return super.toString() + "Teacher [salary=" + salary + "]";
    }

}

