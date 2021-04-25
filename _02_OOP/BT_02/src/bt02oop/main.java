package bt02oop;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class main {
    private static Scanner sc = new Scanner(System.in);

    public static void main(String[] args) {
        List<Student> stds = Arrays.asList(new Student("trung", 12, "hue", 3), new Student("trung", 12, "hue", 4),
                new Student("trung", 13, "hue", 2), new Student("trung", 15, "hue", 2.5),
                new Student("trung", 14, "hue", 3.5));
        System.out.println("Danh sách sinh viên: ");
        stds.stream().forEach(System.out::println);
        List<Teacher> tcs = Arrays.asList(new Teacher("hoang", 22, "Đà Nẵng", 100),
                new Teacher("hoang", 22, "Đà Nẵng", 200), new Teacher("hoang", 22, "Đà Nẵng", 400),
                new Teacher("hoang", 22, "Đà Nẵng", 300), new Teacher("hoang", 22, "Đà Nẵng", 400));
        System.out.println("Danh sách học viên: ");
        tcs.stream().forEach(System.out::println);
        System.out.println("3 người có lương cao nhất là : ");
        tcs.stream().sorted((o1, o2) -> o2.getSalary() - o1.getSalary()).limit(3).forEach(System.out::println);

        stds = stds.stream().sorted((o1, o2) -> o1.getAge() - o2.getAge()).collect(Collectors.toList());
        final int std = stds.get(0).getAge();
        System.out.println("Những người có số tuổi ít nhất là: ");
        stds.stream().filter(t -> t.getAge() == std).forEach(System.out::println);

    }

}
