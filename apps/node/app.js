async function main() {
    const mysql = require('mysql2/promise');
    const express = require('express');
    const app = express();
    const port = 3000;
    const connOpts = {
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        port: process.env.DB_PORT,
        password: process.env.DB_PASSWORD,
        database: process.env.DB_DATABASE
    };
    const conn = await mysql.createConnection(connOpts);
    console.log(`Connected to DB`);

    process.on('SIGINT', close);

    app.get('/', (req, res) => res.json({ hello: 'world' }));

    app.get('/blocks', getBlocks);
    app.get('/transactions', getTransactions);

    app.listen(port);
    console.log(`Listening on port ${port}.`);

    async function close() {
        await conn.end();
        process.exit(0);
    }

    async function getBlocks(req, res) {
        const [blocks] = await conn.query(`
      SELECT  u.hash, u.size, u.number
      FROM    blocks u`);
        res.json(blocks);
    }

    async function getTransactions(req, res) {
        const [transactions] = await conn.query(`
      SELECT  u.hash, u.size, u.block_number, u.block_hash
      FROM    transactions u`);
        res.json(transactions);
    }
}

main();