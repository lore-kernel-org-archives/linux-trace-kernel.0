Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4E311958;
	Thu, 11 Sep 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597897; cv=none; b=Thgbzo15b4i0e5po6xJWt6zHotxiQMRF4JLOgVcprQziSCo9ri6HQmozdhmOTJpUsbM/rWf4/QHB//VRWNTX923/UYDtOGqlSUG7G/NrDyflfcbYtYW2MCLc7pWDUzELLD+toB01qGtLCFsHWyutHfHThMBgXvKrm9tCbxVTIOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597897; c=relaxed/simple;
	bh=JHwWqnTYn3Fug9+bvZh4zonn/Ba9kH7IhAH8TdW5lkM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aaYHjCSXnMdApGeCokGSd+C1UFQdSXc6uSjtE1zV704yC3Do1PgF8aXRRDqvRV0dOaI3xBTKbnDohH7HqDekDix5gWLgIJ74i6a6hJs9TXhM/6iYotNUzHgPzlVx5ktggcoZevSFdbPpLyOUUw8HB1uIWSErcE5mi0/mImsnOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngpVkeOr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngpVkeOr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7FEC4CEF0;
	Thu, 11 Sep 2025 13:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757597897;
	bh=JHwWqnTYn3Fug9+bvZh4zonn/Ba9kH7IhAH8TdW5lkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngpVkeOrZI/HZin0pxo06kf9Fz4kB7zHNNeZ6SM0o/jGOSnc5/k5UNUZTDJO3X2RV
	 SnEyaZiddFF3Q88VmQ3HA6gm96mFYTv97rj5cokh1yFeCd5gsq8rZbliqX0+tOkYjN
	 rN0HOQnKmFyoa/+A5gjK28QDyWBQRblo0Bs+46poybkP7IoN9qHZ2q5wto9Yc4pnFA
	 8Lrjstp75JQn2X8pg8eIOSwp/3gRdbbwYeFA+GBfC2qnKv7zWfhP0w64NE/n/XnMvj
	 mZlG/5WVFq3RXCYlD+gMrT7HxPWwruR+BJXCfBba6kEBjUUMsMohkXJbpVPRf3u3PL
	 5cnkkMcZLvPQg==
Date: Thu, 11 Sep 2025 22:38:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Vladimir Riabchun <ferr.lambarginio@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Fix softlockup in ftrace_module_enable
Message-Id: <20250911223813.58c894b4c8ce8e3eba298c71@kernel.org>
In-Reply-To: <aMLPm__QGrQCwz1t@vova-pc>
References: <aMLPm__QGrQCwz1t@vova-pc>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 15:33:15 +0200
Vladimir Riabchun <ferr.lambarginio@gmail.com> wrote:

> A soft lockup was observed when loading amdgpu module,
> this is the same issue that was fixed in
> commit d0b24b4e91fc ("ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY
> kernels") and commit 42ea22e754ba ("ftrace: Add cond_resched() to
> ftrace_graph_set_hash()").
> 
> Fix it the same way by adding cond_resched() in ftrace_module_enable.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
> ---
>  kernel/trace/ftrace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index a69067367c29..23c4d37c7bcd 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7526,6 +7526,9 @@ void ftrace_module_enable(struct module *mod)
>  
>  	do_for_each_ftrace_rec(pg, rec) {
>  		int cnt;
> +
> +		cond_resched();
> +
>  		/*
>  		 * do_for_each_ftrace_rec() is a double loop.
>  		 * module text shares the pg. If a record is
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
