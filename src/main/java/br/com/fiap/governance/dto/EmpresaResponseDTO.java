package br.com.fiap.governance.dto;
import lombok.Data;

@Data
public class EmpresaResponseDTO {
    private Integer idEmpresa;
    private String nomeEmpresa;
    private String cnpj;
    private String endereco;
}