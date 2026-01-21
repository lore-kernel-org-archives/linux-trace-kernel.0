Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6CC158538;
	Wed, 21 Jan 2026 02:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768962641; cv=none; b=FwW8VbkHFWwy84L6OrIXtHb9SkZr5/pbQ/IB/Pt/xMSB8mNygGpOLKkOUwh6WXfrvDqTwU7xhzPs03PyModMK26XMBrBj5gQ9Km3PGz3yazTLI1CuyZwzcuQOUOfzm0xjYfzHJQAMjGasQ71bvVhSLJmuwINBB8+YQH1mrFHr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768962641; c=relaxed/simple;
	bh=cbTWKDLTrTeZd2zzPxXxETDtvGMsfmP4WT5IDdll8k4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hiWKaU7xiIsjFQ9UPKHD7JTeyPFr3obkBjgqOTtD3GxVblndBcPlUTSokVNhLjpfoQHgA6TceziD1GCwrlCL+74sMjcuHyWZKgtgWu3T41xNu4MY/n29IvvZAZb1bChqY3cRAwrYNEhgAqhtmdZXDYfT0xqWM3ZtCprzViB82lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2mtVQ0Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2mtVQ0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CE4C19423;
	Wed, 21 Jan 2026 02:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768962639;
	bh=cbTWKDLTrTeZd2zzPxXxETDtvGMsfmP4WT5IDdll8k4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u2mtVQ0YC2TonxreTrNKn6SKqxWLTx6lWXBQ2AWZ8pZht16R66vilRWLL4OkH9O7P
	 lIR7uoBSB3IH0vdVMettpsbjJ8Z8WDUxyRHkvA2oLfAk1x3Hc73qnIMzE8m4IJTMoE
	 SQtKUkq/EIz22Dg4xoL5y+a1So1V8TNTdKgTvYdy9ok9mrXVJqXk6YWqflIyjGogSl
	 aHMnamoFjwkwRepUTUBk5yxxIT1ZCC810x8swsvOY0+NtIy/R3uhONaTggvTIQjb8o
	 9CVbMt0wT+VH0Qq1RG19PXmODjGrlArp+6cGSHFRS+insIQxlHXgY5XjpXI5By5JPK
	 NiqjZSP2KC03A==
Date: Wed, 21 Jan 2026 11:30:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Weigang He <geoffreyhe2@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Tuo Li
 <islituo@gmail.com>
Subject: Re: [PATCH] scripts/tracepoint-update: fix memory leak in
 make_trace_array()
Message-Id: <20260121113035.20f1f464c5f416998d577784@kernel.org>
In-Reply-To: <20260118105457.755291a5@robin>
References: <20260118130247.1003369-1-geoffreyhe2@gmail.com>
	<20260118105457.755291a5@robin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Jan 2026 10:54:57 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 18 Jan 2026 13:02:47 +0000
> Weigang He <geoffreyhe2@gmail.com> wrote:
> 
> > In make_trace_array(), if add_string() fails after some successful
> > iterations, the function returns without freeing the 'vals' array that
> > was allocated by previous add_string() calls.
> > 
> > The add_string() function uses realloc() internally with a local
> > temporary variable, which means the original pointer is preserved on
> > allocation failure. When make_trace_array() returns early on error,
> > the previously allocated memory is leaked.
> > 
> > Fix this by freeing 'vals' before returning on the error path.
> > 
> > This bug is found by my static analysis tool and my code review.
> > 
> > Signed-off-by: Tuo Li <islituo@gmail.com>
> > ---
> >  scripts/tracepoint-update.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
> > index 90046aedc97b9..7bc9d66229ddf 100644
> > --- a/scripts/tracepoint-update.c
> > +++ b/scripts/tracepoint-update.c
> > @@ -93,8 +93,10 @@ static void make_trace_array(struct elf_tracepoint *etrace)
> >  	for_each_shdr_str(len, ehdr, check_data_sec) {
> >  		if (!len)
> >  			continue;
> > -		if (add_string(str, &vals, &count) < 0)
> > +		if (add_string(str, &vals, &count) < 0) {
> > +			free(vals);
> >  			return;
> > +		}
> >  	}
> 
> It would make much more sense to have add_string() free vals, and set
> vals to NULL on error.

I think it should be failed if it fails to add string. Can it
continue checking tracepoints even after the error?

Thank you,

> 
> -- Steve
> 
> 
> >  
> >  	/* If CONFIG_TRACEPOINT_VERIFY_USED is not set, there's nothing to do */
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
