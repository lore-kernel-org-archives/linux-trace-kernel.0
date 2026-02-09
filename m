Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A20284898;
	Mon,  9 Feb 2026 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653454; cv=none; b=U7ZZ2LtOUI8OWTGQLQ3nnnNO+oYKxtlG8H98nNhSx/YkTs7xsxkluBV1HNLDi46zAVeUOzdV7AzD384DmKHx4oYQvKF5w4zOwJ5Zn4fpeSeBd/ggvH0V1sUm9GQBBlrf0ZXfZbnlAihlYuZP3zmQprFfbc8pcRs1l2kUEyc6rGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653454; c=relaxed/simple;
	bh=fYD1ko73PP2FyHN2uMGX1OSDNVAXfJ0a+a+tWcPCwdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syMuwaXFLQKIP/LKMCk51rlylDDKvSrSS24lga/vQ6NWLmfxjiWyXe3L5rdSUlhOufghuKDeJIRiPxxVPKLQWXc3b/Y6rFkeG3xP1DE+PR6NUCHDCRMVkWjXdV1IZJqEyFkaFS2VlgAsp2ipMXHm7F7oIhLPBDJc66hd/KTH2yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id E49AA8A866;
	Mon,  9 Feb 2026 16:10:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id BBCC82000D;
	Mon,  9 Feb 2026 16:10:50 +0000 (UTC)
Date: Mon, 9 Feb 2026 11:10:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>, Peter Zijlstra
 <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@elte.hu>, Thomas
 Gleixner <tglx@kernel.org>, Arnaldo Carvalho de Melo
 <acme@ghostprotocols.net>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix soft lockup when lseeking trace file
Message-ID: <20260209111049.5ec83195@gandalf.local.home>
In-Reply-To: <20260209093101.1623454-1-wutengda@huaweicloud.com>
References: <20260209093101.1623454-1-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8h77c4qni37bbehh9ptubar6ckzc3znz
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BBCC82000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18SNlhvEMj/og+ZsbNaIsyteZEzPR4Uypg=
X-HE-Tag: 1770653450-107203
X-HE-Meta: U2FsdGVkX1/FP5YNQYPX46gYvXBy6WvxOIWl8R8A3DI+u2hfIlw1gWv3PF9nvyz96PV22HCbPMZFY16ZGemXjORv9uL2kKjrrzVW/NajDFmUOOX4DBETmKTv1qVKBG1shkF8Cy3ELDIYlTmcozOH257IGWRbNPCAc+nh2Ht0lmgK/ZowscvPzbczGEkBvJIbcW9ybmni00kIAyNTgSiuw0kYRKOoQStsJh1+osRyhO5Wkk4WGKZ3ESC16gO40+sLYd3zP8P+SFnnrQTwVPCZo7b0OG0CZ+m8UAIYtUeFmlAPYTyuOcH5v0ma7mocSlZ1pTDKZg0GVeVdTXJkfLq+Xar+PqSjgkgb


Peter,

When is PREEMPT_NONE going to be removed? If that's going into 7.0, I want
to stop accepting these scattered cond_resched() additions.

-- Steve


On Mon,  9 Feb 2026 17:31:01 +0800
Tengda Wu <wutengda@huaweicloud.com> wrote:

> A soft lockup may occur when accessing trace file via lseek while
> tracing is active and a large offset is provided. The call trace
> is shown below:
> 
> watchdog: BUG: soft lockup - CPU#3 stuck for 26s! [poc:141]
> CPU: 3 UID: 0 PID: 141 Comm: poc Not tainted 6.19.0 #1 PREEMPT(none)
> Call Trace:
>   ring_buffer_iter_peek
>   peek_next_entry
>   __find_next_entry
>   trace_find_next_entry_inc
>   s_next
>   traverse.part.0
>   seq_lseek
>   tracing_lseek
>   __x64_sys_lseek
>   do_syscall_64
>   entry_SYSCALL_64_after_hwframe
> 
> The root cause is that the lseek implementation for trace files
> is based on seq_lseek, which contains a loop that repeatedly calls
> show() and next() functions until the position reaches the target
> offset. Since no scheduling point is set within this loop, a large
> offset can cause the CPU to be stuck in the loop for an extended
> period, triggering the soft lockup detector.
> 
> Fixed by adding cond_resched() in s_next().
> 
> Fixes: bc0c38d139ec ("ftrace: latency tracer infrastructure")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  kernel/trace/trace.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8bd4ec08fb36..3afe148ef683 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3928,6 +3928,8 @@ static void *s_next(struct seq_file *m, void *v, loff_t *pos)
>  
>  	iter->pos = *pos;
>  
> +	cond_resched();
> +
>  	return ent;
>  }
>  

