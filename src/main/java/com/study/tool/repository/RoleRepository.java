package com.study.tool.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.tool.model.Role;

@Repository
public interface RoleRepository extends JpaRepository<Role, Long> {
    
	Role findByRole(String role);
	
}
