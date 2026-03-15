const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '', 
    database: 'irac_ref' 
});

db.connect((err) => {
    if (err) {
        console.error('❌ Database Connection Error:', err);
        return;
    }
    console.log('✅ Backend & Database Connected! 🌳');
});

// ดึงรายชื่อแมลงและโรค
app.get('/api/pests', (req, res) => {
    db.query('SELECT * FROM pest', (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// ดึงกลุ่มยา
app.get('/api/moa/:pestId', (req, res) => {
    const { pestId } = req.params;
    const sql = `
        SELECT DISTINCT g.g_id, g.g_name 
        FROM irac_moa_group g
        JOIN active_ingredient ai ON g.g_id = ai.g_id
        JOIN ingredient_pest_control ipc ON ai.c_id = ipc.c_id
        WHERE ipc.pest_id = ?
    `;
    db.query(sql, [pestId], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// ระบบ Login
app.post('/api/login', (req, res) => {
    const { username, password } = req.body;
    db.query('SELECT * FROM users WHERE username = ? AND password = ?', [username, password], (err, results) => {
        if (results && results.length > 0) {
            // ตรวจสอบว่าส่ง id ออกไปถูกต้อง
            res.json({ user: { id: results[0].id, name: results[0].name } });
        } else {
            res.status(401).json({ error: 'Login failed' });
        }
    });
});

// ดึงประวัติ (ใช้ log_id)
app.get('/api/history/:userId', (req, res) => {
    const sql = `
        SELECT h.log_id, h.usage_date, p.pest_name, g.g_name 
        FROM usage_history h
        JOIN pest p ON h.pest_id = p.pest_id
        JOIN irac_moa_group g ON h.g_id = g.g_id
        WHERE h.user_id = ?
        ORDER BY h.usage_date DESC
    `;
    db.query(sql, [req.params.userId], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

// บันทึกประวัติ
app.post('/api/history', (req, res) => {
    const { user_id, pest_id, g_id } = req.body;
    const sql = 'INSERT INTO usage_history (user_id, pest_id, g_id, usage_date) VALUES (?, ?, ?, NOW())';
    db.query(sql, [user_id, pest_id, g_id], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Saved' });
    });
});

// ลบประวัติ (ใช้ log_id)
app.delete('/api/history/:historyId', (req, res) => {
    const { historyId } = req.params;
    const sql = 'DELETE FROM usage_history WHERE log_id = ?'; 
    db.query(sql, [historyId], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        if (result.affectedRows === 0) return res.status(404).json({ error: 'ไม่พบรายการ' });
        res.json({ message: 'Deleted' });
    });
});

// สถิติ
app.get('/api/stats/:userId', (req, res) => {
    db.query('SELECT g.g_name, COUNT(*) as count FROM usage_history h JOIN irac_moa_group g ON h.g_id = g.g_id WHERE h.user_id = ? GROUP BY g.g_name', [req.params.userId], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));