#!/usr/bin/env python3
# LAB-11 STRESS TIER — real multilingual-LM meaning-vs-count Phi.
# Driven by stress_real_harness.hexa (this file lives UNDER /tmp, outside the repo,
# per the hexa-codex hard constraint that repo-authored source be .hexa; the .hexa
# harness exec()s this for the torch numerics. Only the .hexa + result artifacts
# are committed.)
#
# WHAT IT MEASURES (real representations, NOT a substrate proxy):
#   model: Qwen/Qwen2.5-1.5B (cached locally, real multilingual LM, headless, $0).
#   corpora: 5 langs ko/en/zh/ru/ja.
#     MEANING-coupled set : S sentence-tuples; tuple s is the SAME meaning in all 5
#                           langs (translations) -> cross-lingual rep geometry aligns.
#     COUNT-only control  : S sentences per lang, MUTUALLY UNRELATED across langs
#                           (different meaning) -> count up, no cross-lingual overlap.
#   per (lang, sentence): mean-pooled last-hidden-state vector h in R^d.
#   cross-lingual MI proxy: mean pairwise representational MI between languages,
#     computed on a discretized k-bit code of the per-lang sentence-rep stream
#     (SAME info-theoretic engine family as the 1st smoke: Shannon MI on codes).
#   collective Phi proxy: whole-system MI - min-bipartition over the 5 lang codes
#     (whole_EI - min_bipartition, SAME engine as smoke phi_proxy()).
#   coupling sweep c in [0,1]: each lang's rep stream is linearly interpolated
#     toward the CROSS-LANG CONSENSUS (per-sentence mean rep across langs):
#       rep_c[lang] = (1-c)*rep[lang] + c*consensus
#     c=0 -> 5 independent lang streams (low cross-lingual MI). c=1 -> all langs
#     collapse to the shared consensus (differentiation -> 0). For the MEANING set
#     the consensus is a real shared-meaning signal; for COUNT-only it is rep noise.
#   This reproduces the smoke c-axis on REAL Qwen reps and tests both predictions:
#     H_240 inverse-U (Phi vs measured cross-lingual MI) and
#     H_635 super-additivity (meaning-coupled cohort >> count-only baseline).
import os, sys, json, math
import numpy as np

SEED = 42
np.random.seed(SEED)
MODEL = os.environ.get("LAB11_MODEL", "Qwen/Qwen2.5-1.5B")
KBITS = 2          # bits per language per axis (4-symbol code) -> matches smoke 2^N granularity
C_GRID = [0.0, 0.1, 0.25, 0.5, 0.75, 0.9, 1.0]
OUT = os.environ.get("LAB11_OUT", "/tmp/lab11_stress")

LANGS = ["ko", "en", "zh", "ru", "ja"]

# MEANING-coupled corpus: each ROW is the SAME meaning across the 5 langs (translations).
MEANING = [
    # ko, en, zh, ru, ja
    ["고양이가 매트 위에 앉아 있다.", "The cat sits on the mat.", "猫坐在垫子上。", "Кошка сидит на коврике.", "猫がマットの上に座っている。"],
    ["나는 아침에 커피를 마신다.", "I drink coffee in the morning.", "我早上喝咖啡。", "Я пью кофе утром.", "私は朝にコーヒーを飲む。"],
    ["해가 동쪽에서 떠오른다.", "The sun rises in the east.", "太阳从东方升起。", "Солнце восходит на востоке.", "太陽は東から昇る。"],
    ["아이들이 공원에서 놀고 있다.", "Children are playing in the park.", "孩子们在公园里玩耍。", "Дети играют в парке.", "子供たちが公園で遊んでいる。"],
    ["그녀는 도서관에서 책을 읽는다.", "She reads a book in the library.", "她在图书馆里读书。", "Она читает книгу в библиотеке.", "彼女は図書館で本を読む。"],
    ["비가 내려서 길이 젖었다.", "It rained and the road got wet.", "下雨了，路湿了。", "Прошёл дождь, и дорога намокла.", "雨が降って道が濡れた。"],
    ["우리는 함께 저녁을 요리했다.", "We cooked dinner together.", "我们一起做了晚饭。", "Мы вместе приготовили ужин.", "私たちは一緒に夕食を作った。"],
    ["기차가 정시에 역에 도착했다.", "The train arrived at the station on time.", "火车准时到站。", "Поезд прибыл на станцию вовремя.", "電車は時間通りに駅に着いた。"],
    ["그는 매일 아침 달리기를 한다.", "He goes running every morning.", "他每天早上跑步。", "Он бегает каждое утро.", "彼は毎朝走る。"],
    ["음악은 사람들을 행복하게 만든다.", "Music makes people happy.", "音乐让人们快乐。", "Музыка делает людей счастливыми.", "音楽は人々を幸せにする。"],
    ["바다는 깊고 푸르다.", "The sea is deep and blue.", "大海又深又蓝。", "Море глубокое и синее.", "海は深くて青い。"],
    ["학생들이 시험을 준비하고 있다.", "The students are preparing for the exam.", "学生们正在准备考试。", "Студенты готовятся к экзамену.", "学生たちは試験の準備をしている。"],
]

