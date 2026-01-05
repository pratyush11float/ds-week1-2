Experiment: A/B test analysis (synthetic)
Objective

Evaluate whether variant B improves 7-day conversion relative to control A, and sanity-check experiment integrity (SRM) + statistical pitfalls (peeking).

1) Data integrity: SRM check

- SRM chi-square: 0.392
- SRM p-value: 0.531

Interpretation: No evidence of sample ratio mismatch. Group counts are consistent with intended random assignment (e.g., ~50/50). Proceed with outcome analysis.

2) Primary metric: 7-day conversion

- Control (A) conversion: 0.1450
- Treatment (B) conversion: 0.1197
- Observed lift (B − A): −0.0253 (−2.53 percentage points, absolute)

Interpretation: Point estimate suggests B performs worse than A on conversion.

3) Significance + uncertainty

- Two-sided z-test: z = −1.668, p = 0.095
- Decision at α = 0.05: Not statistically significant → insufficient evidence to declare a true difference at 95% confidence.
- Confidence intervals for lift (B − A):
- Newcombe 95% CI: [−0.0671, +0.0168]
- Unpooled 95% CI: [−0.0550, +0.0044]

Interpretation: Both CIs cross 0 → result is inconclusive. The data is compatible with:
                - meaningful negative impact (down to ~−5.5% to −6.7% absolute), OR
                - near-zero effect, OR
                - small positive effect (up to ~+0.4% to +1.7% absolute depending on CI method).

4) Power / sample size adequacy

- Simulated power (n=2000 per group): 0.109

Interpretation: This test is underpowered for small effect sizes (e.g., +0.5% absolute). A non-significant p-value here does not imply “no effect”; it may simply reflect insufficient sample size to reliably detect the target lift.

Action: Define a minimum detectable effect (MDE) (e.g., ±0.5% absolute conversion) and size the experiment for ~80% power before rerunning.

5) Pitfall demonstration: stopping / peeking

- False positive rate with peeking: 0.178
- False positive rate with single final analysis: 0.048

Interpretation: Repeatedly checking p-values and stopping early inflates Type I error (false positives) from ~5% to ~18% in this simulation.

Action: Use a pre-registered stopping rule, fixed sample size, or valid sequential methods (alpha spending / group sequential) if interim looks are required.

6) Recommendation (based on current evidence)

- Do not ship variant B based on this run:
- Point estimate indicates potential harm to conversion.
- Uncertainty intervals include meaningful downside.
- The test is underpowered for small positive lifts, so results are not decisive.

Next step: Rerun with adequate sample size based on MDE and power target; include guardrails and consider segment checks (device/country) to detect heterogeneous effects.

7) Notes / assumptions

- This analysis uses a synthetic dataset and a simplified binary metric (“purchase within 7 days of signup”).
- In a production setting, also validate:
- exposure logging (did users actually see treatment),
- tracking completeness for purchase events,
- guardrails (latency, crashes, refund rate).