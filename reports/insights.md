# Insights Memo: Product Analytics Mini-Case (Synthetic)

## Executive summary
- DAU is [trend: stable/increasing/decreasing] over the observed period.
- Largest funnel drop-off occurs at: [view→cart / cart→checkout / checkout→purchase].
- Retention is [shape], with cohorts from [week(s)] showing [higher/lower] Week 1 retention.

## Key metrics (overall)
- Average DAU: 567.87
- Average conversion (active → purchase same day): 19.25%
- Total revenue (period): 10767.02

## Funnel findings
- Overall view→purchase conversion: [X%]
- Biggest drop-off step: [step] ([rate])
- Segment notes (device/country):
  - [segment] has lowest [step] conversion: [value]
  - Hypothesis: [e.g., mobile UX friction, payment issues, performance]

## Retention findings
- Week 0 retention (median cohort): [X%]
- Week 1 retention (median cohort): [Y%]
- Notable cohort behavior: [e.g., one cohort higher; explain likely reason/data artifact]

## Recommended actions
1) [Action] to improve [funnel step], e.g., reduce checkout friction / improve cart UX
2) [Action] targeting [segment], e.g., Android-specific performance fixes
3) Instrumentation: add tracking for [missing events] to validate hypotheses

## Proposed A/B test
- Hypothesis: [e.g., streamlined checkout increases purchase conversion]
- Primary metric: [7-day conversion] (binary)
- Secondary: revenue per user, checkout rate
- Guardrails: session crashes, load time, refund rate
- Sample size / power: target detecting [abs lift] with ~80% power
