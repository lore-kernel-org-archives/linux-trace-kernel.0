Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750375;
	b=x/qX+idCeJkgPEvT1C99PImfv8+mdiVdVYK3T4XQC5x0RwdJU2sjX0rkvc4GX8t6B2UU
	 ajfM99QWn7iTiyhyssf2dvnGAiGfSo4Ihku2E0gv4+hkPQDwn5F+QgHDh3pZL/gfwPW1k
	 2bYhQvytf2WJ/iZYyq94ZUgVpKJHxBdP3t5AfD2o2+tyc7BGmecXH69QCVDzz+DuIDbJR
	 93rxYu8U/e7XvvjBbdITnf971q28h1VmVpFySZ4U5GWAjxaOoe7wERKk1K61y4g+59T2b
	 r9r1hOEWKArPIl/VSiJsh1jAB8ZOBBWDTx5w85XNBtFT0LX9dwtCv6dYOKn9wb5t6FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750375;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IW9Bp1spxA1IECNE8RTDxBWhNPYLwMzCFp8L9qO9RhM=;
	b=YZ8xqbGNw3d8KRnoyKIxnMMS95jfI0Kh3VlET2CqgguREHLBINx5KlYN6tzuOcm/HgSo
	 RXLICZn6Uyhyj1uKyD3qe7roQ89KhZ2blnJmKmq5iyka7lQReNGQFFVYQVLplXXq94Qr0
	 RcPD7RIrcDFDp07yz/RmIZ+FFUQj4F/dVepe5vJwS6KmP0tkX0NLqTb0pBcjXliR1k6NQ
	 PBD4We9H+xB3Wk3mYWwPGm/fhp2yqRPk/M+BlGJhCifSJ7p7RXMmYpV5GRjIJPiWn5r3+
	 ifAMoGXz1DImNcg90tOCjl9DfBxq5pxi/6/LAGQLLy5GCv0koJtveucbwoeoW8aHGag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eis5o/bg";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52752606A31B;
	Tue,  3 Nov 2026 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eis5o/bg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45EF1F000C1;
	Tue,  3 Nov 2026 23:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750375;
	bh=IW9Bp1spxA1IECNE8RTDxBWhNPYLwMzCFp8L9qO9RhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eis5o/bggueqt3To4PxxO2iUSEsaTRAgQgx3jwYWTD1NULnf1It5tD1dKUCdUxivJ
	 Hb8LxBnh6NYL31nYCkUvjGjyNbClY+tUEyRTyUHQ3YOZp++fUphh6bEz3NJoH5PUqa
	 IhV3zXteUUtLgsg108XV7fbkMRn3iNcNIgg3pHcYnN80krDjTJT10Pgrc9SiTXAiFP
	 mRbyzL/W9N0b7DF1W6SbNaH6foIBcsVjlHo5+XBY/0nth6EUgXCU5K4hCrt9ORQy/j
	 VfrSolZ5IsPM9HPvwhVEnoUvI8djobravTcW+tql3XSrk+qhbNpYipZTE01jKHN5qt
	 Ha2KcZTrXNfxg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 8/8] kprobes: Add KUnit test cases for kprobes regressions
Date: Wed,  4 Nov 2026 08:59:31 +0900
Message-ID: <179375037150.247640.2739381151766036732.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179375029807.247640.13024754173032838618.stgit@devnote2>
References: <179375029807.247640.13024754173032838618.stgit@devnote2>
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
   Verifies that disabling an optimized kprobe and immediately
   re-enabling it before the optimizer thread runs does not overwrite the
   jump instruction opcode or crash on execution.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 lib/tests/test_kprobes.c |  123 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/lib/tests/test_kprobes.c b/lib/tests/test_kprobes.c
index 06e729e4de05..c20f70cc63d7 100644
--- a/lib/tests/test_kprobes.c
+++ b/lib/tests/test_kprobes.c
@@ -358,8 +358,123 @@ static void test_stacktrace_on_nested_kretprobe(struct kunit *test)
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
+
+	current_test = test;
+
+	/* 1. Register first probe without post_handler (armed with kprobe_ftrace_ops) */
+	KUNIT_ASSERT_EQ(test, 0, register_kprobe(&kp_entry));
+
+	/* 2. Register second probe with post_handler at same IP (must switch ops) */
+	KUNIT_ASSERT_EQ(test, 0, register_kprobe(&kp_post));
+
+	/* 3. Execute target function to trigger both */
+	preh_val = 0;
+	posth_val = 0;
+	target(rand1);
+	KUNIT_EXPECT_NE(test, 0, preh_val);
+	KUNIT_EXPECT_NE(test, 0, posth_val);
+
+	/* 4. Unregistering must successfully disarm without -ENOENT */
+	unregister_kprobe(&kp_post);
+	unregister_kprobe(&kp_entry);
+}
+#endif
+
+#if defined(CONFIG_OPTPROBES)
+/* Test for: kprobes: Do not overwrite jump instruction when re-arming unoptimizing probe */
+static void test_optprobe_rearm_unoptimizing(struct kunit *test)
+{
+	struct kprobe opt_kp = {
+		.symbol_name = "kprobe_target",
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
+	KUNIT_ASSERT_EQ(test, 0, disable_kprobe(&opt_kp));
+
+	/* Immediately re-enable (re-arm) before optimizer thread unoptimizes */
+	KUNIT_ASSERT_EQ(test, 0, enable_kprobe(&opt_kp));
+
+	/* Verify jump opcode was not corrupted by an unaligned INT3 overwrite */
+	preh_val = 0;
+	target(rand1);
+	KUNIT_EXPECT_NE(test, 0, preh_val);
+
+	unregister_kprobe(&opt_kp);
+}
+#endif
+
 static int kprobes_test_init(struct kunit *test)
 {
 	KP_CLEAR(kp);
@@ -391,10 +506,18 @@ static struct kunit_case kprobes_testcases[] = {
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
+#if defined(CONFIG_OPTPROBES)
+	KUNIT_CASE(test_optprobe_rearm_unoptimizing),
 #endif
 	{}
 };

