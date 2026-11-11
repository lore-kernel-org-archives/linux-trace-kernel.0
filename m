Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406415;
	b=hGpHATfsEyzCGwF0XRs5QYFWypRherqlbDWe8kKwXeYN4VQVpjHgPlB8KzmzGDXGw3jJ
	 UCHej8MetolznilKFkb/Sfk2GJJBj61nxYHVu/IH0w+pE4k/J0hsXfdXfUyIuJQCi+10o
	 aaADUN/RnRWoHJv2kXYLdngXZXjeRObqNceLQ1VHRWfzBOCzmi/xN/03tfvCjn7KCNr9g
	 pWt0d/jOnvQmH5jh3MD3hePWrOl/RHs8tCV4hDR34zZSnSLAF15TdUQ+kF8WTRZatxsRT
	 qPO38+zZSgiXXH+DR3RBO7dY6uGalyxYlNy4X0fpxL3JV3g/Hqn+vqxkZeOkiyyq7rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406415;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7B57yFhhoC7EhQeanlpezdJDPtjATDROjKxXttsKNQY=;
	b=k8/lwwDwQobTKNr9TH5Z5D6bVX73pADxEp2XULipOeP3DTF5ElJ0M7c75VeLoQZeEMEI
	 JOpL0PeacN0uH2JneQPFKuQQRdWnpS+bhQNLGw0hJ3NI8BELmNxnRWB1szjnaSCBo/VYf
	 1yGx2RI3B5qgE7wuD1Gbae0NKYB8O0YAetlls/jHGAzVe5LXN1q9HzCB5UggDrQCdLnAP
	 kQi92Eo+gJTDy60aYZSiLA3U93AoK8xVzNjHRnuTTI+X48qaBZU0kAFd+2smTxKN0INNt
	 MLOSbVJ15EHIyjTK86V3oFdsquGNHXAInrogtvvR6NyoVT1KKkpIkCIqQHrWBpzVv+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XX8lwRGL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE8606A332;
	Wed, 11 Nov 2026 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XX8lwRGL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C071F00A05;
	Wed, 11 Nov 2026 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406415;
	bh=7B57yFhhoC7EhQeanlpezdJDPtjATDROjKxXttsKNQY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XX8lwRGLIbvzKxwLmD5x/4rdbUX7Orr3msOHeo9XnXqUYKMAJ5Oq8aPVlxvNIAA3/
	 H0KsmdAGL/MgqFY0k3kR1zgtloa2r1nfRQlfIQJMvz9lFdUm+7BPFU5KrDy1Zkipz3
	 VbbTFMOUOe/YL5o+mLtO2wVUChlEeRje7KSvuxkBaT7ysxkBpOx68VNaRv2nTc3ljB
	 CRoDsF4QXZ6YZHTWIxWCk8xlgucDD7sXhSSpUe/+/sdih8gnnFmoYi/wdYBiBc2NxN
	 p6v3MUWMLhy+NpsUuJUMi1YRdyPuUI2BBiDXV97RLsFpdTbX2od5w3QLmKEzTKM79o
	 QSsbE8U2lGtqQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mani Tofigh <mt4022@columbia.edu>
Subject: [PATCH v3 1/5] kprobes: Switch ftrace ops when adding probe with post_handler
Date: Wed, 11 Nov 2026 23:13:31 +0900
Message-ID: <179440641120.328088.15542754095040659094.stgit@devnote2>
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

