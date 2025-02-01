package com.e.d.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.e.d.model.vo.CreatorVo;

@Mapper
public interface CreatorMapper {
	List<CreatorVo> selectBySubscribeUsername(String name, long id);
}
