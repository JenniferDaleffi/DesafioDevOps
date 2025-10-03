package br.com.fiap.governance.controller;


import br.com.fiap.governance.dto.EmpresaRequestDTO;
import br.com.fiap.governance.dto.EmpresaResponseDTO;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import br.com.fiap.governance.service.EmpresaService;

import java.util.List;

@RestController
@RequestMapping("/api/empresas")
public class EmpresaController {

    @Autowired
    private EmpresaService empresaService;

    @GetMapping
    public ResponseEntity<List<EmpresaResponseDTO>> listarEmpresas() {
        return ResponseEntity.ok(empresaService.listarTodas());
    }

    @PostMapping
    public ResponseEntity<EmpresaResponseDTO> adicionarEmpresa(@Valid @RequestBody EmpresaRequestDTO empresaRequestDTO) {
        EmpresaResponseDTO novaEmpresa = empresaService.adicionarEmpresa(empresaRequestDTO);
        return new ResponseEntity<>(novaEmpresa, HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<EmpresaResponseDTO> atualizarEmpresa(@PathVariable Integer id, @Valid @RequestBody EmpresaRequestDTO empresaRequestDTO) {
        EmpresaResponseDTO empresaAtualizada = empresaService.atualizarEmpresa(id, empresaRequestDTO);
        return ResponseEntity.ok(empresaAtualizada);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> excluirEmpresa(@PathVariable Integer id) {
        empresaService.excluirEmpresa(id);
        return ResponseEntity.noContent().build();
    }
}