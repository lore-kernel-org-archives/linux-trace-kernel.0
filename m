Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273625;
	b=ahz/MoYCAXJZbDx7tRHkug94Uw7CWMgxOI2S7YEujfk7nx2S6S/rN7uEBabIjkQUulWL
	 0k4Q2nnZKCtihN57NY4Xk38AAi2Re54tvRCDWOUbasZurGtRC/Af/m8RpTaMQ0pmJEHAv
	 9BNw6y+icY6tavBLfjF2WF4lyEMnxOSnAfdwP+Y2AUZfsgTW+H1v98X7MHpq8DKt98gh0
	 W1WGsTY1NMjJv5+Cp+LktCuOfDYNyRnfnpI2wBZH1s7GLLW3NimUdA8SeB6X0Axy2+tpE
	 Tdtz4LYIF4OFI0N3Jf6fzYFrjPBQCp6cYt8A3QquSKHxPLYgqzt9jfpamZgvQx+oApA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273625;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nUMlmqHbsT1a6wxY8WGJYQj0ylZGPkN3vbel3uxdAAc=;
	b=VUgtOhvB79jPgilcBa7Hcz0aAVaEuIvlcJwSf0N6OcgY9ba9sre20lij+lmiE9zGbUi1
	 IN1Jrl7WpPTowEOrjUDyicPCjnUpLMCeTZ6irg94PC8jIL09B4tBnrWV+QUD3zbk9snR3
	 ycyoVKQtKpmXbDr3Anrzg8V7kzYijarxud/fZeDLRIcCfckm0u1CyXQG8ypan3O5oG0aW
	 +azVEZwMTrVfhB+wo4hC+7jFTBB+xWtwjOBAUkJ1vhIQXXxqgr666BlNmM1u1lcJhS5BQ
	 IyJeBZuwdilxq7nlj7xSDg9d7G+4P7x+rzGMcC4QNVXD2nlBMfuPE/+sPZlCM3BJMqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I0EJKiQB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C71560A2607;
	Tue, 10 Nov 2026 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I0EJKiQB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5261F008A1;
	Tue, 10 Nov 2026 01:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273624;
	bh=nUMlmqHbsT1a6wxY8WGJYQj0ylZGPkN3vbel3uxdAAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0EJKiQBhCNkrHlZOOO/nubMoNYmbn28L4LGrv03ahKTAielt9pHLFZKryUdx41Mn
	 nT6brCQM13dkNB1QAIoVpR19StpfQZ+6O+YAIhKCmnHCjzhSnllalfUm6lX5q5Vz2X
	 RwgQD0rPrfkx3/R9f5Iu2PWV60cWmpOMHXYXxdLjlb6qcrM/y4q6Js6s21DWbMaLrm
	 AW1I9/uquQxAK69+CmIK/ZHWRFcPJEqdotk+FQrpqmTGTJtSnjNylQaK6Q5HPxsF5T
	 t7Wk9C8iK2+m89dqgizJO4/YVJKKDgsupRNwnG89nULAqME/x4CCb7pa9c0oJXdr7B
	 BgOQRCOASRv0w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: [PATCH v2 4/4] kprobes: Add KUnit test cases for kprobes regressions
Date: Tue, 10 Nov 2026 10:20:20 +0900
Message-ID: <179427362063.291326.12590758885048682193.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179427358690.291326.2078291446658598883.stgit@devnote2>
References: <179427358690.291326.2078291446658598883.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Add KUnit test cases to lib/tests/test_kprobes.c to verify that the
recent regressions in kprobes registration, ftrace ops switching, and
optimization state transitions are resolved:

1. test_kretprobe_unregistered_cleanup:
   Verifies that unregistering an uninitialized or already-unregistered
   kretprobe does not cause a NULL pointer dereference or double free.

2. test_kretprobe_rereg_by_symbol:
   Verifies that attempting to re-register an active kretprobe by symbol
   name fails with -EINVAL and does not destroy the active probe's
   underlying rethook state.

