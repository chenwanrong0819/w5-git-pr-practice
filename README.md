# W5 Pull Request 練習 Repo

這是第五週的練習 repo，專門用來練習建立 PR 和 Code Review。

## 開始之前

1. Fork 這個 repo 到你自己的帳號
2. Clone 你的 fork：
```bash
git clone https://github.com/你的帳號/w5-git-pr-practice.git
cd w5-git-pr-practice
```

---

## 分支說明

| 分支 | 練習內容 |
|------|---------|
| `main` | 基本版本（乾淨起點）|
| `feature/add-timestamp` | 新增訊息時間戳（觀察 PR diff）|
| `feature/add-search` | 新增訊息搜尋功能（觀察 PR diff）|
| `review-practice` | 有幾個小問題的程式碼，練習 review |

---

## 練習一：觀察 PR diff

```bash
# 切換到 feature 分支，觀察與 main 的差異
git checkout feature/add-timestamp
# 打開瀏覽器看效果

# 也可以用 git diff 指令比較
git diff main feature/add-timestamp
```

**思考：這個 branch 改了哪些檔案？哪些行？**

---

## 練習二：建立自己的 PR

```bash
# 從 main 建立你自己的分支
git checkout main
git checkout -b feature/你的名字

# 修改任一處：改標題、改顏色、改按鈕文字...
# 完成後 push
git add .
git commit -m "feat: 我的修改"
git push origin feature/你的名字
```

到 GitHub 建立 PR，填寫完整描述。

---

## 練習三：Review `review-practice` 分支的 PR

這個分支的程式碼裡藏了幾個值得討論的地方，試著：
1. 到 GitHub 查看這個分支與 main 的 diff
2. 找出可以改進的地方
3. 在 Files changed 留下 comment
