Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852682E7368
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203542; cv=none; b=uXRa0VpSSsoR8ofy3UTsB41YauWKuYC0wZtupiN0MCc2XSwvhj15W/d47UMennfNYw6J1FABMExmzcyQYZ0/ztkDMJErVjRPLyq7r8sK7NHFedX8VWA7dvhDsS7fjxKZ/M9MgHnZJPjWkqybW6axypAxUVJ3G2XJ/rK8s9h7SHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203542; c=relaxed/simple;
	bh=SrZ9st9APpqmT6tqf8ajrLfTTDJ+9dl+XoXuc6Hk2Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2G5C95/YmJ8/uiAhWocnughHyPAhX0D8db+RXR42MvLBcPqZ0bDOoro0rZvBn89h3F+771zohNfyv2i5p5SttLP9N8+S8SAioS7BnXyyDfoqIdgtBPvtLK2/OvmqVLTXKuHxoY5hAW4dq+gDg5MeXeYmCTVOnuJyaMNTUEsRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fWdU3XR2; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fWdU3XR2"
Message-ID: <dd3e12c2-e5fa-4ed7-8de7-a24a40fb9959@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784203525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECiSHVYcdqBHAwN+3AeE9F+29i7Cb5kboeGaslbuWEU=;
	b=fWdU3XR2I7/m3pSlUzqJi2Wd2PLhYEcfsS9OffvChtQkx1YP0/l3zV38obIyKNI6xw2tL9
	OOEbdVJi9fudBzG6Rf2+mHARoKNlI1JntvnHYs1ya9RLVNtCIsjj90y6jWadqovSwwHB+i
	KAnM64+BVoP92Rh9N1lqq7aBKO8O/uk=
Date: Thu, 16 Jul 2026 13:05:15 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC] tracing: Try user copies with page faults disabled first
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, leitao@debian.org
References: <20260715155454.4127988-1-usama.arif@linux.dev>
 <20260715151120.0c7b80cb@gandalf.local.home>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260715151120.0c7b80cb@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 15/07/2026 20:11, Steven Rostedt wrote:
> On Wed, 15 Jul 2026 08:54:54 -0700
> Usama Arif <usama.arif@linux.dev> wrote:
> 
>> trace_user_fault_read() is called with preemption disabled to copy user
>> memory into a per-cpu scratch buffer. The existing implementation enables
>> preemption around the copy because faulting user memory can sleep. That
>> opens a window where another task can run on the same CPU and clobber the
>> per-cpu buffer, so the copy is wrapped in a retry loop: sample
>> nr_context_switches_cpu(), do the preempt-enabled copy, and retry if the
>> counter changed. If this fails to complete 100 times, the function gives up
>> with a warning.
>>
>> nr_context_switches_cpu() reads rq->nr_switches. That counter increments
>> for every context switch on the CPU, not only for switches to tasks that
>> use this tracing scratch buffer. On a heavily loaded system, unrelated
>> scheduler activity can move the counter during every preempt-enabled copy
>> attempt, exhaust the retry guard, and trigger the warning.
>>
>> This is showing up across the Meta fleet around 100 times a day since the
>> kernel began upgrading to 7.1, mostly on arm servers:
>>
>>   Error: Too many tries to read user space
>>   WARNING: kernel/trace/trace.c:6244 at trace_user_fault_read+0x284/0x2c8, CPU#28: Collection-18/677527
>>   CPU: 28 UID: 0 PID: 677527 Comm: Collection-18 Kdump: loaded Not tainted 7.1.0-.... #1 PREEMPTLAZY
>>   Hardware name: Quanta Java Island MP 29F0EMA08CH/Java Island, BIOS F0EJ3A16 03/12/2026
>>   Call trace:
>>    trace_user_fault_read+0x284/0x2c8 (P)
>>    syscall_get_data+0x144/0x2c0
>>    perf_syscall_enter+0xc0/0x2d8
>>    syscall_trace_enter+0x1a0/0x270
>>    do_el0_svc+0x54/0xb8
>>    el0_svc+0x44/0x268
>>    el0t_64_sync_handler+0x7c/0x120
>>    el0t_64_sync+0x17c/0x180
>>   ---[ end trace 0000000000000000 ]---
>>
>> The retry loop is only needed when preemption must be enabled for the user
>> copy. If the user pages are already resident, the copy can complete without
>> fault handling that sleeps, and preemption can stay disabled throughout.
>>
>> Add a fast path that first tries the copy with page faults disabled. For
>> the plain copy_from_user case, use __copy_from_user_inatomic(). If the
>> probe faults, the architecture exception-table fixup returns a non-zero
>> not-copied count and trace_user_fault_read() falls back to the existing
>> preempt-enabled slow path.
>>
>> Custom copy callbacks need the same behavior. Update the syscall argument
>> copy callbacks to report a non-zero return only when the pagefault-disabled
>> probe faults. With page faults enabled, keep their previous behavior:
>> record the syscall event and omit only the individual user argument that
>> still cannot be copied.
>>
>> The slow path remains in place for nonresident pages and permanent copy
>> failures. nr_context_switches_cpu() still overcounts, but the retry loop is
>> now avoided for the common resident-page case that does not need fault
>> handling.
> 
> This was reported also under memory load.
> 
> I have a patch that will only do a retry if another *user* task schedules
> in, and will not be bothered by kernel tasks (which may be scheduled in due
> to the copy from user to begin with).
> 
> Can you see if that works too?
> 
>   https://lore.kernel.org/all/20260710083357.49e05ff6@gandalf.local.home/
> 
Thanks, I will try and put this in the next kernel, although it will take sometime
for the new kernel to roll in the fleet and to see if the warnings disappear.
