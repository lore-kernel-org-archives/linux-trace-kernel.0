Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDDE28FF;
	Thu, 11 Jul 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720713349; cv=none; b=dAMQoL4QO6fEggIcrRu7tsWXZ5vXQ+3IpLzReNyOSJZTGknFn6aXkziyTbiBv33226bSSunJRmU9nSNxVT0RJP6AKH/dZLxfA5alk48cNdOzZX6SsaVR0PlX+9Tiz7YJZ4ly5u7A66Tc4wngeyWOrfqmr3oyuUGAvMhdyeupYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720713349; c=relaxed/simple;
	bh=w+A3sOrmDUAx1OwvIRO2HQ+zODeOjMMWaJ4EeToH730=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWYTv7Ymn5SidzulL8xt6nMXl86znDzNHWVuEaQbsU0rwb1vKeDd9xSwdxMh9NO9/ShIHvCYBTtWY/Pt9JqOd/YDOdi+s4GE6lG1TqPf0wE/gtMF2Vjx899w982uyTsTJedhArr+YPZsBL3Bm3DYcYL9rM3udezrXz2vMj7eB2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jyqLzf8B; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jyqLzf8B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cSiIU7bwvCcF253N61ilnrKuKH5iA5GLzafJDCHXnS4=; b=jyqLzf8B8pIUmcgb3JcmiUOM+Z
	bE3JlUZywstx1MO5Do98TzsIGLsGwPatYYuTM4KYlVr9H8oc7Ep3nPXsDTD0ZIM8c0Dj+wEG0Ldi+
	iDTKykteijllru5XUAa557dJktIL82lGKwmQraIgLIl6WF+de5Dpx6wBcTCa+GgD5gI3IfAwlNB/V
	jH79SFJgpY4FBBfKUyNjdlMaNg3ubwQGUYqaKI/lpjxJ7bgQKI/yZ4yj9l8vTYlx4nC6SAWTFavtb
	i/nQlXnxsdwO5bs/2UrgAAkowqJN5/Z9UbYEDZon+yU9O/HbS5d8ZVYXoKiZ/l7AgDJd7gEGNb43g
	a0mL2LWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRw90-000000017wR-1tjP;
	Thu, 11 Jul 2024 15:55:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 11B9030050D; Thu, 11 Jul 2024 17:55:42 +0200 (CEST)
Date: Thu, 11 Jul 2024 17:55:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com,
	paulmck@kernel.org
Subject: Re: [PATCH v2 11/11] perf/uprobe: Add uretprobe timer
Message-ID: <20240711155542.GA34311@noisy.programming.kicks-ass.net>
References: <20240711110235.098009979@infradead.org>
 <20240711110401.412779774@infradead.org>
 <20240711131918.GC16902@redhat.com>
 <20240711150054.GA3285@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240711150054.GA3285@noisy.programming.kicks-ass.net>

On Thu, Jul 11, 2024 at 05:00:54PM +0200, Peter Zijlstra wrote:

> Let me ponder that a little, I *can* make it work, but all 'solutions'
> I've come up with so far are really rather vile.

This is the least horrible solution I could come up with...

---
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -83,6 +83,7 @@ struct uprobe_task {
 
 	struct timer_list		ri_timer;
 	struct callback_head		ri_task_work;
+	bool				ri_work_pending;
 	struct task_struct		*task;
 };
 
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1797,9 +1797,8 @@ void uprobe_free_utask(struct task_struc
 	t->utask = NULL;
 }
 
-static void return_instance_task_work(struct callback_head *head)
+static void __return_instance_put(struct uprobe_task *utask)
 {
-	struct uprobe_task *utask = container_of(head, struct uprobe_task, ri_task_work);
 	struct return_instance *ri;
 
 	for (ri = utask->return_instances; ri; ri = ri->next) {
@@ -1815,9 +1814,43 @@ static void return_instance_task_work(st
 	}
 }
 
+static void return_instance_task_work(struct callback_head *head)
+{
+	struct uprobe_task *utask = container_of(head, struct uprobe_task, ri_task_work);
+	utask->ri_work_pending = false;
+	__return_instance_put(utask);
+}
+
+static int return_instance_blocked(struct task_struct *p, void *arg)
+{
+	unsigned int state = READ_ONCE(p->__state);
+
+	if (state == TASK_RUNNING || state == TASK_WAKING)
+		return 0;
+
+	smp_rmb();
+	if (p->on_rq)
+		return 0;
+
+	/*
+	 * Per __task_needs_rq_locked() we now have: !p->on_cpu and only hold
+	 * p->pi_lock, and can consiter the task fully blocked.
+	 */
+
+	__return_instance_put(p->utask);
+	return 1;
+}
+
 static void return_instance_timer(struct timer_list *timer)
 {
 	struct uprobe_task *utask = container_of(timer, struct uprobe_task, ri_timer);
+	if (utask->ri_work_pending)
+		return;
+
+	if (task_call_func(utask->task, return_instance_blocked, NULL))
+		return;
+
+	utask->ri_work_pending = true;
 	task_work_add(utask->task, &utask->ri_task_work, TWA_SIGNAL);
 }
 
