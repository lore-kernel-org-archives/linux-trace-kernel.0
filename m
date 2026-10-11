Received: from mta1.migadu.com (out-85.mta1.migadu.com [95.215.58.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B523CD8D3
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Oct 2026 19:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791747599; cv=none; b=hUFJ3m62vi3LxJ71whKPwNH2iCsEVbOeqbxur2D91mWb4a+AxAkJNnMbrAR4B5+dD7GptGbEyPUadyvcP+e6jB5AEtj47I8qTQeVzG9YRhF1/h5E46wG6n2vq5pS+UcUOrQXGRRUKGG2iwCIHToBeURvNf4lPC+pOM8u3l3Hlgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791747599; c=relaxed/simple;
	bh=6eg0UDUM2pFKpqXL3ww0DT1cCVW2CMwQ1Kb1jumm1bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrYtduMOVUhyJ3GRQePA6q6rLwNOnz2maog9JwFuKcAcqf761ilPRQvKB2YaSwQ0cA3S58Hws5wKj6sPkSNlJF89vitITbnzuY0tGeE4HyAEQ2bWDHc+DAy16IM6fdiKuF3X5fy22q6lA1BOPsU663mB+Qf5OKmVfeOl/8XpgKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=STtWoN6Z; arc=none smtp.client-ip=95.215.58.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="STtWoN6Z"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=6eg0UDUM2pFKpqXL3ww0DT1cCVW2CMwQ1Kb1jumm1bE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791747596; v=1; x=1792352396;
 b=STtWoN6Z1jia9ORstWcP1QCMxoQO9ahIb6gyPX/1bdyyStzufXP2j9UcZzEn1OVy9PUyQGJP
 mb3JvuHmsPAv1e0ErfxHeKxqXYBnm5yX8vfeL0gZeRqkEWwW9eBjvzHkg4cweNbTFOx9UOfwH4z
 W1HrBSH1xITdlr4UMDXz2HsA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id e05ea2146313d171;
	Sun, 11 Oct 2026 19:39:56 +0000
X-Mizu-Trace-ID: e05ea2146313d171
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v7 03/14] rv: Add a KUnit test for the HA timer underflow
Date: Mon, 12 Oct 2026 03:39:09 +0800
Message-Id: <cdaf33af866392428f1942cef4e442b1d106989c.1791745088.git.wen.yang@linux.dev>
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

Add rvtest, a minimal per-object HA monitor, and a test for both
underflows fixed by the previous patch: an invariant checked while the
uptime is below the budget holds, and a timer armed after the budget
elapsed expires now.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/rv_monitors_test.c | 122 +++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/kernel/trace/rv/rv_monitors_test.c b/kernel/trace/rv/rv_monitors_test.c
index 3ad11195e664..889a209f6435 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
@@ -13,6 +13,87 @@
 #include <linux/rv.h>
 #include "rv.h"
 
+#include <rv_trace.h>
+
+/* rvtest: a minimal per-object HA monitor driven directly by the tests. */
+#define MONITOR_NAME rvtest
+#define RV_MON_TYPE RV_MON_PER_OBJ
+#define HA_TIMER_TYPE HA_TIMER_HRTIMER
+typedef void *monitor_target;
+
+/* The framework calls these for every monitor; this one reports nothing. */
+#define trace_event_rvtest(...)		do { } while (0)
+#define trace_error_rvtest(...)		do { } while (0)
+#define trace_error_env_rvtest(...)	do { } while (0)
+
+enum states_rvtest {
+	idle_rvtest,
+	armed_rvtest,
+	state_max_rvtest,
+};
+
+#define INVALID_STATE state_max_rvtest
+
+enum events_rvtest {
+	start_rvtest,
+	event_max_rvtest,
+};
+
+enum envs_rvtest {
+	clk_rvtest,
+	env_max_rvtest,
+	env_max_stored_rvtest = env_max_rvtest,
+};
+
+#define HA_CLK_NS
+
+struct automaton_rvtest {
+	char *state_names[state_max_rvtest];
+	char *event_names[event_max_rvtest];
+	char *env_names[env_max_rvtest];
+	unsigned char function[state_max_rvtest][event_max_rvtest];
+	unsigned char initial_state;
+	bool final_states[state_max_rvtest];
+};
+
+static const struct automaton_rvtest automaton_rvtest = {
+	.state_names = { "idle", "armed" },
+	.event_names = { "start" },
+	.env_names = { "clk" },
+	.function = {
+		{ armed_rvtest },
+		{ INVALID_STATE },
+	},
+	.initial_state = idle_rvtest,
+	.final_states = { 1, 0 },
+};
+
+#include <rv/ha_monitor.h>
+
+#define RVTEST_BUDGET_NS (300ULL * NSEC_PER_MSEC)
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_rvtest env,
+		      u64 time_ns)
+{
+	return ha_get_clk_ns(ha_mon, env, time_ns);
+}
+
+static void ha_reset_env(struct ha_monitor *ha_mon, enum envs_rvtest env,
+			 u64 time_ns)
+{
+	ha_reset_clk_ns(ha_mon, env, time_ns);
+}
+
+/* The tests arm the timer themselves. */
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state, u64 time_ns)
+{
+	return true;
+}
+
+static const struct rv_kunit_mon rvtest_mon = RV_MON_OPS_INIT();
+
 /*
  * An easy way to pass the context is to use kunit_get_current_test()->priv,
  * but this doesn't always work (e.g. a reactor running from another context
@@ -146,6 +227,46 @@ static void rv_test_dummy(struct kunit *test)
 	active_ctx = NULL;
 }
 
+/*
+ * rv_test_rvtest_underflow - the HA clock math must not underflow as u64
+ *
+ * An invariant checked while the uptime is below the budget holds, and a
+ * timer armed after the budget elapsed expires now.
+ */
+static void rv_test_rvtest_underflow(struct kunit *test)
+{
+	struct ha_monitor *ha_mon;
+	struct da_monitor *da_mon;
+	const int id = 4242;
+
+	prepare_test(test, &rvtest_mon);
+	da_handle_start_run_event(id, NULL, start_rvtest);
+
+	scoped_guard(rcu)
+		da_mon = da_get_monitor(id, NULL);
+	KUNIT_ASSERT_NOT_NULL(test, da_mon);
+	ha_mon = to_ha_monitor(da_mon);
+
+	/* Uptime below the budget: time_ns - expire_ns would underflow. */
+	ha_reset_clk_ns(ha_mon, clk_rvtest, 0);
+	KUNIT_EXPECT_TRUE(test, ha_check_invariant_ns(ha_mon, clk_rvtest, 0,
+						      RVTEST_BUDGET_NS));
+
+	/*
+	 * Budget already elapsed: expire - passed would underflow and queue
+	 * the timer at KTIME_SEC_MAX.
+	 */
+	da_monitor_reset(&ha_mon->da_mon);
+	ha_reset_clk_ns(ha_mon, clk_rvtest, 0);
+	ha_start_timer_ns(ha_mon, clk_rvtest, RVTEST_BUDGET_NS,
+			  RVTEST_BUDGET_NS + NSEC_PER_SEC);
+	KUNIT_EXPECT_TRUE(test,
+			  ktime_before(hrtimer_get_expires(&ha_mon->hrtimer),
+				       ktime_get() + NSEC_PER_SEC));
+
+	ha_cancel_timer_sync(ha_mon);
+}
+
 #include "monitors/sco/sco_kunit.c"
 #include "monitors/sssw/sssw_kunit.c"
 #include "monitors/sts/sts_kunit.c"
@@ -163,6 +284,7 @@ static struct kunit_case rv_mon_test_cases[] = {
 	KUNIT_CASE(rv_test_nomiss),
 	KUNIT_CASE(rv_test_pagefault),
 	KUNIT_CASE(rv_test_sleep),
+	KUNIT_CASE(rv_test_rvtest_underflow),
 	{}
 };
 
-- 
2.25.1

