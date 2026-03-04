Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCFC373C0B;
	Wed,  4 Mar 2026 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772664955; cv=none; b=sqklPUvqOOevtBVrmjRxQxKbr5MOt5j2aWCDvP7JlDPV4F7Ny/KR+lUBRbOcCAIM9BwO9s8MUSjRjktdBaR0RAlgs0ldCE6KCAEsgNOthWfkAU/KZ6Zr2SYpaeweIshFEG7dIKdyY9FmK9TsYk3N698p9pNY6WoGKF23pQKqfaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772664955; c=relaxed/simple;
	bh=Th0k5BwLXjcKqKxNPyWtlPrNyyCtPIZvtetPczGQdsQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cnSgtw97hEZc8kdUZiaSOMKEDyvnOZ7gw2XkrtDldDGPkQMelRSr0shTr/Iutj1H9l0zK7ixzkWmMD8EhBsMwy2zLeTkvdox2FZX06Sk0Tv1GoIRnTVRE9EUHH5vIF4SkMKYrnuyek/EE6x1MHA0T40w5Tf02xFhLJlVZnFmi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWhjr6g0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWhjr6g0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96504C4CEF7;
	Wed,  4 Mar 2026 22:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772664955;
	bh=Th0k5BwLXjcKqKxNPyWtlPrNyyCtPIZvtetPczGQdsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WWhjr6g0YC/LGPHBiN1pOKYTPC9D7XGrawhQ9VLi6aULm0neouoE2TgJ2spzkdHk5
	 DdX/AlePnhz7ZyyXe3lq3uO+KAyX4vJv5uF3SVt6AowTxQBphvW2PsWjh+GAJ8bR1o
	 bGnHKj/e1Dqj1+DLjbnMlJK4n4UefH5hrkG8fIFFctIXAkmU6EBSZV9BXd85uHX3sm
	 U4Qsoxlfpmbl13fvlzO6KECwLGyZZbFyX4W4MOSoJEs5HCN4AUgJ+A3Vo81unCgIAt
	 IFSk8a+CiWezGNMSHNTtRuqHQ741kixcB5IFYeigIrYXVJwcYLjzILj/mIRs0MnFWJ
	 98Lj/W3RqnJbw==
Date: Thu, 5 Mar 2026 07:55:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph
 Lameter <cl@gentwo.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
 <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC 1/3] locking: Add contended_release tracepoint
Message-Id: <20260305075552.0840e6b107dd9560e09e4f86@kernel.org>
In-Reply-To: <f8605471fd84ebff963c011aa98f79ed17f493c7.1772642407.git.d@ilvokhin.com>
References: <cover.1772642407.git.d@ilvokhin.com>
	<f8605471fd84ebff963c011aa98f79ed17f493c7.1772642407.git.d@ilvokhin.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Mar 2026 16:56:15 +0000
Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Add the contended_release trace event. This tracepoint fires on the
> holder side when a contended lock is released, complementing the
> existing contention_begin/contention_end tracepoints which fire on the
> waiter side.
> 
> This enables correlating lock hold time under contention with waiter
> events by lock address. Subsequent patches wire this tracepoint into
> the individual lock implementations.
> 

OK, but I don't recommend you to split the traceevent definition
and its usage. Could you combine [1/3] and [3/3], so that we can
understand why this event is introduced and where it is recorded
by checking one commit?

Thank you,

> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---
>  include/trace/events/lock.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
> index 8e89baa3775f..4f28e41977ec 100644
> --- a/include/trace/events/lock.h
> +++ b/include/trace/events/lock.h
> @@ -138,6 +138,23 @@ TRACE_EVENT(contention_end,
>  	TP_printk("%p (ret=%d)", __entry->lock_addr, __entry->ret)
>  );
>  
> +TRACE_EVENT(contended_release,
> +
> +	TP_PROTO(void *lock),
> +
> +	TP_ARGS(lock),
> +
> +	TP_STRUCT__entry(
> +		__field(void *, lock_addr)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->lock_addr = lock;
> +	),
> +
> +	TP_printk("%p", __entry->lock_addr)
> +);
> +
>  #endif /* _TRACE_LOCK_H */
>  
>  /* This part must be outside protection */
> -- 
> 2.47.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
