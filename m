Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750302;
	b=b5cdpU9iyaXAPIzGuRgrwaB2yYeXWLyFMQ1ooHWgHO9zv+OKYsXHDnIzWIVuOnOLiM2i
	 ZSCZp1wUtI5vzKJ2ItysuqrP6+zIRn6NILceFRLMwQmIrunoOtAIfmE63gCbHeFjVPpqo
	 tobW7vFHD/z3itvpsU/NKC2RnLeZTWI2uzTrk5bNciGqtCAKETTXDVzyEV47vTJS0xR5t
	 rskDJs+8AiBLBU3/P3c3ks8wYgHlJYjJms1siMPAyro/f1tqNyks5JXP3J5j9YXnn+CPv
	 PMzb934C7dB72VXkgpEQVuTSube6VHxD1gq3FC7S5A1HX51vuB0SW7yGaZ7uvWJfo9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750302;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nkhF+W6nwZ+ldcyedH8K9zkiSkiRmrNmGBdDDS85EOo=;
	b=YSrd4CF/2iFsSxC9vj+KfqD4jxPZb7DYNU0LI8IBORQ5/uufWXJ7xksmTqLIBuCj1/AM
	 Y0d4Bx5wA3lnJ++fEdd6ywo+GUr18VMYIuCcLL3O+fgeRzmF48bmpDA3a1sjrGeMhWMKk
	 dXJiUxqmyikSpCSb5SjKY1F4yH4Vfv6o9xi5m2u2oSg+jCkonsB/lOdriYIZoySkXURSd
	 Xd4TDUHh8R4ZesbI2BObMFpb01jQny8pJLs6S+3zYxOUrPRfkLB6vL3PuFOJjdMr1KxFj
	 Mz7139fJlyKvDh9VUtoKBuq2TzIDCv3KGoUv08QSUuz/KUXx/yXY1UeoXXZQ/rvFSiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Oe/kdl7a";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A5B606A31B;
	Tue,  3 Nov 2026 23:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Oe/kdl7a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B791F000C1;
	Tue,  3 Nov 2026 23:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750302;
	bh=nkhF+W6nwZ+ldcyedH8K9zkiSkiRmrNmGBdDDS85EOo=;
	h=From:To:Cc:Subject:Date;
	b=Oe/kdl7aQbF444x0sDYuHuf/UqvwxYUlr/Rr7DgSTUdAg6rK5F5IsVIrDiEevwf9B
	 R4mdr2ubucHecK8ExWf3TJBnWBxpevSmE6/lDZWQUR6JYR4k50kpvfGXLPqig9B+qj
	 R6B7vmCXPx33x69tEpVuR/yDByLJCzmRbVaMeiUIF5vbB/WyYYUxBSiNeJ38dG2X0r
	 KdcfBc5HkTdRlhBSR+ArYzm0SIH0CTJUF1scSxV8ilKVh4tBsrhh8OXHQ63WAEUvL7
	 l9tS/Gi3TXhgk0jR0945z/+ljwQQAHkSMS0uqfT8KCxHAN7ZdDKfIuBDJzo8Z1ozmo
	 plGdAffJbSptg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/8] kprobes: Fixes for registration errors, ftrace ops and optprobe state machine
Date: Wed,  4 Nov 2026 08:58:18 +0900
Message-ID: <179375029807.247640.13024754173032838618.stgit@devnote2>
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

Here is a series of bug fixes for kprobes and optprobes, addressing error
recovery, ftrace ops management, and optprobe asynchronous state machine
edge cases:

1. Registration & Unregistration Error Handling (Patches 1-3):
   - In __register_kprobe(), when arm_kprobe() fails, the error code was
     ignored and the instruction slot was leaked.
   - In unregister_kretprobes(), failing __unregister_kprobe_top() still
     invoked rethook/rph freeing, causing a double free or NULL deref.
     Clearing rp->rh is also deferred until after synchronize_rcu() to
     prevent racing with in-flight pre_handler_kretprobe() invocations.
   - In register_kretprobe(), re-registration validation was skipped when
     registered by symbol_name without an explicit addr, leading to
     destruction of the live probe's rethook instance on failure.

2. Ftrace Ops Switching for Post-Handlers (Patch 4):
   - When adding a second probe with a post_handler to an existing ftrace
     kprobe, the aggregate probe's post_handler was set but remained armed
     on kprobe_ftrace_ops. Subsequent disarming attempted to disarm from
     kprobe_ipmodify_ops, failing with -ENOENT and leaking the armed probe.
     Switch ftrace ops safely in register_aggr_kprobe() outside of
     text_mutex and cpus_read_lock.

