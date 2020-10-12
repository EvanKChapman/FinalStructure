package com.study.tool.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.study.tool.model.ImageFiles;

@Repository
public interface ImageRepository extends JpaRepository<ImageFiles, Long>{

}
