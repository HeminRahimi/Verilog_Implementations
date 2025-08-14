# First-Order Masked AES S-Box Implementation

## Description  
This folder contains a **first-order masked implementation** of the AES S-Box, designed to resist side-channel attacks. The implementation follows a **two-stage pipeline structure**, ensuring secure and efficient operation.  

### Key Features:  
- **First-order masking** for side-channel resistance  
- **Two-stage architecture** for balanced latency and throughput  
- **PINI (Probe Isolating Non Interference)** and **OPINI (Output Probe Isolating Non Interference)** compliant  

---

## Related Work  
This implementation is based on:  

**Title:** *Higher-Order Time Sharing Masking*  
**Conference:** CHES 2025  
**Link:** [https://tches.iacr.org/article/12047](https://tches.iacr.org/index.php/TCHES/article/view/12047)  

### Architectural Overview  
<img width="774" height="327" alt="image" src="https://github.com/user-attachments/assets/98ec6bf4-558d-446d-9867-aa92d385fe67" />

