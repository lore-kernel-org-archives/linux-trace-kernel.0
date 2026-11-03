Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750348;
	b=ffPxqoCP1V3SBqing8I8/+Q5wvztBf6ZVNiJTQaFL1X1JwV2E/HJALRnkNXI9uag5ZO8
	 U6yVc1PDSOrhMz1kcOAnirksrqnQNIitucbdg1hqMEMD+gyno2VFqeecDwmG+STx0G3gr
	 bFpYKYaoNzYuCJTMqXfJbhHmxgGsRnW/QBTTg+Ryl80wnOJRmumhQ9j6wS/y734oGmEle
	 c2RY/pUW05FCjPXlRmKjgZk7mGDdOJO1mahFyBK0pZPUFkui012UYqekUfejeIQ6Z6gH7
	 ovkYBJE4/VictznFIUE2wPOHLBWoBTgZPGqPGl9mqXQQjLrelzxrwHAyq4c6g0nm7Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750348;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TKSuzsNmcd1nHP7SpVkLAFC1qAsq++7i3oM7rAo53Uk=;
	b=jsMyu+YgUG7qaEAOdSo8RF2Mj270uXnVHBemYg/Xq/fKxTp0vzdgYlHsxb8IPOCoO+y4
	 BbEBs6TD4kh9bS2Ccu6cDYQTXzjlfOUtgie70SMuIcIh1M8tNLoPhQHlsnwGx/w+4zjjg
	 dMg/qI4k+8Hbd7Quq9T5jWeTwbO41yuncKsza2ylrygRuM2R5HaPeNkn49QoMk+AvHf3W
	 I09y8g7jmblViKKjdHdWoZ7esYDhrrysUkztmTCcI4czaG5IuxGXDLqX5j0zz769jdynE
	 IJY7SClCN90DkkW4CkIcWuU6tUfy0VpoJ2R9IV45wCl/XavRuNG9+SIPzsMxzmbZFAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLMgqPsV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E0606A31B;
	Tue,  3 Nov 2026 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GLMgqPsV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264D71F0093A;
	Tue,  3 Nov 2026 23:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750347;
	bh=TKSuzsNmcd1nHP7SpVkLAFC1qAsq++7i3oM7rAo53Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GLMgqPsVw3EfOM2dMSmAYRWGfvco649zC+7E099A+DqtrCoPbWZys3cYUsq+dcE7R
	 XE4Bf48+M0+yfp9hqLSXHxhQNU5d2pkFoT/hfOgpEW/JiY4qg6bdMAUT5Hin4glPaF
	 2knGKDCqoVedJbX6pkqUoI314jc7u3oaZ14/2wmpP/XlOaeie/X05ySb6MPSLTmqkk
	 L0sA6LyrdhBF/7JiRG79P45CKjolYEvPNCCQj0trJKgSKQ47Skgz3Tc+ATR2VC+9T8
	 m9pNmlQ4t8ExFSb/y17rIPQQMNcAuNwFdCdspkUrrbxdd7co6ARb+pYG4AqE1PL+M4
	 pDMlrIHVQYRiQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 5/8] kprobes: Fix UAF and queue cooling probes on forced unoptimization
Date: Wed,  4 Nov 2026 08:59:04 +0900
Message-ID: <179375034391.247640.7677208599009420639.stgit@devnote2>
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

When unoptimize_kprobe() is called with force = true on an actively
optimized probe (whose op->list is empty), force_unoptimize_kprobe()
replaces the relative jump with a breakpoint, but leaves op->list empty
without queueing op to cur->cooling_list or cur->freeing_list.

Because op->list remains empty, kprobe_disarmed() returns true
prematurely as soon as the probe is disabled. When unregister_kprobes()
runs, __unregister_kprobe_top() unhashes the probe immediately, and
unregister_kprobes() frees op and the optinsn slot after synchronize_rcu()
without waiting for Tasks RCU. Any task preempted inside the optinsn slot
then encounters a use-after-free when resuming execution.

Queue forcibly unoptimized probes onto cur->freeing_list (if unused) or
cur->cooling_list (if still in use), and include gen->cooling_list in
optprobe_has_queued_probes() so that the generation is dispatched and
flushed properly. In do_unoptimize_kprobes(), collect newly unoptimized
probes into a separate local list so that probes already placed on
freeing_list are not disarmed a second time.

Fixes: 06e0d3b89da1 ("kprobes: Make optprobe optimizer multi-generational and asynchronous")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 135fec5d49cf..ceacd56245c2 100644
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
 		/* Disarm probes if marked disabled and not gone */
@@ -643,6 +642,7 @@ static void do_unoptimize_kprobes(struct list_head *unopt_list,
 			 * (reclaiming is done by do_free_cleaned_kprobes().)
 			 */
 			hlist_del_init_rcu(&op->kp.hlist);
+			list_move(&op->list, free_list);
 		} else {
 			/*
 			 * Keep on cooling_list until the quiescence period
@@ -1039,6 +1039,15 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 	if (force) {
 		/* Forcibly update the code: this is a special case */
 		force_unoptimize_kprobe(op);
+		if (kprobe_unused(&op->kp)) {
+			if (!kprobe_gone(&op->kp))
+				arch_disarm_kprobe(&op->kp);
+			hlist_del_init_rcu(&op->kp.hlist);
+			list_add(&op->list, &cur->freeing_list);
+		} else {
+			list_add(&op->list, &cur->cooling_list);
+		}
+		kick_kprobe_optimizer();
 	} else {
 		list_add(&op->list, &cur->unoptimizing_list);
 		kick_kprobe_optimizer();

