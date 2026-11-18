Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961031;
	b=SLJbQiVIYKEtUaj8tJaIYsx9f3WQd1HrTNskqyvXHpJEKW7ll8JZzFJM4pip6StSSnYE
	 A6jjBEhkm9H+AfbNHzM+eFqmw8CATemg0bGairNuie3VvQzx7qLs0zjTb2il5U+cD2/Ao
	 n5aLXTLFyOgultjuEurmOVRKOZoRHILZKzxVFpNAV29CPIRI7Om6gPMNxqEZqcp1uGsAt
	 NCPX5mNY2/3DGOjB8YhE03cTLy55elxA67nggCMJJs7lzcE7621bTZeTMWO5l9C+zvOBX
	 1iOwwLbgA75M1Bo+01b07q0Gio8hia/g7k04oECWxpykkDZdlZB6ZBvPDlYNa4gnNkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961031;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Spam-Status:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=nB+gjuRUBau1r4/44QHA44Pj17gefsRJ2uGOE8AuGuI=;
	b=TAS7y7OSC9IRra0KjeJrfUo5kv29u0OLEevZiv0FWeagn83l0OPFxpwV/creynTOUmNz
	 Vx65aIJzJS5VdHoJB3sg822V95H9ZrENHQ3jCKBOPidWbWGG1tTM6jprOrOtWb7HvsI5U
	 TAFgIFsBBLpOdaE3Ig6ean6UB1fRtU3vusPqpAHvUC7z6zYop++KwHNsxnuIt2BLAmfiT
	 Os4SIFevL9Y5VFdHToTN+G8jmoOetLfQ/U9PvjKq0tkZDJbQVaY7ymsKhvLWiRYzkvlGl
	 d8pVuVfxpe2iYf23RVeS6kZ+ND2mB9ukhz5W1KyVBJ8BNWR2s0LlBYMH82d2eyS4Atg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Dky5B1EU;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331D6606A31C;
	Wed, 18 Nov 2026 00:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 331D6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=Dky5B1EU
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 3237340528;
	Wed, 18 Nov 2026 00:17:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 1C86F20024;
	Wed, 18 Nov 2026 00:17:02 +0000 (UTC)
Date: Tue, 17 Nov 2026 19:17:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 08/15] tracing/filters: Reject unsupported field
 sizes in parse_pred()
Message-ID: <20261117191700.7e5f1a10@gandalf.local.home>
In-Reply-To: <179323791927.740114.2174706496595446472.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
	<179323791927.740114.2174706496595446472.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uqa1e8c6p63frqkppqydag99yf7ibiao
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1C86F20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18mMmaCzgOxIbDsahODxHWL9zZ2WjjclQw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=nB+gjuRUBau1r4/44QHA44Pj17gefsRJ2uGOE8AuGuI=; b=Dky5B1EUjw4FszzLtcU9Mm3VxmdkTvcn22M8S7jQCPY6wlxtVCsQofwoXAW3Cr0bpuapptSTfCF4g0uYjrw1gD4hS9HO+USMyLTRpu4P9zO0QOjA1WyJ/Vg5/4TGTD03DSbqk8xNJFJp84SRo5gUAYkyKjCGgHhhlgMKiKpveV0=
X-HE-Tag: 1794961022-560662
X-HE-Meta: U2FsdGVkX1/9geDdSvzb+sa0A5xCFrldOeszpsg1TpnmT4Lyv/SwsZZr1h4obMyARgIS3ASGWN7r4OI8HY6FvsAsXxx7g8WFLZStAxXIW3reeT/9JsrcdqlWqC5RCK6KChgwh6R35YuLwh4nlWa+KrD060HcCzBkuy9h73+qW6E2xm+RosAHLuq2fMT6aeHQQDGCr3ZYjrCLiPytBbDXgjefce+JQ5Y80E5kr4y/in/4CWog2/8JhQvVCYuF3P1gbQHN2lzQYNt1/aLASOk4PJCbECSPr0dore1MgaRjG0CwYJZjexMUSSCOHSgpJmq8zCWCmzruMdNxtZEsTse5aI0sLNGZf6rB

On Thu, 29 Oct 2026 10:38:39 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Prior to commit 80765597bc58 ("tracing: Rewrite filter logic to be simpler
> and faster"), parse_pred() checked whether select_comparison_fn() returned
> NULL and failed with FILT_ERR_INVALID_OP and -EINVAL. That check was lost
> during the rewrite, and commit 3cbec9d7b93d ("tracing/filters: Enable
> filtering a scalar field by a cpumask") similarly omitted a default error
> case when matching field->size for CPUS{} comparisons.
> 
> If a non-string field (FILTER_OTHER) has a size other than 1, 2, 4, or 8
> (such as a fixed-size integer array field), pred->fn_num remains
> FILTER_PRED_FN_NOP (0) and parse_pred() returns success. Subsequently,
> update_preds() rejects FILTER_PRED_FN_NOP via WARN_ON_ONCE() and returns
> -EINVAL without setting a parse_error() message, triggering a kernel
> warning from user-supplied filter input.
> 
> Restore the check for FILTER_PRED_FN_NOP in both the numeric scalar and
> CPUS{} branches of parse_pred() and report FILT_ERR_INVALID_OP.

Again, please show real examples of what fails, so I can test it.

Thanks,

-- Steve

> 
> Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> Fixes: 3cbec9d7b93d ("tracing/filters: Enable filtering a scalar field by a cpumask")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_events_filter.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index a645af9eb1f8..40efcef94e02 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -2013,6 +2013,10 @@ static int parse_pred(const char *str, void *data,
>  				break;
>  			}
>  		}
> +		if (pred->fn_num == FILTER_PRED_FN_NOP) {
> +			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
> +			goto err_free;
> +		}
>  
>  	/* This is either a string, or an integer */
>  	} else if (str[i] == '\'' || str[i] == '"') {
> @@ -2166,6 +2170,10 @@ static int parse_pred(const char *str, void *data,
>  		else {
>  			pred->fn_num = select_comparison_fn(pred->op, field->size,
>  							    field->is_signed);
> +			if (pred->fn_num == FILTER_PRED_FN_NOP) {
> +				parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
> +				goto err_free;
> +			}
>  			if (pred->op == OP_NE)
>  				pred->not = 1;
>  		}