3. Optprobe State Machine & Tasks RCU Quiescence (Patches 5-7):
   - Forcibly unoptimized probes (unoptimize_kprobe(force = true)) were
     not queued to cooling_list, causing kprobe_disarmed() to return true
     prematurely and risking use-after-free in the optinsn detour buffer
     before Tasks RCU completed.
   - Re-arming an unoptimizing probe before the unoptimization pass ran
     overwrote the first byte of the relative jump with a breakpoint,
     corrupting the jump opcode in text.
   - Probes killed at module unload while child probes were still active
     were prematurely freed or improperly unhashed before Tasks RCU
     quiescence elapsed.

In addition to the bugfixes, the last patch adds KUnit test cases for
these bugs. (Patch 8)

Summary of patches in this series:

[01/08] kprobes: Fix error return and slot leak in __register_kprobe()
 - Release allocated instruction slot via arch_remove_kprobe(p) and
   return the arm_kprobe() error code upon failure.

[02/08] kprobes: Fix double free and NULL deref in unregister_kretprobes()
 - Skip rethook_free() and rph cleanup if __unregister_kprobe_top()
   fails, and clear rp->rh after synchronize_rcu().

[03/08] kprobes: Validate re-registration earlier in register_kretprobe()
 - Resolve target address via _kprobe_addr() up-front and check whether
   the probe is already registered via check_kprobe_rereg_at() before
   allocating rethook resources, dropping the WARN_ON_ONCE().

[04/08] kprobes: Switch ftrace ops when adding probe with post_handler
 - Switch from kprobe_ftrace_ops to kprobe_ipmodify_ops in
   register_aggr_kprobe() outside of text_mutex and cpus_read_lock.
 - Restore ftrace ops counter and registration if ftrace_set_filter_ip()
   fails during disarm.

[05/08] kprobes: Fix UAF and queue cooling probes on forced unoptimization
 - Queue forcibly unoptimized probes onto cur->cooling_list (or
   cur->freeing_list if unused), include cooling_list in
   optprobe_has_queued_probes(), and isolate newly unoptimized probes
   into a local list in do_unoptimize_kprobes() to prevent double disarm.

[06/08] kprobes: Do not overwrite jump instruction when re-arming
        unoptimizing probe
 - Skip arch_arm_kprobe() in __arm_kprobe() when kprobe_queued_unopt()
   is true, keeping the relative jump intact while unoptimization is
   cancelled.
 - Force unoptimization immediately if optimize_kprobe() cannot optimize
   the re-armed probe.
 - Avoid premature flag clearing or dequeuing in reuse_unused_kprobe().

[07/08] kprobes: Fix slot reclaim and sibling re-opt in optprobe state machine
 - In kill_optimized_kprobe(), queue in-use probes on unoptimizing_list
   to cooling_list rather than freeing_list to preserve kprobe_table
   lookup and ensure Tasks RCU elapses before slot reclamation.
 - Reclaim optinsn slots for kprobe_gone() probes upon cooling completion
   in optprobe_finalize_generation().
 - Re-optimize blocked sibling probes when a cooling probe finishes
   cooling to safely disarmed.

[08/08] kprobes: Add KUnit test cases for kprobes regressions
 - Add test cases to lib/tests/test_kprobes.c covering unregistered
   kretprobe cleanup, kretprobe re-registration validation by symbol,
   ftrace ops dynamic switching on post_handler addition, and optprobe
   re-arming while unoptimizing.

Thank you,

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4

Masami Hiramatsu (Google) (8):
      kprobes: Fix error return and slot leak in __register_kprobe()
      kprobes: Fix double free and NULL deref in unregister_kretprobes()
      kprobes: Validate re-registration earlier in register_kretprobe()
      kprobes: Switch ftrace ops when adding probe with post_handler
      kprobes: Fix UAF and queue cooling probes on forced unoptimization
      kprobes: Do not overwrite jump instruction when re-arming unoptimizing probe
      kprobes: Fix slot reclaim and sibling re-opt in optprobe state machine
      kprobes: Add KUnit test cases for kprobes regressions


 kernel/kprobes.c         |  226 ++++++++++++++++++++++++++++++----------------
 lib/tests/test_kprobes.c |  123 +++++++++++++++++++++++++
 2 files changed, 271 insertions(+), 78 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
