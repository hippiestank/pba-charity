# 🤝 PBA-Charity Smart Contract

A smart contract designed to enable collective philanthropy on the **Asset Hub**. Donors come together, contribute funds, and vote—anonymously—for which registered non-profit should receive the donations. Fair, private, and decentralized giving.

---

## ✨ Overview

This contract enables:

- ✅ Individuals to **donate** Asset Hub tokens  
- ✅ Anonymous **voting** using a commitment scheme  
- ✅ Non-profits to **receive** funds based on votes  
- ✅ Only the **contract owner** can register non-profits  

---

## 🧱 How It Works

1. **Registration**  
   The **contract owner** registers trusted non-profit organizations, each linked to a unique address.

2. **Donations**  
   Any user can donate **Asset Hub registered tokens** to the contract.

3. **Anonymous Voting**  
   Donors submit a **vote commitment hash** during the voting phase. This hides their real vote.

4. **Vote Reveal**  
   After the voting period ends, donors **reveal** their votes using the original values that match their hash.

5. **Distribution**  
   Funds are automatically distributed based on the **percentage of revealed votes** for each charity.

---

## 🛠 Milestones

### 📌 Milestone #1
- [x] Only the **contract owner** can register non-profit organizations  
- [x] Users can **donate** Asset Hub tokens  

### 📌 Milestone #2
- [x] Users can **submit a hashed vote commitment**  
- [x] Users can **reveal their vote** after a specific period  
- [x] Funds are **distributed proportionally** to vote results  

---

## 🔐 Voting Mechanism

- **Commit Phase**:  
  Donors send a **hashed vote** (e.g., `hash(vote || secret)`) to keep their choice private.

- **Reveal Phase**:  
  Donors reveal their original `vote` and `secret`. The contract verifies the hash and counts the vote.

- **Tally & Distribute**:  
  After the reveal phase ends, funds are distributed to the non-profits based on the **number of valid revealed votes**.