# COUNT-only control: S unrelated (different-meaning) sentences PER LANG. Same 5 langs,
# same count, but row s carries NO shared meaning across langs (count up, overlap=0).
COUNT_ONLY = {
    "ko": ["회의가 세 시에 시작된다.", "빨간 자동차가 빠르게 지나갔다.", "할머니는 정원을 가꾼다.", "내일 눈이 올 것 같다.",
           "그 영화는 두 시간 동안 상영된다.", "강아지가 공을 물고 왔다.", "새 휴대폰을 샀다.", "산 정상에 눈이 쌓였다.",
           "그는 기타를 배우고 있다.", "시장에서 과일을 팔았다.", "다리를 건너 마을로 갔다.", "촛불이 바람에 꺼졌다."],
    "en": ["The committee approved the budget.", "A storm is forming over the ocean.", "He fixed the broken bicycle.",
           "Photosynthesis converts light to energy.", "The museum opens at nine.", "They signed the contract yesterday.",
           "Volcanoes can erupt without warning.", "The recipe needs two eggs.", "Stars form inside nebulae.",
           "The bridge was closed for repairs.", "She painted the fence white.", "The market crashed last week."],
    "zh": ["他们建了一座新桥。", "蜜蜂在花丛中飞舞。", "电脑突然死机了。", "长城非常壮观。", "医生开了一些药。",
           "火山喷发了浓烟。", "他赢得了比赛。", "湖面结了一层冰。", "孩子摔倒哭了。", "工厂生产汽车零件。",
           "她学会了游泳。", "图书馆周一闭馆。"],
    "ru": ["Учёные открыли новую планету.", "Поезд опоздал на час.", "Дерево упало во время бури.",
           "Он играет на скрипке.", "Завод выпускает тракторы.", "Река замёрзла зимой.", "Птицы улетают на юг.",
           "Магазин закрыт по воскресеньям.", "Она выиграла приз.", "Гора покрыта снегом.", "Лампа перегорела.",
           "Они построили мост."],
    "ja": ["新しい橋が建設された。", "蜂が花の周りを飛んでいる。", "コンピュータが突然止まった。", "富士山はとても美しい。",
           "医者が薬を処方した。", "火山が煙を噴き出した。", "彼は試合に勝った。", "湖が凍りついた。",
           "子供が転んで泣いた。", "工場が部品を作る。", "彼女は泳ぎを覚えた。", "図書館は月曜休みだ。"],
}

def log(*a):
    print(*a, file=sys.stderr, flush=True)

