Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273607;
	b=3x+E7MIbbjRVo48/7wTVpKXNGw8CR/YeeAKHKpKpo7XhqdBNDrgSFWokcC510q0+rAOQ
	 hv8DFCHy4SiwERcsxYeqaU8Js3AS243bk/CaOPZejwrbNfZ+K38wN8D044fFfq/R0j71I
	 4fIeaiHtKwvvKs0vS7J+u627mEYbnO5Wl0vpBbpkeksq7zJ996KRskpAVNQvKLNFJCtOp
	 kNzPtEvkoeKgcpwBnqAEiEJ8So/c4aIfbEHkN7rOJ7uir3bWgYwPiDqkULf9NAHkecpF3
	 u4ub3qC1C0qir9SYwc6u05p8zJdo0KewFAGa5wcxCq+nO9R2HQqtVf6ItcjLmrinF5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=u2+5FPEipUNpLwTEmCbVo+EBM+txYxYryhyGKU/mDgw=;
	b=evqVy9/3NM2VYV1B7uJGvBspWNTVFBg9R9EvQWFLDdOS+BQDmC0qns5CTGzVtAxz/cjr
	 hUYTzlOCAKo9mRva1yuOf2NsIJvBlB/AeRPv+dZIb1hPmLYAlUvum9jws/H1uoQytMoRf
	 w3jJM+x6DxEfab/8yapILXwwfVOsMgKoxkxuaA9TMRYs5ybfytgT3PZfI9Tp+PtkqAjbi
	 2+xE0MtxCXfZebI2SOvJpa7MX/XQgJDKwl2z18/CHxGOHz3QboRzPnO+9VkWdzlMuFlyp
	 eTb5XvljPRRrqhh8BLkiCi2I4/IrgtukkQTuxe/Nu/8ijRXcYgQNXv7y4r0OAIifgfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zevv+W4w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F7606A33E;
	Tue, 10 Nov 2026 01:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zevv+W4w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC02F1F0089F;
	Tue, 10 Nov 2026 01:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273607;
	bh=u2+5FPEipUNpLwTEmCbVo+EBM+txYxYryhyGKU/mDgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zevv+W4w+IvZbKjWO4WePtxIIRVtJ8eajaRD20hyhW76XKmFqtmbq2AAOOVCmUabi
	 RwjB5d7UB/utjBWPmtfDuF0s3wSQBc4YnhG/ang6WZsP5OtTiKz9X88+RC++/kJC3R
	 A4bmos3K8YMzzfACDdGy1zSjTlw84NPXr1xfYWeb0sRyPnbFBfXGdOhMdayMnqR2m7
	 EHCZyzYnhuC5hZpRD20j88YsKIeXjlpV1RYWIVlCwc8zKtSt6fiwgaq1Xr/G9+9twW
	 SVgAKJXGgQkxvBZGeD1HS6p/x17eYs34RUsGjGcmuPcHPiCT0rhrTxW26VL6kGJhcd
	 OzuHmJoWRVfOw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: [PATCH v2 2/4] kprobes: Fix UAF and queue cooling probes on forced unoptimization
Date: Tue, 10 Nov 2026 10:20:04 +0900
Message-ID: <179427360419.291326.11129449813483716145.stgit@devnote2>
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

