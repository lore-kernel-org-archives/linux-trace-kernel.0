Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D4A14D283
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 21:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555929; cv=none; b=KNG1/Il8JsTDGt7fIxAVMhoua6jXMMVOZ9hVvm9rS1VkVV5qQYIbbIOmBocFMvN6WVBGLSxA6GGfBo4Ccfvn06Gvnzp/1EYsuvH365WGmqhoBdMTkjfdGwLYYG+RtDfFnc8Pw6XHqvLGKvHFjl2W+xsdPgP0E/8HGUN/laYLq8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555929; c=relaxed/simple;
	bh=6Xco6atdYO2X+voymAVLVXb0q0JYthfVNd0GAAhn5oI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EeviTjNy3QWe6/2WlJUYcpHTMBCVSL044RXiqSNfoDWSJFNse1Wq51metLBTBM9xlayRV9NIIen0GmwfneaSkP83pNdbrWsW79uhoQ0ERMHY94cFIslVBXYHc3NmxtiSJUtBAuewNm5cKUaQkjr9/APGXjYYq4eNT4GxkK+VG/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=EqpdXK7i; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="EqpdXK7i"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YD5md1bkCz1GxMn;
	Wed, 18 Dec 2024 22:05:21 +0100 (CET)
Received: from [10.10.15.7] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YD5mc6jfDz1GxMg;
	Wed, 18 Dec 2024 22:05:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1734555921;
	bh=0KsRNfK1ckGHFYbMU8+kbSARz8JOnZLgnc9Zme9lN5Y=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=EqpdXK7ir/QDE/O5kyNJPE9q63WU+mG+XP7+WStEPuA1F/NPyVQur13eJhMfaZDp4
	 mS2CZjuIDrGT8tWYyUBZonCGLiIwkTNa2IqcjohuwejPJ7uMVXkss2cJwuhZjcGxUj
	 k7YO4jF4a4qCe9Ec0/tpa2giA88FdMo5KrOjlHN4=
Message-ID: <bb8485bf-d720-4803-aa3c-037ea1169f8a@gaisler.com>
Date: Wed, 18 Dec 2024 22:05:20 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: Re: [BUG] spinlock recursion when enabling function tracer on 32-bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, Andreas Larsson <andreas@gaisler.com>
References: <86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com>
 <20241218110115.29d4cc77@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20241218110115.29d4cc77@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-18 17:01, Steven Rostedt wrote:

> Hmm, we do have recursion protection, but it allows one loop to handle
> transitions between normal and interrupt context. If we stop that
> transition for archs that use the generic atomic64, I wonder if that would
> fix things.
> 
> Can you try this patch?

Thanks!

I applied the patch and did some testing and the initial issue I reported
seems to have been fixed but unfortunately I'm still able to trigger
a spinlock recursion.

The following sequence works fine with the patch applied:
# echo function > current_tracer
# echo 1 > tracing_on
# usleep 1
# echo 0 > tracing_on
# cat trace
# ...

But this triggers a spinlock recursion:
# echo 1 > tracing_on
# find /

[   61.276675] BUG: spinlock recursion on CPU#0, find/119
[   61.277571]  lock: 0xc1c076c0, .magic: dead4ead, .owner: find/119, .owner_cpu: 0
[   61.278365] CPU: 0 UID: 0 PID: 119 Comm: find Not tainted 6.13.0-rc3 #5
[   61.278724] Hardware name: riscv-virtio,qemu (DT)
[   61.278994] Call Trace:
[   61.279351] dump_backtrace (arch/riscv/kernel/stacktrace.c:131)
[   61.279848] show_stack (arch/riscv/kernel/stacktrace.c:137)
[   61.280022] dump_stack_lvl (lib/dump_stack.c:122)
[   61.280202] dump_stack (lib/dump_stack.c:130)
[   61.280372] spin_dump (kernel/locking/spinlock_debug.c:71)
[   61.280534] do_raw_spin_lock (kernel/locking/spinlock_debug.c:78 kernel/locking/spinlock_debug.c:87 kernel/locking/spinlock_debug.c:115)
[   61.280714] _raw_spin_lock_irqsave (kernel/locking/spinlock.c:163)
[   61.280905] generic_atomic64_read (lib/atomic64.c:51)
[   61.281091] __rb_reserve_next.constprop.0 (kernel/trace/ring_buffer.c:608 kernel/trace/ring_buffer.c:4265)
[   61.281299] ring_buffer_lock_reserve (kernel/trace/ring_buffer.c:4457 (discriminator 2) kernel/trace/ring_buffer.c:4514 (discriminator 2))
[   61.281496] trace_function (kernel/trace/trace.c:1021 kernel/trace/trace.c:2906)
[   61.281672] function_trace_call (kernel/trace/trace_functions.c:222)
[   61.281859] ftrace_call (arch/riscv/kernel/mcount-dyn.S:178)
[   61.282030] inode_query_iversion (fs/libfs.c:2050)
[   61.282217] ext4_readdir (fs/ext4/dir.c:597 fs/ext4/dir.c:143)
[   61.282393] iterate_dir (fs/readdir.c:109)
[   61.282562] __se_sys_getdents64 (fs/readdir.c:403 fs/readdir.c:389)
[   61.282758] __riscv_sys_getdents64 (fs/readdir.c:389)
[   61.282945] do_trap_ecall_u (./arch/riscv/include/asm/syscall.h:90 (discriminator 1) arch/riscv/kernel/traps.c:331 (discriminator 1))
[   61.283121] handle_exception (arch/riscv/kernel/entry.S:198)

// Ludwig
