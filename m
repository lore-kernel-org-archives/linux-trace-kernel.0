Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC6D27442;
	Wed,  1 Apr 2026 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028982; cv=none; b=fs2yVgsTqnUMWPcnT10nHRdK7qla4hot3VoNcbulCnLXH/JYumN6uaJVvEj6euwrl8eudISF9LIx1Q64FxWyYckPmnkIW7ZKUKcn7NZtOgCaXXKTT+jhhRjqDMKZ/VckzUWosCsEyUVcekEkvobE7Ej9tV0bKGdR8nnT/FK9+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028982; c=relaxed/simple;
	bh=KJWoxcgBrmv6aiB7HIluEDRqHjyTg6kZfSNv2QCiz28=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dohBzwoM1qb8n9RkTYLPgrOedIZvEclSNDbawwyKkbrkvR/zUJyzEEpsvicHGVDakokTRR3FWz/3/h0Vitc03f7QRO/sSUu1e39fIxByrCAfqjtX9WvmeVFYExpDW3o8VeFr8CohumeJ1nv27EQ3Y9UPu8Iq/IB+ed+htOglaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=e9RLizYc; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="e9RLizYc"
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=CgTvKdo/p2bgLfcLhC67tpYYumUMNTRd/FLgAyX/pIQ=;
	b=e9RLizYcoe8gkHVBOqL7jxfUkmtOdBuXmz0i9jpqj9M+1oYceFOXiNqyOD3rR09deo8Il143E
	L6p5gETjJSRBVWmLliaH0KmsZx7cNZTUEXo9oVZ9NyLMPoGgH4UzFWwolQwJJmW3SSxdX/fxk6G
	TTtGe1u1yIkkdIF9U+2D1ss=
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4flxBN5Kl3zYlYLZ;
	Wed,  1 Apr 2026 15:17:00 +0800 (CST)
Received: from TA012.hihonor.com (10.77.228.68) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 1 Apr
 2026 15:17:55 +0800
