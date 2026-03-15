const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
const multer = require('multer');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());
app.use('/uploads', express.static('uploads'));

const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, 'uploads/'),
    filename: (req, file, cb) => cb(null, Date.now() + path.extname(file.originalname))
});
const upload = multer({ storage });

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '', 
    database: 'irac_ref' 
});

db.connect((err) => {
    if (err) { console.error('❌ Connection Error:', err); return; }
    console.log('✅ Backend Ready! 🌳');
});

app.get('/api/pests', (req, res) => {
    db.query('SELECT * FROM pest', (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.get('/api/moa/:pestId', (req, res) => {
    const { pestId } = req.params;
    const sql = `SELECT DISTINCT g.g_id, g.g_name FROM irac_moa_group g JOIN active_ingredient ai ON g.g_id = ai.g_id JOIN ingredient_pest_control ipc ON ai.c_id = ipc.c_id WHERE ipc.pest_id = ?`;
    db.query(sql, [pestId], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.post('/api/login', (req, res) => {
    const { username, password } = req.body;
    db.query('SELECT * FROM users WHERE username = ? AND password = ?', [username, password], (err, results) => {
        if (results && results.length > 0) res.json({ user: { id: results[0].id, name: results[0].name } });
        else res.status(401).json({ error: 'Login failed' });
    });
});

app.post('/api/register', (req, res) => {
    const { username, password, name } = req.body;
    db.query('INSERT INTO users (username, password, name) VALUES (?, ?, ?)', [username, password, name], (err) => {
        if (err) return res.status(500).json({ error: 'Username นี้มีผู้ใช้แล้ว' });
        res.json({ message: 'Success' });
    });
});

app.get('/api/history/:userId', (req, res) => {
    const sql = `SELECT h.*, p.pest_name, g.g_name FROM usage_history h JOIN pest p ON h.pest_id = p.pest_id JOIN irac_moa_group g ON h.g_id = g.g_id WHERE h.user_id = ? ORDER BY h.usage_date DESC`;
    db.query(sql, [req.params.userId], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.post('/api/history', upload.single('image'), (req, res) => {
    const { user_id, pest_id, g_id, dosage, phi_days } = req.body;
    const image_path = req.file ? `/uploads/${req.file.filename}` : null;
    const sql = 'INSERT INTO usage_history (user_id, pest_id, g_id, dosage, phi_days, image_path, usage_date) VALUES (?, ?, ?, ?, ?, ?, NOW())';
    db.query(sql, [user_id, pest_id, g_id, dosage, phi_days, image_path], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Saved' });
    });
});

app.delete('/api/history/:historyId', (req, res) => {
    db.query('DELETE FROM usage_history WHERE log_id = ?', [req.params.historyId], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Deleted' });
    });
});

app.get('/api/stats/:userId', (req, res) => {
    db.query('SELECT g.g_name, COUNT(*) as count FROM usage_history h JOIN irac_moa_group g ON h.g_id = g.g_id WHERE h.user_id = ? GROUP BY g.g_name', [req.params.userId], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
});

app.listen(PORT, () => console.log(`🚀 Server running on port ${PORT}`));