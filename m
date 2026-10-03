Received: from mail-yx2-f8.google.com (mail-yx2-f8.google.com [74.125.224.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F94399C4
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Oct 2026 20:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059254; cv=none; b=a0zzsp/xDdVp14Iax93Jxrr5qXy3kDYDhHEzi/oA8siyT8CJJo8X6rUc7bMx1obq5S74cMoUIo29A9MvhG5/CXUTPGM/f8KpI5h0O4AhTdpyoEfbLibV3Y/1zUgVJRxjDfqGIokRHDEat5DB4IDxZN4Y4JBpA+h6P4robbPKT3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059254; c=relaxed/simple;
	bh=qw1YGHR5szNuGFQTU6mwuicpfah1VyNrKo4cH5Yu2Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=noMbs0MeDtwrF66dr70cLbI4ClN5aw++UtY86hZv+kZH2WOGDcYiF7Wqrd0lv9z8L55/zsnyqi0l/TU/oTR1LZ/hhFVqqhMQQeHpEP39tpoWwnn4E7gjr6QE1Z0iGTfgMkZoirmbX85KHxFnmE/KlcubrunbHiESceASF+WdMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8ENKLnb; arc=none smtp.client-ip=74.125.224.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8ENKLnb"
Received: by mail-yx2-f8.google.com with SMTP id 00721157ae682-8949fcc5ea0so797897b3.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 Oct 2026 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791059251; x=1791664051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wdO1qiLDUurZfNdh4Bo7wDLkgu1IWEB9hS1GOH9sv2Y=;
        b=L8ENKLnbg9oEmVM1+46ZUXf+m/1rcVzicad3mkku5kEfpkklNoN8Srl7Ak2lZq/weZ
         +dMQQQ8nGLh9nOEchTZ8D7Byu3n5MEZPklZxM8lxLkh44zxwHrM0Wj9sDzpur0CG7vom
         kVeWN93uzhC7EHXCXF2YqzAtv2jjB9WQY5oRPnXh3xT72eGOQlonhd2v+RGNykt1q/xM
         gzVB0dtzY5A4zmVPkerbKZ8ZePc7lj+2Inf6aOGUsHXdZivG6CRkKUEbblbs4hBRc0cB
         wp5J+ol6MOxySccz5fgwV+7VuJtHJmw8HXmFDr/MbfWVw5eAYEEZfmpXhiN3ANdne5Tz
         of6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791059251; x=1791664051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wdO1qiLDUurZfNdh4Bo7wDLkgu1IWEB9hS1GOH9sv2Y=;
        b=vHXsOqBjyQfFDsdKR1zttse3U98Wps64NJW1oTpGQ/l8/34wAFTvHNLWIS33X4ZAK3
         7kN/EcMH8pWl0LOxhLhOtt26VwfJi/XXMWDCZdARHGsr8pJmh6s8ATu5DIRp5rykcdK2
         2+tN64PHj+ohMOv2Osjw3LNRUiyZcB4iKDMAOGN5a3tQDCqcp94hQLE4BrN2iK7gu/nA
         QcNhn6IZmmnwYZW+Z6/YGleSIUQXJ5rjQnmHGftYaIXH7bsxZLIEI+TGrLzwj5VwiQEn
         +oUCcAXVRh+thsQ/38C/Qk50oOBUPXXZl34gxAvbuIolxL9y2+2GbeyQcKUb1c3kF0LY
         2xFg==
X-Forwarded-Encrypted: i=1; AKwUvBxqHYXPo7b65F2zwx0lkEwPRqEnegQzIKErxybOBdQe6MnCMKVXWEqxsuJrcM1U0lUG4u4hMspJFtbLNeIuFmIKRxc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyIyU7IjfRie+A6TqeXLu0k3Tm+Onq9qtrCFAbh0Cb8F4RATUJ
	e8NQoLZFyuiWVgYIF4sKiAHkJQexLCBI3JHR8zzOo0R3VbO/kPZ6YH4=
X-Gm-Gg: AYBFou2qCDVa90dQSP2v+I9uVFm5iW2am+qN5Pt1PKWwy3maTTp6U+ex9wZxoWjk4TS
	yGTmuKRrIE8YM+bGN/RazQZKC5YbQiopbC8k96I6XaozwNWUrB6ht7EWiQwCFeEPjW2yB2w2Qvv
	eN5GPKXHaa0w6pkPtVs3Oj4cm0Zx7zC0RVZ0OgaBKH6c6ZafhC+h419/vUKClA6nWSggAxQ1C+8
	hl5qDClEjDDArknQOu+jRiauodzhlNSIz6h7yXYM4/QNOWLMG/JohfZ5uXSYTc/GJYAGdUjTcEy
	pXuPtY47qLmgX7nL6Dz3Rww9YHr9dyINsj8zX0KFQuxgpbDKa1fcsMgqwyC7xcwCxzIdLIwiDVj
	5BkaNs8M0U+s7LXLq3AzXvOePP6F7vkQx5YhibnzVFZqHOdI5DVd4Wx+vw+NI7maeTVap4z8lky
	7pbrTgmzbg65RHT1VHndpBLrpL132/VrFYtg9QmD0XJKACtGD3cKE2AKuOvtAnqFYz5hMrufxJA
	4luYVLNikPTEtIU+COCdHUvm+P6z9wXZzr1YCZ6JQ==
X-Received: by 2002:a05:690c:ec4:b0:8a8:93e9:3824 with SMTP id 00721157ae682-8ae95ad61e8mr14431447b3.62.1791059251099;
        Sat, 03 Oct 2026 13:27:31 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:4577:1050:550f:9551:5468:60f1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm23389887b3.47.2026.10.03.13.27.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 03 Oct 2026 13:27:30 -0700 (PDT)
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	SJ Park <sj@kernel.org>
Cc: Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Yunjeong Mun <yunjeong.mun@sk.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>
Subject: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
Date: Sat,  3 Oct 2026 13:27:27 -0700
Message-ID: <20261003202727.3673-1-ravis.opensrc@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tracepoint for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP quota goal
evaluation.  The tracepoint fires once per quota-score computation when
the goal metric is DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, exposing
context_idx, scheme_idx, nid, target_value, and current_value.
current_value is reported as the quota tuning sees it, after the goal's
complement setting is applied.

The DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric expresses node memory
occupancy as basis points of eligible bytes.  This information is not
exposed through any existing external interface (perf stat, /proc, or
sysfs), so the tracepoint is the only way for userspace to observe the
target and current eligible-memory basis point values at quota-scoring
time.

Link: https://lore.kernel.org/linux-mm/20260428030520.701-1-ravis.opensrc@gmail.com/
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
---
 include/trace/events/damon.h | 31 +++++++++++++++++++++++++++++++
 mm/damon/core.c              | 16 ++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 8851727ae162..2c7249cc7c88 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -74,6 +74,37 @@ TRACE_EVENT(damos_esz,
 			__entry->esz)
 );
 
+/* Per-tick DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP goal evaluation. */
+TRACE_EVENT(damos_node_eligible_mem_bp,
+
+	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
+		int nid,
+		unsigned long target_value, unsigned long current_value),
+
+	TP_ARGS(context_idx, scheme_idx, nid, target_value, current_value),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, context_idx)
+		__field(unsigned int, scheme_idx)
+		__field(int, nid)
+		__field(unsigned long, target_value)
+		__field(unsigned long, current_value)
+	),
+
+	TP_fast_assign(
+		__entry->context_idx = context_idx;
+		__entry->scheme_idx = scheme_idx;
+		__entry->nid = nid;
+		__entry->target_value = target_value;
+		__entry->current_value = current_value;
+	),
+
+	TP_printk("ctx_idx=%u scheme_idx=%u nid=%d target_value=%lu current_value=%lu",
+			__entry->context_idx, __entry->scheme_idx,
+			__entry->nid,
+			__entry->target_value, __entry->current_value)
+);
+
 TRACE_EVENT_CONDITION(damos_before_apply,
 
 	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index b63e60ef8990..6ddd15dc4f55 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3294,6 +3294,22 @@ static unsigned long damos_quota_score(struct damon_ctx *c, struct damos *s)
 		highest_score = max(highest_score,
 				mult_frac(goal->current_value, 10000,
 					goal->target_value));
+
+		if (goal->metric == DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP &&
+		    trace_damos_node_eligible_mem_bp_enabled()) {
+			unsigned int cidx = 0, sidx = 0;
+			struct damos *siter;
+
+			damon_for_each_scheme(siter, c) {
+				if (siter == s)
+					break;
+				sidx++;
+			}
+			trace_damos_node_eligible_mem_bp(cidx, sidx,
+					goal->nid,
+					goal->target_value,
+					goal->current_value);
+		}
 	}
 
 	return highest_score;

base-commit: 763ad0211c7b587344f03bc4d1299810aeb736f4
-- 
2.54.0 (Apple Git-157)