Received: from TA011.hihonor.com (10.77.232.85) by TA012.hihonor.com
 (10.77.228.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 15:17:43 +0800
Received: from TA011.hihonor.com ([fe80::1391:8a1:1ddc:4344]) by
 TA011.hihonor.com ([fe80::1391:8a1:1ddc:4344%8]) with mapi id 15.02.2562.017;
 Wed, 1 Apr 2026 15:17:54 +0800
From: wangzhen <wangzhen5@honor.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"david@kernel.org" <david@kernel.org>, "mhocko@kernel.org"
	<mhocko@kernel.org>, "zhengqi.arch@bytedance.com"
	<zhengqi.arch@bytedance.com>, "shakeel.butt@linux.dev"
	<shakeel.butt@linux.dev>, "ljs@kernel.org" <ljs@kernel.org>,
	"axelrasmussen@google.com" <axelrasmussen@google.com>, "yuanchu@google.com"
	<yuanchu@google.com>, "weixugc@google.com" <weixugc@google.com>,
	"jiayuan.chen@shopee.com" <jiayuan.chen@shopee.com>, wangzhen
	<wangzhen5@honor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "kasong@tencent.com" <kasong@tencent.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"baohua@kernel.org" <baohua@kernel.org>
Subject: [PATCH] mm/vmscan: add tracepoint for changes in min_seq and max_seq
Thread-Topic: [PATCH] mm/vmscan: add tracepoint for changes in min_seq and
 max_seq
Thread-Index: AdzBp6diUCgIzLcpTbOIx0zw848r2g==
Date: Wed, 1 Apr 2026 07:17:54 +0000
Message-ID: <402fbac2fde14bcda8230c1535186b4e@honor.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From 20f685d13826ebaa86705a689128893be6316c7b Mon Sep 17 00:00:00 2001
From: w00021541 <wangzhen5@hihonor.com>
Date: Tue, 31 Mar 2026 16:00:48 +0800
Subject: [PATCH] mm/vmscan: add tracepoint for changes in min_seq and max_s=
eq

Currently, when tracking the changes in min_seq and max_seq of mglru,
it can only be done through debugfs. The granularity of debugfs is too
coarse when we debug the generations of mglru. there's no way to trace
the increase in min_seq and max_seq, so we add 2 tracepoints,
mm_vmscan_lru_inc_min_seq and mm_vmscan_lru_inc_max_seq.

Test results:

kswapd0-94      [003] d..1.    72.664921: mm_vmscan_lru_inc_min_seq: memcg_=
id=3D87 type=3D0 swappiness=3D140 min_seq=3D2
kswapd0-94      [003] d..1.    72.664922: mm_vmscan_lru_inc_min_seq: memcg_=
id=3D87 type=3D1 swappiness=3D140 min_seq=3D1
kswapd0-94      [003] d..1.    72.667303: mm_vmscan_lru_inc_max_seq: memcg_=
id=3D87 swappiness=3D140 max_seq=3D4
kswapd0-94      [000] d..1.    72.807691: mm_vmscan_lru_inc_min_seq: memcg_=
id=3D25 type=3D0 swappiness=3D140 min_seq=3D2
kswapd0-94      [000] d..1.    72.807692: mm_vmscan_lru_inc_min_seq: memcg_=
id=3D25 type=3D1 swappiness=3D140 min_seq=3D1
kswapd0-94      [000] d..1.    72.810955: mm_vmscan_lru_inc_max_seq: memcg_=
id=3D25 swappiness=3D140 max_seq=3D4
kswapd0-94      [005] d..1.    73.482586: mm_vmscan_lru_inc_min_seq: memcg_=
id=3D91 type=3D0 swappiness=3D140 min_seq=3D2
kswapd0-94      [005] d..1.    73.482588: mm_vmscan_lru_inc_min_seq: memcg_=
id=3D91 type=3D1 swappiness=3D140 min_seq=3D1
kswapd0-94      [005] d..1.    73.485509: mm_vmscan_lru_inc_max_seq: memcg_=
id=3D91 swappiness=3D140 max_seq=3D4
kswapd0-94      [000] d..1.    77.708630: mm_vmscan_lru_inc_min_seq: memcg_=
id=3D88 type=3D0 swappiness=3D140 min_seq=3D1
kswapd0-94      [000] d..1.    77.709491: mm_vmscan_lru_inc_min_seq: memcg_=
id=3D88 type=3D0 swappiness=3D140 min_seq=3D2
kswapd0-94      [000] d..1.    77.709491: mm_vmscan_lru_inc_min_seq: memcg_=
id=3D88 type=3D1 swappiness=3D140 min_seq=3D1
kswapd0-94      [000] d..1.    77.715550: mm_vmscan_lru_inc_max_seq: memcg_=
id=3D88 swappiness=3D140 max_seq=3D4
kswapd0-94      [003] d..1.    77.749288: mm_vmscan_lru_inc_min_seq: memcg_=
id=3D4 type=3D0 swappiness=3D140 min_seq=3D2
kswapd0-94      [003] d..1.    77.749290: mm_vmscan_lru_inc_min_seq: memcg_=
id=3D4 type=3D1 swappiness=3D140 min_seq=3D1
kswapd0-94      [003] d..1.    77.763055: mm_vmscan_lru_inc_max_seq: memcg_=
id=3D4 swappiness=3D140 max_seq=3D4

Signed-off-by: w00021541 <wangzhen5@hihonor.com>
---
 include/trace/events/vmscan.h | 49 +++++++++++++++++++++++++++++++++++
 mm/vmscan.c                   |  6 +++++
 2 files changed, 55 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index ea58e4656abf..6f2ae5c597fd 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -488,6 +488,55 @@ TRACE_EVENT(mm_vmscan_lru_shrink_active,
 		show_reclaim_flags(__entry->reclaim_flags))
 );
