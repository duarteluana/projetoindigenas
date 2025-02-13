CREATE DATABASE indigenas;
USE indigenas;

CREATE TABLE POVO_INDIGENA (
    id_povo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    localizacao TEXT,
    populacao INT
);

CREATE TABLE ARTE_INDIGENA (
    id_arte INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    id_povo INT,
    FOREIGN KEY (id_povo) REFERENCES POVO_INDIGENA(id_povo)
);

CREATE TABLE HISTORIA_LENDA (
    id_historia INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(200) NOT NULL,
    conteudo TEXT,
    id_povo INT,
    FOREIGN KEY (id_povo) REFERENCES POVO_INDIGENA(id_povo)
);

CREATE TABLE BOLETIM_INFORMATIVO (
    id_inscricao INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) UNIQUE NOT NULL,
    data_inscricao DATETIME DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
     FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);
CREATE TABLE CATEGORIA (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

CREATE TABLE PRODUTO (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    preco_parcelado DECIMAL(10, 2),
    num_parcelas INT,
    url_imagem VARCHAR(255),
    estoque INT DEFAULT 0,
    id_categoria INT,
    id_povo INT,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIA(id_categoria),
    FOREIGN KEY (id_povo) REFERENCES POVO_INDIGENA(id_povo)
);
CREATE TABLE CLIENTE (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    endereco TEXT NOT NULL,
    telefone VARCHAR(20),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE PEDIDO (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    valor_total DECIMAL(10, 2) NOT NULL,
    status ENUM('Pendente', 'Confirmado', 'Em Processamento', 'Enviado', 'Entregue', 'Cancelado') DEFAULT 'Pendente',
    data_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente)
);

CREATE TABLE ITEM_PEDIDO (
    id_item INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES PRODUTO(id_produto)
);

CREATE TABLE PAGAMENTO (
    id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    id_pedido INT,
    valor DECIMAL(10, 2) NOT NULL,
    status ENUM('Pendente', 'Aprovado', 'Recusado', 'Estornado') DEFAULT 'Pendente',
    metodo_pagamento ENUM('PIX', 'Cartão de Crédito', 'Boleto') NOT NULL,
    data_pagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pedido) REFERENCES PEDIDO(id_pedido)
);
ALTER TABLE BOLETIM_INFORMATIVO
ADD COLUMN id_cliente INT NOT NULL;

ALTER TABLE BOLETIM_INFORMATIVO
ADD FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente);
