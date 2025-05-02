Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49C268FD5;
	Fri,  2 May 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204610; cv=none; b=fZnfJL2EkE8CDqz6NbJxw3hRbRWdRwDZa4gi763JuCriQxj83IqoN4aWPaV275umew7j1HJ6CLWr4LgnDYmSsbZ3b6XV2w+dFSDfG6uDadvn991r+4YEbQHO5MnHQxCg6BFl1F16sNpgLxkeqvOBvhveYD0dfgTJ/DRGd5Qzo6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204610; c=relaxed/simple;
	bh=g593+XuzQEKQ7TP4igZ61P/wDrXKaJbg8PWTdIUm3W0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qk8PX9NW0wS6I8Q07jE5nU0mhq26mVmNoid2X24470JUkk83aQhL0z+lCqVWcKFhxz6RzfMVZ8vSradnXvpBOuUvtl5j6o9+lUHurbjh3gY6iHgHf1srIWaV98SXv6hzi6twmGiw5mp758c+WpZxfXs0sRlZ6gmstS9LfoX1W9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3355FC4CEED;
	Fri,  2 May 2025 16:50:10 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uAtaT-0000000035E-2Kny;
	Fri, 02 May 2025 12:50:09 -0400
Message-ID: <20250502165009.406665968@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 02 May 2025 12:47:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org,
 Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v7 12/17] unwind deferred: Use SRCU unwind_deferred_task_work()
References: <20250502164746.178864972@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Instead of using the callback_mutex to protect the link list of callbacks
in unwind_deferred_task_work(), use SRCU instead. This gets called every
time a task exits that has to record a stack trace that was requested.
This can happen for many tasks on several CPUs at the same time. A mutex
is a bottleneck and can cause a bit of contention and slow down performance.

As the callbacks themselves are allowed to sleep, regular RCU can not be
used to protect the list. Instead use SRCU, as that still allows the
callbacks to sleep and the list can be read without needing to hold the
callback_mutex.

Link: https://lore.kernel.org/all/ca9bd83a-6c80-4ee0-a83c-224b9d60b755@efficios.com/

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/unwind/deferred.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 716393dff810..5f98ac5e3a1b 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -23,10 +23,11 @@
  */
 static DEFINE_PER_CPU(u64, unwind_ctx_ctr);
 
-/* Guards adding to and reading the list of callbacks */
+/* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
 static unsigned long unwind_mask;
+DEFINE_STATIC_SRCU(unwind_srcu);
 
 /*
  * The context cookie is a unique identifier that is assigned to a user
@@ -137,6 +138,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct unwind_work *work;
 	struct task_struct *task = current;
 	u64 cookie;
+	int idx;
 
 	if (WARN_ON_ONCE(!info->pending))
 		return;
@@ -155,14 +157,16 @@ static void unwind_deferred_task_work(struct callback_head *head)
 
 	cookie = get_cookie(info);
 
-	guard(mutex)(&callback_mutex);
-	list_for_each_entry(work, &callbacks, list) {
+	idx = srcu_read_lock(&unwind_srcu);
+	list_for_each_entry_srcu(work, &callbacks, list,
+				 srcu_read_lock_held(&unwind_srcu)) {
 		if (task->unwind_mask & (1UL << work->bit)) {
 			work->func(work, &trace, cookie);
 			clear_bit(work->bit, &current->unwind_mask);
 		}
 	}
-	barrier();
+	srcu_read_unlock(&unwind_srcu, idx);
+
 	/* If another task work is pending, reuse the cookie and stack trace */
 	if (!READ_ONCE(info->pending))
 		WRITE_ONCE(info->cookie, 0);
@@ -238,6 +242,7 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 {
 	struct unwind_task_info *info = &current->unwind_info;
 	int pending;
+	int bit;
 	int ret;
 
 	*cookie = 0;
@@ -249,12 +254,17 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 	if (in_nmi())
 		return unwind_deferred_request_nmi(work, cookie);
 
+	/* Do not allow cancelled works to request again */
+	bit = READ_ONCE(work->bit);
+	if (WARN_ON_ONCE(bit < 0))
+		return -EINVAL;
+
 	guard(irqsave)();
 
 	*cookie = get_cookie(info);
 
 	/* This is already queued */
-	if (current->unwind_mask & (1UL << work->bit))
+	if (current->unwind_mask & (1UL << bit))
 		return 1;
 
 	/* callback already pending? */
@@ -280,19 +290,26 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
 void unwind_deferred_cancel(struct unwind_work *work)
 {
 	struct task_struct *g, *t;
+	int bit;
 
 	if (!work)
 		return;
 
 	guard(mutex)(&callback_mutex);
-	list_del(&work->list);
+	list_del_rcu(&work->list);
+	bit = work->bit;
+
+	/* Do not allow any more requests and prevent callbacks */
+	work->bit = -1;
+
+	clear_bit(bit, &unwind_mask);
 
-	clear_bit(work->bit, &unwind_mask);
+	synchronize_srcu(&unwind_srcu);
 
 	guard(rcu)();
 	/* Clear this bit from all threads */
 	for_each_process_thread(g, t) {
-		clear_bit(work->bit, &t->unwind_mask);
+		clear_bit(bit, &t->unwind_mask);
 	}
 }
 
@@ -309,7 +326,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	work->bit = ffz(unwind_mask);
 	unwind_mask |= 1UL << work->bit;
 
-	list_add(&work->list, &callbacks);
+	list_add_rcu(&work->list, &callbacks);
 	work->func = func;
 	return 0;
 }
-- 
2.47.2


