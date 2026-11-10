Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273590;
	b=WR2NecbQc0FgQIPhB8hhDozg5RA3YtBuXBY+g20aSCDHKkphqB6WFbWJ9Owy19nf4Aut
	 3U2T+/ZTksVlZVEbF6wTcK5/G8fpNiNz2rQezYr973FPgjaoHro5xkpaFjaoqD48ZIlFS
	 Ur4WsERCQuCFPMy3HGo1X2Llw+ucOJGpXWZrZQJ+l2Wjakzt+KtIvYfdZDuiX7MvVD/jc
	 oSK7mx3b/A+TU4VLLSwy87s7bfPUGDaCZmPq/HnuQHCoZDPEEXkKh8TaMaLOIoLacdn7d
	 JQnLjsVDK8Ctoqq0WnB2MTIlIFAJ4AvqmILC+pZaQ/E8n+8KwzaULpJUuQFt+quud1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273590;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=U05+Mie79PyeWtUEBw0kGiOkIb8tSC2Jl/FhrH9xV8w=;
	b=hmwdp7Tn1sM8NbHwxaosjaDEHW/6+Y2RJN1zVn/L9xf7YjOFUDWJPbA3xY3DzBuoxYMx
	 7taTOlGk7otLRGbmG6typfO1tU51rI5yHvVtMIoyBPTRXxU4Zn3QFkaIQTV0V6xEEhnoA
	 zh5Zj4U6+KVgSWY/mVecsThQ2cdF66avahegdKTBg53wJhRLreWczg8UiqEddKXAPK2RU
	 PoAuYhvwGH0/aM0iAMCTM+4CtAQCYKbxlAZODB7gWA36HAiIQhzCUUA/1+aRRNxsQfppp
	 5WGBrzbTAl5LdE7CKO70akEwuMJHyFpnZwI3BeoD2pVGT3ukJjym4fKRxEpulKJLpkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mQE/ilfw";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FEC606A31C;
	Tue, 10 Nov 2026 01:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQE/ilfw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF111F008A1;
	Tue, 10 Nov 2026 01:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273590;
	bh=U05+Mie79PyeWtUEBw0kGiOkIb8tSC2Jl/FhrH9xV8w=;
	h=From:To:Cc:Subject:Date;
	b=mQE/ilfwO3xKy/hq0LTNskUiGiU7//zIIPekBJGuoyasIlUW4SE1HbkgZO3nVvYWG
	 qYeEgxkgO57brh0Pl9ScfJUWDc1us+EQ6CShiZhtfcAW5UsyGC8g4rHyLcVpy96I8I
	 nNCxuoJCutEEeLuSboTVrLSrcPBAkWGWrp0exzvVlqfKfpCxvLNGPLxNFXxiW0jiVb
	 XFwnnGioZGsyZWP/mA7YNqhNeL3pu2XW7KEossCqTeXV4EeQovdDiTMryNXdq437SM
	 CAQz5DcVAyVO2w+2gGd7r9uJKNu0DUJuzDSdhY0PLt+gPfr5yXWEdo6QO8jEEGuGhi
	 H5WpefTi1RY2g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: [PATCH v2 0/4] kprobes: Fixes for ftrace ops and optprobe state machine
Date: Tue, 10 Nov 2026 10:19:47 +0900
Message-ID: <179427358690.291326.2078291446658598883.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

Hi,

Here is v2 of the remaining bug fixes for kprobes and optprobes, rebased
on the latest probes/fixes branch (which already includes patches 1-3 from
v1 and Mani Tofigh's optprobe state fixes that superseded patch 6 from v1).
The previous version is here:

  https://lore.kernel.org/all/179375029807.247640.13024754173032838618.stgit@devnote2/

This includes following fixes.

1. Ftrace Ops Switching for Post-Handlers (Patch 1):
   - When adding a second probe with a post_handler to an existing ftrace
     kprobe, the aggregate probe's post_handler was set but remained armed
     on kprobe_ftrace_ops. Subsequent disarming attempted to disarm from
     kprobe_ipmodify_ops, failing with -ENOENT and leaking the armed probe.
     Switch ftrace ops safely in register_aggr_kprobe() outside of
     text_mutex and cpus_read_lock.

2. Optprobe State Machine & Tasks RCU Quiescence (Patches 2-3):
   - Forcibly unoptimized probes (unoptimize_kprobe(force = true)) were
     not queued to cooling_list, causing kprobe_disarmed() to return true
     prematurely and risking use-after-free in the optinsn detour buffer
     before Tasks RCU completed.
   - When a disabled cooling probe finishes cooling and transitions to
     safely disarmed in optprobe_finalize_generation(), re-optimize any
     blocked sibling probe whose jump range covers its address.

3. KUnit Regression Tests (Patch 4):
   - Add KUnit test cases to lib/tests/test_kprobes.c covering the recent
     kprobes, kretprobes, ftrace ops, and optprobe fixes.

Changes in v2:
 - Rebased on the latest probes/fixes branch (v1 patches 1-3 merged;
   v1 patch 6 superseded by Mani Tofigh's optprobe fixes).
[01/04]
 - Defer add_new_kprobe() until after ftrace_switch_ops completes so
   that p is not visible on ap->list if switching ftrace ops fails.
 - Set KPROBE_FLAG_DISABLED on ap if rollback arm_kprobe_ftrace() fails.
[02/04]
 - Drop the unreachable kprobe_unused(&op->kp) branch when force is true
   and list_empty(&op->list) in unoptimize_kprobe().
[03/04]
 - Drop the unoptimize_kprobe() and reuse_unused_kprobe() hunks which
   were superseded by commits 0be7a931c5e4 and 1ffd6efb1b58 in
   probes/fixes.
 - Drop the kill_optimized_kprobe() cooling deferral since kill_kprobe()
   runs at MODULE_STATE_GOING when no tasks execute the module text.
[04/04]
 - Probe a notrace target function (kprobe_opt_target) in
   test_optprobe_rearm_unoptimizing() so that jump optimization is tested
   even when CONFIG_KPROBES_ON_FTRACE=y.
 - Guard test_optprobe_rearm_unoptimizing() with
   !IS_MODULE(CONFIG_KPROBES_SANITY_TEST) since
   wait_for_kprobe_optimizer() is not exported to modules.
 - Replace KUNIT_ASSERT_EQ() with KUNIT_EXPECT_EQ() while stack-allocated
   probes are registered to prevent stack use-after-free on test failure.

Thank you,

---
base-commit: 1ffd6efb1b58e596ed70f660182803264a4c84d9

Masami Hiramatsu (Google) (4):
      kprobes: Switch ftrace ops when adding probe with post_handler
      kprobes: Fix UAF and queue cooling probes on forced unoptimization
      kprobes: Re-optimize blocked sibling probe when cooling finishes
      kprobes: Add KUnit test cases for kprobes regressions


 kernel/kprobes.c         |   85 ++++++++++++++++++++++-------
 lib/tests/test_kprobes.c |  136 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 200 insertions(+), 21 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