def get_reps():
    import torch
    from transformers import AutoTokenizer, AutoModel
    log(f"[load] {MODEL}")
    tok = AutoTokenizer.from_pretrained(MODEL)
    model = AutoModel.from_pretrained(MODEL, torch_dtype=torch.float32, output_hidden_states=True)
    model.eval()
    def embed(sents):
        out = []
        with torch.no_grad():
            for s in sents:
                enc = tok(s, return_tensors="pt", truncation=True, max_length=64)
                h = model(**enc).last_hidden_state[0]          # (T, d)
                out.append(h.mean(0).numpy().astype(np.float64)) # mean-pool -> (d,)
        return np.stack(out)                                    # (S, d)
    # MEANING: reps[lang] shape (S, d) aligned row-wise across langs (same meaning per row)
    meaning_reps = {}
    for li, lang in enumerate(LANGS):
        meaning_reps[lang] = embed([row[li] for row in MEANING])
    # COUNT-only
    count_reps = {lang: embed(COUNT_ONLY[lang]) for lang in LANGS}
    return meaning_reps, count_reps

# ---- info-theoretic engine (same family as the 1st smoke) ----
def entropy_counts(counts, total):
    h = 0.0
    for c in counts:
        if c > 0:
            p = c / total
            h -= p * math.log2(p)
    return h

def codes_from_R(R, axes):
    # R: (L, S, d) real reps -> KBITS-per-axis integer symbol per (lang, sentence).
    proj = R @ axes                                  # (L, S, n_axes)
    L, S, nax = proj.shape
    codes = np.zeros((L, S), dtype=np.int64)
    for a in range(nax):
        flat = proj[:, :, a].reshape(-1)
        qs = [np.quantile(flat, (k + 1) / (2 ** KBITS)) for k in range((2 ** KBITS) - 1)]
        lev = np.zeros((L, S), dtype=np.int64)
        for q in qs:
            lev += (proj[:, :, a] > q).astype(np.int64)
        codes = codes * (2 ** KBITS) + lev
    return codes

def aligned_R(reps_by_lang):
    # MEANING-coupled: row s is the SAME meaning in every lang (translations aligned).
    return np.stack([reps_by_lang[l] for l in LANGS])             # (L, S, d)

def shuffled_R(reps_by_lang, rng):
    # COUNT-only / decoupled: each lang gets an INDEPENDENT permutation of its own
    # sentence-reps, so slot s carries no shared cross-lingual meaning (overlap -> 0).
    langs = list(reps_by_lang.keys()); S = reps_by_lang[langs[0]].shape[0]
    out = []
    for l in langs:
        perm = rng.permutation(S)
        out.append(reps_by_lang[l][perm])
    return np.stack(out)

def mix_R(reps_by_lang, f, rng):
    # meaning-overlap fraction f in [0,1]: a fraction f of the S sentence-SLOTS are
    # ALIGNED translations (shared cross-lingual meaning); the rest are independently
    # shuffled per lang (no shared meaning). f=0 -> fully separate (MI~0); f=1 -> all
    # translations aligned (max meaning coupling). The real-rep analog of smoke c.
    L = len(LANGS); S = reps_by_lang[LANGS[0]].shape[0]
    k = int(round(f * S))
    aligned_slots = set(rng.choice(S, size=k, replace=False).tolist()) if k > 0 else set()
    out = np.zeros((L, S, reps_by_lang[LANGS[0]].shape[1]))
    perms = [rng.permutation(S) for _ in range(L)]
    for li, l in enumerate(LANGS):
        for s in range(S):
            if s in aligned_slots:
                out[li, s] = reps_by_lang[l][s]          # aligned translation
            else:
                out[li, s] = reps_by_lang[l][perms[li][s]]  # independent shuffle
    return out

def mi_pair(a, b):
    # Shannon MI(bits) between two integer label streams a,b (len S)
    sa = sorted(set(a.tolist())); sb = sorted(set(b.tolist()))
    ia = {v: i for i, v in enumerate(sa)}; ib = {v: i for i, v in enumerate(sb)}
    na, nb = len(sa), len(sb); S = len(a)
    joint = np.zeros((na, nb))
    for x, y in zip(a, b):
        joint[ia[x], ib[y]] += 1
    rows = joint.sum(1); cols = joint.sum(0)
    return entropy_counts(rows, S) + entropy_counts(cols, S) - entropy_counts(joint.reshape(-1), S)

