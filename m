Received: from mta0.migadu.com (out-95.mta0.migadu.com [91.218.175.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC12E1746
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747622; cv=none; b=a9H3YM5HYWeBBRlO6OmOT0pZ3vvf3ZnYIARSpBPQ1oRQKu2gQANqNKX/BcuGIDjiGwJofBweJh9S6HM3gH1DPPXLE+IESLMDQbPm60DD557Zj3XEID5dwf9YuYpT3s5DMRBzAd+zt4I8Tl/lA0HJ9Os7TNvWbmat+04ZG9Oysn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747622; c=relaxed/simple;
	bh=VrECW6y3UTzCcA5YfnHCh/KC1GIO6HnF3Hx/47w6WF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJJcGscqn+NqG9tJLGbML6IiTfG1+/l7VVQBUjLx4DDImgwat8rmQbFNjNGH7nFi50n7oqe6e9STyLt3ALJRW+g2G/CBYiWxbm0/UMuw3WK2X9mSBExP9ELqWB1Uk+jiHBCPbNvWypa1X+UzIJtUPbVBcgd406ulNefOSaZpaho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gQMSrCRv; arc=none smtp.client-ip=91.218.175.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gQMSrCRv"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VrECW6y3UTzCcA5YfnHCh/KC1GIO6HnF3Hx/47w6WF0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747618; v=1; x=1792352418;
 b=gQMSrCRvxLbqc9G1Cajh2BBD+6ApUeMb/f93m9CF0JufgnHe0e9jbyJExoSkB1dWXwVKQ4nO
 61Ipy3OqNlADB0+SoNHTCR+HrBn9kj5G/kEd+or5BA9/K/teSo0XPG91GZjEbhv5kFY8qSW70Z0
 uh9dHxI8BvvWkjXgYUraUVtI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id c1f1836e7e53e850;
	Sun, 11 Oct 2026 19:40:18 +0000
X-Mizu-Trace-ID: c1f1836e7e53e850
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 08/14] rv: Add per-object teardown hook da_extra_cleanup
Date: Mon, 12 Oct 2026 03:39:14 +0800
Message-Id: <68b2e41332eb12ebcd07383402ca6cac1a83b429.1791745088.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1791745088.git.wen.yang@linux.dev>
References: <cover.1791745088.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

da_monitor_destroy() frees each per-object storage, but a monitor
whose target is allocated separately has no point to free it: the
target is still reachable from the storage until hash_del_rcu().

Add an optional da_extra_cleanup() hook, called for each storage after
da_monitor_free_hook() has disarmed its timer and before the storage is
unlinked.  It defaults to a no-op.  tlob, added later in this series,
uses it to retire and free its per-window record.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/da_monitor.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index f9af56304c9f..97d9e876c891 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -116,6 +116,16 @@ static struct rv_monitor rv_this;
 #define da_monitor_free_hook(da_mon)
 #endif
 
+/*
+ * Per-object teardown hook, called for each entry after
+ * da_monitor_reset_all() + da_monitor_sync_hook() and before hash_del_rcu().
+ * Runs after da_monitor_free_hook(), so it may free the storage's target.
+ * Default: no-op.
+ */
+#ifndef da_extra_cleanup
+#define da_extra_cleanup(da_mon)
+#endif
+
 /*
  * Type for the target id, default to int but can be overridden.
  * A long type can work as hash table key (PER_OBJ) but will be downgraded to
@@ -715,7 +725,9 @@ static inline void da_monitor_destroy(void)
 	 * pending, we can safely assume no concurrent user.
 	 */
 	hash_for_each_safe(da_monitor_ht, bkt, tmp, mon_storage, node) {
+		/* Before da_extra_cleanup(): it frees what the timer reads. */
 		da_monitor_free_hook(&mon_storage->rv.da_mon);
+		da_extra_cleanup(&mon_storage->rv.da_mon);
 		hash_del_rcu(&mon_storage->node);
 		if (DA_MON_ALLOCATION_STRATEGY == DA_ALLOC_POOL)
 			mempool_free(mon_storage, &da_monitor_pool);
-- 
2.25.1

