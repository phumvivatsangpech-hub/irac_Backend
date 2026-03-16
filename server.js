const express = require('express');
const cors = require('cors');
const sqlite3 = require('sqlite3').verbose();
const multer = require('multer');
const path = require('path');
const fs = require('fs');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());
app.use('/uploads', express.static('uploads'));

// --- ส่วนจัดการฐานข้อมูล SQLite ---
// สร้างไฟล์ฐานข้อมูลชื่อ irac_ref.db
const db = new sqlite3.Database('./irac_ref.db', (err) => {
    if (err) {
        console.error('❌ SQLite Connection Error:', err);
    } else {
        console.log('✅ Connected to SQLite Database (irac_ref.db)');
        importSQLSchema(); // รันพิมพ์เขียวจากไฟล์ .sql ของคุณ
    }
});

// ฟังก์ชันสำหรับอ่านไฟล์ irac_ref.sql มาสร้างตาราง
function importSQLSchema() {
    try {
        const sqlPath = path.join(__dirname, 'irac_ref.sql');
        if (fs.existsSync(sqlPath)) {
            const sql = fs.readFileSync(sqlPath, 'utf8');
            db.exec(sql, (err) => {
                if (err) console.log('ℹ️ Note: Tables exist or schema already imported.');
                else console.log('📊 irac_ref.sql Schema successfully imported!');
            });
        } else {
            console.error('⚠️ Warning: irac_ref.sql not found in root directory!');
        }
    } catch (error) {
        console.error('❌ Error reading SQL file:', error);
    }
}

// --- API ต่างๆ (ปรับเป็น Syntax ของ SQLite) ---

app.get('/api/pests', (req, res) => {
    db.all('SELECT * FROM pest', [], (err, rows) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(rows);
    });
});

app.get('/api/moa/:pestId', (req, res) => {
    const { pestId } = req.params;
    const sql = `SELECT DISTINCT g.g_id, g.g_name FROM irac_moa_group g 
                 JOIN active_ingredient ai ON g.g_id = ai.g_id 
                 JOIN ingredient_pest_control ipc ON ai.c_id = ipc.c_id 
                 WHERE ipc.pest_id = ?`;
    db.all(sql, [pestId], (err, rows) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(rows);
    });
});

app.post('/api/login', (req, res) => {
    const { username, password } = req.body;
    db.get('SELECT * FROM users WHERE username = ? AND password = ?', [username, password], (err, row) => {
        if (err) return res.status(500).json({ error: err.message });
        if (row) res.json({ user: { id: row.id, name: row.name } });
        else res.status(401).json({ error: 'Login failed' });
    });
});

app.get('/api/history/:userId', (req, res) => {
    const sql = `SELECT h.*, p.pest_name, g.g_name FROM usage_history h 
                 JOIN pest p ON h.pest_id = p.pest_id 
                 JOIN irac_moa_group g ON h.g_id = g.g_id 
                 WHERE h.user_id = ? ORDER BY h.usage_date DESC`;
    db.all(sql, [req.params.userId], (err, rows) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(rows);
    });
});

// การจัดการรูปภาพ
const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, 'uploads/'),
    filename: (req, file, cb) => cb(null, Date.now() + path.extname(file.originalname))
});
const upload = multer({ storage });

app.post('/api/history', upload.single('image'), (req, res) => {
    const { user_id, pest_id, g_id, dosage, phi_days } = req.body;
    const image_path = req.file ? `/uploads/${req.file.filename}` : null;
    const sql = `INSERT INTO usage_history (user_id, pest_id, g_id, dosage, phi_days, image_path, usage_date) 
                 VALUES (?, ?, ?, ?, ?, ?, datetime('now', 'localtime'))`;
    db.run(sql, [user_id, pest_id, g_id, dosage, phi_days, image_path], function(err) {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Saved', id: this.lastID });
    });
});

app.delete('/api/history/:historyId', (req, res) => {
    db.run('DELETE FROM usage_history WHERE log_id = ?', [req.params.historyId], (err) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: 'Deleted' });
    });
});

app.get('/api/stats/:userId', (req, res) => {
    const sql = `SELECT g.g_name, COUNT(*) as count FROM usage_history h 
                 JOIN irac_moa_group g ON h.g_id = g.g_id 
                 WHERE h.user_id = ? GROUP BY g.g_name`;
    db.all(sql, [req.params.userId], (err, rows) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(rows);
    });
});

app.listen(PORT, () => console.log(`🚀 Modern Backend (SQLite) running on port ${PORT}`));