3. test_kprobe_ftrace_post_handler_switch:
   Verifies that adding a second kprobe with a post_handler to a probe
   point armed with kprobe_ftrace_ops correctly switches to
   kprobe_ipmodify_ops and both probes cleanly unregister without
   disarming errors (-ENOENT).

4. test_optprobe_rearm_unoptimizing:
   Verifies that disabling an optimized kprobe on a notrace target and
   immediately re-enabling it before the optimizer thread runs works
   cleanly without corrupting the jump instruction or crashing.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Probe a notrace target function (kprobe_opt_target) in
   test_optprobe_rearm_unoptimizing() so that jump optimization is tested
   even when CONFIG_KPROBES_ON_FTRACE=y.
 - Guard test_optprobe_rearm_unoptimizing() with
   !IS_MODULE(CONFIG_KPROBES_SANITY_TEST) since
   wait_for_kprobe_optimizer() is not exported to modules.
 - Replace KUNIT_ASSERT_EQ() with KUNIT_EXPECT_EQ() while stack-allocated
   probes are registered to prevent stack use-after-free on test failure.
---
 lib/tests/test_kprobes.c |  136 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/lib/tests/test_kprobes.c b/lib/tests/test_kprobes.c
index 06e729e4de05..d692612bc224 100644
--- a/lib/tests/test_kprobes.c
+++ b/lib/tests/test_kprobes.c
@@ -358,8 +358,133 @@ static void test_stacktrace_on_nested_kretprobe(struct kunit *test)
 }
 #endif /* CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE */
 
+/* Test for: kprobes: Fix double free and NULL deref in unregister_kretprobes() */
+static void test_kretprobe_unregistered_cleanup(struct kunit *test)
+{
+	struct kretprobe unreg_rp = {
+		.kp.symbol_name = "kprobe_target",
+	};
+
+	current_test = test;
+
+	/* Unregistering a probe that was never registered must return cleanly */
+	unregister_kretprobe(&unreg_rp);
+
+	/* Double unregister of a valid registered probe */
+	KUNIT_ASSERT_EQ(test, 0, register_kretprobe(&unreg_rp));
+	unregister_kretprobe(&unreg_rp);
+	/* Second unregister must not cause double-free or NULL pointer dereference */
+	unregister_kretprobe(&unreg_rp);
+}
+
+/* Test for: kprobes: Validate re-registration earlier in register_kretprobe() */
+static void test_kretprobe_rereg_by_symbol(struct kunit *test)
+{
+	struct kretprobe test_rp = {
+		.kp.symbol_name = "kprobe_target",
+		.handler = return_handler,
+		.entry_handler = entry_handler,
+	};
+
+	current_test = test;
+	KUNIT_ASSERT_EQ(test, 0, register_kretprobe(&test_rp));
+
+	/* Verify the probe is live and functional */
+	krph_val = 0;
+	target(rand1);
+	KUNIT_EXPECT_EQ(test, krph_val, rand1);
+
+	/*
+	 * Attempt re-registration with symbol_name (with kp.addr cleared).
+	 * Must fail with -EINVAL and NOT destroy the live probe's rethook.
+	 */
+	test_rp.kp.addr = NULL;
+	KUNIT_EXPECT_EQ(test, -EINVAL, register_kretprobe(&test_rp));
+
+	/* The original kretprobe must still be functional */
+	krph_val = 0;
+	target(rand1);
+	KUNIT_EXPECT_EQ(test, krph_val, rand1);
+
+	unregister_kretprobe(&test_rp);
+}
+
 #endif /* CONFIG_KRETPROBES */
 