=20
+#ifdef CONFIG_LRU_GEN
+TRACE_EVENT(mm_vmscan_lru_inc_min_seq,
+
+	TP_PROTO(struct mem_cgroup *memcg, int type, int swappiness, unsigned lon=
g min_seq),
+
+	TP_ARGS(memcg, type, swappiness, min_seq),
+
+	TP_STRUCT__entry(
+		__field(int, id)
+		__field(int, type)
+		__field(int, swappiness)
+		__field(unsigned long, min_seq)
+	),
+
+	TP_fast_assign(
+		__entry->id =3D mem_cgroup_id(memcg);
+		__entry->type =3D type;
+		__entry->swappiness =3D swappiness;
+		__entry->min_seq =3D min_seq;
+	),
+
+	TP_printk("memcg_id=3D%d type=3D%d swappiness=3D%d min_seq=3D%ld",
+		__entry->id, __entry->type,
+		__entry->swappiness, __entry->min_seq)
+);
+
+TRACE_EVENT(mm_vmscan_lru_inc_max_seq,
+
+	TP_PROTO(struct mem_cgroup *memcg, int swappiness, unsigned long max_seq)=
,
+
+	TP_ARGS(memcg, swappiness, max_seq),
+
+	TP_STRUCT__entry(
+		__field(int, id)
+		__field(int, swappiness)
+		__field(unsigned long, max_seq)
+	),
+
+	TP_fast_assign(
+		__entry->id =3D mem_cgroup_id(memcg);
+		__entry->swappiness =3D swappiness;
+		__entry->max_seq =3D max_seq;
+	),
+
+	TP_printk("memcg_id=3D%d swappiness=3D%d max_seq=3D%ld",
+		__entry->id, __entry->swappiness, __entry->max_seq)
+);
+#endif /* CONFIG_LRU_GEN */
+
 TRACE_EVENT(mm_vmscan_node_reclaim_begin,
=20
 	TP_PROTO(int nid, int order, gfp_t gfp_flags),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0fc9373e8251..6b5d21ee45ba 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3848,6 +3848,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int ty=
pe, int swappiness)
 	int zone;
 	int remaining =3D MAX_LRU_BATCH;
 	struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
+	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
 	int hist =3D lru_hist_from_seq(lrugen->min_seq[type]);
 	int new_gen, old_gen =3D lru_gen_from_seq(lrugen->min_seq[type]);
=20
@@ -3892,6 +3893,7 @@ static bool inc_min_seq(struct lruvec *lruvec, int ty=
pe, int swappiness)
 done:
 	reset_ctrl_pos(lruvec, type, true);
 	WRITE_ONCE(lrugen->min_seq[type], lrugen->min_seq[type] + 1);
+	trace_mm_vmscan_lru_inc_min_seq(memcg, type, swappiness, lrugen->min_seq[=
type]);
=20
 	return true;
 }
@@ -3902,6 +3904,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec,=
 int swappiness)
 	bool success =3D false;
 	bool seq_inc_flag =3D false;
 	struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
+	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
 	DEFINE_MIN_SEQ(lruvec);
=20
 	VM_WARN_ON_ONCE(!seq_is_valid(lruvec));
@@ -3947,6 +3950,7 @@ static bool try_to_inc_min_seq(struct lruvec *lruvec,=
 int swappiness)
=20
 		reset_ctrl_pos(lruvec, type, true);
 		WRITE_ONCE(lrugen->min_seq[type], min_seq[type]);
+		trace_mm_vmscan_lru_inc_min_seq(memcg, type, swappiness, lrugen->min_seq=
[type]);
 		success =3D true;
 	}
=20
@@ -3959,6 +3963,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsign=
ed long seq, int swappiness
 	int prev, next;
 	int type, zone;
 	struct lru_gen_folio *lrugen =3D &lruvec->lrugen;
+	struct mem_cgroup *memcg =3D lruvec_memcg(lruvec);
 restart:
 	if (seq < READ_ONCE(lrugen->max_seq))
 		return false;
@@ -4012,6 +4017,7 @@ static bool inc_max_seq(struct lruvec *lruvec, unsign=
ed long seq, int swappiness
 	WRITE_ONCE(lrugen->timestamps[next], jiffies);
 	/* make sure preceding modifications appear */
 	smp_store_release(&lrugen->max_seq, lrugen->max_seq + 1);
+	trace_mm_vmscan_lru_inc_max_seq(memcg, swappiness, lrugen->max_seq);
 unlock:
 	spin_unlock_irq(&lruvec->lru_lock);
=20
--=20
2.17.1

