Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB2535942;
	Fri,  9 May 2025 01:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746754590; cv=none; b=TRKsjA+rTt/og/5TdEa418HxtzmO99yw0pF/g51JneVBtgIUFA/lWuK2ELpADyq4GJjRV0LmAUZfTHGs0TBofj7xKX/Yy355qn5df8iL0/bdagsyzlu69e8ZpAKrzUYF7pr4ef7l7Y3VP62kfnqlHTAywq1AwWGGm9SPLzyRHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746754590; c=relaxed/simple;
	bh=4/BicO1syPjQXua00Gn5pqpsEBVkcsuNF1q+sEZ9Au4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAWoMlLGBSbPuQpAGbzgC5+XDUIFj6LJyzqlg85Pqy7j9/Y+GlkN2aZY3SoKzJod2Hq9SbKsg8NuYsQLdZZKwyImvVWpEVM4Vi5C+jwf9sLbs6dRkoTpFnQKiRnxr9juhfLmX7RAx5EXSPQbVgSNJkj9dOyk33lXO5vXJboSJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD8AC4CEE7;
	Fri,  9 May 2025 01:36:28 +0000 (UTC)
Date: Thu, 8 May 2025 21:36:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v7 11/17] unwind deferred: Use bitmask to determine
 which callbacks to call
Message-ID: <20250508213642.73b00fe1@gandalf.local.home>
In-Reply-To: <20250502165009.236733114@goodmis.org>
References: <20250502164746.178864972@goodmis.org>
	<20250502165009.236733114@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 May 2025 12:47:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -134,6 +135,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
>  	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
>  	struct unwind_stacktrace trace;
>  	struct unwind_work *work;
> +	struct task_struct *task = current;
>  	u64 cookie;
>  
>  	if (WARN_ON_ONCE(!info->pending))
> @@ -155,7 +157,10 @@ static void unwind_deferred_task_work(struct callback_head *head)
>  
>  	guard(mutex)(&callback_mutex);
>  	list_for_each_entry(work, &callbacks, list) {
> -		work->func(work, &trace, cookie);
> +		if (task->unwind_mask & (1UL << work->bit)) {
> +			work->func(work, &trace, cookie);
> +			clear_bit(work->bit, &current->unwind_mask);
> +		}
>  	}
>  	barrier();
>  	/* If another task work is pending, reuse the cookie and stack trace */

So testing this code I hit a live lock. What happened was I enabled the
flag that asks for a user space callback after every event. But when I
enabled this and also enabled all events, I did this on a kernel that had
irq_disable as an event, and then the system hung.

What happened was that after the trace was recorded, on the way back to
user space, interrupts were disabled again, and the request for a callback
was done again. This enabled another task_work to be triggered, and it
would do the callback again, and then back on the way back to user space,
it disabled interrupts, another request for a user space stack trace was
done, the task_work was triggered again, and ... wash, rinse, repeat!

To fix this, I decided to move the "pending" bit into the task->unwind_mask
(the most significant bit). I also moved the clearing of the work bits into
unwind_exit_to_user_mode():

static __always_inline void unwind_exit_to_user_mode(void)
{
	unsigned long bits;

	/* Was there any unwinding? */
	if (likely(!current->unwind_mask))
		return;

	bits = current->unwind_mask;
	do {
		/* Is a task_work going to run again before going back */
		if (bits & UNWIND_PENDING)
			return;
	} while (!try_cmpxchg(&current->unwind_mask, &bits, 0UL));

	if (likely(current->unwind_info.cache))
		current->unwind_info.cache->nr_entries = 0;
	current->unwind_info.timestamp = 0;
}

The idea is, current->unwind_mask would only be set if an unwind was
requested and given. If it's not set, no unwind was done and there's
nothing left to do, so just exit the routine.

Then if unwind_mask has PENDING set, it means that a task work is going to
be executed again before going back to user space, so exit, otherwise, try
to clear all the bits to zero (using try_cmpxchg() in case an NMI comes in).

Finally clear all the data normally.

Now if a tracer requests a callback, it will get only one callback, if it
requests another one on he way out it will be told that it has already
requested one (and it was already delivered). Now, if a tracer really wants
to request another one, and it knows it will not cause an infinite recursion
by doing so, then I could add an API that lets the unwinder do that.
Possibly adding a "force" argument to the request function.

Otherwise, the bit for the tracer stays set until the task goes back to
user space or, if another tracer requests its first stacktrace, then it
will set the pending bit and clear all other bits that were set previously.

Having the pending bit be part of the unwind_mask allows for updating the
pending bit atomically with the other bits.

