Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EAE52CCC2
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868862; cv=none; b=Y6peJYklT50HdCnSteInqjit/EmoukNJzEMHwJhsQOQMSXC/6WE6FgQw+4vrXJAykLDaFge/UQOx4kXJcj0OJeogPyfBj0Ekkwl9s87tM5A0cMu/lIkH5TFe23Jo7nTEz1W027YL4lx30b/mB4AU0D1/13bUGGEfMHVXgg45+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868862; c=relaxed/simple;
	bh=zfoGhZ9tkatQAPTvMhsHChhPWCw6Z8eEJLu/axoyvVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GBVgSCS8FHQH6TZd2cz2pT87a2gNIBJJ4JO1JXl4IMTpJDbdYrMnjfhk4bzhphuGrQMX6/jbfwkts0y61jiILxjd1paUxKoxihckAtdK2+dho5sET1JyEyLqRiT8SBddR/d6uyEjor+wS0bLn1m5uyNf98gaFjkJbgwIOeROl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4HyrvoH; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4HyrvoH"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-1474c6b7742so5025122c88.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Oct 2026 08:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790868859; x=1791473659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UYLCjPpLfBewvYdjBDkNxTVbyP/bcB0jfIhL2wBACGM=;
        b=K4HyrvoHiwX8tLPo+4vior3S0EMYyxp/gpIhJSbLb1l3Lf6kYSSmvLmignKZdHTDDo
         1+ac/DDls+UQO0aG4SHQ0VwLizJMVnGWgiCVJwAS1hd1MYRPwLaSx3oTUJtCHiKugQuc
         1j1cnEGOS+Tq/mPmzAiPdaRw7AdX96UlrdUo6Q0GmtP5FdCgHYbhOgozOktoyY9D9/80
         wdt8IjxsO9qtTzrFYRM//HDZnLWl6ozOad3mPps3lAOrP99OseKFDGRdxE+cpUDkMVTO
         zgdz/Ma3IDq1UE5mocAi/ODqNcQgP7oV7v8kbozPWLs5ofsq0TQ9by06qbysfG5kf4dw
         tj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790868859; x=1791473659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYLCjPpLfBewvYdjBDkNxTVbyP/bcB0jfIhL2wBACGM=;
        b=0n7MGG3wc4CI26GDXxgASD9rwEmKHotXPQ92HGWHB4kKXjYIOGHApFvCQIBPwLvhkf
         9hSUFFR3nX7uuDVdkkBG0kcaK8wyNZnAlkcO9zKvQq0o40qEk3vdT9m50GMD5E/bpaGI
         IpqLMqhSZ3mJz5ZRdHbmubVE/dtdCwNSP7grOfE1xdR4sVlXEBi0FsuAicQ3YzwENsNv
         N0MiBaxg7aUs54rzfNuSVLPZx+IfS7+nsdLXKR1CeFVLlAvoUm8bA1FgFd/VZUMXgutv
         9OMHUpvKzIexiEntCR2B2/vNUxLUyaGqK0uy+VI8eEGK4nW+3xSexcKIzyZPpnv3RZ2T
         JxFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzFzyMq6BGWy3G2jQ9wNCaHdXsnFxAPQPUC2VQL0FVgSvZgQQBtYBxmF9OWHMjVFERzWo/YisP/wpyIr1OKfF3hxXI=@vger.kernel.org
X-Gm-Message-State: AFuF++lWI99nd/GmDcio9vMgZzWKbPyesBYs49WN96M5TjGX4n8Eatmh
	jw9lesNfPV4H37sNcsQvk/V7lG/X+kl9rcH+e7VuD7Fn7SfDr6z/0vCa
X-Gm-Gg: AYBFou1pzCA2dhBfUU7A0iCH3QFwOp3+sIW93ukVQcpBGFlW2L2rUi+ZnkUUMnT9P3N
	+P5+Lxwe0f9hfZ3wDNiXB1Ry6lPwB8i+rPWNbAD31362SmdRBMseYwnwh+/92ZjobNfHMyZRFIL
	mtNzzRI5I97SigDgPyTryxXlBeQqGURwy8YFTRHX1HV+oeNhr/j5rJbbGwNJLcnosQn35UBQCqk
	xWI1k5dRKRlGFipGAev/g1k0FHxqWmZ1vIH9hS0mOj+khkthBy6O8XWOgJ0YNWysFo6suUnCF0y
	3mzk+gy5Qp4qIdTcLpawzc/uTaOQiEhvywgJg7x9BvpZL1SBH5r8K20t2cQfRHY/V5o+v3QjbIx
	fgVvLGU/UYKGbaO3hoK2wm0HWMvWLY/wEnlBtP7XTXf90KLrwn3xeyt+9JnxZ77AsguetwW9Bp8
	LI5N19ih6nXtYWmHrBUyxqqML/xkbBvDanbxpkOvFaMuR93P966m9j/QWlWEY/s9r1HQ==
