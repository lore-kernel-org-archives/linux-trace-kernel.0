Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29C2D061D;
	Tue, 14 Apr 2026 01:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776129557; cv=none; b=cDTWr6bvCxzjsiMPVJQkF1SOOgQUPXF+9OjiE5pRZF4FaepAcET3bajSus1bQbsCqueHE5WZIZsHVXj/w5cuL7JqjeXw0ksF5AS2PfuusSx16CvHsm3CovSiM19XBaNXcwH7d/hbJt328V7KbQoumtmdW0LI368BTsGmyzSLfxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776129557; c=relaxed/simple;
	bh=TOiniBOp9vBKt4wGkX8HvPpdqyq5CdwHT28M8AcXvOA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E8MHcBz4I6yyZVjEmgR8wWqWzZMVoPKu5opB0brctKWAwIQzNvN0TXUjQQG5hyKgbCC6Sn9GlGJs6bkmR8N8N/CbwGGNvzcxen13zRq09LuqfbqDmQuuUf4EFH3UtZmeLOlTQQavSHiqo/od78NCtwrwed/hbWpBhz/3OCSE1vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb84WPG9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb84WPG9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334B3C2BCAF;
	Tue, 14 Apr 2026 01:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776129557;
	bh=TOiniBOp9vBKt4wGkX8HvPpdqyq5CdwHT28M8AcXvOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gb84WPG9913bkWdp4fmkNinbjKZrnmf0RGQ0DvyjEm5NroJPsTuUk021TdYwPvYgM
	 +taZyBRE2UhBnp+XKcWi9vyaezCq/qsQ5MuebbZeB5XxbiPpu8MgHtAJwJ+6ArFUaG
	 iBDYzklUfgm2Nrty795uh/eQbuCjJlfSTHSoFdiExuAxlSQLPEpMRSEYckzPulVznm
	 x9nZcqzKnFqKaNiCthlCwrY47yTuPMVWTtmVjjUn03i2kGSymYN/SemqR4871iU8+5
	 LfWHzMB08DUD5zwBfIHaeYjKJKNzy04zWf11UGu8Sq96XbHSKB+Wku98Nnir0Q9Hm8
	 g/6sGymfaztug==
Date: Tue, 14 Apr 2026 10:19:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Menglong Dong
 <menglong8.dong@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] tracing/fprobe: Fix fprobe_ip_table related bugs
Message-Id: <20260414101912.c97d1248d34e35393e494e10@kernel.org>
In-Reply-To: <177606956628.929411.17392736689322577701.stgit@devnote2>
References: <177606956628.929411.17392736689322577701.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 17:39:26 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Here is the 5th series of patches to fix bugs in fprobe.
> The previous version is here.
> 
> https://lore.kernel.org/all/177584108931.388483.11311214679686745474.stgit@devnote2/
> 
> This version fixes to remove fprobe_hash_node forcibly when fprobe
> registration failed [1/3] and skips updating ftrace_ops when fails
> to allocate memory in module unloading [2/3].

Hmm, Sashiko pointed out some issues in fprobe, which seems not introduced
this series but existing UAF cases.

https://sashiko.dev/#/patchset/177606956628.929411.17392736689322577701.stgit%40devnote2

Especially,

> In fprobe_return(), the code traverses the fprobe_table which contains
> RCU-protected struct fprobe_hlist nodes. These nodes are freed using
> kfree_rcu(hlist_array, rcu) in unregister_fprobe_nolock().
>
> To safely traverse this RCU-protected list, readers must hold the RCU read
> lock. However, fprobe_return() only calls preempt_disable_notrace(). While
> disabling preemption acts as an RCU-sched read-side critical section on
> non-RT kernels, it does not prevent regular RCU grace periods from
> completing on PREEMPT_RT. Thus, kfree_rcu() can free the hlist_array while
> fprobe_return() is actively iterating over it.

I would like to ask Steve a comment about this. Is fgraph return handler
context RCU safe?

Thanks,

> 
> Thanks,
> ---
> 
> Masami Hiramatsu (Google) (3):
>       tracing/fprobe: Remove fprobe from hash in failure path
>       tracing/fprobe: Avoid kcalloc() in rcu_read_lock section
>       tracing/fprobe: Check the same type fprobe on table as the unregistered one
> 
> 
>  kernel/trace/fprobe.c |  251 +++++++++++++++++++++++++++++--------------------
>  1 file changed, 147 insertions(+), 104 deletions(-)
> 
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
