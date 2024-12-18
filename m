Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C17935966
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534174; cv=none; b=jfJ+VOGZElKPnfCve0mVWPWtY4IfjJzNkMMgQ6uRjLyazD3FGzx7hNYzu6jTMb0LuG/ngpP/qWRXQwsyFE6ddOvd3Lcqw+6KnZkWu2odeoFUolGSLcCN9ys4svABZ5CZpBnHZygbgvQsuFq8Z5+0JC8lLFyUSrEtIbAl5UY6FrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534174; c=relaxed/simple;
	bh=k0gTi4g0kIS0BKm8Htu5pjxdewKfGkcI4VzBr5atsNA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ktWiq1AcTB9kQ2ZiAd+cj507vS12cPVnyNM8iB7dEwEX+nP/RnPD2EopZnWZZQha9zBUtuTguGXcoGJR4Kf0cDoJKoqvOaV8a4VRW/Tqu0TBUDEK6n+fWcfagE5PiJ5OqWKPe4k6gDS6zxXO3nyAABH53kVH+ymymGP6wP2jvcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=RPC7z0pG; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="RPC7z0pG"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YCxbg33p1z1Fbvt;
	Wed, 18 Dec 2024 15:57:03 +0100 (CET)
Received: from [192.168.0.69] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YCxbg1SwQz1DHVc;
	Wed, 18 Dec 2024 15:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1734533823;
	bh=ytWdVg7/8UkZQEvqx0A4vYI3gJLAzrXMpWRFYEbU39U=;
	h=Date:From:Subject:To:Cc;
	b=RPC7z0pGNZcCLoEU7H0ub9UmTey/GifsD5sGEuGtZUmG+5abtaYhdNVfgRGWEL2En
	 tfmzKSDaiJfFDjP0/GURYLsys9OFCzppGZwnfVVDI5v0ebnka7XlQEaTGYe96bQmUj
	 1aWH+9i6YcA/PfV47gvSVS+sM5eCcwL1JSnflEiA=
Message-ID: <86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com>
Date: Wed, 18 Dec 2024 15:57:02 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: [BUG] spinlock recursion when enabling function tracer on 32-bit
To: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: Andreas Larsson <andreas@gaisler.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear maintainers,

When I try to enable the function tracer using Linux 6.13.0-rc3 on some
32-bit systems (tested on qemu-riscv32 and LEON4-sparc32) a BUG message
about spinlock recursion is printed and the system becomes unresponsive.

Steps to reproduce the issue:
# mount -t tracefs nodev /sys/kernel/tracing
# echo function > /sys/kernel/tracing/current_tracer
[   16.204882] BUG: spinlock recursion on CPU#0, sh/117
[   16.205758] lock: atomic64_lock+0x0/0x400, .magic: dead4ead, .owner:
sh/117,
.owner_cpu: 0
[   16.206564] CPU: 0 UID: 0 PID: 117 Comm: sh Not tainted 6.13.0-rc3 #7
[   16.206777] Hardware name: riscv-virtio,qemu (DT)
[   16.206966] Call Trace:
[   16.207245] dump_backtrace (arch/riscv/kernel/stacktrace.c:131)
[   16.207392] show_stack (arch/riscv/kernel/stacktrace.c:137)
[   16.207497] dump_stack_lvl (lib/dump_stack.c:122)
[   16.207623] dump_stack (lib/dump_stack.c:130)
[   16.207745] spin_dump (kernel/locking/spinlock_debug.c:71)
[   16.207859] do_raw_spin_lock (kernel/locking/spinlock_debug.c:78
kernel/locking/spinlock_debug.c:87 kernel/locking/spinlock_debug.c:115)
[   16.207999] _raw_spin_lock_irqsave (kernel/locking/spinlock.c:163)
[   16.208139] generic_atomic64_read (lib/atomic64.c:51)
[   16.208284] __rb_reserve_next.constprop.0
(kernel/trace/ring_buffer.c:608 kernel/trace/ring_buffer.c:4262)
[   16.208437] ring_buffer_lock_reserve (kernel/trace/ring_buffer.c:4454
(discriminator 2) kernel/trace/ring_buffer.c:4511 (discriminator 2))
[   16.208585] trace_function (kernel/trace/trace.c:1021
kernel/trace/trace.c:2906)
[   16.208715] function_trace_call (kernel/trace/trace_functions.c:222)
[   16.208854] ftrace_call (arch/riscv/kernel/mcount-dyn.S:178)
[   16.208981] __rb_reserve_next.constprop.0
(kernel/trace/ring_buffer.c:608 kernel/trace/ring_buffer.c:4262)
[   16.209133] ring_buffer_lock_reserve (kernel/trace/ring_buffer.c:4454
(discriminator 2) kernel/trace/ring_buffer.c:4511 (discriminator 2))
[   16.209282] trace_function (kernel/trace/trace.c:1021
kernel/trace/trace.c:2906)
[   16.209411] function_trace_call (kernel/trace/trace_functions.c:222)
[   16.209546] ftrace_call (arch/riscv/kernel/mcount-dyn.S:178)
[   16.209666] tracing_set_trace_write (kernel/trace/trace.c:6377)
[   16.209802] vfs_write (fs/read_write.c:677 fs/read_write.c:659)
[   16.209920] ksys_write (fs/read_write.c:731)
[   16.210040] __se_sys_write (fs/read_write.c:739)
[   16.210179] __riscv_sys_write (fs/read_write.c:739)
[   16.210312] do_trap_ecall_u (./arch/riscv/include/asm/syscall.h:90
(discriminator 1) arch/riscv/kernel/traps.c:331 (discriminator 1))
[   16.210441] handle_exception (arch/riscv/kernel/entry.S:198)

The issue seems to have been introduced by the following commit:
c84897c0ff59 ("ring-buffer: Remove 32bit timestamp logic")

I did a quick test to revert the patch and then its possible to enable
the function tracer on Linux 6.13-rc3.

An observation I made is that CONFIG_GENERIC_ATOMIC64 is enabled on the
systems I have tested on and I can see that there is a call to
generic_atomic64_read (i.e local64_read from the ring buffer) in the
call trace leading up to the warning. Not sure if its the root-cause but
it could perhaps be related.

Is this a known problem? I tried to find any previous reports but could
not find any. Please let me know if you need more details.

Best regards,
// Ludwig

--

Test environment:
ARCH=riscv32
Buildroot 2024.11
QEMU 6.2.0
Buildroot config: qemu_riscv32_virt_defconfig
Linux tag: v6.13-rc3
Linux buildroot 6.13.0-rc3 #5 SMP Wed Dec 18 12:58:40 CET 2024 riscv32
GNU/Linux
