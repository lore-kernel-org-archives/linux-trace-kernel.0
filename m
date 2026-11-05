Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.82
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900992;
	b=LbOyVv449V5gaEUcevu8eBKMaK4vIO7FqUlx4djE0rmLgNy9NC7sc1Br29TCS3xninFJ
	 SnG0YemFm3+13pS/kkCKyrpfn15icPUOPT3o72xp1F7v4aI19Aa6gtYVzsZS25kFTcmat
	 ut7pSFUJGvAjLxwosqs1GJxJEBqbSTvmnG6Vvw9pIksqoKo+BjEix1bd8BJy1c33LTo4B
	 8/OiCE5S2xf37sMbtLQb1dSNFDTuojp0wxLlZis+CZbOVEgqOwE8YVcJ533KhZ2kc3fxZ
	 2kGyCSI6D3+6bWy04hXJGk+Y29KqrlYp08Mn3/3fCW3egYw/+3+yf85ahW/+fbDFQXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900992;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i7lHOYDFws42KWAMRcaowzO1od4EUT/Dr3sRxjV6nc8=;
	b=Vz+LMZ8zSGshvbuCfcyVoNfHW2qWFBCFX6RXWUrPnQOOlXlgVuXIoOm7RLpGhNa2fEnu
	 HpaskUopSEPQmd/eibv6HAWmh8c1mJ5HwyrcDc3kch6OHs6HQK6k3Hf0+hGK07DL+AXtk
	 e0hfhQv4kl8i6lzpEsFDHWYSRIf8xU1Mo3YR3mOgNp+L/+ogaDYzoCuuGVEa20G3tEC+X
	 Ct4op/D/W0kaOlXVlVzS98AjfC6kifHoTCFtDvhGeYFxYIXUjB2Xij2FhHcpTzXMKhD10
	 z23qs/gSCgfw/UWo6HkZ90hnAtKqDsWnjouCLcfAC2zfnlKPUXBESmQBkB8WbkM6O9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qnxHXIbX;
	arc=none smtp.remote-ip=91.218.175.82
Received: from mta0.migadu.com (out-82.mta0.migadu.com [91.218.175.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02571606A329
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 17:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02571606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qnxHXIbX
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NirXRPgN4XmpzWS8psxuxF59x3eYAuZTNTwIQLLxoq4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793900990; v=1; x=1794505790;
 b=qnxHXIbXbxqTIZ/vQV8gtI+329nvp1kiLeX+vJj1RKk0UtzqsYYI10PGjFxq1tzvZE9OYSDF
 1j9zs97G9/UJIOmRnhBAE5uPwC2h+SyChBNwzbbGAjcuRH6b7VffOnRtTiD3vGXkrAMhRE3bWGy
 WMmdiisVICm0jC2oZco7vfvg=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id f4080175b0873934;
	Thu, 05 Nov 2026 17:49:49 +0000
X-Mizu-Trace-ID: f4080175b0873934
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v8 03/14] rv: Add a KUnit test for the HA timer underflow
Date: Fri,  6 Nov 2026 01:49:03 +0800
Message-Id: <4ae656adc2e23939c3bf2138e1d6a9ee496fe4da.1793900349.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793900349.git.wen.yang@linux.dev>
References: <cover.1793900349.git.wen.yang@linux.dev>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

Add rv_ha_kunit.c as a standalone test suite with rvtest, a minimal
per-object HA monitor, to test both underflows fixed by the previous
patch: an invariant checked while the uptime is below the budget holds,
and a timer armed after the budget elapsed expires now. Without that fix
both expectations fail.

Building the HA test in its own compilation unit keeps ha_monitor.h
isolated from non-monitor test runners and avoids macro conflicts. The
suite is guarded by IS_ENABLED(CONFIG_RV_HA_MONITOR) so kernels without
HA monitors build cleanly.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/trace/rv/Makefile      |   1 +
 kernel/trace/rv/rv_ha_kunit.c | 152 ++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100644 kernel/trace/rv/rv_ha_kunit.c

diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index cdbf68c84f5a..4b84b83b942b 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
 obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) += rv_monitors_test.o
+obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) += rv_ha_kunit.o
diff --git a/kernel/trace/rv/rv_ha_kunit.c b/kernel/trace/rv/rv_ha_kunit.c
new file mode 100644
index 000000000000..e8aaee110fae
--- /dev/null
+++ b/kernel/trace/rv/rv_ha_kunit.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for RV hybrid automata (HA) framework
+ */
+#include <kunit/test.h>
+#include <linux/rv.h>
+
+#if IS_ENABLED(CONFIG_RV_HA_MONITOR)
+
+#include <rv_trace.h>
+
+/* rvtest: a minimal per-object HA monitor driven directly by the tests. */
+#define MONITOR_NAME rvtest
+#define RV_MON_TYPE RV_MON_PER_OBJ
+#define HA_TIMER_TYPE HA_TIMER_HRTIMER
+typedef void *monitor_target;
+
+#define rv_monitoring_on()		true
+#define trace_rv_retries_error(...)	do { } while (0)
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
+		{ armed_rvtest },	/* idle */
+		{ INVALID_STATE },	/* armed */
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
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state, u64 time_ns)
+{
+	return true;
+}
+
+static const struct rv_kunit_mon rvtest_mon __maybe_unused = RV_MON_OPS_INIT();
+
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
+	da_monitor_init();
+	rv_this.enabled = 1;
+
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
+	 * the timer at KTIME_SEC_MAX. Reset first so the expiry does not
+	 * report.
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
+	da_destroy_storage(id);
+	da_monitor_destroy();
+	rv_this.enabled = 0;
+}
+
+static struct kunit_case rv_ha_kunit_cases[] = {
+	KUNIT_CASE(rv_test_rvtest_underflow),
+	{}
+};
+
+static struct kunit_suite rv_ha_kunit_suite = {
+	.name = "rv_ha",
+	.test_cases = rv_ha_kunit_cases,
+};
+
+kunit_test_suite(rv_ha_kunit_suite);
+
+#endif /* CONFIG_RV_HA_MONITOR */
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit tests for RV hybrid automata (HA) framework");
-- 
2.25.1

