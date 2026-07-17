Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E113FAE1A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309889; cv=none; b=LEvEjE0S1+6sMvSmpvZ16bW7HgcOPBtC0hFLtoR7ZAXGzETN67rYKvlOWIMDl7cHI5Ht7rYsDL7gwcaRJcuqfG2Y69waHUl9iOfTM+ShCG2nY3wE0QB4TpxePWIqcu9Zg/H8ij3w+BOlS41CaTDc3SKSGTfTvhkiKWbRQy7Y30A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309889; c=relaxed/simple;
	bh=bGIQZ+q9MSSyTW8gGlZXldByjgC3TeLEyStXGm8pKhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wt8ne9mW8CyMJ8UBU3pbqeZzLHDAt1BNXCxE9xzKd6O/6jxPGMxzOLtaB1Fu7W0zsPUTjAt1PcvxAqSXrFmvMb6A85VkhxUzo0VvfFDO/0zZQXeWUfN2UT0O4t6S4oF+9fh8RvOmATEc/MYbx6SY2Czmyv4Rl6aKgHp16VDDJcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Upsp3WoB; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Upsp3WoB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784309883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZDEfj1UT8xy+O0jyYOUvJTRj35/E1i7m7ya5vwKSg0o=;
	b=Upsp3WoB7ZmY3Hinib7Mw3/oDC3AAWjbvFaoFHAdkUTxwsx7QVZlBvpKjj4YkxfCPbgY45
	/fBQWMJiBubYIiDSJnSbcqRjcsi74qbNLn3qyddWFBsVrn9kFahuIL5NKH+cOwZLWcA6Nx
	ev/HqwGxdTGCFoPYfPsnLKxAmbYzmPQ=
From: Usama Arif <usama.arif@linux.dev>
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	leitao@debian.org
Subject: Re: [RFC] tracing: Try user copies with page faults disabled first
Date: Fri, 17 Jul 2026 10:37:57 -0700
Message-ID: <20260717173758.3644427-1-usama.arif@linux.dev>
In-Reply-To: <20260715155454.4127988-1-usama.arif@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 15 Jul 2026 08:54:54 -0700 Usama Arif <usama.arif@linux.dev> wrote:

> trace_user_fault_read() is called with preemption disabled to copy user
> memory into a per-cpu scratch buffer. The existing implementation enables
> preemption around the copy because faulting user memory can sleep. That
> opens a window where another task can run on the same CPU and clobber the
> per-cpu buffer, so the copy is wrapped in a retry loop: sample
> nr_context_switches_cpu(), do the preempt-enabled copy, and retry if the
> counter changed. If this fails to complete 100 times, the function gives up
> with a warning.
> 
> nr_context_switches_cpu() reads rq->nr_switches. That counter increments
> for every context switch on the CPU, not only for switches to tasks that
> use this tracing scratch buffer. On a heavily loaded system, unrelated
> scheduler activity can move the counter during every preempt-enabled copy
> attempt, exhaust the retry guard, and trigger the warning.
> 
> This is showing up across the Meta fleet around 100 times a day since the
> kernel began upgrading to 7.1, mostly on arm servers:
> 
>   Error: Too many tries to read user space
>   WARNING: kernel/trace/trace.c:6244 at trace_user_fault_read+0x284/0x2c8, CPU#28: Collection-18/677527
>   CPU: 28 UID: 0 PID: 677527 Comm: Collection-18 Kdump: loaded Not tainted 7.1.0-.... #1 PREEMPTLAZY
>   Hardware name: Quanta Java Island MP 29F0EMA08CH/Java Island, BIOS F0EJ3A16 03/12/2026
>   Call trace:
>    trace_user_fault_read+0x284/0x2c8 (P)
>    syscall_get_data+0x144/0x2c0
>    perf_syscall_enter+0xc0/0x2d8
>    syscall_trace_enter+0x1a0/0x270
>    do_el0_svc+0x54/0xb8
>    el0_svc+0x44/0x268
>    el0t_64_sync_handler+0x7c/0x120
>    el0t_64_sync+0x17c/0x180
>   ---[ end trace 0000000000000000 ]---
> 

I think the actual problem might be:
https://lore.kernel.org/all/20260717173252.3431565-1-usama.arif@linux.dev/
 
