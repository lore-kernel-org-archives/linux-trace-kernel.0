Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA63B791
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Dec 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707118; cv=none; b=IxWvN/mAbR6gCOw5hv7BQGp5A4efXkVJ+BRZoDOgzT/21dZ+vPC7rBBwDqPW4UI3zoocBAdj9+gGkt47JoB9HgwGXIPIET9Ov7ars8pCeT0/EO+pq/pfYf5FV2axQonqxWMBwMT95Yrr0ya1FOTNYy7AJall27tbwD/ie5ujWp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707118; c=relaxed/simple;
	bh=Hq27cTk+WIA+qmH+p2nx5m6QcmAqoYPQ5zoBPaG/8Es=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZBHUbHBtLKzP1SLCDyCQhZq2QqcnqoASWV2ISL5ItNftNH2DOgDZaNxoTMFr7j4oXXKYO4b4U8v45+1s1hUvlsXxw4ujkLk08+VA/AP7luMnst8mw6rG1/FbHfrkeuIhBaka2QYvptKJXiGHbrOC90CQz812cPK9aXipcsO5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13EBC4CECD;
	Fri, 20 Dec 2024 15:05:15 +0000 (UTC)
Date: Fri, 20 Dec 2024 10:05:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, Andreas Larsson <andreas@gaisler.com>
Subject: Re: [BUG] spinlock recursion when enabling function tracer on
 32-bit
Message-ID: <20241220100558.10b48f0f@gandalf.local.home>
In-Reply-To: <2d634c54-d8d9-4f33-bfda-9236b6a2ea06@gaisler.com>
References: <86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com>
	<20241218110115.29d4cc77@gandalf.local.home>
	<bb8485bf-d720-4803-aa3c-037ea1169f8a@gaisler.com>
	<20241218163526.2569917f@gandalf.local.home>
	<2d634c54-d8d9-4f33-bfda-9236b6a2ea06@gaisler.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Dec 2024 14:55:27 +0100
Ludwig Rydberg <ludwig.rydberg@gaisler.com> wrote:

> On 2024-12-18 22:35, Steven Rostedt wrote:
> 
> > 
> > Can you test this patch?
> >   
> 
> I have tested the patch on both riscv32 (qemu) & sparc32 (leon) and it seems
> to be working fine.
> 
> But I can mention that I ran into a deadlock situation on sparc32.
> I had to remove CC_FLAGS_FTRACE for the code that is responsible for
> flushing TLBs (SMP). It uses an NMI to signal other CPUs which triggered
> the deadlock if tracing was enabled on that path.

Can you try this patch on top of the last one?

-- Steve

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7e257e855dd1..a9fe54b79ce5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4398,8 +4398,13 @@ rb_reserve_next_event(struct trace_buffer *buffer,
 	int nr_loops = 0;
 	int add_ts_default;
 
-	/* ring buffer does cmpxchg, make sure it is safe in NMI context */
-	if (!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) &&
+	/*
+	 * ring buffer does cmpxchg as well as atomic64 operations
+	 * (which some archs use locking for atomic64), make sure this
+	 * is safe in NMI context
+	 */
+	if ((!IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) ||
+	     IS_ENABLED(CONFIG_GENERIC_ATOMIC64)) &&
 	    (unlikely(in_nmi()))) {
 		return NULL;
 	}
