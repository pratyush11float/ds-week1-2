# Day 7 — A/B test results (allocation + proportion test)

## Question
Does variant B change the primary binary outcome compared to variant A?

Metric: <fill this in: retention / conversion / ...>  
Lift is defined as **p(B) − p(A)**.

---

## 1) Allocation sanity check (50/50 split)
Chi-squared goodness-of-fit test against expected equal split.

- χ² = 0.392  
- p = 0.531

**Interpretation:** No evidence of allocation imbalance; A and B appear evenly split by counts.

---

## 2) Difference in proportions (two-sided z-test)
- Lift (pB − pA) = **−0.0253** (−2.53 percentage points)
- z = **−1.668**
- p-value (two-sided) = **0.0953**

**Interpretation:** At α = 0.05, the result is **not statistically significant** (fail to reject H0).  
Directionally, B performs worse than A, but evidence is not strong enough to conclude a real decrease at the 5% level.

---

## 3) 95% confidence interval for lift
- 95% CI = **[−0.0550, +0.0044]**

**Interpretation:** The CI includes 0. Data is consistent with anything from ~5.5 pp harm to ~0.44 pp benefit.

---

## 4) Power check (simulation)
Simulated power for detecting an absolute lift of 0.5 pp at baseline p=0.05 with n=2000 per group:

- Estimated power ≈ **0.109**

**Interpretation:** The test is underpowered for small effects (~0.5 pp). A non-significant result here should not be treated as strong evidence of no effect.

---

## Next steps
- If small effects (≤1 pp) matter, increase sample size substantially or run longer.
- If the observed negative lift is concerning, monitor guardrail metrics and consider stopping/rolling back B until more data is collected.
- Validate balance on key covariates (e.g., new vs returning users, geo, device) — equal counts alone doesn’t guarantee covariate balance.
