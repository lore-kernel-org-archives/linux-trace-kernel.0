Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59943E6392;
	Fri,  2 Oct 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790980011; cv=none; b=nJxm5o+CmJFHp9apasTLxv5EcyJ+j+lccap08QoEYANJ+ipeRj0K2pJxMAYTXfcHxHvDnDKdUi0rDquD9sYq7bwBxsoDKuCVaKgdNIDLqwcLIo1CGvRPFR86SFG53OejjDaC9NdYJ8vdA0rRJEEVN21rBSK2Dk2Lo446D3NEo80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790980011; c=relaxed/simple;
	bh=vThO3R+nULGiITw60zIUOaCF9D04d26JUAUhJ7HkbgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKNTcf/Fy0GeSuTN3ik/uZ86KEivTGIVQo/WGEdgxOS1hxPmZ+kEEKiSzuMbERPgvAvbowwucjpqacjcJ6lbtcIKDsXWwj2742LZVaQ8yO7m8ApiXVEWM6aLk01FSYx2Jox1rVktRf3ijFaa+T3VX80VzSmzJa1cxhboHRGvwnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q03BGjnU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q03BGjnU"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.167.115.14])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB89620B7167;
	Fri,  2 Oct 2026 15:25:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB89620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790979955;
	bh=xNXMt/RcyWJPjA5xCQyh/2Wc9Ppw/cuFEVRkanXQhgM=;
	h=From:To:Cc:Subject:Date:From;
	b=q03BGjnUAFAofbbvAZfg62W92ZXAJLVuwsW9KKOtpHi+nvs9mXOeFqb8oIbxV9k7N
	 YkZKti7sMGV08tJBc7ffs8HpWoo9fj+V7l+rxroqIn7bVIagBqWQe3WgU7h8OXx9J6
	 zvCjYTKLei27N1rv4BHrmhFKocIZKzc0NSsZlvpY=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: linux-trace-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	kees@kernel.org
Subject: [PATCH] tracing/user_events: Fail fork when event state duplication fails
Date: Fri,  2 Oct 2026 18:26:39 -0400
Message-ID: <20261002222639.1964370-1-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Registered user events are retained across fork, but duplicating their
state for a child with a separate mm can fail. Both user_event_mm_dup() and
user_events_fork() currently return void, so allocation failure silently
creates a child without the inherited registration state.

The child can consequently retain a stale copy-on-write enable word and
miss later event enable and disable updates.

Return an error from user_event_mm_dup() and user_events_fork(), and
perform the duplication in copy_process() while failure can still be
unwound. Return -ENOMEM when the child user_event_mm or any of its enablers
cannot be duplicated.

Add a cleanup path so successfully acquired user-events state is removed if
a later fork operation fails. Preserve the existing CLONE_VM behavior and
its task reference accounting.

A deterministic allocation-failure test on upstream master previously
allowed fork() to succeed while the child missed an enablement update. With
this change, the same fork fails with ENOMEM. The complete user_events ABI
suite passes.

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Cc: stable@vger.kernel.org
Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
---
 include/linux/user_events.h      | 16 +++++++---------
 kernel/fork.c                    |  8 ++++++--
 kernel/trace/trace_events_user.c |  8 +++++---
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 57d1ff006090..75f184126727 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -27,28 +27,26 @@ struct user_event_mm {
 	struct rcu_work		put_rwork;
 };
 
-extern void user_event_mm_dup(struct task_struct *t,
-			      struct user_event_mm *old_mm);
+int user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm);
 
 extern void user_event_mm_remove(struct task_struct *t);
 
-static inline void user_events_fork(struct task_struct *t,
-				    u64 clone_flags)
+static inline int user_events_fork(struct task_struct *t, u64 clone_flags)
 {
 	struct user_event_mm *old_mm;
 
 	if (!t || !current->user_event_mm)
-		return;
+		return 0;
 
 	old_mm = current->user_event_mm;
 
 	if (clone_flags & CLONE_VM) {
 		t->user_event_mm = old_mm;
 		refcount_inc(&old_mm->tasks);
-		return;
+		return 0;
 	}
 
-	user_event_mm_dup(t, old_mm);
+	return user_event_mm_dup(t, old_mm);
 }
 
 static inline void user_events_execve(struct task_struct *t)
@@ -67,9 +65,9 @@ static inline void user_events_exit(struct task_struct *t)
 	user_event_mm_remove(t);
 }
 #else
-static inline void user_events_fork(struct task_struct *t,
-				    u64 clone_flags)
+static inline int user_events_fork(struct task_struct *t, u64 clone_flags)
 {
+	return 0;
 }
 
 static inline void user_events_execve(struct task_struct *t)
diff --git a/kernel/fork.c b/kernel/fork.c
index 10f2d05d816a..9e3da2e6059f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2311,9 +2311,12 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_mm(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_signal;
-	retval = copy_namespaces(clone_flags, p);
+	retval = user_events_fork(p, clone_flags);
 	if (retval)
 		goto bad_fork_cleanup_mm;
+	retval = copy_namespaces(clone_flags, p);
+	if (retval)
+		goto bad_fork_cleanup_user_events;
 	retval = copy_io(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_namespaces;
@@ -2575,7 +2578,6 @@ __latent_entropy struct task_struct *copy_process(
 
 	trace_task_newtask(p, clone_flags);
 	uprobe_copy_process(p, clone_flags);
-	user_events_fork(p, clone_flags);
 
 	copy_oom_score_adj(clone_flags, p);
 
@@ -2602,6 +2604,8 @@ __latent_entropy struct task_struct *copy_process(
 		exit_io_context(p);
 bad_fork_cleanup_namespaces:
 	exit_nsproxy_namespaces(p);
+bad_fork_cleanup_user_events:
+	user_events_exit(p);
 bad_fork_cleanup_mm:
 	sched_cache_fork_cleanup(p);
 	if (p->mm) {
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index f658c3a77aa7..8941c8d7c193 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -863,7 +863,7 @@ void user_event_mm_remove(struct task_struct *t)
 	queue_rcu_work(system_percpu_wq, &mm->put_rwork);
 }
 
-void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
+int user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 {
 	struct user_event_mm *mm = user_event_mm_alloc(t);
 	struct user_event_enabler *enabler;
@@ -872,7 +872,7 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 	t->user_event_mm = NULL;
 
 	if (!mm)
-		return;
+		return -ENOMEM;
 
 	rcu_read_lock();
 
@@ -884,10 +884,12 @@ void user_event_mm_dup(struct task_struct *t, struct user_event_mm *old_mm)
 	rcu_read_unlock();
 
 	user_event_mm_attach(mm, t);
-	return;
+	return 0;
 error:
 	rcu_read_unlock();
 	user_event_mm_destroy(mm);
+
+	return -ENOMEM;
 }
 
 static bool current_user_event_enabler_exists(unsigned long uaddr,
-- 
2.43.0

