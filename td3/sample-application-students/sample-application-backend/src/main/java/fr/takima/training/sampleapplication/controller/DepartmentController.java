package fr.takima.training.sampleapplication.controller;

import fr.takima.training.sampleapplication.entity.Department;
import fr.takima.training.sampleapplication.service.DepartmentService;
import fr.takima.training.sampleapplication.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@RequestMapping(value = "/api/departments")
public class DepartmentController {

    private final DepartmentService departmentService;
    private final StudentService studentService;

    @Autowired
    public DepartmentController(DepartmentService departmentService, StudentService studentService) {
        this.departmentService = departmentService;
        this.studentService = studentService;
    }

    @GetMapping
    public ResponseEntity<Object> getAll() {
        return ResponseEntity.ok(departmentService.getAll());
    }

    @GetMapping("/{departmentName}/students")
    public ResponseEntity<Object> getDepartmentList(@PathVariable(name = "departmentName") String name) {
        Optional<Department> optionalDepartment = Optional.ofNullable(this.departmentService.getByName(name));
        if (optionalDepartment.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(this.studentService.getStudentsByDepartmentName(name));
    }

    @GetMapping("/{departmentName}")
    public ResponseEntity<Object> getDepartmentByName(@PathVariable(name = "departmentName") String name) {
        Optional<Department> optionalDepartment = Optional.ofNullable(this.departmentService.getByName(name));
        if (optionalDepartment.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(this.departmentService.getByName(name));
    }

    @GetMapping("/{departmentName}/count")
    public ResponseEntity<Object> getDepartmentCountByName(@PathVariable(name = "departmentName") String name) {
        Optional<Department> optionalDepartment = Optional.ofNullable(this.departmentService.getByName(name));
        if (optionalDepartment.isEmpty()) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(this.studentService.getStudentsNumberByDepartmentName(name));
    }

}
