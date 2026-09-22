Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FB833937B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091788; cv=none; b=Pq1uwKa3Wj5uDbqtZkF8kj7+kOqXY7mv2wWqobxzSk3FmRIldomAwtTXyqMUHVIm4W9UbKYo6Dxv4lyxpIZ/+0/ZoN0ve2UdSi2cEaq2ZE9QnzUuwLsG+7cWxS9SEhn3EQ0TLsAosSBErEDfru7ZjkQIBKUw48IGT90KpSbU7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091788; c=relaxed/simple;
	bh=l07At5e/FtwvFEhvmUdFRuvOuYiPaFWdFCcvR7eYvUQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NjQXxfO8HWwZF5Y3xarqGPqnMjU2T0ilzjSOrpHFt+6wtSar1Uoh6xRkA6gvJnQIotnwgpH9eeRta32/rSZT9sPWg3uB3HyKxY4QGHGfUPRPi6H1r27PlRL5b3ZIwuJKCwn3wDJ662PgHCxbc1ptw28w4jq1VY3Kw+i1b8jwkQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=HmGRtZ1u; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="HmGRtZ1u"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109f067cso3417185a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 08:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1790091783; x=1790696583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NGKku8nyry7LJ3cQ2W+BxzqUbPO2qtN0RpKOVM2oOc8=;
        b=HmGRtZ1uXSJy5W2bLzIdB1jBwSa2qtnPXke0stGNe+fv+pNP9rnPPL4WDaTnfqr3bt
         /7mN16YmsLXQjygdMHRJMwD2buCTN0SwoJvV9Xt71/2SJDmRyKHX7Yxant0YMAAeTh+n
         zMMYMgD9RkdDN6WmPHeeAVOpKlJgusqLOlJYPXWrg6OPzNRnLOF1cumRsSfzMYfMedQo
         SasVdnkynUDXsyn2hBqYSpiJfXtJLmzc6JYBrZc3FciPxHOnxvkykWzZTP51OwaxXsYW
         3y9TznhMdcQCZSOBat6hh6sqcQaexAnF22qR4Uwcg6gLuk5bp/ze94gRCCbIZz7PJxHx
         fp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091783; x=1790696583;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:subject:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NGKku8nyry7LJ3cQ2W+BxzqUbPO2qtN0RpKOVM2oOc8=;
        b=JTGZ+bamXFoxkGL9IqndPFLj0rZdAIicaQBEVBnYPB+ezTMzjanyH/8+5OkRCTB1Kw
         XZhLEFYo+brafrGP6dMPURugSLGVwIwUMqp27KPOuhwx2X7BYxVyAvpNxu6VBMjiInj3
         fSsAq02Ga+pGVp8GtN0sBxKzuhMZKNxMdsgHor+LeCqbugE91I7WVXlX+yfmTQXlStgh
         7OGlLcrK6pxQMPdU8U6n8IKZlu/MAEnqXtV+/Xuw5if2LdEB0EbL28PItGlEH7930WSF
         C9NYYFSNaCdwAbtqnP1/GNlcKFVXLaaPzIOdm2OSGkyE3KANkLqD9e08IVJcquEJC21r
         rNHQ==
X-Forwarded-Encrypted: i=1; AKwUvBySk8rlNWMm566m4OH8BjVg1v8YLii6V1m3cGlI5V64Z+tOUKY2uN4JKcQxuwD3AmxsIoy3J3bSCzlimSlcEddp5gk=@vger.kernel.org
X-Gm-Message-State: AFuF++lm+3tLpWq0Y9B70uZjNyxBffkJM2HvTZA+no006+sdjrCx/tz0
	mbhP5wm0XL5rbcXXhVyg5VD9PgTC8QrQ9BMXkzD6fMakAlIDAqpigvdDeLTYfwcCiMA=
X-Gm-Gg: AYBFou0A6wngaLKdjicUE0+98IaK55isogKba+2RWNtJ7cpErRsO2AdEQibagxOlP9J
	5FNsWi/x7b3JgBqYrT/gn3QCAK447M7w1V95Du22iTkWBwoZzwCHwXhBgbq11KOEv4Z2fz/GZyj
	RdJbddkJfggzg1kfRnbCqSquyKfoesArcyvWpKpvI3sdQf8+0FsxKzRUAsIhFqS6vRzYijN+E/T
	9XHaX4Z66wlIU6mh8p42Ity8avZmbG9zsb+HtUyxtLJR8l+yQLFvBytAt3/i40OfshmOwoAjpry
	3ZsJXbQ58CErKetEIaPc/ThJN5UnBt66F0CC+SMJDNyxx6RbsTtAwXiKHRb4rPEMqYY3CM0jdnP
	tvOhDDQYEOMaHlfSxXB78WI/nVZ+O1xRh7aRdLID/Wwkgsi1Mdm3J/vl52sNAh3UEsiDzihh+eT
	Q+9phO9u1mUfeOKsH8fQyyzsqfuujIzWuoW3ILCFb8rIaxeFMhefY01CfJpsCo+/LNC3q1R3zS9
	tpQ8FnFOpYXh7Q=
X-Received: by 2002:a05:620a:6006:b0:93b:d79f:d955 with SMTP id af79cd13be357-93c15f2e6e5mr588176085a.74.1790091783184;
        Tue, 22 Sep 2026 08:43:03 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2485dce4sm1063585a.23.2026.09.22.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:43:01 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:42:15 +0000
Message-ID: <d36fdaad78296f3c43f84bc9c5b15a36.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v3 03/13] rcu-tasks: Add a Tasks RCU implementation for reader-marked trampolines
In-Reply-To: <aqxLgT41UyA-bV5J@pavilion.home>
References: <20260915-b4-rcu-tasks-preempt-qs-v3-0-0ad30c4c5ee7@toxicpanda.com> <20260915-b4-rcu-tasks-preempt-qs-v3-3-0ad30c4c5ee7@toxicpanda.com> <aqxLgT41UyA-bV5J@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 22:20:17 +0200, Frederic Weisbecker wrote:
> > +	lockdep_assert_irqs_disabled();
> > +	WRITE_ONCE(t->rcu_tasks_irq_ip, ip);
> > +	t->rcu_tasks_exit_cpu = smp_processor_id();
> > +	raw_spin_lock_rcu_node(rtpcp);
> > +	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
> > +	raw_spin_unlock_rcu_node(rtpcp);
>
> I don't think we can do that. This is too much unconditional overhead
> on the hot preemption path. rcu_tasks_trampoline_text() should be
> a condition here.

Sorry, I missed this one before sending v4/v5. Agreed, and it is gone
for v6: the hook is now just the WRITE_ONCE() of the IP plus the
rcu_tasks_trampoline_text() check, and the exit side a single store.

The IP store itself has to stay unconditional because of the kprobe
jump optimizer: its window is ordinary text, so a task parked there
before the optimizer decided to patch was not "trampoline text" when it
was preempted, and the optimizer needs to find it afterwards.

> And do we really need to maintain both lists? I understand that they
> have different purposes.
[...]
> Can the latter replace the former?

With the above there is only the holdout list left. The optimizer's
rcu_tasks_wait_irq_preempted() now does what classic does for its scan:
walk the task list plus the per-CPU exit lists (exit_tasks_rcu_start()
and friends stay shared between the two flavors for that), checking each
task's recorded IP. That is a slow path that only kprobe optimization
hits.

And thanks for picking up the core-RCU follow-on.

Josef
