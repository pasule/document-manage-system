package com.manage.service.impl;

import com.manage.entity.Tag;
import com.manage.mapper.TagMapper;
import com.manage.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TagServiceImpl implements TagService {

    @Autowired(required = false)
    private TagMapper tagMapper;

    @Override
    public List<Tag> getAllTags() {
        // 如果TagMapper未实现，返回模拟数据
        if (tagMapper == null) {
            return getMockTags();
        }
        return tagMapper.findAll();
    }

    @Override
    public Tag getTagById(Long id) {
        if (tagMapper == null) {
            // 从模拟数据中查找
            for (Tag tag : getMockTags()) {
                if (tag.getId().equals(id)) {
                    return tag;
                }
            }
            return null;
        }
        return tagMapper.findById(id);
    }

    @Override
    public void addTag(Tag tag) {
        if (tagMapper != null) {
            tagMapper.insert(tag);
        }
    }

    @Override
    public void updateTag(Tag tag) {
        if (tagMapper != null) {
            tagMapper.update(tag);
        }
    }

    @Override
    public void deleteTag(Long id) {
        if (tagMapper != null) {
            tagMapper.delete(id);
        }
    }

    @Override
    public boolean isTagNameExists(String name) {
        if (tagMapper == null) {
            // 从模拟数据中查找
            for (Tag tag : getMockTags()) {
                if (tag.getName().equals(name)) {
                    return true;
                }
            }
            return false;
        }
        return tagMapper.findByName(name) != null;
    }
    
    // 获取模拟标签数据
    private List<Tag> getMockTags() {
        List<Tag> tags = new ArrayList<>();
        
        Tag tag1 = new Tag();
        tag1.setId(1L);
        tag1.setName("重要");
        tag1.setColor("#ff0000");
        tags.add(tag1);
        
        Tag tag2 = new Tag();
        tag2.setId(2L);
        tag2.setName("普通");
        tag2.setColor("#00ff00");
        tags.add(tag2);
        
        Tag tag3 = new Tag();
        tag3.setId(3L);
        tag3.setName("紧急");
        tag3.setColor("#0000ff");
        tags.add(tag3);
        
        Tag tag4 = new Tag();
        tag4.setId(4L);
        tag4.setName("归档");
        tag4.setColor("#ffff00");
        tags.add(tag4);
        
        return tags;
    }
} 