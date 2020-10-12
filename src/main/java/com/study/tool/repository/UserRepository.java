package com.study.tool.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.study.tool.model.Users;

public interface UserRepository extends JpaRepository<Users, Long> {
	
	String search="SELECT u FROM Users u WHERE u.email =:email AND " +
		    "u.fname LIKE (CONCAT('%',:name, '%')) OR u.lname =:name";
	
	Optional<Users> findByEmail(String email);
	
	@Query("FROM Users u WHERE u.email=?1 AND u.password=?2")
	Optional<Users> login(String email, String password);

	
	@Query("FROM Users WHERE lname=?1 OR fname=?1 OR email=?1")
	List<Users> findByName(String name);
	
	@Query("FROM Users WHERE lname=?1 AND email=?2")
	List<Users> findByName(String lname, String email);
	
	@Query("SELECT u FROM Users u WHERE u.lname=:name OR u.fname=:name")
	List<Users> findByUser(@Param("name")String lname);
	
	@Query(search)
	Page<Users> customeseacher(@Param("name") String name, @Param("email") String email, Pageable pageable);
	
}