Here's the patch that implements this:

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 1789c3624723..db7a8d5d6040 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -18,6 +18,9 @@ struct unwind_work {
 
 #ifdef CONFIG_UNWIND_USER
 
+#define UNWIND_PENDING_BIT	(BITS_PER_LONG - 1)
+#define UNWIND_PENDING		(1UL << UNWIND_PENDING_BIT)
+
 void unwind_task_init(struct task_struct *task);
 void unwind_task_free(struct task_struct *task);
 
@@ -29,7 +32,20 @@ void unwind_deferred_cancel(struct unwind_work *work);
 
 static __always_inline void unwind_exit_to_user_mode(void)
 {
-	if (unlikely(current->unwind_info.cache))
+	unsigned long bits;
+
+	/* Was there any unwinding? */
+	if (likely(!current->unwind_mask))
+		return;
+
+	bits = current->unwind_mask;
+	do {
+		/* Is a task_work going to run again before going back */
+		if (bits & UNWIND_PENDING)
+			return;
+	} while (!try_cmpxchg(&current->unwind_mask, &bits, 0UL));
+
+	if (likely(current->unwind_info.cache))
 		current->unwind_info.cache->nr_entries = 0;
 	current->unwind_info.timestamp = 0;
 }
diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index ae27a02234b8..28811a9d4262 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -12,7 +12,6 @@ struct unwind_task_info {
 	struct callback_head	work;
 	u64			timestamp;
 	u64			nmi_timestamp;
-	int			pending;
 };
 
 #endif /* _LINUX_UNWIND_USER_DEFERRED_TYPES_H */
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 6ffed486bd7b..637ab6491bc5 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -19,6 +19,11 @@ static LIST_HEAD(callbacks);
 static unsigned long unwind_mask;
 DEFINE_STATIC_SRCU(unwind_srcu);
 
+static inline bool unwind_pending(struct task_struct *task)
+{
+	return test_bit(UNWIND_PENDING_BIT, &task->unwind_mask);
+}
+
 /*
  * Read the task context timestamp, if this is the first caller then
  * it will set the timestamp.
@@ -99,11 +104,11 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	struct task_struct *task = current;
 	int idx;
 
-	if (WARN_ON_ONCE(!info->pending))
+	if (WARN_ON_ONCE(!unwind_pending(task)))
 		return;
 
 	/* Allow work to come in again */
-	WRITE_ONCE(info->pending, 0);
+	clear_bit(UNWIND_PENDING_BIT, &task->unwind_mask);
 
 	/*
 	 * From here on out, the callback must always be called, even if it's
@@ -126,10 +131,8 @@ static void unwind_deferred_task_work(struct callback_head *head)
 	idx = srcu_read_lock(&unwind_srcu);
 	list_for_each_entry_srcu(work, &callbacks, list,
 				 srcu_read_lock_held(&unwind_srcu)) {
-		if (task->unwind_mask & (1UL << work->bit)) {
+		if (task->unwind_mask & (1UL << work->bit))
 			work->func(work, &trace, timestamp);
-			clear_bit(work->bit, &current->unwind_mask);
-		}
 	}
 	srcu_read_unlock(&unwind_srcu, idx);
 }
@@ -156,10 +159,11 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 		inited_timestamp = true;
 	}
 
+	/* Is this already queued */
 	if (current->unwind_mask & (1UL << work->bit))
 		return 1;
 
-	if (info->pending)
+	if (unwind_pending(current))
 		goto out;
 
 	ret = task_work_add(current, &info->work, TWA_NMI_CURRENT);
@@ -174,7 +178,13 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 		return ret;
 	}
 
-	info->pending = 1;
+	/*
+	 * This is the first to set the PENDING_BIT, clear all others
+	 * as any other bit has already had their callback called, and
+	 * those callbacks should not be called again because of this
+	 * new callback.
+	 */
+	current->unwind_mask = UNWIND_PENDING;
 out:
 	return test_and_set_bit(work->bit, &current->unwind_mask);
 }
@@ -202,7 +212,7 @@ static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *timestamp)
 int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 {
 	struct unwind_task_info *info = &current->unwind_info;
-	int pending;
+	unsigned long old, bits;
 	int bit;
 	int ret;
 
@@ -224,25 +234,30 @@ int unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
 
 	*timestamp = get_timestamp(info);
 
-	/* This is already queued */
+	/* Is this already queued */
 	if (current->unwind_mask & (1UL << bit))
 		return 1;
 
-	/* callback already pending? */
-	pending = READ_ONCE(info->pending);
-	if (pending)
+	old = current->unwind_mask;
+	barrier();
+
+	if (unwind_pending(current))
 		goto out;
 
-	/* Claim the work unless an NMI just now swooped in to do so. */
-	if (!try_cmpxchg(&info->pending, &pending, 1))
+	/* This is the first to set the pending bit since the task enter kernel */
+	bits = UNWIND_PENDING | (1 << bit);
+
+	/* callback already pending? */
+	if (!try_cmpxchg(&current->unwind_mask, &old, bits))
 		goto out;
 
 	/* The work has been claimed, now schedule it. */
 	ret = task_work_add(current, &info->work, TWA_RESUME);
-	if (WARN_ON_ONCE(ret)) {
-		WRITE_ONCE(info->pending, 0);
-		return ret;
-	}
+
+	if (WARN_ON_ONCE(ret))
+		WRITE_ONCE(current->unwind_mask, 0);
+
+	return ret;
 
  out:
 	return test_and_set_bit(work->bit, &current->unwind_mask);
@@ -281,7 +296,7 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
 	guard(mutex)(&callback_mutex);
 
 	/* See if there's a bit in the mask available */
-	if (unwind_mask == ~0UL)
+	if (unwind_mask == ~(UNWIND_PENDING))
 		return -EBUSY;
 
 	work->bit = ffz(unwind_mask);

-- Steve