+#if defined(CONFIG_KPROBES_ON_FTRACE)
+/* Test for: kprobes: Switch ftrace ops when adding probe with post_handler */
+static void test_kprobe_ftrace_post_handler_switch(struct kunit *test)
+{
+	struct kprobe kp_entry = {
+		.symbol_name = "kprobe_target",
+		.pre_handler = kp_pre_handler,
+	};
+	struct kprobe kp_post = {
+		.symbol_name = "kprobe_target",
+		.post_handler = kp_post_handler,
+	};
+	int ret;
+
+	current_test = test;
+
+	/* 1. Register first probe without post_handler (armed with kprobe_ftrace_ops) */
+	KUNIT_ASSERT_EQ(test, 0, register_kprobe(&kp_entry));
+
+	/* 2. Register second probe with post_handler at same IP (must switch ops) */
+	ret = register_kprobe(&kp_post);
+	KUNIT_EXPECT_EQ(test, 0, ret);
+	if (!ret) {
+		/* 3. Execute target function to trigger both */
+		preh_val = 0;
+		posth_val = 0;
+		target(rand1);
+		KUNIT_EXPECT_NE(test, 0, preh_val);
+		KUNIT_EXPECT_NE(test, 0, posth_val);
+
+		/* 4. Unregistering must successfully disarm without -ENOENT */
+		unregister_kprobe(&kp_post);
+	}
+	unregister_kprobe(&kp_entry);
+}
+#endif
+
+#if defined(CONFIG_OPTPROBES) && !IS_MODULE(CONFIG_KPROBES_SANITY_TEST)
+static u32 (*opt_target)(u32 value);
+
+static noinline notrace u32 kprobe_opt_target(u32 value)
+{
+	return (value / div_factor) + 2;
+}
+
+/* Test for: kprobes: Do not overwrite jump instruction when re-arming unoptimizing probe */
+static void test_optprobe_rearm_unoptimizing(struct kunit *test)
+{
+	struct kprobe opt_kp = {
+		.symbol_name = "kprobe_opt_target",
+		.pre_handler = kp_pre_handler,
+	};
+
+	current_test = test;
+	KUNIT_ASSERT_EQ(test, 0, register_kprobe(&opt_kp));
+
+	/* Allow background optimizer thread to jump-optimize the probe */
+	wait_for_kprobe_optimizer();
+
+	/* Temporarily disable probe (queues on unoptimizing_list, leaves jump) */
+	KUNIT_EXPECT_EQ(test, 0, disable_kprobe(&opt_kp));
+
+	/* Immediately re-enable (re-arm) before optimizer thread unoptimizes */
+	KUNIT_EXPECT_EQ(test, 0, enable_kprobe(&opt_kp));
+
+	/* Verify jump opcode was not corrupted by an unaligned INT3 overwrite */
+	preh_val = 0;
+	opt_target(rand1);
+	KUNIT_EXPECT_NE(test, 0, preh_val);
+
+	unregister_kprobe(&opt_kp);
+}
+#endif
+
 static int kprobes_test_init(struct kunit *test)
 {
 	KP_CLEAR(kp);
@@ -380,6 +505,9 @@ static int kprobes_test_init(struct kunit *test)
 	stacktrace_target = kprobe_stacktrace_target;
 	internal_target = kprobe_stacktrace_internal_target;
 	stacktrace_driver = kprobe_stacktrace_driver;
+#if defined(CONFIG_OPTPROBES) && !IS_MODULE(CONFIG_KPROBES_SANITY_TEST)
+	opt_target = kprobe_opt_target;
+#endif
 	rand1 = get_random_u32_above(div_factor);
 	return 0;
 }
@@ -391,10 +519,18 @@ static struct kunit_case kprobes_testcases[] = {
 #ifdef CONFIG_KRETPROBES
 	KUNIT_CASE(test_kretprobe),
 	KUNIT_CASE(test_kretprobes),
+	KUNIT_CASE(test_kretprobe_unregistered_cleanup),
+	KUNIT_CASE(test_kretprobe_rereg_by_symbol),
 #ifdef CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
 	KUNIT_CASE(test_stacktrace_on_kretprobe),
 	KUNIT_CASE(test_stacktrace_on_nested_kretprobe),
 #endif
+#endif
+#if defined(CONFIG_KPROBES_ON_FTRACE)
+	KUNIT_CASE(test_kprobe_ftrace_post_handler_switch),
+#endif
+#if defined(CONFIG_OPTPROBES) && !IS_MODULE(CONFIG_KPROBES_SANITY_TEST)
+	KUNIT_CASE(test_optprobe_rearm_unoptimizing),
 #endif
 	{}
 };

