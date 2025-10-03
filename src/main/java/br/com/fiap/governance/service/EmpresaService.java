package br.com.fiap.governance.service;


import br.com.fiap.governance.dto.EmpresaRequestDTO;
import br.com.fiap.governance.dto.EmpresaResponseDTO;
import br.com.fiap.governance.exception.ResourceNotFoundException;
import br.com.fiap.governance.model.Empresa;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import br.com.fiap.governance.repository.EmpresaRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class EmpresaService {

    @Autowired
    private EmpresaRepository empresaRepository;

    private EmpresaResponseDTO toResponseDTO(Empresa empresa) {
        EmpresaResponseDTO dto = new EmpresaResponseDTO();
        BeanUtils.copyProperties(empresa, dto);
        return dto;
    }

    private Empresa toEntity(EmpresaRequestDTO dto) {
        Empresa entity = new Empresa();
        BeanUtils.copyProperties(dto, entity);
        return entity;
    }

    @Transactional(readOnly = true)
    public List<EmpresaResponseDTO> listarTodas() {
        return empresaRepository.findAll().stream().map(this::toResponseDTO).collect(Collectors.toList());
    }

    @Transactional
    public EmpresaResponseDTO adicionarEmpresa(EmpresaRequestDTO requestDTO) {
        if (empresaRepository.findByCnpj(requestDTO.getCnpj()).isPresent()) {
            throw new DataIntegrityViolationException("CNPJ " + requestDTO.getCnpj() + " já cadastrado.");
        }
        Empresa empresa = toEntity(requestDTO);
        return toResponseDTO(empresaRepository.save(empresa));
    }

    @Transactional
    public EmpresaResponseDTO atualizarEmpresa(Integer id, EmpresaRequestDTO requestDTO) {
        Empresa empresaExistente = empresaRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Empresa não encontrada com ID: " + id));

        if (!empresaExistente.getCnpj().equals(requestDTO.getCnpj()) &&
                empresaRepository.findByCnpj(requestDTO.getCnpj()).filter(e -> !e.getIdEmpresa().equals(id)).isPresent()) {
            throw new DataIntegrityViolationException("CNPJ " + requestDTO.getCnpj() + " já pertence a outra empresa.");
        }

        BeanUtils.copyProperties(requestDTO, empresaExistente, "idEmpresa");
        return toResponseDTO(empresaRepository.save(empresaExistente));
    }

    @Transactional
    public void excluirEmpresa(Integer id) {
        if (!empresaRepository.existsById(id)) {
            throw new ResourceNotFoundException("Empresa não encontrada com ID: " + id);
        }
        empresaRepository.deleteById(id);
    }
}