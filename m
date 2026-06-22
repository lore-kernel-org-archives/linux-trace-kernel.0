Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A234D3B0;
	Mon, 22 Jun 2026 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782159917; cv=none; b=RKqwyEnNjcFVMUQ2C9G1BG9PXsfECbhF4Q0MO5ijBAjMOn5eReN//sjtlGlPBFzlyUcc0JIPwMqG8f8Z87DAStNCYNDYYW/8mW1AKPHRLDuMTZOq5sbzwTfBYMyQyMvwAiDdT6Wq0/sWMoaGOxJJl9ACEw2NCiedv1J+IWgQoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782159917; c=relaxed/simple;
	bh=Qm3fN9SxpqdsziW5uabSJ3ImEYV11vJ5Zu0CZyrxk2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZptjTozsJ2Kt+M8FFuOAwQ4hcw971IjGq00zil9eb63BlxF/dJjnDsUYTQlGM9m7AKmT0inoOIxrRv7nSesX0S5vKATFz07c4Ek9J+E/1zcEaB43QpefL1u5Jwm2cOwGhT91yTEZVg6SyHH5lRu9iK5oh3NxJsOS5zimgPPOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=bYouQ9GI; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="bYouQ9GI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782159913;
	bh=ZLlfepZFeaknCi6xAkAqXBfExe+6Pg0BUxgR3tzsj14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bYouQ9GINun7AFdz1AKycwsTNIazXlEIuyFulJ0XMuMWkTcA509run8/FXg8mVMre
	 zN/G7JU8e+WeRZAtiSEN+agfNAj5R0dTLHYOq6mU3aYmmQshn45VwXA9gSXpsswkkb
	 W6P0ESdHF5NGGKgYBCk9pors3VobM2pZr35Q0ABQ=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gkfp13yrMz10wc;
	Mon, 22 Jun 2026 20:25:13 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gkfp050RLz10wK;
	Mon, 22 Jun 2026 20:25:12 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Marco Elver <elver@google.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Kexin Sun <kexinsun@smail.nju.edu.cn>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH v2 2/2] signal: make send_signal_locked() take const siginfo
Date: Mon, 22 Jun 2026 20:25:09 +0000
Message-ID: <f754c4e5c82b45bcbb770aa8bb1f4ab1d87a0b0e.1782159692.git.include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622164029.11474-1-include@grrlz.net>
References: <20260622164029.11474-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

send_signal_locked() should not change the caller's siginfo. Make that
part of the type and keep the local rewrite on its copy.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
Changes since v1:
- New patch from Oleg's suggestion.
- Link to Oleg's suggestion:
  https://lore.kernel.org/all/0873AC4A-3CB2-4F7B-BFE6-75D855AD22DC@grrlz.net/T/#m5f8a2d54928efff41de539969b68149e1ec5fca4

 include/linux/signal.h        |  2 +-
 include/trace/events/signal.h |  4 ++--
 kernel/signal.c               | 20 +++++++++++---------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index f19816832f05..a1ba8c5973c6 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -283,7 +283,7 @@ extern int do_send_sig_info(int sig, struct kernel_siginfo *info,
 				struct task_struct *p, enum pid_type type);
 extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
 			       struct task_struct *p, enum pid_type type);
-extern int send_signal_locked(int sig, struct kernel_siginfo *info,
+extern int send_signal_locked(int sig, const struct kernel_siginfo *info,
 			      struct task_struct *p, enum pid_type type);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
 extern void set_current_blocked(sigset_t *);
diff --git a/include/trace/events/signal.h b/include/trace/events/signal.h
index 1db7e4b07c01..05a46135ee34 100644
--- a/include/trace/events/signal.h
+++ b/include/trace/events/signal.h
@@ -49,8 +49,8 @@ enum {
  */
 TRACE_EVENT(signal_generate,
 
-	TP_PROTO(int sig, struct kernel_siginfo *info, struct task_struct *task,
-			int group, int result),
+	TP_PROTO(int sig, const struct kernel_siginfo *info,
+		 struct task_struct *task, int group, int result),
 
 	TP_ARGS(sig, info, task, group, result),
 
diff --git a/kernel/signal.c b/kernel/signal.c
index d72d9be3a992..26e8b8e1d03c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1037,7 +1037,7 @@ static inline bool legacy_queue(struct sigpending *signals, int sig)
 	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
 }
 
-static int __send_signal_locked(int sig, struct kernel_siginfo *info,
+static int __send_signal_locked(int sig, const struct kernel_siginfo *info,
 				struct task_struct *t, enum pid_type type, bool force)
 {
 	struct sigpending *pending;
@@ -1154,7 +1154,7 @@ static int __send_signal_locked(int sig, struct kernel_siginfo *info,
 	return ret;
 }
 
-static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
+static inline bool has_si_pid_and_uid(const struct kernel_siginfo *info)
 {
 	bool ret = false;
 	switch (siginfo_layout(info->si_signo, info->si_code)) {
@@ -1178,10 +1178,11 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 	return ret;
 }
 
-int send_signal_locked(int sig, struct kernel_siginfo *info,
+int send_signal_locked(int sig, const struct kernel_siginfo *info,
 		       struct task_struct *t, enum pid_type type)
 {
 	struct kernel_siginfo rewritten;
+	const struct kernel_siginfo *send_info = info;
 	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
 	bool force = false;
 
@@ -1196,26 +1197,27 @@ int send_signal_locked(int sig, struct kernel_siginfo *info,
 		struct user_namespace *t_user_ns;
 
 		rewritten = *info;
-		info = &rewritten;
+		send_info = &rewritten;
 
 		rcu_read_lock();
 		t_user_ns = task_cred_xxx(t, user_ns);
 		if (current_user_ns() != t_user_ns) {
-			kuid_t uid = make_kuid(current_user_ns(), info->si_uid);
-			info->si_uid = from_kuid_munged(t_user_ns, uid);
+			kuid_t uid = make_kuid(current_user_ns(), rewritten.si_uid);
+
+			rewritten.si_uid = from_kuid_munged(t_user_ns, uid);
 		}
 		rcu_read_unlock();
 
 		/* A kernel generated signal? */
-		force = (info->si_code == SI_KERNEL);
+		force = (rewritten.si_code == SI_KERNEL);
 
 		/* From an ancestor pid namespace? */
 		if (!task_pid_nr_ns(current, task_active_pid_ns(t))) {
-			info->si_pid = 0;
+			rewritten.si_pid = 0;
 			force = true;
 		}
 	}
-	return __send_signal_locked(sig, info, t, type, force);
+	return __send_signal_locked(sig, send_info, t, type, force);
 }
 
 static void print_fatal_signal(int signr)
-- 
2.53.0
