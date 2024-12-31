Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8F2C181;
	Tue, 31 Dec 2024 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735659971; cv=none; b=YSPgVDo3+tYOuqF4LaQaj8L4hLpouFX2Tttb77KFgtPmNa72eIuyi3WTF9bu93mIbNdyAvJyPAP9KnOFcXspbxGfTYCvzIjpiKKGF8pU5GHncH6JwNqERqCf2AfYcgsgeuMxYovlLNqvIP7qLptwy2qtIOi2JBhFl1nmTmz7t1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735659971; c=relaxed/simple;
	bh=hxxhfWM8ZAqoudfVE8I59DFXAhEIOUN87uOxxHsqLpI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BVHEFbL/no5n9bqEx8xuVfUOf3nPXoXNofJttXAoy05FfdqqATO24Ytp9VFaey1P1AdSQ+mVhgwuxbI7Ch9jui88fdEdgKPO4Tel59G6Lp3mnIIM2Drxi1wvpQIwToMJwS+jJg5eDdCTILcHhdUleJLGevzH3hwH4fC600ELgzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8T9DwRC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8T9DwRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B29C4CED2;
	Tue, 31 Dec 2024 15:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735659971;
	bh=hxxhfWM8ZAqoudfVE8I59DFXAhEIOUN87uOxxHsqLpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i8T9DwRCjjvkUgDbaxkuVhuBt6v2lQFwzq5GhCNyBAn31lKcgB10+2EeBcY8aS5u6
	 N2Jys426jlLN2fQIZHBbMZHxFzZ7oVXO6SmRP/lOEQBXdMpVqy8Ulfkp55FmrD85zr
	 liP84CvsDgUnQPsyBNb3lOHPw4FWQLnynNJaj04fxIk2jdYIW0X3z/fj0kZwAZwsz0
	 8zflq8FpPGQbsga86RLCnr/xNbxnDO8pXkaKUKfvxDZDnovRbLEp+85VYc86kQ2Tdl
	 L0BV0pev/kAhIx8p2qyrJw7RSIIFF9jv4JFdYONEOezf2dxIOJFJv6eSoPdG6iKDD3
	 4q0/vig4HVIKA==
Date: Wed, 1 Jan 2025 00:46:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Genes Lists <lists@sapience.com>, Gene C <arch@sapience.com>
Subject: Re: [PATCH] tracing: Have process_string() also allow arrays
Message-Id: <20250101004607.d20559613bdde9b349c420c5@kernel.org>
In-Reply-To: <20241231000646.324fb5f7@gandalf.local.home>
References: <20241231000646.324fb5f7@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Dec 2024 00:06:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In order to catch a common bug where a TRACE_EVENT() TP_fast_assign()
> assigns an address of an allocated string to the ring buffer and then
> references it in TP_printk(), which can be executed hours later when the
> string is free, the function test_event_printk() runs on all events as
> they are registered to make sure there's no unwanted dereferencing.
> 
> It calls process_string() to handle cases in TP_printk() format that has
> "%s". It returns whether or not the string is safe. But it can have some
> false positives.
> 
> For instance, xe_bo_move() has:
> 
>  TP_printk("move_lacks_source:%s, migrate object %p [size %zu] from %s to %s device_id:%s",
>             __entry->move_lacks_source ? "yes" : "no", __entry->bo, __entry->size,
>             xe_mem_type_to_name[__entry->old_placement],
>             xe_mem_type_to_name[__entry->new_placement], __get_str(device_id))
> 
> Where the "%s" references into xe_mem_type_to_name[]. This is an array of
> pointers that should be safe for the event to access. Instead of flagging
> this as a bad reference, if a reference points to an array, where the
> record field is the index, consider it safe.

OK, at least if foo[] is accessible in TP_printk, it should be a global
array. So I think the below works.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Link: https://lore.kernel.org/all/9dee19b6185d325d0e6fa5f7cbba81d007d99166.camel@sapience.com/
> 
> Cc: stable@vger.kernel.org
> Fixes: 65a25d9f7ac02 ("tracing: Add "%s" check in test_event_printk()")
> Reported-by: Genes Lists <lists@sapience.com>
> Tested-by: Gene C <arch@sapience.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 1545cc8b49d0..770e7ed91716 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -364,6 +364,18 @@ static bool process_string(const char *fmt, int len, struct trace_event_call *ca
>  		s = r + 1;
>  	} while (s < e);
>  
> +	/*
> +	 * Check for arrays. If the argument has: foo[REC->val]
> +	 * then it is very likely that foo is an array of strings
> +	 * that are safe to use.
> +	 */
> +	r = strstr(s, "[");
> +	if (r && r < e) {
> +		r = strstr(r, "REC->");
> +		if (r && r < e)
> +			return true;
> +	}
> +
>  	/*
>  	 * If there's any strings in the argument consider this arg OK as it
>  	 * could be: REC->field ? "foo" : "bar" and we don't want to get into
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