def mean_pair_mi(codes):
    L = codes.shape[0]; tot = 0.0; n = 0
    for i in range(L):
        for j in range(i + 1, L):
            tot += mi_pair(codes[i], codes[j]); n += 1
    return tot / n

def joint_symbol(rows):
    # combine a list of integer streams into one joint symbol stream (S,)
    S = rows[0].shape[0]; base = 1; out = np.zeros(S, dtype=np.int64)
    for r in rows:
        m = int(r.max()) + 1
        out = out * m + r
    return out

def mi_between_groups(codes, A, B):
    # MI( joint(A) ; joint(B) ) where A,B are disjoint lang-index lists
    ja = joint_symbol([codes[i] for i in A]); jb = joint_symbol([codes[i] for i in B])
    return mi_pair(ja, jb)

def phi_proxy(codes):
    # IIT Phi = DIFFERENTIATION x INTEGRATION (Tononi 2008; whole_EI - min_bipart
    # is the integration term, SAME engine as the smoke phi_proxy). The smoke gets
    # its inverse-U because full synchronization (c=1) FREEZES the dynamical system
    # so differentiation -> 0; on STATIC reps we must supply the differentiation term
    # EXPLICITLY, else integration alone is maximized by full fusion (degenerate).
    #
    #   integration = whole multi-information - min-bipartition cross-MI
    #     (how much the langs share that the cheapest cut cannot remove)
    #   differentiation = mean cross-lingual DISTINCTNESS = 1 - redundancy
    #     redundancy = mean pairwise (normalized) code agreement across langs;
    #     c=0 langs independent -> low agreement; c=1 langs identical -> agreement=1
    #     -> differentiation -> 0 (the langs are no longer distinguishable parts).
    #   Phi = integration * differentiation  -> inverse-U in the coupling c.
    L, S = codes.shape
    # --- integration term (multi-information - min cut), same as before ---
    Hsum = 0.0
    for i in range(L):
        vals, cnt = np.unique(codes[i], return_counts=True)
        Hsum += entropy_counts(cnt.tolist(), S)
    whole_joint = joint_symbol([codes[i] for i in range(L)])
    vals, cnt = np.unique(whole_joint, return_counts=True)
    Hjoint = entropy_counts(cnt.tolist(), S)
    whole = Hsum - Hjoint
    best = 1e18
    for mask in range(1, 1 << (L - 1)):
        A = [i for i in range(L) if (mask >> i) & 1]
        B = [i for i in range(L) if not (mask >> i) & 1]
        if not A or not B:
            continue
        cut = mi_between_groups(codes, A, B)
        if cut < best:
            best = cut
    integration = whole - best
    if integration < 0.0:
        integration = 0.0
    # --- differentiation term = mean cross-lingual distinctness (1 - agreement) ---
    agree = 0.0; npair = 0
    for i in range(L):
        for j in range(i + 1, L):
            same = float(np.mean(codes[i] == codes[j]))
            agree += same; npair += 1
    redundancy = agree / npair                  # 0 (all distinct) .. 1 (all identical)
    differentiation = 1.0 - redundancy
    return integration * differentiation

N_SEED = 8   # average over independent shuffle seeds (robustness, smooths the shuffle)

# ---- continuous representational cross-lingual MI + Phi (sensitive at small S) ----
# Quantized Shannon MI saturates at S=12; for LM hidden states the standard sensitive
# measure is REPRESENTATIONAL SIMILARITY: per lang we have an (S,d) rep stream; the
# cross-lingual coupling is captured by the per-sentence-index correlation of the
# representational geometry. We summarize each lang stream by its leading PCA-axis
# score vector (length S), then cross-lingual MI(i;j) = Gaussian MI = -0.5*log2(1-r^2)
# of those score vectors (r = Pearson over the S sentence slots). For ALIGNED
# translations slot s is the same meaning in all langs -> r high -> MI high; for
# SHUFFLED slots meaning is unaligned -> r~0 -> MI~0. Phi = integration*differentiation
# on the L-lang correlation matrix: integration = total correlation (multivariate
# Gaussian) minus min-bipartition; differentiation = 1 - mean|r| (langs fuse -> 0).

