
CREATE DATABASE bakery_michi
  WITH OWNER = ecommerce
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'es_CO.UTF-8'
       LC_CTYPE = 'es_CO.UTF-8'
       CONNECTION LIMIT = -1;


CREATE ROLE ecommerce_admin WITH LOGIN ENCRYPTED PASSWORD '234567';
CREATE ROLE ecommerce_client WITH LOGIN ENCRYPTED PASSWORD '345678';
CREATE ROLE ecommerce_guest WITH LOGIN ENCRYPTED PASSWORD '456789';

CREATE TABLE categories (
id bigserial NOT NULL,
published integer NOT NULL DEFAULT '0',
name varchar (255) NOT NULL,
icon varchar (255) NOT NULL,
created_at timestamp without time zone DEFAULT now (),
updated_at timestamp without time zone DEFAULT now (),
CONSTRAINT categories_pkey PRIMARY KEY (id)
)
WITH (OIDS=FALSE);
ALTER TABLE public.categories OWNER TO ecommerce;



CREATE TABLE products (
id bigserial NOT NULL,
published integer NOT NULL DEFAULT '0',
rating_cache double precision NOT NULL DEFAULT '3.0',
rating_count double precision NOT NULL DEFAULT '0',
category_id bigint NOT NULL,
name varchar (255) NOT NULL,
pricing double precision NOT NULL DEFAULT '0.00',
short_description text NOT NULL,
long_description text NOT NULL,
icon varchar (255) NOT NULL,
created_at timestamp without time zone DEFAULT now (),
updated_at timestamp without time zone DEFAULT now (),
CONSTRAINT products_pkey PRIMARY KEY (id),
CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id)
REFERENCES public.categories (id) MATCH SIMPLE
ON UPDATE NO ACTION
ON DELETE NO ACTION
)
WITH (OIDS=FALSE);
ALTER TABLE public.products OWNER TO ecommerce;



CREATE TABLE users (
id bigserial NOT NULL,
user_type integer NOT NULL DEFAULT '0',
username varchar (128) NOT NULL,
email varchar (128) NOT NULL,
password varchar (128) NOT NULL,
created_at timestamp without time zone DEFAULT now (),
updated_at timestamp without time zone DEFAULT now (),
CONSTRAINT users_pkey PRIMARY KEY (id)
)
WITH (OIDS=FALSE);
ALTER TABLE public.users OWNER TO ecommerce;


CREATE TABLE reviews (
id bigserial NOT NULL,
user_id bigint NOT NULL,
item_id bigint NOT NULL,
rating double precision NOT NULL,
comment text NOT NULL,
approved integer NOT NULL DEFAULT '1',
spam integer NOT NULL DEFAULT '0',
created_at timestamp without time zone DEFAULT now (),
updated_at timestamp without time zone DEFAULT now (),
CONSTRAINT reviews_pkey PRIMARY KEY (id)
)
WITH (OIDS=FALSE);
ALTER TABLE public.reviews OWNER TO ecommerce;





