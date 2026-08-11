package com.example.LernApp.service;

import com.example.LernApp.dto.AntwortCreateRequest;
import com.example.LernApp.dto.AntwortResponse;
import com.example.LernApp.dto.AntwortUpdateRequest;
import com.example.LernApp.exception.AntwortNotFoundException;
import com.example.LernApp.exception.FrageNotFoundException;
import com.example.LernApp.mapper.AntwortMapper;
import com.example.LernApp.model.Antwort;
import com.example.LernApp.model.Frage;
import com.example.LernApp.repository.AntwortRepository;
import com.example.LernApp.repository.FrageRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AntwortService {

    private final AntwortRepository repository;
    private final FrageRepository frageRepository;
    private final AntwortMapper mapper;

    public List<AntwortResponse> findByFrage(Long frageId) {
        return repository.findByFrageId(frageId)
                .stream()
                .map(mapper::toResponse)
                .toList();
    }
    public AntwortService(AntwortRepository repository, FrageRepository frageRepository, AntwortMapper mapper) {
        this.repository = repository;
        this.frageRepository = frageRepository;
        this.mapper = mapper;
    }

    public List<AntwortResponse> findAll() {
        return repository.findAll().stream()
                .map(mapper::toResponse)
                .toList();
    }

    public AntwortResponse findById(Long id) {
        Antwort antwort = repository.findById(id)
                .orElseThrow(() -> new AntwortNotFoundException(id));
        return mapper.toResponse(antwort);
    }

    public AntwortResponse create(AntwortCreateRequest request) {
        // Frage hier laden, nicht im Mapper
        Frage frage = frageRepository.findById(request.frageId()).orElseThrow(() -> new FrageNotFoundException(request.frageId()));

        Antwort saved = repository.save(mapper.toEntity(request, frage));
        return mapper.toResponse(saved);
    }

    public AntwortResponse update(Long id, AntwortUpdateRequest request) {
        Antwort antwort = repository.findById(id)
                .orElseThrow(() -> new AntwortNotFoundException(id));

        // Frage hier laden, nicht im Mapper
        Frage frage = frageRepository.findById(request.frageId()).orElseThrow(() -> new FrageNotFoundException(request.frageId()));

        mapper.updateEntity(antwort, request, frage);
        return mapper.toResponse(repository.save(antwort));
    }

    public void delete(Long id) {
        if(!repository.existsById(id)) {
            throw new AntwortNotFoundException(id);
        }
        repository.deleteById(id);
    }
}