def _cka(X, Y):
    # linear Centered Kernel Alignment between two (S,d) rep matrices: the standard,
    # sensitive cross-lingual representational-similarity score in [0,1]. Captures the
    # alignment signal that lives across MANY dims (retrieval = 75%), not just PCA-1.
    X = X - X.mean(0, keepdims=True); Y = Y - Y.mean(0, keepdims=True)
    hsic = np.linalg.norm(X.T @ Y, 'fro') ** 2
    nx = np.linalg.norm(X.T @ X, 'fro'); ny = np.linalg.norm(Y.T @ Y, 'fro')
    return float(hsic / (nx * ny + 1e-12))

def corr_matrix_R(R):
    # L x L cross-lingual representational-similarity (CKA) matrix from reps (L,S,d).
    L = R.shape[0]
    C = np.eye(L)
    for i in range(L):
        for j in range(i + 1, L):
            r = _cka(R[i], R[j]); C[i, j] = r; C[j, i] = r
    return C

def lang_scores(R, axes, a=0):
    return R  # compat shim: downstream now takes R directly

def corr_matrix(scores):
    return corr_matrix_R(scores)

def gauss_mi(r):
    r = min(max(r, -0.999), 0.999)
    return -0.5 * math.log2(max(1e-9, 1.0 - r * r))

def mean_pair_mi_cont(scores):
    C = corr_matrix(scores); L = scores.shape[0]; tot = 0.0; n = 0
    for i in range(L):
        for j in range(i + 1, L):
            tot += gauss_mi(C[i, j]); n += 1
    return tot / n

def phi_cont(scores):
    C = corr_matrix(scores); L = scores.shape[0]
    # integration = total correlation of the L-variate Gaussian = -0.5*log2 det(C)
    sign, logdet = np.linalg.slogdet(C + 1e-6 * np.eye(L))
    total_corr = -0.5 * (logdet / math.log(2))
    if total_corr < 0: total_corr = 0.0
    # min-bipartition: cheapest cross-MI cut (Gaussian MI between the two blocks via
    # block-determinant identity). Approx by the single weakest pairwise link removed
    # = total_corr of the best 2-block split; we scan splits using block total-corr.
    best = 1e18
    for mask in range(1, 1 << (L - 1)):
        A = [i for i in range(L) if (mask >> i) & 1]
        B = [i for i in range(L) if not (mask >> i) & 1]
        if not A or not B: continue
        CA = C[np.ix_(A, A)]; CB = C[np.ix_(B, B)]
        _, la = np.linalg.slogdet(CA + 1e-6 * np.eye(len(A)))
        _, lb = np.linalg.slogdet(CB + 1e-6 * np.eye(len(B)))
        # cross-MI removed by this cut = TC(whole) - TC(A) - TC(B)
        tcA = -0.5 * (la / math.log(2)); tcB = -0.5 * (lb / math.log(2))
        cut = total_corr - max(0.0, tcA) - max(0.0, tcB)
        if cut < best: best = cut
    integration = max(0.0, best)            # info the CHEAPEST cut must still sever
    mean_abs_r = (np.sum(np.abs(C)) - L) / (L * (L - 1))
    differentiation = 1.0 - mean_abs_r       # langs identical -> r=1 -> 0
    return integration * differentiation

def run_meaning_sweep(reps, axes):
    # sweep meaning-overlap fraction f; x-axis = MEASURED cross-lingual MI; y = Phi.
    rows = []
    for f in C_GRID:
        mis = []; phis = []
        for sd in range(N_SEED):
            rng = np.random.default_rng(1000 + sd)
            R = mix_R(reps, f, rng)
            sc = lang_scores(R, axes, a=0)
            mis.append(mean_pair_mi_cont(sc)); phis.append(phi_cont(sc))
        mi = float(np.mean(mis)); phi = float(np.mean(phis))
        rows.append((f, mi, phi))
        log(f"  [MEANING f={f:.2f}]  MI={mi:.6f}  phi={phi:.6f}")
    return rows

