CREATE DATABASE motor_credito; 
USE motor_credito;

DROP DATABASE motor_credito;


CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    sexo CHAR(1),
    idade INT,
    estado CHAR(2),
    renda_mensal DECIMAL(10,2),
    segmento VARCHAR(20),
    score_interno INT
);

CREATE TABLE produtos_credito (
    id_produto INT PRIMARY KEY,
    nome_produto VARCHAR(50),
    tipo VARCHAR(30),
    taxa_juros DECIMAL(5,2),
    prazo_maximo INT
);

CREATE TABLE contratos (
    id_contrato INT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    data_contratacao DATE,
    valor_contratado DECIMAL(10,2),
    prazo_meses INT,
    status VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produtos_credito(id_produto)
);

CREATE TABLE parcelas (
    id_parcela INT PRIMARY KEY,
    id_contrato INT,
    numero_parcela INT,
    valor_parcela DECIMAL(10,2),
    data_vencimento DATE,
    FOREIGN KEY (id_contrato) REFERENCES contratos(id_contrato)
);

CREATE TABLE pagamentos (
    id_pagamento INT PRIMARY KEY,
    id_parcela INT,
    data_pagamento DATE,
    valor_pago DECIMAL(10,2),
    atraso_dias INT,
    FOREIGN KEY (id_parcela) REFERENCES parcelas(id_parcela)
);


INSERT INTO cliente VALUES
(1,'Ana Silva','F',29,'SP',4200,'PF',720),
(2,'Bruno Santos','M',35,'RJ',5800,'PF',680),
(3,'Carlos Lima','M',42,'MG',7600,'PF',750),
(4,'Daniela Rocha','F',31,'SP',3900,'PF',640),
(5,'Eduardo Alves','M',50,'PR',9200,'PF',810),
(6,'Fernanda Costa','F',27,'BA',3100,'PF',610),
(7,'Gustavo Pereira','M',38,'RS',6700,'PF',700),
(8,'Helena Martins','F',45,'SP',8400,'PF',780),
(9,'Igor Nogueira','M',33,'RJ',5200,'PF',690),
(10,'Juliana Farias','F',41,'PE',6100,'PF',720);


INSERT INTO produtos_credito VALUES
(1,'Crédito Pessoal','Pessoal',4.50,48),
(2,'Consignado','Consignado',2.10,72),
(3,'Cartão Crédito','Cartão',9.90,36);

INSERT INTO contratos VALUES
(1,1,1,'2023-01-10',12000,24,'ativo'),
(2,2,1,'2023-02-15',18000,36,'inadimplente'),
(3,3,2,'2023-03-20',25000,48,'ativo'),
(4,4,1,'2023-04-05',10000,24,'inadimplente'),
(5,5,2,'2023-01-18',30000,60,'ativo'),
(6,6,3,'2023-05-12',8000,18,'ativo'),
(7,7,1,'2023-06-01',15000,36,'ativo'),
(8,8,2,'2023-02-28',22000,48,'ativo'),
(9,9,1,'2023-03-14',14000,24,'inadimplente'),
(10,10,3,'2023-04-20',9000,18,'ativo');


INSERT INTO parcelas VALUES
(1,2,1,500,'2023-03-15'),
(2,2,2,500,'2023-04-15'),
(3,4,1,420,'2023-05-05'),
(4,9,1,580,'2023-04-14');

INSERT INTO pagamentos VALUES
(1,1,'2023-03-28',500,13),
(2,2,'2023-05-10',500,25),
(3,3,'2023-06-20',420,46),
(4,4,'2023-05-25',580,41);

SELECT estado, COUNT(*) AS qtd_inadimplentes
FROM cliente c
JOIN contratos ct ON c.id_cliente = ct.id_cliente
WHERE ct.status = 'inadimplente'
GROUP BY estado;

SELECT
  status,
  ROUND(AVG(score_interno),0) AS score_medio
FROM contratos ct
JOIN cliente c ON ct.id_cliente = c.id_cliente
GROUP BY status;

SELECT 
    ct.status,
    ROUND(AVG(c.score_interno),0) AS score_medio,
    COUNT(*) AS total_contratos
FROM contratos ct
JOIN cliente c ON ct.id_cliente = c.id_cliente
GROUP BY ct.status
ORDER BY score_medio ASC;














