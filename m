Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750339;
	b=dX6pJzHwX4bxhTJhNWjze7GQhNFxLZnndeE6kusiDhiK8rDHI0SM+7KhxW4xIdL0Isqi
	 K7XwdNCBht2JkZ4mvDz5KkTiwUgDwtPPQ2YIPWrI860VM2jsYhKpVgFm/fFIQ6SSzcCF9
	 0E3eQGPwdEwTAdoUEp3MtdXPeZHv1UcmVpZyiZGKSZLAq88AJyERvYDmteJsFBqykUcj1
	 0Q3eWThQupWTVnAYI1duYpy24GM7LGc0ctDKLGdcp76kNeA8GOVXpsIGAU75IWNwms/iP
	 4lvu3bCYzPrN1h7r5hBjDRewCep0xKhgE5G+zuYXs2ufQs/+Pj28EwMpEC2j4raHWmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750339;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=D9Lp8ejoSl0CbPgh+r4mawte3O11aZxdP5a4HLYSWxo=;
	b=HHg5qdjdpZ6vgce2logey27cNC1A6vSHTypq76r6moguH9qRlsfPTTYJbWcLQMSwpIUK
	 u/rLYT9Lf/bePoDSt8ZkHpTp0PEKiZTJazP19I0z+DzO5EXwxOCJCBoKt4GET24gUbJ0n
	 h5h8B579sGpNpCy3gJGbLmLm99UqSiOI/1edHCXkkOOQS6bCha0nuBspCzoN0noztJ+FB
	 ZsqaIppnSpTZYFAGR2hoVE7VYkB4mclNiGEM1OnEYjAuUYYhCb3Z8MdFMdMgfdVewx+y2
	 XXzX/2yeVj/wefuhsDzAfGyKa9Bb2ln7fUUwmObZZcNbpSynm2g/YAk3tCtj6v/Ob4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ncxTI/oI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB62606A328;
	Tue,  3 Nov 2026 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ncxTI/oI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A3C1F000C1;
	Tue,  3 Nov 2026 23:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750338;
	bh=D9Lp8ejoSl0CbPgh+r4mawte3O11aZxdP5a4HLYSWxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ncxTI/oIDnDibl2PF8t5qbGq46aqb0SZN5VFmPuyHsL8OFOs74ed2594REsRAfokk
	 +ydKHLpEGJD+GuZB+KMgWveHOv01DoBeDWdQ78TfC1/Z6h0k1kNPzcPlmE4rC6TewA
	 XQeweF/vIl6TOz78E4hniX75VirxgrqPiUgAwfr4/KGtIAVAyWsqRUF8Hxm70kphL0
	 OW+ECabXCAGAv9KjonDe3JntWW1YldNmJiYfwmHABtHtHi9Y6elgq+umvQeh00drk0
	 sIsYP5YI110E9AxOXlqmR6u3+D5oXl1mLWJeWRL+C18M3Bqx3kr/NK9sbchxkG1zrr
	 TVSpuKgLMl3ew==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/8] kprobes: Switch ftrace ops when adding probe with post_handler
Date: Wed,  4 Nov 2026 08:58:54 +0900
Message-ID: <179375033462.247640.15676311043239442590.stgit@devnote2>
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

When an ftrace-based kprobe is registered without a post_handler, it is
armed using kprobe_ftrace_ops. If a second probe with a post_handler is
subsequently registered at the same address, register_aggr_kprobe() sets
ap->post_handler to aggr_post_handler, but leaves the probe armed using
kprobe_ftrace_ops.

When the probe is later disarmed or disabled, disarm_kprobe_ftrace()
checks whether p->post_handler is non-NULL and attempts to disarm from
kprobe_ipmodify_ops. This fails with -ENOENT, decrements
kprobe_ipmodify_enabled below zero, leaves the probe armed on
kprobe_ftrace_ops, and aborts unregistration, leading to a use-after-free
if the probe module is unloaded.

