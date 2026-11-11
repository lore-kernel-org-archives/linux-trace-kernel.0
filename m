Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406424;
	b=xIuGCAWGgkIi06KMwmiaXwFuR8ATtofisH2EW+7UQnC10lsii87jQjc4YKF1I7YzqFX9
	 4jfMh61iso9rkOmk5g/yWqW4sul/+30U1gO7/xw+5rbk8Yv7QvkgQbJV42Y28D9GDsRXS
	 S9Y7AexnPZCLopOjlirj+dVlxhfO6nvx5tTJqoqay6NqeEXueJfAuwdzNPJf5u0pqxemB
	 RQ6hdJxkzuSyM3ACt9DqwYMmuyZ6EwCdv55URe9SVUhIPcDvscclEZfrp6a49c+tEkywQ
	 251FP7E1XagH012fBpagvGPmsXC/t4pbjvyuvjG1BmozHgNjByfHqm/w9tpgD8GDdXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406424;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=u2+5FPEipUNpLwTEmCbVo+EBM+txYxYryhyGKU/mDgw=;
	b=biM3Uz/oqudCjQkd62UGpCEQYWEGEaEKdegEx4xgL+QX+GVKVJ8cVVFVdTcgmxp2/eI6
	 Tb3wwnw40wqfTqMAH29YYqQ13Yl6vR9wKpMp8fAhM2zr2h4KAjMVa3jBNpaEi0n9dUTOJ
	 AEAruQnPsHpAd8E2ZJ+9jNK3xaNUgocC8KAUugCcMNfrC66zT5muKK9cRl9KP0vnCKzAt
	 CiZ/Nfrh1TR1xrizGy7ZTJqL1nT2QXkIeVY2EhH3wjwYzIKyBrwGW+w/DAvEpzOVZwrKe
	 q8xdrmsjc2BYUcqtyQo3jqIGW6cUmmJWScLJnyajYJyrtu04kGPDxlYjbRjgjCvLQrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwKnKNiu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F99606A327;
	Wed, 11 Nov 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwKnKNiu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42DE1F00A06;
	Wed, 11 Nov 2026 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406424;
	bh=u2+5FPEipUNpLwTEmCbVo+EBM+txYxYryhyGKU/mDgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XwKnKNiuUn69sE7r7qQkMdxxMO5LujNVK9HtA0bqM12TQHw53v4zXv/VRCGY5LHb+
	 JNgEey44LHJApB69N6K2g5wYXuo5Mjtyg7KcOMwruz87ByGY+HrKlBgETSAmY7IBK+
	 1lfH8lAHfDaRcWw0FrtEP+WdfbTh+/min8vMddYfw6jF6UHm3mmgOmMBN4Uui1VwRL
	 kPW5WqApPv2oORaIzFMYDeuQbVdaYbUTGgHYNzm6mK0k3ePZQWes6bfEMUeSa4xYnz
	 7WdDA4ypZKff7oopDsNQMfVMKVS55zOdMdwNtUoRxPdtgaI8Q9s62k/4CEOUrNi4yK
	 WOf7pfMmPQAhA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: [PATCH v3 2/5] kprobes: Fix UAF and queue cooling probes on forced unoptimization
Date: Wed, 11 Nov 2026 23:13:40 +0900
Message-ID: <179440642050.328088.13914468408589377897.stgit@devnote2>
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

When unoptimize_kprobe() is called with force = true on an actively
optimized probe (whose op->list is empty), force_unoptimize_kprobe()
replaces the relative jump with a breakpoint, but leaves op->list empty
without queueing op to cur->cooling_list.

Because op->list remains empty, kprobe_disarmed() returns true
prematurely as soon as the probe is disabled. When unregister_kprobes()
runs, __unregister_kprobe_top() unhashes the probe immediately, and
unregister_kprobes() frees op and the optinsn slot after synchronize_rcu()
without waiting for Tasks RCU. Any task preempted inside the optinsn slot
then encounters a use-after-free when resuming execution.

Queue forcibly unoptimized probes onto cur->cooling_list and include
gen->cooling_list in optprobe_has_queued_probes() so that the generation
is dispatched and flushed properly. In do_unoptimize_kprobes(), collect
newly unoptimized probes into a separate local list so that probes
already placed on freeing_list are not processed a second time.

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Drop the unreachable kprobe_unused(&op->kp) branch when force is true
   and list_empty(&op->list), since kprobe_disarmed() already checked for
   disabled probes with an empty op->list at the start of
   unoptimize_kprobe().
---
 kernel/kprobes.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b6ff971df451..c0637302eeae 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -552,17 +552,13 @@ static unsigned long optimizer_passes;
 
 #define OPTIMIZE_DELAY 5
 
-/*
- * Note: gen->cooling_list is not checked here because it is strictly
- * an in-flight holding list for dispatched generations, so it is always
- * empty in optprobe_cur_gen.
- */
 static bool optprobe_has_queued_probes(void)
 {
 	struct optprobe_generation *gen = &optprobe_gens[optprobe_cur_gen];
 
 	return !list_empty(&gen->optimizing_list) ||
 	       !list_empty(&gen->unoptimizing_list) ||
+	       !list_empty(&gen->cooling_list) ||
 	       !list_empty(&gen->freeing_list);
 }
 
@@ -612,6 +608,7 @@ static void do_unoptimize_kprobes(struct list_head *unopt_list,
 				  struct list_head *cooling_list)
 {
 	struct optimized_kprobe *op, *tmp;
+	LIST_HEAD(unoptimized);
 
 	lockdep_assert_held(&text_mutex);
 	/*
@@ -626,11 +623,13 @@ static void do_unoptimize_kprobes(struct list_head *unopt_list,
 	 */
 	lockdep_assert_cpus_held();
 
-	if (!list_empty(unopt_list))
-		arch_unoptimize_kprobes(unopt_list, free_list);
+	if (list_empty(unopt_list))
+		return;
 
-	/* Loop on 'free_list' for disarming and removing from kprobe hash list */
-	list_for_each_entry_safe(op, tmp, free_list, list) {
+	arch_unoptimize_kprobes(unopt_list, &unoptimized);
+
+	/* Loop on newly unoptimized probes for disarming and hash list removal */
+	list_for_each_entry_safe(op, tmp, &unoptimized, list) {
 		/* Switching from detour code to origin */
 		op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 		/*
@@ -647,6 +646,7 @@ static void do_unoptimize_kprobes(struct list_head *unopt_list,
 			 * (reclaiming is done by do_free_cleaned_kprobes().)
 			 */
 			hlist_del_init_rcu(&op->kp.hlist);
+			list_move(&op->list, free_list);
 		} else {
 			/*
 			 * Keep on cooling_list until the quiescence period
@@ -1044,10 +1044,11 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 	if (force) {
 		/* Forcibly update the code: this is a special case */
 		force_unoptimize_kprobe(op);
+		list_add(&op->list, &cur->cooling_list);
 	} else {
 		list_add(&op->list, &cur->unoptimizing_list);
-		kick_kprobe_optimizer();
 	}
+	kick_kprobe_optimizer();
 }
 
 /* Cancel unoptimizing for reusing */

