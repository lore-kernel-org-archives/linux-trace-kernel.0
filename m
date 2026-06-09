Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302323EE1DB
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780998211; cv=none; b=R6YEmXx+P0F+4z7MBHhAEicKCqVEXcsmRUL4udNsT22RWOEjATbIeoRBfGpLp6OAKTdHAtdC9hxasoZ+U2VT0r/2EisdFmR/7YBZehJauq3AbZ93VpJ7jdJEctocQBZs6tozRMu8jn3hqoQaBiTxaTPgfbHH7+6lvG1H2aufoMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780998211; c=relaxed/simple;
	bh=E2Ltt0U4mmFQEyaRwsaS3Tp+9/ALm4bhHbe+tUpel7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj+m7ixiyP7hPAzcmhUxIOHTmEcyOuyeHs+v9rzf7UD8dDioJ5Z2yMuQedXlYLytFiuHNYfb8EPXeWSIYHw7Zz3VsqT4yYpGOrOEcUcs00eE0UktD4YCVXvikEmO/CvfBvinaw2x193U7LiCWu3MCXXuRkJ3DHj/G2i8dAPE2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XK7x+kBv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XK7x+kBv"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so24617315e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 02:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780998207; x=1781603007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1LEnHb0maSy8g9/4BjSQSLOMIWn5PmICQLX5a0bKKEc=;
        b=XK7x+kBvvKRd4cC892JCxG1ZKmC/c0SxDpRwXwYQTIy0GbxGwfyhQ+fnuAhLHIRcL/
         A03hVawBQvGmavLXAdXkOtAMSHUriHgOyWBCkFrK/Oudy/1tjSkbOTFshi/gTptXQsk0
         OnkIGFF4rKwVhMco3vF8jFVJQLGlIq8z+0bgAIEtgFBrtkGLScl06USiVmEaScJS/dAa
         yqUYM6/71D7w+cnBwki6Xli8gr84zwjOhCQQo8xRcoQ7c/Xa3MRY6twVRX/78kfWrMJ1
         SqmjSNzvB2NPu2tH5Z2keUy9SiPuvOijZgon5Mplh2ZnY/7DxHiJSqOq2MBGSQMsoqSk
         yZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780998207; x=1781603007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LEnHb0maSy8g9/4BjSQSLOMIWn5PmICQLX5a0bKKEc=;
        b=f4XXOVTdJCJxPcY+SKDEobH6QcklViNogT7N7Zok04TCblM0xVNy9Dt3YTL/t2tyJ9
         7Y73PyZFR8+QaoiF8NPIoO0nKQWJNvVIUO71w60Am2AF2ENEUdJLA2YS4Aq/Hf2CCNlv
         lS6CEbF06tY2uzZ9S+0Ump7Gcag4loffnOexptF4sB1tr+CXIyVIwsn1GAY8yy/f8jmZ
         +ziqQbSQUqpsOwentDmvC+SB6zXMv/h7qdTcCwu9uM3RjV9YKttAKW0iRvZiFsBpApDM
         1epCezc2aF8wK2PEu577MZvWB67bKdy1ZK6NBNAzIVWAnk39WtS7SMhH+sOJPdH/Fhij
         cPeg==
X-Forwarded-Encrypted: i=1; AFNElJ9TYLM9ScKOkpd2e6jVOPuvnzmoLzfdaMgf+CoKagPDyf3rTTZyKIH0S4XUv/AKZwrDgFTXJ9ZvssCIaK8uFuJ9nyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvZwK3Q2BYv/kO/qCP1gjmMfgRiORo3zLt1IT7pzeCEJ21fyZb
	vyVSW97pW7nxerxJ78gsWQtIZGnXQ798pP/LNVBbaCtqpirkWtlSJpKBEaJZr+kc4OlRakcgQo1
	tSqUN
X-Gm-Gg: Acq92OFmOI22oQXYcMVglW32jVwLMWO2aY1DKhQq6Q5JR27DbzruzCLrdNjNPBTb+fA
	oUm1HVslnAw6NnJSiOyOFvfRIXMmsUjaXXDaA06fZhWx4pp9eC2rZuSmFjftD+RnkNLvNtwvGg5
	ko83ydwTTM3IY46e9lJu6zauyK5x71HRLvut3BfkZfWxeHbQxpyfIyU4dFs7MEp+guicw3rFfzS
	Jh5pWLF4Rm7vzYnmasUi0lBQ6O/0bQwyrrvH+A/7EIqG5Sh5/h30ID+O+dB3KqwJha3eS/RyJjA
	0wAJm5XBqCXRfzsZNNPPhVBf51i0XHYLGAMBI8XSDzPsmj4eIegp8LeJjwD00YrBaxwCTnaXRg3
	hrRLomNsS5DOixpEeOMUkZVfRVsE3xCqo6h55Zeh8ciKqC4TsTMJziMwfcTiwvFA5ERDUlX0NpS
	rgYjPs3BYVO8kgpaPbNfOHLCXTAo/FrnbujWif
