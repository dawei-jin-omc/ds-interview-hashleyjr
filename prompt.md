# Data Science Interview — Take-Home / Pairing Exercise

**Role:** Data Science Engineer, Perpetua (Retail Media)
**Time:** ~75–90 minutes. We care about **how you think, not syntax recall.** Use any docs, Google, or AI tooling you normally would — just narrate your reasoning as you go.

---

## The Scenario

You've joined the team that builds Perpetua's autonomous bidding engine. Advertisers set a **target ACoS** (Advertising Cost of Sales = ad spend ÷ attributed sales) and our system decides how to bid on search keywords to hit that target.

You've been handed a slice of Amazon Sponsored Products data for a set of brands. It is **raw production data** — expect it to be messy.

You have two files:

### `ad_performance.csv` — daily performance, one row per keyword per day
| column | meaning |
|---|---|
| `date` | day of the record |
| `campaign_id` | FK to campaigns |
| `keyword_id` | the search keyword |
| `keyword_text` | the keyword string |
| `match_type` | `exact`, `phrase`, or `broad` |
| `impressions` | times the ad was shown |
| `clicks` | times it was clicked |
| `spend` | ad spend (USD) |
| `orders` | attributed orders |
| `sales` | attributed revenue (USD) |
| `bid` | cost-per-click bid set that day |

### `campaigns.csv` — one row per campaign
| column | meaning |
|---|---|
| `campaign_id` | primary key |
| `campaign_name` | — |
| `brand_id` | the advertiser |
| `product_category` | Kitchen, Pet, Beauty, … |
| `target_acos` | the ACoS goal for this campaign (e.g. 0.25 = 25%) |
| `launch_date` | — |

**Key metric definitions**
- **CTR** = clicks ÷ impressions
- **CVR** (conversion rate) = orders ÷ clicks
- **ACoS** = spend ÷ sales  *(lower is more efficient)*
- **CPC** = spend ÷ clicks

---

## Part 1 — SQL (~10 min)

Assume both files are tables in **SqlLite**. Write queries for (give the candidate Q No.2 or 3. If they struggle, give them No.1 ):

1. **Campaign efficiency.** Total spend, total sales, and ACoS for each campaign over the whole period. Exclude campaigns with no sales.
2. **Overspending keywords.** Join to `campaigns`. For each `product_category`, list keywords whose lifetime ACoS is *worse than* (greater than) their campaign's `target_acos`. Return category, keyword, its ACoS, and the target.
3. **Spend concentration.** For each campaign, return its top 3 keywords by spend, and what percentage of the campaign's total spend those keywords represent.

## Part 2 — Python / Pandas (~25 min)

Work in a notebook.

1. **Load & clean.** Load both files. Identify data-quality problems and decide how to handle each. Explain your choices — some issues you should *fix*, some you should *investigate*, some you might *keep*.
2. **Reshape.** Build a keyword × week table of ACoS. Which keywords are the most volatile week to week? (Be careful how you aggregate ACoS.)
3. **Insight.** Explore freely and tell us **three things a client should know**, and what you'd recommend they *do*. Quantify the impact where you can. What are you unsure about?

## Part 3 — Modeling (~20 min, can be discussion if short on time)

1. Build a model to predict, for a keyword-day, whether it will **convert** (`orders > 0`), or to predict `sales`. Your choice — justify it.
2. How did you split train/test, and why? What features did you use, and are any of them problematic?
3. Evaluate it with an appropriate metric. **Would you ship this into the autonomous bidding engine?** What would you monitor?

---

*Deliverable: your queries, your notebook, and a few sentences of findings. Partial is fine — we'd rather see sound reasoning on 80% than rushed answers on everything.*
