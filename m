Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59D1F37AD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 16:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734537638; cv=none; b=cCSrGwm+GcX2bHvLvep/oNaoJtH9QSv9mpyrXEZQr9sjv2LCo/WRnpfWVxWb1iKahGw9QXHRgPi0VoizZb/6CB9dI5k/jHyBwS8UkkjKh8+qF0+trfu1InS1CcDLdnjygOANZCBmfDjyeuVhiWgz9/Tim9yanfjwsEBUGfMqRIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734537638; c=relaxed/simple;
	bh=l+D0WwP87W3VTI34EYDSx6O1+eUtrL4FlAto3t31tzA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odxY/sCbHoI3v5LFQ0Xig6NGCgBJA0TUeJrAXXrHqDsU7BNvP3+rZUqy1q6roFW6AePCfB3CyHM4AKItlbf/qo9+daPk/ZtysYwkRLU0zrYFuSfjUwzBgyZ2sdmmuBrByk6KX1auEVN/WuhuTPQsI1ZSQnMfqXfZ9RAWlZaGx50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70958C4CECD;
	Wed, 18 Dec 2024 16:00:37 +0000 (UTC)
Date: Wed, 18 Dec 2024 11:01:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, Andreas Larsson <andreas@gaisler.com>
Subject: Re: [BUG] spinlock recursion when enabling function tracer on
 32-bit
Message-ID: <20241218110115.29d4cc77@gandalf.local.home>
In-Reply-To: <86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com>
References: <86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Dec 2024 15:57:02 +0100
Ludwig Rydberg <ludwig.rydberg@gaisler.com> wrote:

> Dear maintainers,
> 
> When I try to enable the function tracer using Linux 6.13.0-rc3 on some
> 32-bit systems (tested on qemu-riscv32 and LEON4-sparc32) a BUG message
> about spinlock recursion is printed and the system becomes unresponsive.
> 
> Steps to reproduce the issue:
> # mount -t tracefs nodev /sys/kernel/tracing
> # echo function > /sys/kernel/tracing/current_tracer
> [   16.204882] BUG: spinlock recursion on CPU#0, sh/117
> [   16.205758] lock: atomic64_lock+0x0/0x400, .magic: dead4ead, .owner:
> sh/117,
> .owner_cpu: 0
> [   16.206564] CPU: 0 UID: 0 PID: 117 Comm: sh Not tainted 6.13.0-rc3 #7
> [   16.206777] Hardware name: riscv-virtio,qemu (DT)
> [   16.206966] Call Trace:
> [   16.207245] dump_backtrace (arch/riscv/kernel/stacktrace.c:131)
> [   16.207392] show_stack (arch/riscv/kernel/stacktrace.c:137)
> [   16.207497] dump_stack_lvl (lib/dump_stack.c:122)
> [   16.207623] dump_stack (lib/dump_stack.c:130)
> [   16.207745] spin_dump (kernel/locking/spinlock_debug.c:71)
> [   16.207859] do_raw_spin_lock (kernel/locking/spinlock_debug.c:78
> kernel/locking/spinlock_debug.c:87 kernel/locking/spinlock_debug.c:115)

> [   16.207999] _raw_spin_lock_irqsave (kernel/locking/spinlock.c:163)
> [   16.208139] generic_atomic64_read (lib/atomic64.c:51)

Grumble. This is due to your architecture using the atomic64 code that
takes spin locks.

I'm not bringing back the logic that the commit you specified removed.

Hmm, we do have recursion protection, but it allows one loop to handle
transitions between normal and interrupt context. If we stop that
transition for archs that use the generic atomic64, I wonder if that would
fix things.

Can you try this patch?

-- Steve

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7e257e855dd1..c402874a979b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3935,6 +3935,9 @@ trace_recursive_lock(struct ring_buffer_per_cpu *cpu_buffer)
 	bit = RB_CTX_NORMAL - bit;
 
 	if (unlikely(val & (1 << (bit + cpu_buffer->nest)))) {
+		/* Do not allow any recursion for archs using locks for atomic64 */
+		if (IS_ENABLED(CONFIG_GENERIC_ATOMIC64))
+			return true;
 		/*
 		 * It is possible that this was called by transitioning
 		 * between interrupt context, and preempt_count() has not