X-Received: by 2002:a05:600c:5246:b0:489:5022:39a4 with SMTP id 5b1f17b1804b1-490c25d800dmr317190655e9.9.1780998207384;
        Tue, 09 Jun 2026 02:43:27 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3444fesm60610711f8f.20.2026.06.09.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 02:43:27 -0700 (PDT)
Date: Tue, 9 Jun 2026 11:43:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v3] rethook: Remove the running task check in
 rethook_find_ret_addr()
Message-ID: <aifgPaLc_p2vZr5n@pathway.suse.cz>
References: <20260609084953.901576-1-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609084953.901576-1-wutengda@huaweicloud.com>

Added live-patching mailing list.

On Tue 2026-06-09 16:49:53, Tengda Wu wrote:
> The current check in rethook_find_ret_addr() prevents obtaining a return
> address when the target task is marked as running. However, this condition
> is both insufficient for correctness and unnecessary for its intended
> purpose.
> 
> The check is inherently racy: a task can begin running on another CPU
> immediately after task_is_running() returns false, potentially leading to
> concurrent modification of rethook data structures while the iteration is
> in progress.
> 
> Rather than trying to fix this unreliable check deep in the unwinding
> path, simply remove it. The iteration is already safe from crashes because
> unwind_next_frame() holds RCU and rethook_node structures are RCU-freed;
> even if the iteration goes off the rails and returns invalid information,
> it will not crash. Callers that require consistency must provide a safe
> context themselves.
> 
> Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
> v3: Improve commit message: clarify safety semantics and document that RCU guarantees no crash.
> v2: https://lore.kernel.org/all/20260609005728.458962-1-wutengda@huaweicloud.com/
> v1: https://lore.kernel.org/all/20260525132253.1889726-1-wutengda@huaweicloud.com/
> 
> --- a/kernel/trace/rethook.c
> +++ b/kernel/trace/rethook.c
> @@ -250,9 +250,6 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>  	if (WARN_ON_ONCE(!cur))
>  		return 0;
>  
> -	if (tsk != current && task_is_running(tsk))
> -		return 0;
> -

The description of the function should be updated as well. It still
mentions:

 * The @tsk must be 'current' or a task which is not running.

Instead it should explain that it safe to call the function even
on another running tasks but the returned address is not reliable
then.

>  	do {
>  		ret = __rethook_find_ret_addr(tsk, cur);
>  		if (!ret)

I am still a bit concerned about the motivation.

Tengda mentioned at
https://lore.kernel.org/all/679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com/
that they tried to verify livepatching:

<paste>
Background: We are verifying the support of live patches for functions that
have a kretprobe. The specific verification method is as follows:

We construct a function foo() that calls bar():

void bar(void)
{
    for (;;) {
        schedule();
    }
}

void foo(void)
{
    bar();
}

A kretprobe is attached to bar():

echo 'r:rp1 bar' > /sys/kernel/tracing/kprobe_events
echo 1 > /sys/kernel/tracing/events/kprobes/rp1/enable

Then foo() is triggered. The expected behavior is that bar() will call
schedule() and yield the CPU.

After that, the live patch is activated to attempt replacing the implementation
of foo(). The expectation is that this should succeed.

However, in reality, because the task that called schedule() is still in the
RUNNING state, the condition task_is_running(tsk) inside rethook_find_ret_addr()
is not satisfied, causing the function to return early. This, in turn,
prevents stack_trace_save_tsk_reliable() from determining the stack as
reliable, leading to a failure in activating the live patch.

**Not sure if this is correct:**

We believe that after a task voluntarily calls schedule(), when the stack
is expected to be reliable, it is a safe time to activate a live patch.
Additionally, a similar tsk->on_cpu check can be found elsewhere in the
kernel (See task_on_another_cpu() in arch/x86/include/asm/unwind.h).
Therefore, we propose changing the task_is_running(tsk) condition to
tsk->on_cpu.
</paste>

More background:
----------------

The test is artificial because it keeps the RUNNING state before
calling schedule, see
https://lore.kernel.org/all/20260608093449.GH4149641@noisy.programming.kicks-ass.net/



My questions:

Does this patch allows to livepatch the above mentioned test code?
Is the livepatching safe?
Does it help in another scenarios?


My opinion:

The livepatching might be safe only when the process is migrating
itself. I mean that it might be safe even when it is RUNNING as long
at it is _current_.

I agree that we do not need to enforce this in rethook_find_ret_addr()
if the function is used also in other scenarios, for example, by
ftrace/BTF for taking snapshots of other processes.

But we need to make sure that the backtrace is reliable when
livepatching (migrating) the task.

Best Regards,
Petr
