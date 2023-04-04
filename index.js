const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

const Pool = require('pg').Pool;
// database koneksi
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'postgres',
  password: 'postgres',
  port: 5432,
});

app.use(bodyParser.json());
app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

app.get('/', (request, response) => {
  response.json({ info: 'Super simple api' });
});

app.post('/transaksi', async (req, res) => {
  // simple method [request tidak di devinisikan]
  const customerId = 1; //name = customer1
  const productId = 1; //name = product1
  const paymentMethodId = 1; //name = 1

  /**Masukan ke transaksi */

  const queryTransaksi = {
    text: 'INSERT INTO transaksi (customer_id, product_id) VALUES ($1, $2) RETURNING *',
    values: [customerId, productId],
  };
  const transaksiResults = await pool.query(queryTransaksi);
  const transaksiId = transaksiResults.rows[0].id;

  /**End transaksi */

  /*Cek payment method is active*/
  const paymentMethodResults = await pool.query({
    text: 'SELECT * FROM  payment_method WHERE id = $1',
    values: [paymentMethodId],
  });

  const is_active = paymentMethodResults.rows[0].is_active;

  if (is_active) {
    await pool.query({
      text: 'INSERT INTO payment (transaksi_id, paymentmethod_id) values($1, $2)',
      values: [transaksiId, paymentMethodId],
    });

    return res
      .status(201)
      .send(`Transaksi ditambahkan dengan ID: ${transaksiId}`);
  }
  /**cek payment method */

  return res
    .status(400)
    .send('Transaksi tidak bisa dilakukan dengan pembayaran ini');
});

app.listen(port, () => {
  console.log(`App running on port ${port}.`);
});