Switch the armed probe from kprobe_ftrace_ops to kprobe_ipmodify_ops in
register_aggr_kprobe() outside of text_mutex and cpus_read_lock to avoid
lockdep and deadlock issues when modifying ftrace code. Also restore
ftrace ops registration and counter if ftrace_set_filter_ip() fails in
__disarm_kprobe_ftrace().

Fixes: 5dd7caf0bdc5 ("kprobes: Skip clearing aggrprobe's post_handler in kprobe-on-ftrace case")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |   56 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0b41d69540ae..135fec5d49cf 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1435,9 +1435,14 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 	(*cnt)--;
 
 	ret = ftrace_set_filter_ip(ops, (unsigned long)p->addr, 1, 0);
-	WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (error %d)\n",
-		  p->addr, ret);
-	return ret;
+	if (WARN_ONCE(ret < 0, "Failed to disarm kprobe-ftrace at %pS (error %d)\n",
+		      p->addr, ret)) {
+		if (*cnt == 0)
+			register_ftrace_function(ops);
+		(*cnt)++;
+		return ret;
+	}
+	return 0;
 }
 
 static int disarm_kprobe_ftrace(struct kprobe *p)
@@ -1566,16 +1571,12 @@ void kprobe_busy_end(void)
 }
 
 /* Add the new probe to 'ap->list'. */
-static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
+static void add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
 	if (p->post_handler)
 		unoptimize_kprobe(ap, true);	/* Fall back to normal kprobe */
 
 	list_add_rcu(&p->list, &ap->list);
-	if (p->post_handler && !ap->post_handler)
-		ap->post_handler = aggr_post_handler;
-
-	return 0;
 }
 
 /*
@@ -1608,6 +1609,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 {
 	int ret = 0;
 	struct kprobe *ap = orig_p;
+	bool reset_post_handler = false;
+	bool ftrace_switch_ops = false;
 
 	scoped_guard(cpus_read_lock) {
 		/* For preparing optimization, jump_label_text_reserved() is called */
@@ -1654,18 +1657,51 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 					| KPROBE_FLAG_DISABLED;
 		}
 
+		if (p->post_handler && !ap->post_handler) {
+			reset_post_handler = true;
+			if (kprobe_ftrace(ap) && !kprobes_all_disarmed &&
+			    !kprobe_disabled(ap))
+				ftrace_switch_ops = true;
+			else
+				ap->post_handler = aggr_post_handler;
+		}
+
 		/* Copy the insn slot of 'p' to 'ap'. */
 		copy_kprobe(ap, p);
-		ret = add_new_kprobe(ap, p);
+		add_new_kprobe(ap, p);
+	}
+
+	if (ftrace_switch_ops) {
+		/*
+		 * Must switch ftrace ops outside of text_mutex and cpus_read_lock
+		 * to prevent deadlocks when ftrace code modification acquires text_mutex.
+		 */
+		ret = disarm_kprobe_ftrace(ap);
+		if (ret) {
+			list_del_rcu(&p->list);
+			synchronize_rcu();
+			return ret;
+		}
+		ap->post_handler = aggr_post_handler;
+		ret = arm_kprobe_ftrace(ap);
+		if (ret) {
+			ap->post_handler = NULL;
+			arm_kprobe_ftrace(ap);
+			list_del_rcu(&p->list);
+			synchronize_rcu();
+			return ret;
+		}
 	}
 
-	if (ret == 0 && kprobe_disabled(ap) && !kprobe_disabled(p)) {
+	if (kprobe_disabled(ap) && !kprobe_disabled(p)) {
 		ap->flags &= ~KPROBE_FLAG_DISABLED;
 		if (!kprobes_all_disarmed) {
 			/* Arm the breakpoint again. */
 			ret = arm_kprobe(ap);
 			if (ret) {
 				ap->flags |= KPROBE_FLAG_DISABLED;
+				if (reset_post_handler)
+					ap->post_handler = NULL;
 				list_del_rcu(&p->list);
 				synchronize_rcu();
 			}

