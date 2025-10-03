-- 1. Trigger para atualizar status da LICENÇA automaticamente para ‘Expirada’:

CREATE OR REPLACE TRIGGER TRG_ATUALIZA_STATUS_LICENCA
    BEFORE INSERT OR UPDATE ON LIC_AMBIENTAL
    FOR EACH ROW
BEGIN
    IF :NEW.validade < SYSDATE THEN
        :NEW.status := 'Expirada';
    ELSE
        :NEW.status := 'Ativa';
    END IF;
END;

-- 2. Trigger para impedir emissão de carbono por empresa sem licença ambiental válida:

CREATE OR REPLACE TRIGGER TRG_VERIFICA_LICENCA_EMISSAO
    BEFORE INSERT ON EMI_CARBONO
    FOR EACH ROW
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM LIC_AMBIENTAL
    WHERE id_empresa = :NEW.id_empresa
      AND validade >= SYSDATE
      AND status = 'Ativa';
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Empresa sem licença ambiental válida.');
    END IF;
END;


-- 3. Trigger para registrar automaticamente uma compensação ambiental quando emissão ultrapassar 100 toneladas:

CREATE SEQUENCE COMP_AMBIENTAL_SEQ START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE TRIGGER TRG_AUTO_COMPENSACAO
    AFTER INSERT ON EMI_CARBONO
    FOR EACH ROW
BEGIN
    IF :NEW.quantidade_toneladas > 100 THEN
        INSERT INTO COMP_AMBIENTAL (
            id_compensacao,
            tipo_compensacao,
            descricao,
            data_compensacao,
            id_empresa
        ) VALUES (
                     COMP_AMBIENTAL_SEQ.NEXTVAL,
                     'Automática',
                     'Compensação por emissão superior a 100 toneladas',
                     SYSDATE,
                     :NEW.id_empresa
                 );
    END IF;
END;

-- 4. Trigger para atualizar resultado da auditoria como 'Conforme' se não houver emissão de carbono no mês:

CREATE OR REPLACE TRIGGER TRG_RESULTADO_AUDITORIA
    BEFORE INSERT ON AUDI_AMBIENTAL
    FOR EACH ROW
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM EMI_CARBONO
    WHERE id_empresa = :NEW.id_empresa
      AND EXTRACT(MONTH FROM data_emissao) = EXTRACT(MONTH FROM :NEW.data_auditoria)
      AND EXTRACT(YEAR FROM data_emissao) = EXTRACT(YEAR FROM :NEW.data_auditoria);
    IF v_count = 0 THEN
        :NEW.resultado := 'Conforme';
    END IF;
END;
