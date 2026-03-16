const express = require('express');
const cors = require('cors');
const Database = require('better-sqlite3'); 
const multer = require('multer');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use('/uploads', express.static('uploads'));

if (!fs.existsSync('./uploads')) { fs.mkdirSync('./uploads'); }

// --- 1. เชื่อมต่อฐานข้อมูล (ดีกว่าและเสถียรกว่าบน Render) ---
const db = new Database('irac_ref.db');
console.log('✅ Connected to SQLite via better-sqlite3');

// --- 2. ฟังก์ชันนำเข้าข้อมูลจาก irac_ref.sql ---
function importSQL() {
    const sqlPath = path.join(__dirname, 'irac_ref.sql');
    if (fs.existsSync(sqlPath)) {
        const sql = fs.readFileSync(sqlPath, 'utf8');
        db.exec(sql); 
        console.log('📊 ข้อมูลโรคและศัตรูพืช 23 รายการพร้อมใช้งาน!');
    }
}
importSQL();

// --- 3. API Endpoints (ปรับปรุง Syntax ใหม่ทั้งหมด) ---

// ดึงรายชื่อศัตรูพืช
app.get('/api/pests', (req, res) => {
    try {
        const rows = db.prepare('SELECT * FROM pest').all();
        res.json(rows);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// ดึงกลุ่มยา (MoA) - **ส่วนที่ทำให้ปุ่มกลับมาแสดงผล**
app.get('/api/moa/:pestId', (req, res) => {
    const { pestId } = req.params;
    const sql = `SELECT DISTINCT g.g_id, g.g_name 
                 FROM irac_moa_group g 
                 JOIN active_ingredient ai ON g.g_id = ai.g_id 
                 JOIN ingredient_pest_control ipc ON ai.c_id = ipc.c_id 
                 WHERE ipc.pest_id = ?`;
    try {
        const rows = db.prepare(sql).all(pestId);
        res.json(rows); // ส่งข้อมูลกลับไปให้ App.jsx สร้างปุ่ม
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.post('/api/login', (req, res) => {
    const { username, password } = req.body;
    try {
        const row = db.prepare('SELECT * FROM users WHERE username = ? AND password = ?').get(username, password);
        if (row) res.json({ user: { id: row.id, name: row.name } });
        else res.status(401).json({ error: 'Login failed' });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

// --- API สำหรับสมัครสมาชิกใหม่ (เพิ่มส่วนนี้) ---
app.post('/api/register', (req, res) => {
    const { username, password, name } = req.body;
    try {
        // เตรียมคำสั่ง SQL สำหรับเพิ่มผู้ใช้ใหม่ลงในตาราง users
        const stmt = db.prepare('INSERT INTO users (username, password, name) VALUES (?, ?, ?)');
        stmt.run(username, password, name);
        res.json({ message: 'สมัครสมาชิกสำเร็จแล้ว!' });
    } catch (err) {
        // ตรวจสอบว่าชื่อผู้ใช้ซ้ำหรือไม่
        if (err.code === 'SQLITE_CONSTRAINT_UNIQUE') {
            res.status(400).json({ error: '❌ ชื่อผู้ใช้นี้มีอยู่ในระบบแล้ว' });
        } else {
            res.status(500).json({ error: '❌ เกิดข้อผิดพลาด: ' + err.message });
        }
    }
});

app.get('/api/history/:userId', (req, res) => {
    const sql = `SELECT h.*, p.pest_name, g.g_name FROM usage_history h 
                 JOIN pest p ON h.pest_id = p.pest_id 
                 JOIN irac_moa_group g ON h.g_id = g.g_id 
                 WHERE h.user_id = ? ORDER BY h.usage_date DESC`;
    try {
        const rows = db.prepare(sql).all(req.params.userId);
        res.json(rows);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

const upload = multer({ dest: 'uploads/' });
app.post('/api/history', upload.single('image'), (req, res) => {
    const { user_id, pest_id, g_id, dosage, phi_days } = req.body;
    const image_path = req.file ? `/uploads/${req.file.filename}` : null;
    const sql = `INSERT INTO usage_history (user_id, pest_id, g_id, dosage, phi_days, image_path, usage_date) 
                 VALUES (?, ?, ?, ?, ?, ?, date('now'))`;
    try {
        db.prepare(sql).run(user_id, pest_id, g_id, dosage, phi_days, image_path);
        res.json({ message: 'Saved' });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.delete('/api/history/:historyId', (req, res) => {
    try {
        db.prepare('DELETE FROM usage_history WHERE log_id = ?').run(req.params.historyId);
        res.json({ message: 'Deleted' });
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.get('/api/stats/:userId', (req, res) => {
    const sql = `SELECT g.g_name, COUNT(*) as count FROM usage_history h 
                 JOIN irac_moa_group g ON h.g_id = g.g_id 
                 WHERE h.user_id = ? GROUP BY g.g_name`;
    try {
        const rows = db.prepare(sql).all(req.params.userId);
        res.json(rows);
    } catch (err) { res.status(500).json({ error: err.message }); }
});

app.listen(PORT, () => console.log(`🚀 Server with better-sqlite3 on port ${PORT}`));