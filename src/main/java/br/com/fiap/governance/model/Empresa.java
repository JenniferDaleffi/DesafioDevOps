package br.com.fiap.governance.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Entity
@Table(name = "EMPRESA")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Empresa {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "empresa_seq_gen") // Nome do gerador
    @SequenceGenerator(name = "empresa_seq_gen", sequenceName = "EMPRESA_SEQ", allocationSize = 1) // Nome da sequence no DB
    @Column(name = "id_empresa")
    private Integer idEmpresa;

    @NotBlank(message = "Nome da empresa é obrigatório")
    @Size(max = 20, message = "Nome da empresa deve ter no máximo 20 caracteres")
    @Column(name = "nome_empresa", nullable = false, length = 20)
    private String nomeEmpresa;

    @NotBlank(message = "CNPJ é obrigatório")
    @Pattern(regexp = "\\d{14}", message = "CNPJ deve conter 14 dígitos numéricos")
    @Column(name = "cnpj", nullable = false, length = 14, unique = true)
    private String cnpj;

    @Size(max = 150, message = "Endereço deve ter no máximo 150 caracteres")
    @Column(name = "endereco", length = 150)
    private String endereco;

}