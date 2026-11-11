Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406452;
	b=pkuDFMRr4V5cc7pCEN8z5tqBJO/i2/0E/X4hOwHLHMZHz0nSiDa1eZjamJxVhyAbXjMW
	 5t21lVYfMhrTxPfFou0NC/Vq4IenwVjIa44k0YGhhPAg95VRcvdXruD8WRptwp+UfmF7g
	 YtvH2kiFFEl4QOJ1T3H6IVOtjaC2RFeJKPqOgJ8o4NOdtFMJ73DB11UId8HkM5AEAvDcm
	 fIKpoCexwatq/TmZZ4Y/fIBkIebbvnuRd/8pG3fUOwKWU7iQdCO6tSb/YQT0aeLRx8fbD
	 Tey7YWlK5mcHoRe6mpu2c5u3ixZF4tNBR+405uE8FWd4jFNBgvM3SPrHm8mJlYAH8AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406452;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=trPIUdSSKjXgSUN1AJr3c8r0RrVvSESVFD0KpzTUtgg=;
	b=hvuXxJQmmuZj8fXbrq9p3MtigQMqDQo+CSJdNOFVq8aTl5cfzHY1OZG4pONq/YRslIXL
	 bxCoFRGi63IcEiEIYcBF3BwkAH/AOLms8vycBIayxP/EEBF0+m0GASzeiwfCcUN30V5C8
	 tfmUZeFZDidoh6GAvsDVbTs5FtQ7QfPkNiawSSW4VysllgcGNqksojW/x0UIus4im++ZL
	 ptb+kX9sdOmMzH59GMo4YVa2VhTYpKbf613HPhPm+VUNPt7soMLZhYgT3uouTVD5tDIEC
	 fig1b3BWI9iWLteE/WIZK0V6V72OIGl9cI5pHoAXPkfCj4vbfDxfd9dQZHdiD/NWGcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpY3d5VD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA691606A330;
	Wed, 11 Nov 2026 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpY3d5VD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8521F00A06;
	Wed, 11 Nov 2026 14:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406452;
	bh=trPIUdSSKjXgSUN1AJr3c8r0RrVvSESVFD0KpzTUtgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XpY3d5VD5td8Eulw4MZ81BCSIWs127cjPh1EdZ6H2LncD4viLHnAFIDxBzVJofK2R
	 VP9mP5wZJ4btyiwM5seJc3ub7V/VD0oxosuIfcLFSpRqnmBo6vZgGS+c2b211MJLiW
	 za7fDpGcxwrmfWn6fm1jojCcYCbDzigC2u5h0dwvun+z/yGeyUJF7zPz/4uY0pwL7j
	 DV2sTkylED1sNvDrVxD3X3Li4akwsmGNM7zXiERFqeBIcpKa/nxzyziakkjFyQyzDf
	 yzJc+/pc8N45wVXc78fPglmol9D3170aecc+o+E8vui10ubyB9B6bXwiNU2805IisY
	 wtvolFbxdtAfA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: [PATCH v3 5/5] kprobes: Add KUnit test cases for kprobes regressions
Date: Wed, 11 Nov 2026 23:14:08 +0900
Message-ID: <179440644868.328088.1235522965655007009.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179440640176.328088.17106877243326801914.stgit@devnote2>
References: <179440640176.328088.17106877243326801914.stgit@devnote2>
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
   cleanly without overwriting the jump instruction or crashing.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Check that the jump opcode at *opt_kp.addr is preserved across
   disable_kprobe() and enable_kprobe() in
   test_optprobe_rearm_unoptimizing().
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
 lib/tests/test_kprobes.c |  139 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)

diff --git a/lib/tests/test_kprobes.c b/lib/tests/test_kprobes.c
index 06e729e4de05..df3f080b1852 100644
--- a/lib/tests/test_kprobes.c
+++ b/lib/tests/test_kprobes.c
@@ -358,8 +358,136 @@ static void test_stacktrace_on_nested_kretprobe(struct kunit *test)
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
+	kprobe_opcode_t jmp_op;
+
+	current_test = test;
+	KUNIT_ASSERT_EQ(test, 0, register_kprobe(&opt_kp));
+
+	/* Allow background optimizer thread to jump-optimize the probe */
+	wait_for_kprobe_optimizer();
+	jmp_op = READ_ONCE(*opt_kp.addr);
+
+	/* Temporarily disable probe (queues on unoptimizing_list, leaves jump) */
+	KUNIT_EXPECT_EQ(test, 0, disable_kprobe(&opt_kp));
+
+	/* Immediately re-enable (re-arm) before optimizer thread unoptimizes */
+	KUNIT_EXPECT_EQ(test, 0, enable_kprobe(&opt_kp));
+
+	/* Verify jump opcode was not overwritten by a breakpoint on re-arm */
+	KUNIT_EXPECT_EQ(test, jmp_op, READ_ONCE(*opt_kp.addr));
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
@@ -380,6 +508,9 @@ static int kprobes_test_init(struct kunit *test)
 	stacktrace_target = kprobe_stacktrace_target;
 	internal_target = kprobe_stacktrace_internal_target;
 	stacktrace_driver = kprobe_stacktrace_driver;
+#if defined(CONFIG_OPTPROBES) && !IS_MODULE(CONFIG_KPROBES_SANITY_TEST)
+	opt_target = kprobe_opt_target;
+#endif
 	rand1 = get_random_u32_above(div_factor);
 	return 0;
 }
@@ -391,10 +522,18 @@ static struct kunit_case kprobes_testcases[] = {
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

