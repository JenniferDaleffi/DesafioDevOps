package br.com.fiap.governance.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class EmpresaRequestDTO {
    @NotBlank(message = "Nome da empresa é obrigatório")
    @Size(max = 20)
    private String nomeEmpresa;

    @NotBlank(message = "CNPJ é obrigatório")
    @Pattern(regexp = "\\d{14}", message = "CNPJ deve ter 14 dígitos")
    private String cnpj;

    @Size(max = 150)
    private String endereco;
}