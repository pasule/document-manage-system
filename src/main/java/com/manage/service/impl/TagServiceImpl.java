package com.manage.service.impl;

import com.manage.entity.Tag;
import com.manage.mapper.TagMapper;
import com.manage.service.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TagServiceImpl implements TagService {

    @Autowired
    private TagMapper tagMapper;

    @Override
    public List<Tag> getAllTags() {
        return tagMapper.findAll();
    }

    @Override
    public Tag getTagById(Long id) {
        return tagMapper.findById(id);
    }

    @Override
    public void addTag(Tag tag) {
        tagMapper.insert(tag);
    }

    @Override
    public void updateTag(Tag tag) {
        tagMapper.update(tag);
    }

    @Override
    public void deleteTag(Long id) {
        // Here you might want to delete related records in document_tag table first
        tagMapper.delete(id);
    }

    @Override
    public boolean isTagNameExists(String name) {
        return tagMapper.findByName(name) != null;
    }
} 