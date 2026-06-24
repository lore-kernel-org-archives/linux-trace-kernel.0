Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044016F27F;
	Wed, 24 Jun 2026 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782344024; cv=none; b=QVSmt22lVKq++7dwEtP00foeVPIQUT1LaiqR3e6zcvz4NhNZBtXp5SLNlB4btnxSOgTaX4Ygf9/VkiCTd29IE709FvKgOGAfL81yp4asDT2TG+HzToAsa6i5lm6nzPkzwXCjbVSeoLQ61rk14Qm5dTRwOPZMVsjkyP4H26zg0uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782344024; c=relaxed/simple;
	bh=2eORMWxcorD3GAQSTGiMyCp0CCsM1hgP033YdXPZqDU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cYKhIjuFKnfP5SVD9WnwF1vqYHeMZ5VzPPZ0dwnImNewaeDUD7T8sxm5/FsfGMn5jhPUZFHcJljDDMzz250Mb68yJ6Vau80i7GE/CgzoQAcAcJJ9yI+2rkZYz/lEgE8c9MlD4/3bEFag0gLB9RciYTjbcX6WDwirCCR0XpRUkHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7BUcnmO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7BUcnmO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6641F000E9;
	Wed, 24 Jun 2026 23:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782344022;
	bh=adqpob2PJ285ilftSDw/zm0UkI/paO9O/1Yyd2iQc4g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=c7BUcnmOaV7QFceNFKLvWozS3pDjLp9Oj0jq56AlT9e2WIHRewYSjXAjlD4vsr8hE
	 YOH6AE0LtILCZgU+RuiefvyWZg78sS/FQsKymWGN66NWtkmi5sNnH7zXPXjmiEY/vx
	 IzYNSIYnzIOYJcDbj7CrV9nfb0MvAofSvl3F4XjbPmOZQ6A+UowJHPePgH5BTLxAYv
	 +WWfuXbfpFiG6fvkmmQzlOFC76j2foyg7z2MEqjc7zWFoTl3s7jyNUkNed2sFu+Hbo
	 WCWIMUj0+PcKD8iHxAtoEBcaDSvqXekOUsoeUFfDrkLoI4Uuzcpjgn3Zc3oLfGQWqj
	 yiZ2d80Kauc2Q==
Date: Thu, 25 Jun 2026 08:33:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 01/10] tracing/probes: Make the $ prefix mandatory
 for comm access
Message-Id: <20260625083338.60b38483b5766c841ce4af32@kernel.org>
In-Reply-To: <178231209724.732967.12049805699091810641.stgit@devnote2>
References: <178231208703.732967.1160700962651040729.stgit@devnote2>
	<178231209724.732967.12049805699091810641.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 23:41:37 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since $comm or $COMM are not event field but special fetcharg
> variables to access current->comm, It should not be accessed
> without '$' prefix even with typecast.
> 

Let me pick this to probes/core.

Thanks,

> Fixes: 69efd863a785 ("tracing/eprobes: Allow use of BTF names to dereference pointers")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v8:
>   - Newly added.
> ---
>  kernel/trace/trace_probe.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index c10bbb0df7b9..0da7c0b53ba7 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -342,10 +342,6 @@ static int parse_trace_event(char *arg, struct fetch_insn *code,
>  	ret = parse_trace_event_arg(arg, code, ctx);
>  	if (!ret)
>  		return 0;
> -	if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
> -		code->op = FETCH_OP_COMM;
> -		return 0;
> -	}
>  	return -EINVAL;
>  }
>  
> @@ -1065,8 +1061,14 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
>  	int len;
>  
>  	if (ctx->flags & TPARG_FL_TEVENT) {
> -		if (parse_trace_event(arg, code, ctx) < 0)
> +		if (parse_trace_event(arg, code, ctx) < 0) {
> +			/* 'comm' should be checked after field parsing. */
> +			if (strcmp(arg, "comm") == 0 || strcmp(arg, "COMM") == 0) {
> +				code->op = FETCH_OP_COMM;
> +				return 0;
> +			}
>  			goto inval;
> +		}
>  		return 0;
>  	}
>  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
