Received: from mta1.migadu.com (out-90.mta1.migadu.com [95.215.58.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6771544C4EC
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747607; cv=none; b=j34F2yDPS1t1BLf7FNiEINKCOd/vtvgSommffu/WqCN9VzAcx/FBZrScaaZNaVtPSAaVq14zVqhiERmDOq4QFISpb5+C2N6wUrdNpKVooTTBdInTcY9JCu9biEQzh+c8dG3l5IvfeOoDUZeTQbmflAjPngY5hEw8ovSDeA0au5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747607; c=relaxed/simple;
	bh=TqUJZt0jTQnNoDrW5bcG3O1AAOexFyLxL8nTiG2WsTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dG2ZhyVoc6ZpnQ+fUwqlz+iA/Fe5zXItyhbS9MUdnWTdUw1Tf6hNHVk7MJo3CAh9fK1otIdDDk5d6m9OZSi1OjxfTACx3ZQcb9ek26r+gifR8h4UCYhJX8gR/KB9DGqyw5Xr3ItWGbllDrNFSucpmDsmTIQzq+YsCJ8e1wdF/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B51q5m/L; arc=none smtp.client-ip=95.215.58.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B51q5m/L"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TqUJZt0jTQnNoDrW5bcG3O1AAOexFyLxL8nTiG2WsTo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747602; v=1; x=1792352402;
 b=B51q5m/LYPYf8fZdQ1j4vhTIUixm2sJYzdVbq2Pa9T+9PqrWZLFv3HMrkBHIGBON/Yw/oes8
 H5q9MTSsAeG4NQ+ajrP3tpnmx4WR6aCBF3oCjGNB9r1rBZ7N8LiLKUCJcyb7k+deI/WDwIMRSlh
 hy6Ttyb49YuHYvCfhy+JoMgI=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id a578644b0269f23a;
	Sun, 11 Oct 2026 19:40:02 +0000
X-Mizu-Trace-ID: a578644b0269f23a
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 05/14] rv: Add a KUnit test for the storage free path
Date: Mon, 12 Oct 2026 03:39:11 +0800
Message-Id: <448c421a47452ebddc6502ba3435eb91c1749601.1791745088.git.wen.yang@linux.dev>
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

The test resolves a storage, desstroys it with da_destroy_storage(), and
then arms the HA timer through the stale pointer. The free hook must
disarm that timer too, so it never fires and no reaction is reported.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/rv_monitors_test.c | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 889a209f6435..b30e49419e34 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -267,6 +267,43 @@ static void rv_test_rvtest_underflow(struct kunit *test)
 	ha_cancel_timer_sync(ha_mon);
 }
 
+/*
+ * rv_test_rvtest_arm_after_destroy - a storage outlived by its own timer
+ *
+ * da_destroy_storage() cancels the timer, then unlinks:
+ *
+ *	da_monitor_reset_hook()		cancels
+ *	hash_del_rcu()
+ *	call_rcu()
+ *
+ * A reader that resolved the storage before the unlink can arm past that
+ * cancel.  Handlers resolve and use under one guard(rcu)(), so the two steps
+ * are issued separately here.
+ */
+static void rv_test_rvtest_arm_after_destroy(struct kunit *test)
+{
+	struct rv_kunit_ctx *ctx = test->priv;
+	const int id = 4242;
+	struct da_monitor *stale;
+
+	prepare_test(test, &rvtest_mon);
+
+	da_handle_start_run_event(id, NULL, start_rvtest);
+
+	scoped_guard(rcu)			/* resolve before the unlink */
+		stale = da_get_monitor(id, NULL);
+	KUNIT_ASSERT_NOT_NULL(test, stale);
+
+	da_destroy_storage(id);			/* cancel, unlink, call_rcu */
+	ha_start_timer_ns(to_ha_monitor(stale), clk_rvtest,
+			  RVTEST_BUDGET_NS, ha_get_ns());
+
+	rcu_barrier();
+
+	msleep(600);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+}
+
 #include "monitors/sco/sco_kunit.c"
 #include "monitors/sssw/sssw_kunit.c"
 #include "monitors/sts/sts_kunit.c"
@@ -285,6 +322,7 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_pagefault),
 	KUNIT_CASE(rv_test_sleep),
 	KUNIT_CASE(rv_test_rvtest_underflow),
+	KUNIT_CASE(rv_test_rvtest_arm_after_destroy),
 	{}
 };
 
-- 
2.25.1

