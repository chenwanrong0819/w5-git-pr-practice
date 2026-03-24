#!/bin/bash
# W5 demo repo 分支初始化腳本
# 執行前確認已在 w5/demo_repo 目錄，且 main 已推上 GitHub
#
# 用法：
#   chmod +x _setup_branches.sh
#   ./_setup_branches.sh

set -e

echo "=== 初始化 W5 demo repo 分支 ==="

# ── feature/add-timestamp ──
echo "建立 feature/add-timestamp..."
git checkout main
git checkout -b feature/add-timestamp

# 在每則訊息加上時間戳
cat > /tmp/patch_timestamp.py << 'EOF'
import re

with open('index.html', 'r') as f:
    content = f.read()

# 在 sendMessage 函數加入時間戳邏輯
old = "      userDiv.className = 'message user';\n      userDiv.textContent = text;"
new = """      userDiv.className = 'message user';
      const timeUser = document.createElement('span');
      timeUser.className = 'timestamp';
      timeUser.textContent = new Date().toLocaleTimeString('zh-TW', {hour:'2-digit', minute:'2-digit'});
      userDiv.textContent = text;
      userDiv.appendChild(timeUser);"""
content = content.replace(old, new)

old = "      botDiv.className = 'message bot';\n      botDiv.textContent = `你說了「${text}」！`;"
new = """      botDiv.className = 'message bot';
      const timeBot = document.createElement('span');
      timeBot.className = 'timestamp';
      timeBot.textContent = new Date().toLocaleTimeString('zh-TW', {hour:'2-digit', minute:'2-digit'});
      botDiv.textContent = `你說了「${text}」！`;
      botDiv.appendChild(timeBot);"""
content = content.replace(old, new)

with open('index.html', 'w') as f:
    f.write(content)
EOF
python3 /tmp/patch_timestamp.py

# 加入時間戳 CSS
cat >> style.css << 'TIMESTAMP'

/* feature/add-timestamp 新增 */
.timestamp {
  display: block;
  font-size: 10px;
  opacity: 0.6;
  text-align: right;
  margin-top: 4px;
}
TIMESTAMP

git add index.html style.css
git commit -m "feat: 新增訊息時間戳顯示"
echo "✅ feature/add-timestamp done"

# ── feature/add-search ──
echo "建立 feature/add-search..."
git checkout main
git checkout -b feature/add-search

# 在 header 加搜尋欄
sed -i '' 's|      <p class="subtitle">W5 Pull Request 練習</p>|      <p class="subtitle">W5 Pull Request 練習</p>\n      <input id="search-input" type="text" placeholder="搜尋訊息..." oninput="searchMessages(this.value)">|' index.html

# 加搜尋 CSS
cat >> style.css << 'SEARCH'

/* feature/add-search 新增 */
header input {
  margin-top: 8px;
  width: 100%;
  padding: 6px 10px;
  border: none;
  border-radius: 6px;
  font-size: 13px;
  background: rgba(255,255,255,0.25);
  color: white;
}
header input::placeholder { color: rgba(255,255,255,0.7); }
.message.hidden { display: none; }
SEARCH

# 加搜尋 JS
sed -i '' 's|    document.getElementById|    function searchMessages(keyword) {\n      const messages = document.querySelectorAll(".message");\n      messages.forEach(msg => {\n        if (keyword === "" || msg.textContent.includes(keyword)) {\n          msg.classList.remove("hidden");\n        } else {\n          msg.classList.add("hidden");\n        }\n      });\n    }\n\n    document.getElementById|' index.html

git add index.html style.css
git commit -m "feat: 新增訊息搜尋功能"
echo "✅ feature/add-search done"

# ── review-practice（含幾個可討論的地方）──
echo "建立 review-practice..."
git checkout main
git checkout -b review-practice

cat > review_feature.js << 'REVIEW'
// 這個檔案有幾個值得 review 的地方，試著找找看！

// 問題一：變數命名不清楚
function a(x) {
  var d = document.getElementById('chat-box');
  var m = document.createElement('div');
  m.textContent = x;
  d.appendChild(m);
}

// 問題二：重複的程式碼
function addUserMessage(text) {
  var chatBox = document.getElementById('chat-box');
  var div = document.createElement('div');
  div.className = 'message user';
  div.textContent = text;
  chatBox.appendChild(div);
  chatBox.scrollTop = chatBox.scrollHeight;
}

function addBotMessage(text) {
  var chatBox = document.getElementById('chat-box');
  var div = document.createElement('div');
  div.className = 'message bot';
  div.textContent = text;
  chatBox.appendChild(div);
  chatBox.scrollTop = chatBox.scrollHeight;  // 這行和上面一樣
}

// 問題三：沒有處理空白輸入
function send(input) {
  addUserMessage(input);
  addBotMessage('收到：' + input);
}
REVIEW

git add review_feature.js
git commit -m "feat: 新增訊息功能（待 review）"
echo "✅ review-practice done"

# ── 切回 main ──
git checkout main

echo ""
echo "=== 所有分支建立完成 ==="
git branch

echo ""
echo "接下來推到 GitHub："
echo "  git push origin feature/add-timestamp feature/add-search review-practice"
