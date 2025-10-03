CREATE TABLE AUDI_AMBIENTAL
(
    id_auditoria   INTEGER  NOT NULL ,
    data_auditoria DATE ,
    responsavel    VARCHAR2 (100 CHAR) ,
    resultado      VARCHAR2 (100 CHAR) ,
    id_empresa     INTEGER  NOT NULL
)
;

ALTER TABLE AUDI_AMBIENTAL
    ADD CONSTRAINT TBL_AUDITORIA_AMBIENTAL_PK PRIMARY KEY ( id_auditoria ) ;

CREATE TABLE COMP_AMBIENTAL
(
    id_compensacao   INTEGER  NOT NULL ,
    tipo_compensacao VARCHAR2 (50 CHAR) ,
    descricao        VARCHAR2 (150 CHAR) ,
    data_compensacao DATE ,
    id_empresa       INTEGER  NOT NULL
)
;

ALTER TABLE COMP_AMBIENTAL
    ADD CONSTRAINT TBL_COMPENSACAO_AMBIENTAL_PK PRIMARY KEY ( id_compensacao ) ;

CREATE TABLE EMI_CARBONO
(
    id_emissao           INTEGER  NOT NULL ,
    data_emissao         DATE ,
    setor                VARCHAR2 (50 CHAR) ,
    quantidade_toneladas NUMBER (8,2) ,
    id_empresa           INTEGER  NOT NULL
)
;

ALTER TABLE EMI_CARBONO
    ADD CONSTRAINT TBL_EMISSAO_CARBONO_PK PRIMARY KEY ( id_emissao ) ;

CREATE SEQUENCE empresa_seq START WITH 1 INCREMENT BY 1;

CREATE TABLE empresa
(
    id_empresa   INTEGER      NOT NULL,
    nome_empresa VARCHAR2(20) NOT NULL,
    cnpj         VARCHAR2(14) NOT NULL,
    endereco     VARCHAR2(150),
    CONSTRAINT pk_empresa PRIMARY KEY (id_empresa)
);

ALTER TABLE empresa
    ADD CONSTRAINT uc_empresa_cnpj UNIQUE (cnpj);

CREATE TABLE LIC_AMBIENTAL
(
    id_licenca INTEGER  NOT NULL ,
    tipo       VARCHAR2 (50 CHAR) ,
    validade   DATE ,
    status     VARCHAR2 (20 CHAR) ,
    id_empresa INTEGER  NOT NULL
)
;

ALTER TABLE LIC_AMBIENTAL
    ADD CONSTRAINT TBL_LICENCA_AMBIENTAL_PK PRIMARY KEY ( id_licenca ) ;

ALTER TABLE AUDI_AMBIENTAL
    ADD CONSTRAINT AUDI_AMBIENTAL_EMPRESA_FK FOREIGN KEY
        (
         id_empresa
            )
        REFERENCES EMPRESA
            (
             id_empresa
                )
;

ALTER TABLE COMP_AMBIENTAL
    ADD CONSTRAINT COMP_AMBIENTAL_EMPRESA_FK FOREIGN KEY
        (
         id_empresa
            )
        REFERENCES EMPRESA
            (
             id_empresa
                )
;

ALTER TABLE EMI_CARBONO
    ADD CONSTRAINT EMI_CARBONO_EMPRESA_FK FOREIGN KEY
        (
         id_empresa
            )
        REFERENCES EMPRESA
            (
             id_empresa
                )
;

ALTER TABLE LIC_AMBIENTAL
    ADD CONSTRAINT LIC_AMBIENTAL_EMPRESA_FK FOREIGN KEY
        (
         id_empresa
            )
        REFERENCES EMPRESA
            (
             id_empresa
                )
;