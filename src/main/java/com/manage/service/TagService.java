package com.manage.service;

import com.manage.entity.Tag;

import java.util.List;

public interface TagService {

    List<Tag> getAllTags();

    Tag getTagById(Long id);

    void addTag(Tag tag);

    void updateTag(Tag tag);

    void deleteTag(Long id);
} 