package com.study.tool.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.study.tool.model.Products;

public interface ProductRepository extends JpaRepository<Products, Long> {

	
}
