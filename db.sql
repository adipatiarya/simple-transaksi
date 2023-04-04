CREATE TABLE "customer" (
  "id" int PRIMARY KEY,
  "customer_name" varchar NOT NULL
);

CREATE TABLE "customer_address" (
  "id" int PRIMARY KEY,
  "customer_id" int NOT NULL,
  "address" date NOT NULL
);

CREATE TABLE "product" (
  "id" int PRIMARY KEY,
  "name" varchar NOT NULL,
  "price" decimal NOT NULL
);

CREATE TABLE "payment_method" (
  "id" int PRIMARY KEY,
  "name" varchar NOT NULL,
  "is_active" smallint NOT NULL
);

CREATE TABLE "transaksi" (
  "id" serial PRIMARY KEY,
  "customer_id" int NOT NULL,
  "product_id" int NOT NULL
);

CREATE TABLE "payment" (
  "id" serial PRIMARY KEY,
  "transaksi_id" int NOT NULL,
  "paymentmethod_id" int NOT NULL
);

ALTER TABLE "customer_address"
  ADD CONSTRAINT "fk_customer_address.customer_id_costumer.id" FOREIGN KEY(customer_id) REFERENCES customer(id) ON DELETE CASCADE;

ALTER TABLE "transaksi"
  ADD CONSTRAINT "fk_transaksi.customer_id_customer.id" FOREIGN KEY(customer_id) REFERENCES customer(id) ON DELETE SET NULL;
ALTER TABLE "transaksi"
  ADD CONSTRAINT "fk_transaksi.product_id_product.id" FOREIGN KEY(product_id) REFERENCES product(id) ON DELETE SET NULL;

ALTER TABLE "payment"
  ADD CONSTRAINT "fk_payment.transaksi_id_transaksi.id" FOREIGN KEY(transaksi_id) REFERENCES transaksi(id) ON DELETE SET NULL;
ALTER TABLE "payment"
  ADD CONSTRAINT "fk_transaksi.paymentmethod_id.payment_method.id" FOREIGN KEY(paymentmethod_id) REFERENCES payment_method(id) ON DELETE SET NULL;



INSERT INTO customer(id, customer_name) VALUES (1, 'customer1');
INSERT INTO customer_address(id, customer_id, address) VALUES (1, 1, '2015-12-17');
INSERT INTO product(id, name, price) VALUES(1, 'product1',799.9);
INSERT INTO payment_method(id, name, is_active) VALUES(1, 'bca', 1);

