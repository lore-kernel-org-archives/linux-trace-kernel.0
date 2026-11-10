Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273599;
	b=h186smiU9mrq1gZppHXmEAGExp/z4NoRYANXSRHxh6UZnkfFsofqmqO0ywk/w7YlA8d1
	 qVNpATVyGGKmiR4hazRNfoWQvd9JE61xt2wBeILcKBx/bnMnAbk/QbA491w+YPPbIYXwI
	 rEN4ew1mjAcOuoJwo1LQG5NeWaWo4STegyfPOeYdhyUesE4V9VgzxkVgkEv2CFhoTVylI
	 i82rGaVRZkthnbH37fLYSbKlnefnAY5tGOCS3KelZKzXhbMXGpPUSQv6zG+n2098LqEHV
	 4sNEB7JUcqsp0sThCvfwmZM7JwYmXb87Mbu1Ge6pOwwS1l4I7mo68foeOS9Dzhq3Myg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7B57yFhhoC7EhQeanlpezdJDPtjATDROjKxXttsKNQY=;
	b=l7I50Kloh6HQP8ggNVAtASTUKujkvDL0SHJ9cA5xBEHI3lNxNH0x06b8MoD5+rJjdDKJ
	 GgRughXDH+a1w8k/9RKBhDBAGjTfDKqONKGvT74TYyb9wcq5s09GhIbg47sTrpvH2p/JS
	 dUYpD9aT68odHgClvac3mzHhIrdGQEyJwAx/fIe+0tYj9pyNDKr3loYgHULIk/ohTIJni
	 368y/IhAY/Dhh9f3kX/nz8/RdlCEe/rM8THHbn2+5ksGu1brgP7wxmVsB6jjuiETfjy2Z
	 NRQ5Exy8h0R95uiZtWsskPJ9pyRjkjgOOJSMt87z1DCVVHLXZ3kymPlS70AKHubK/ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OH9LwNge;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994E606A33C;
	Tue, 10 Nov 2026 01:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OH9LwNge
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDD91F008A4;
	Tue, 10 Nov 2026 01:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273598;
	bh=7B57yFhhoC7EhQeanlpezdJDPtjATDROjKxXttsKNQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OH9LwNge3xc/nNGY54nhm6TFLxj3fuo45JfTAhot/qihd/pbvSXKjqXhO3DwLwCXG
	 6tqRZPRMovw1FKwvgda0WX2AUn4Q6UvXhudTE7EU2OkFwSlB5Y+Y1NeddZt1Tv4eID
	 5VlNCIqY+Sdg+OdhlyWhdsqFJQCjneX72hQzW2/xHR2ae/0hRTyxOt7PWJKsY0iAnL
	 juZrozBibudvDi04DQaFGNyRC4XHTgKZFOwkeJqqC8u8bmaqm+Ff9bhOl1KR1MInOc
	 pwIN1sKIKZt5svK33RHfQqzXi4mf/Qm3c0Ixy3tTRT4u1irKB1eh4kCqL0VbwJZXRr
	 0eD70wtajijJw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: [PATCH v2 1/4] kprobes: Switch ftrace ops when adding probe with post_handler
Date: Tue, 10 Nov 2026 10:19:56 +0900
Message-ID: <179427359597.291326.2717264793607044000.stgit@devnote2>
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
lockdep and deadlock issues when modifying ftrace code. Defer adding the
new probe onto ap->list until the ftrace ops switch completes so that the
new probe's handlers are not published prematurely while ap is still on
kprobe_ftrace_ops, and mark ap disabled if rollback re-arming fails.
Also restore ftrace ops registration and counter if ftrace_set_filter_ip()
fails in __disarm_kprobe_ftrace().

Fixes: 5dd7caf0bdc5 ("kprobes: Skip clearing aggrprobe's post_handler in kprobe-on-ftrace case")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Defer add_new_kprobe() until after ftrace_switch_ops completes so
   that p is not visible on ap->list if switching ftrace ops fails.
 - Set KPROBE_FLAG_DISABLED on ap if rollback arm_kprobe_ftrace() fails.
---
 kernel/kprobes.c |   55 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dddad1e01866..b6ff971df451 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1444,9 +1444,14 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
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
@@ -1575,17 +1580,13 @@ void kprobe_busy_end(void)
 }
 
 /* Add the new probe to 'ap->list'. */
-static int add_new_kprobe(struct kprobe *ap, struct kprobe *p)
+static void add_new_kprobe(struct kprobe *ap, struct kprobe *p)
 {
 	/* A reused cooling probe is already unoptimized */
 	if (p->post_handler && !kprobe_unused(ap))
 		unoptimize_kprobe(ap, true);	/* Fall back to normal kprobe */
 
 	list_add_rcu(&p->list, &ap->list);
-	if (p->post_handler && !ap->post_handler)
-		ap->post_handler = aggr_post_handler;
-
-	return 0;
 }
 
 /*
@@ -1618,6 +1619,8 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
 {
 	int ret = 0;
 	struct kprobe *ap = orig_p;
+	bool reset_post_handler = false;
+	bool ftrace_switch_ops = false;
 
 	scoped_guard(cpus_read_lock) {
 		/* For preparing optimization, jump_label_text_reserved() is called */
@@ -1664,18 +1667,50 @@ static int register_aggr_kprobe(struct kprobe *orig_p, struct kprobe *p)
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
+		if (!ftrace_switch_ops)
+			add_new_kprobe(ap, p);
+	}
+
+	if (ftrace_switch_ops) {
+		/*
+		 * Must switch ftrace ops outside of text_mutex and cpus_read_lock
+		 * to prevent deadlocks when ftrace code modification acquires text_mutex.
+		 */
+		ret = disarm_kprobe_ftrace(ap);
+		if (ret)
+			return ret;
+
+		ap->post_handler = aggr_post_handler;
+		ret = arm_kprobe_ftrace(ap);
+		if (ret) {
+			ap->post_handler = NULL;
+			if (arm_kprobe_ftrace(ap))
+				ap->flags |= KPROBE_FLAG_DISABLED;
+			return ret;
+		}
+		add_new_kprobe(ap, p);
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

