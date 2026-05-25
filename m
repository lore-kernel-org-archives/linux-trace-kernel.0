Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F063D78F26;
	Mon, 25 May 2026 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779720914; cv=none; b=XAE2WgVgLeSD954hR+qs12ArQggvfkZepy+DSomxeDn9Ex8QQw+q5SHLSIQEYDLBD2fphGNch6CNlG/EocfPrvYMJHGCuKU351+c2VwrzrCFwJUspDrdxuoDtXkFT0Zb4Xl+tSMXC6XBEZ961ROUg2BSLIYkjt98tyWrDM2AKYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779720914; c=relaxed/simple;
	bh=be0z3+5zyA7MHWEh5zCNEw6eQEBZSvrx2eAAe5M14lk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rjlXHJh6Z80+OuOSZkuoe8omT5OBRHSnn6JEadCE9rLwphTh49GBaodBE2192eaeQspwV15o8f705u3/IvjdIsTpD9jhPI4ov5TmCKXPYB1QYN63GZqda16/rQ9+HZvspl7zO/iD2YWEmJ1HFbUrH/hfhylQ1TpIZ7gZTTkTyNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi4R6EwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi4R6EwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5E81F000E9;
	Mon, 25 May 2026 14:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779720912;
	bh=b9V+gJzrxob7UFDV1JZOodpjfRgVfbETlgBi8uyr6KY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vi4R6EwUQYF5jDLNSwYy2QdcRJBZt5Avs2fXzsRU0m5kAnz9z5jhexJuAtfuu3No9
	 ipYtUihbfMh/QU/ZYx/pdRMqI0quFhBLJftQHrLBZHdpqiyev/p08FUx9yNNuvhW/t
	 ezAn1dGf+F1VNQnDO9JAs5Y/guvV9Nl61g/JWK6CztZM8itu9fOmtWnUo+wBhsKzEy
	 p707o6k5bbCCW7P54G9nDZDCJzq/SZT9aSGjnPDBRSU0WEM4BbVVbhyOV8Dr3Sz+o0
	 ywHbIkBTm6VAJidYXLwf1sT1x89Ou0uX9wA8tTzNvPQRVFwDxxyMJMm0+2Z9oFyVej
	 ZLzhwz1cL0seA==
Date: Mon, 25 May 2026 23:55:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>, Tom Zanussi
 <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Jiri Olsa
 <olsajiri@gmail.com>
Subject: Re: [PATCH v6] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-Id: <20260525235507.a81c565023258c63fc9201f4@kernel.org>
In-Reply-To: <20260521225033.56458336@fedora>
References: <20260521225033.56458336@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 22:50:33 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> +static int handle_typecast(char *arg, struct fetch_insn **pcode,
> +			   struct fetch_insn *end,
> +			   struct traceprobe_parse_context *ctx)
> +{
> +	char *tmp;
> +	int ret;
> +
> +	/* Currently this only works for eprobes */
> +	if (!(ctx->flags & TPARG_FL_TEVENT)) {
> +		trace_probe_log_err(ctx->offset, TYPECAST_NOT_EVENT);
> +		return -EINVAL;
> +	}
> +
> +	tmp = strchr(arg, ')');
> +	if (!tmp) {
> +		trace_probe_log_err(ctx->offset + strlen(arg),
> +				    DEREF_OPEN_BRACE);
> +		return -EINVAL;
> +	}
> +	*tmp = '\0';
> +	ret = query_btf_struct(arg + 1, ctx);
> +	*tmp = ')';

BTW, is there any reason to recover this? The @arg is copied
string, see traceprobe_parse_probe_arg_body().

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