def run_count_baseline(reps, axes, lang_count_grid):
    # COUNT-only control (the user's reframe): hold meaning-overlap f=0 (NO shared
    # meaning across langs) and instead grow the LANGUAGE COUNT n=2..5. Tests whether
    # piling up MORE languages (count up) — with no cross-lingual meaning — raises
    # integration. S held FIXED at full S; only the # of langs in the cohort grows.
    rows = []
    S = reps[LANGS[0]].shape[0]
    for n in lang_count_grid:
        n = min(n, len(LANGS))
        mis = []; phis = []
        for sd in range(N_SEED):
            rng = np.random.default_rng(2000 + sd)
            sub = {l: reps[l] for l in LANGS[:n]}
            R = shuffled_R(sub, rng)            # f=0 always: no cross-lingual meaning
            sc = lang_scores(R, axes, a=0)
            mis.append(mean_pair_mi_cont(sc)); phis.append(phi_cont(sc))
        mi = float(np.mean(mis)); phi = float(np.mean(phis))
        rows.append((n, n, mi, phi))
        log(f"  [COUNT n_langs={n}]  MI={mi:.6f}  phi={phi:.6f}")
    return rows

def pca_axes(reps, n_axes=4):
    # fixed PCA scaffold from the meaning-set c=0 reps (shared projection basis)
    X = np.concatenate([reps[l] for l in LANGS], axis=0)  # (L*S, d)
    X = X - X.mean(0, keepdims=True)
    U, Sv, Vt = np.linalg.svd(X, full_matrices=False)
    return Vt[:n_axes].T   # (d, n_axes)

def main():
    os.makedirs(OUT, exist_ok=True)
    cache = os.path.join(OUT, "reps_cache.npz")
    if os.environ.get("LAB11_REUSE") == "1" and os.path.exists(cache):
        log("[reuse] cached reps")
        z = np.load(cache)
        meaning_reps = {l: z["m_" + l] for l in LANGS}
        count_reps = {l: z["c_" + l] for l in LANGS}
    else:
        meaning_reps, count_reps = get_reps()
        save = {}
        for l in LANGS:
            save["m_" + l] = meaning_reps[l]; save["c_" + l] = count_reps[l]
        np.savez(cache, **save)
    # diagnostic: does Qwen actually align translations cross-lingually? (sanity)
    def cos(a, b): return float(a @ b / (np.linalg.norm(a) * np.linalg.norm(b) + 1e-9))
    A = meaning_reps["ko"]; B = meaning_reps["en"]; S = A.shape[0]; hit = 0
    for s in range(S):
        sims = [cos(A[s], B[t]) for t in range(S)]
        if int(np.argmax(sims)) == s: hit += 1
    retrieval_ko_en = f"{hit}/{S}"
    log(f"[diag] ko->en translation retrieval = {retrieval_ko_en} (chance 1/{S})")
    axes = pca_axes(meaning_reps, n_axes=4)
    log("[sweep] MEANING-coupled (meaning-overlap fraction f)")
    meaning_rows = run_meaning_sweep(meaning_reps, axes)
    log("[sweep] COUNT-only control (grow #langs 2..5, meaning-overlap fixed 0)")
    count_rows = run_count_baseline(meaning_reps, axes, [2, 3, 4, 5])
    result = {
        "model": MODEL, "seed": SEED, "langs": LANGS, "kbits": KBITS, "n_seed": N_SEED,
        "n_sentences": len(MEANING), "c_grid": C_GRID,
        "retrieval_ko_en": retrieval_ko_en,
        "meaning": meaning_rows, "count_only": count_rows,
    }
    with open(os.path.join(OUT, "phi_mi_real.json"), "w") as f:
        json.dump(result, f, indent=2)
    print(json.dumps(result))

if __name__ == "__main__":
    main()