CREATE TABLE public.purchases
(
    id bigserial NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT purchases_pkey PRIMARY KEY (id),
    CONSTRAINT purchases_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.purchases
    OWNER to ecommerce;



CREATE TABLE public.purchase_items
(
    id bigserial NOT NULL,
    purchase_id bigint NOT NULL,
    product_id bigint NOT NULL,
    price double precision NOT NULL,
    quantity double precision NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    CONSTRAINT purchase_items_pkey PRIMARY KEY (id),
    CONSTRAINT purchase_items_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.products (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT purchase_items_purchase_id_fkey FOREIGN KEY (purchase_id)
        REFERENCES public.purchases (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);


ALTER TABLE public.purchase_items
    OWNER to ecommerce;


INSERT INTO categories ("published", "name", "icon") VALUES
(1, 'Panaderia', 'panaderia.jpg'),
(1, 'Pasteleria', 'pasteleria.jpg'),
(1,'Colombianitas','Colombianitas.jpg');

INSERT INTO products ("published", "rating_cache", "rating_count", "category_id", "name", "pricing", "short_description", "long_description", "icon") VALUES	
(1, 3.0, 0, 1, 'Pan de Yuca', 1000.00,'Delicioso pan de Yuca coombiano', 'Delicioso pan de Yuca coombiano', 'pandeyuca.jpg'),
(1, 3.0, 0, 1, 'Bizcocho', 1000.00,'Clasica delicia opita', 'Clasica delicia opita', 'bizcocho.jpg'),
(1, 3.0, 0, 1, 'Cuca Colombiana', 2000.00,'Artesania culinaria Colombiana, Cuca echa de panela', 'Artesania culinaria Colombiana, Cuca echa de panela', 'cucascolombianas.jpeg'),
(1, 3.0, 0, 1, 'Pan Rollo', 800.00,'Clasico y delicioso pan rollo', 'Clasico y delicioso pan rollo' , 'panrollo.jpeg'),
(1, 3.0, 0, 1, 'Liberales Colombianos', 2000.00,'Dulces y deliciosos liberales un clasico de la cultura colombiana', 'Dulces y deliciosos liberales un clasico de la cultura colombiana', 'liberalescolombianos.jpg'),
(1, 3.0, 0, 1, 'Pan de Queso', 2000.00, 'Para el desayuno y acompanar en todo momento. El nuestro es el mas delicioso' , 'Para el desayuno y acompanar en todo momento. El nuestro es el mas delicioso' ,'pandequeso.jpeg'),
(1, 3.0, 0, 1, 'Pan de la casa', 4000.00, 'Es un pan con una masa especialmente tratada con un interior de queso y salsa de frambuesa' , 'Es un pan con una masa especialmente tratado con un interior de queso y salsa de frambuesa' ,'pandelacasa.jpg'),
(1, 3.0, 0, 2, 'Torta de chocolate', 3000.00,'La tradicional torta de chocolate de la abuela', 'La tradicional torta de chocolate de la abuela' , 'tortadechocolate.jpg'),
(1, 3.0, 0, 2, 'Torta de vainilla', 3000.00,'La tradicional torta de vainilla de la abuela', 'La tradicional torta de vainilla de la abuela' , 'tortadevainilla.jpg'),
(1, 3.0, 0, 2, 'Torta de amapola', 3000.00,'La tradicional torta de amapola de la abuela', 'La tradicional torta de amapola de la abuela' , 'tortadeamapola.jpg'),
(1, 3.0, 0, 2, 'cheesecake', 3000.00,'La tradicional cheesecake de la abuela', 'La tradicional cheeseckae de la abuela' , 'cheesecake.jpg'),
(1, 3.0, 0, 2, 'Torta de Maria Luisa', 3000.00, 'Torta de dona Maria Luisa una delicia artesanal', 'Torta de dona Maria Luisa una delicia artesanal', 'tortademarialuisa.jpg'),
(1, 3.0, 0, 2, 'Postre de Milo', 3500.00, 'El postre que puedes encontrar en muchas partes pero nuestro postre de milo es el mejor', 'El postre que puedes encontrar en muchas partes pero nuestro postre de milo es el mejor', 'postredemilo.jpg'),
(1, 3.0, 0, 3, 'Empanadas Colombianas', 900.00, 'Nuestras empanadas combinan las tradiciones colombianas de nuestra gastronomia', 'Nuestras empanadas combinan las tradiciones colombianas de nuestra gastronomia', 'empanadacolombiana.jpeg'),
(1, 3.0, 0, 3, 'Juanvalerios', 2000.00, 'Composicion gastronomica de platano, chicharron y otros deliciosos componentes', 'Composicion gastronomica de platano, chicharron y otros deliciosos componentes', 'juanvalerios.jpg'),
(1, 3.0, 0, 3, 'Tammales Colombianos', 5000.00, 'Clasico, tradicional y delicioso tamal colombiano', 'Clasico, tradicional y delicioso tamal colombiano' ,'tamal1.jpg'),
(1, 3.0, 0, 3, 'Aborrajados', 1500.00, 'Mezcla compuesta de platano, queso y jamoneta. Sederrite en la boca', 'Mezcla compuesta de platano, queso y jamoneta. Sederrite en la boca', 'aborrajado.jpg'),
(1, 3.0, 0, 3, 'Arepas', 1200.00, 'La arepita de queso que nunca falta en nuestros desayunos', 'La arepita de queso que nunca falta en nuestros desayunos', 'arepas.jpg'),
(1, 3.0, 0, 3, 'Arepa de choclo', 1200.00, 'Arepa oriunda del Valle caucano, con un queso campesino de tierras magicas', 'Arepa oriunda del Valle caucano, con un queso campesino de tierras magicas', 'arepadechoclo.jpg');



INSERT INTO users ("username", "email", "password") VALUES 
('ivan', 'ivan.hernan@gmail.com', 'ivanhernan'),
('laura', 'laura.valentina@gmail.com', 'lauravalentina'),
('andrea', 'andrea.acevedo@gmail.com', 'andreaacevedo');



INSERT INTO reviews ("item_id", "user_id", "rating", "comment") VALUES

(1,1,4.5,'Comment 001'),
(1,2,3.5,'Comment 002'),
(2,3,4.0,'Comment 003'),
(2,1,2.5,'Comment 004'),
(3,2,3.5,'Comment 005'),
(3,3,3.0,'Comment 006'),
(4,1,4.0,'Comment 007'),
(4,2,3.5,'Comment 008'),
(5,3,2.0,'Comment 009'),
(5,1,5.0,'Comment 010'),
(6,2,3.0,'Comment 011'),
(6,3,3.5,'Comment 012'),
(7,1,3.0,'Comment 013'),
(7,2,4.5,'Comment 014'),
(8,3,4.0,'Comment 015'),
(8,1,3.0,'Comment 016'),
(9,2,4.5,'Comment 017'),
(9,3,4.0,'Comment 018'),
(10,1,3.0,'Comment 019'),
(10,2,4.5,'Comment 020'),
(11,3,4.0,'Comment 021'),
(12,1,3.0,'Comment 022'),
(12,2,4.5,'Comment 023'),
(13,3,2.5,'Comment 024'),
(14,1,3.0,'Comment 025'),
(14,2,4.5,'Comment 026'),
(15,2,4.5,'Comment 026'),
(15,2,4.5,'Comment 026');

grant select, insert, update, delete on categories to ecommerce_admin;
grant select, insert, update, delete on products to ecommerce_admin;
grant select, insert, update, delete on reviews to ecommerce_admin;
grant select, insert, update, delete on purchases to ecommerce_admin;
grant select, insert, update, delete on purchase_items to ecommerce_admin;
grant select, insert, update, delete on users to ecommerce_admin;


grant select on categories to ecommerce_client;
grant select on products to ecommerce_client;
grant select,update, insert on reviews to ecommerce_client;
grant select, insert on purchases to ecommerce_client;
grant select, insert on purchase_items to ecommerce_client;
grant select on users to ecommerce_client;
 

grant select on categories to ecommerce_guest;
grant select on products to ecommerce_guest;
grant select on reviews to ecommerce_guest;
