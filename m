Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A13D984;
	Tue, 25 Feb 2025 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513326; cv=none; b=M6g89YNQOv3N920NpJs5qsEN2alra9TTA47OhRHnCZTF0kszbG9DpYUnN/H59PXtL7n/rqv/KcDbngjB5xAsu9yQF5XMSEU/SR5bjfKij1F+XbMoBQ4nQIlo2JUky+tUPyPbD2BBwVcOGzNVVQcmVmVOzUuEVW0LhEHMWDXXKWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513326; c=relaxed/simple;
	bh=pklSbDBqlHgEbbdSJwcMsHBd0XSKtxXElLot1vsE/Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fi8tjdDoY6use4rNufE5QrUZIl6Xz5ZTp4MSOYJtRlq8E86m1zyeaZvf3/6GH300iAozChEWSXa5rPvYixgjtqWUOdAo1qLRENNhE9BXyPF9vl0MvSHHT3nfOPcvXOoPk5Pj8sFhuL1Ga34b+7VqrlOI4o1IqxG53oZJL2IWcyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBA0C4CEDD;
	Tue, 25 Feb 2025 19:55:24 +0000 (UTC)
Date: Tue, 25 Feb 2025 14:56:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Michael Petlan <mpetlan@redhat.com>, Veronika
  Molnarova <vmolnaro@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RESEND][PATCH] tracing: gfp: Remove duplication of recording
 GFP flags
Message-ID: <20250225145602.59e61cdb@gandalf.local.home>
In-Reply-To: <20250225135611.1942b65c@gandalf.local.home>
References: <20250225135611.1942b65c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 13:56:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Last version: https://lore.kernel.org/20250116214439.046082618@goodmis.org
> 
>   This was originally sent with a patch that fixed the output of gfp flags
>   in trace events to show human readable flags and not hex numbers.
> 
>   This patch on the other hand is a clean up as the there's now two macros
>   that define the bits to print. This makes the one macro use the other
>   macro that is a subset of the first.
> 
>   Can someone in the memory management subsystem either give me an acked-by
>   and I can take this through my tree, or you can just take this through
>   the memory management tree. Either way works for me.

Interesting, I even ran a before and after of this patch by doing the following:

 # trace-cmd start -e dma -e vmscan -e percpu -e kmem
 [ wait a few minutes ]

 # trace-cmd show |grep gfp > ~/gfp-before

 [ apply patch, compile, install, reboot ]

 # trace-cmd start -e dma -e vmscan -e percpu -e kmem
 [ wait a few minutes ]

 # trace-cmd show |grep gfp > ~/gfp-after

 # perl -e 'while (<>) { if (/gfp_flags=(\S+)/) { print "$1\n"; } }' < gfp-before  | sort -u  > /tmp/before.sort
 # perl -e 'while (<>) { if (/gfp_flags=(\S+)/) { print "$1\n"; } }' < gfp-after  | sort -u  > /tmp/after.sort

 # diff -u /tmp/before.sort /tmp/after.sort 
--- /tmp/before.sort	2025-02-25 14:41:49.799742048 -0500
+++ /tmp/after.sort	2025-02-25 14:41:41.247636893 -0500
@@ -4,38 +4,39 @@
 GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP
 GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
 GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_NOMEMALLOC
-GFP_ATOMIC|__GFP_ZERO|0x2000000
+GFP_ATOMIC|__GFP_ZERO|__GFP_COMP|__GFP_NO_OBJ_EXT
 GFP_HIGHUSER|__GFP_ACCOUNT
 GFP_HIGHUSER_MOVABLE|__GFP_COMP
-GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_WRITE
-GFP_HIGHUSER_MOVABLE|__GFP_COMP|__GFP_ZERO
+GFP_HIGHUSER_MOVABLE|__GFP_WRITE|__GFP_COMP
+GFP_HIGHUSER_MOVABLE|__GFP_ZERO|__GFP_COMP
 __GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
-__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE
-__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE
 GFP_KERNEL
 GFP_KERNEL_ACCOUNT
-GFP_KERNEL_ACCOUNT|__GFP_COMP|__GFP_ZERO
+GFP_KERNEL_ACCOUNT|__GFP_NOWARN|__GFP_NOMEMALLOC
 GFP_KERNEL_ACCOUNT|__GFP_ZERO
-GFP_KERNEL|__GFP_COMP|__GFP_ZERO|0x2000000
+GFP_KERNEL_ACCOUNT|__GFP_ZERO|__GFP_COMP
 GFP_KERNEL|__GFP_NOWARN|__GFP_NOMEMALLOC
-GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP
 GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY|__GFP_NOMEMALLOC
 GFP_KERNEL|__GFP_ZERO
+GFP_KERNEL|__GFP_ZERO|__GFP_COMP|__GFP_NO_OBJ_EXT
+GFP_KERNEL|__GFP_ZERO|__GFP_NO_OBJ_EXT
 GFP_NOFS
-GFP_NOFS|__GFP_COMP|__GFP_ZERO|0x2000000
-GFP_NOFS|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL|__GFP_MOVABLE
-GFP_NOFS|__GFP_NOFAIL|__GFP_ZERO
-GFP_NOFS|__GFP_NOFAIL|__GFP_ZERO|__GFP_ACCOUNT
-GFP_NOFS|__GFP_NOFAIL|__GFP_ZERO|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_ACCOUNT
+GFP_NOFS|__GFP_MOVABLE|__GFP_NOFAIL|__GFP_COMP|__GFP_HARDWALL
+GFP_NOFS|__GFP_MOVABLE|__GFP_ZERO|__GFP_NOFAIL|__GFP_HARDWALL|__GFP_ACCOUNT
+GFP_NOFS|__GFP_NOFAIL
 GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP
-GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_RECLAIMABLE
 GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_NOMEMALLOC
+GFP_NOFS|__GFP_RECLAIMABLE|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP
 GFP_NOFS|__GFP_ZERO
-GFP_NOFS|__GFP_ZERO|0x2000000
+GFP_NOFS|__GFP_ZERO|__GFP_NOFAIL
+GFP_NOFS|__GFP_ZERO|__GFP_NOFAIL|__GFP_ACCOUNT
+GFP_NOFS|__GFP_ZERO|__GFP_NO_OBJ_EXT
 GFP_NOWAIT
 GFP_NOWAIT|__GFP_ACCOUNT
-GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP
+GFP_NOWAIT|__GFP_COMP
 GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC
-GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP|__GFP_RECLAIMABLE
 GFP_NOWAIT|__GFP_NORETRY|__GFP_NOMEMALLOC
-GFP_NOWAIT|__GFP_ZERO|0x2000000
+GFP_NOWAIT|__GFP_RECLAIMABLE|__GFP_NORETRY|__GFP_COMP
+GFP_NOWAIT|__GFP_ZERO|__GFP_ACCOUNT
+GFP_NOWAIT|__GFP_ZERO|__GFP_NO_OBJ_EXT
+__GFP_RECLAIMABLE|__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC

Notice that the old way has:

-GFP_NOFS|__GFP_COMP|__GFP_ZERO|0x2000000

And I looked at what that 0x2000000 is, and for my current config, it is:

  __GFP_NO_OBJ_EXT

Which was completely missing from the old way, and this patch actually
picks it up!

That's because the TRACE_GFP_FLAGS has it, but the __def_gfpflag_names
macro was missing it. Again, it's better to remove having to maintain two
lists instead of just one.

-- Steve