X-Received: by 2002:a05:7022:e1b:b0:14e:906f:9c8e with SMTP id a92af1059eb24-14e906f9dc4mr2454634c88.20.1790868859216;
        Thu, 01 Oct 2026 08:34:19 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f266d1156sm146683c88.6.2026.10.01.08.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:34:18 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 01 Oct 2026 23:33:49 +0800
Subject: [PATCH 2/2] mm/compaction: defer failed async direct compaction
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-bug-mm-thp-async-compact-defer-v1-2-0174c7923430@gmail.com>
References: <20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com>
In-Reply-To: <20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

A THP fault on a MADV_HUGEPAGE VMA first tries the local node only,
with __GFP_THISNODE | __GFP_NORETRY, and runs a single round of async
direct compaction there before falling back to other nodes. A failed
async run is never deferred.

When the local node has plenty of free memory but no free pageblock,
and what sits between the free pages can't be migrated, such as memory
long-term pinned for RDMA, each of these faults scans the zone again
and fails. Populating a large buffer pays for one failed compaction
per 2M fault. A KV-cache store that registers hundreds of GiB for RDMA
reports registration growing from tens of seconds to tens of minutes,
and works around it with MPOL_INTERLEAVE.

Defer the async state when an async run fails, and check it before
further async runs. Sync compaction keeps its own state and behaves as
before, and a successful compaction or allocation resets both. Keep
resetting the pageblock skip hints only when sync compaction restarts,
as async relies on them.

Populating a 4 GiB MADV_HUGEPAGE buffer from node 0 of a two-node VM,
with node 0 (24 GiB) fragmented by long-term pinning every other page,
median of 3 runs:

                          before     after
  direct compactions      735        15
  time in compaction      122.7 ms   3.6 ms
  population time         380 ms     273 ms
  THPs on node 0          1313       1126

The THPs that no longer land on node 0 come from node 1. With the same
fragmentation but movable memory, compaction still succeeds and the
median run still gets all 2048 THPs on node 0, as before.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 mm/compaction.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 7f8845d1990aa..25f758bc54f06 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2600,7 +2600,9 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
 
 	/*
 	 * Clear pageblock skip if there were failures recently and compaction
-	 * is about to be retried after being deferred.
+	 * is about to be retried after being deferred. Only do it when sync
+	 * compaction restarts: async compaction relies on the skip hints, and
+	 * clearing them on every async retry would rescan the whole zone.
 	 */
 	if (compaction_restarting(cc->zone, cc->order))
 		__reset_isolation_suitable(cc->zone);
@@ -2858,8 +2860,10 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 			!__cpuset_zone_allowed(zone, gfp_mask))
 				continue;
 
-		if (prio > MIN_COMPACT_PRIORITY
-					&& compaction_deferred(zone, order, true)) {
+		if (prio > MIN_COMPACT_PRIORITY &&
+		    (compaction_deferred(zone, order, true) ||
+		     (prio == COMPACT_PRIO_ASYNC &&
+		      compaction_deferred(zone, order, false)))) {
 			rc = max_t(enum compact_result, COMPACT_DEFERRED, rc);
 			continue;
 		}
@@ -2890,14 +2894,17 @@ enum compact_result try_to_compact_pages(gfp_t gfp_mask, unsigned int order,
 			break;
 		}
 
-		if (prio != COMPACT_PRIO_ASYNC && (status == COMPACT_COMPLETE ||
-					status == COMPACT_PARTIAL_SKIPPED))
+		if (status == COMPACT_COMPLETE ||
+		    status == COMPACT_PARTIAL_SKIPPED)
 			/*
 			 * We think that allocation won't succeed in this zone
 			 * so we defer compaction there. If it ends up
-			 * succeeding after all, it will be reset.
+			 * succeeding after all, it will be reset. A failed
+			 * async run only defers further async runs, as sync
+			 * compaction may succeed on pageblocks it skipped.
 			 */
-			defer_compaction(zone, order, true);
+			defer_compaction(zone, order,
+					 prio != COMPACT_PRIO_ASYNC);
 
 		/*
 		 * We might have stopped compacting due to need_resched() in

-- 
2.43.0

