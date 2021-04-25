package bt01oop;

import bt01oop.Employee;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class main {
    public static void main(String[] args) {
        Employee employee = new Employee(1, "Duong", "Manh", 100);
        System.out.println(employee);

        List<Employee> employees = Arrays.asList(new Employee(1, "Duong", "Manh", 100),
                new Employee(3, "Duong", "Manh", 100), new Employee(9, "Duong", "Manh", 100),
                new Employee(2, "Duong", "Manh", 100), new Employee(5, "Duong", "Manh", 100),
                new Employee(7, "Duong", "Manh", 100), new Employee(6, "Duong", "Manh", 100),
                new Employee(8, "Duong", "Manh", 100), new Employee(4, "Duong", "Manh", 100),
                new Employee(10, "Duong", "Manh", 100));
        // Arrays.stream(employees).forEach(System.out::println);
        employees = employees.stream().sorted((o1, o2) -> o1.getId() - o2.getId()).collect(Collectors.toList());
        employees.stream().forEach(System.out::println);
    }

}