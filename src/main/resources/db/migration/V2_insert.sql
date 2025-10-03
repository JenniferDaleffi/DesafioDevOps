INSERT INTO LIC_AMBIENTAL (id_licenca, id_empresa, validade)
VALUES (1, 1001, TO_DATE('2025-12-31', 'YYYY-MM-DD')); -- Ativa
INSERT INTO LIC_AMBIENTAL (id_licenca, id_empresa, validade)
VALUES (2, 1002, TO_DATE('2026-01-15', 'YYYY-MM-DD')); -- Ativa
INSERT INTO LIC_AMBIENTAL (id_licenca, id_empresa, validade)
VALUES (3, 1003, TO_DATE('2022-01-01', 'YYYY-MM-DD')); -- Expirada
INSERT INTO LIC_AMBIENTAL (id_licenca, id_empresa, validade)
VALUES (4, 1004, TO_DATE('2025-08-01', 'YYYY-MM-DD')); -- Ativa
INSERT INTO LIC_AMBIENTAL (id_licenca, id_empresa, validade)
VALUES (5, 1005, TO_DATE('2025-10-01', 'YYYY-MM-DD')); -- Ativa

SELECT * FROM LIC_AMBIENTAL;

INSERT INTO EMPRESA (id_empresa, nome_empresa, cnpj, endereco)
VALUES (1001, 'Empresa Igor', '12345678000101', 'Rua A, 123 - São Paulo, SP'); -- Ativa
INSERT INTO EMPRESA (id_empresa, nome_empresa, cnpj, endereco)
VALUES (1002, 'Empresa Beta', '23456789000102', 'Av. Brasil, 456 - Rio de Janeiro, RJ'); -- Ativa
INSERT INTO EMPRESA (id_empresa, nome_empresa, cnpj, endereco)
VALUES (1003, 'Empresa Gama', '34567890000103', 'Rua das Flores, 789 - Curitiba, PR'); -- Expirada
INSERT INTO EMPRESA (id_empresa, nome_empresa, cnpj, endereco)
VALUES (1004, 'Empresa Delta', '45678901000104', 'Av. Paulista, 101 - São Paulo, SP'); -- Ativa
INSERT INTO EMPRESA (id_empresa, nome_empresa, cnpj, endereco)
VALUES (1005, 'Empresa Epsilon', '56789012000105', 'Rua Central, 202 - Belo Horizonte, MG'); -- Ativa


SELECT * FROM EMPRESA;