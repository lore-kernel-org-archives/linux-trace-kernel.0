Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DD0368264;
	Tue, 23 Jun 2026 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782211985; cv=none; b=uEqBfXt1NM/ndPdsr2cKeI+Bgd8+S18LmXU9C1XhEAe05LHaWUZfB/Q1Nj4Uorf7X4PqplItskyx6eTbSHzXGRoBDKbqdvFejityyL3ag4S/eyfF/OJgB1L4LFoiGSjgLHkePQBqorZqlWwVM0OE7jxnWcxHTZcuQjak01iy4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782211985; c=relaxed/simple;
	bh=rxsyHUUevEQYt6YPahtR5o9bxMBtJc3xTazEkWT2zYA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rC7R66MAV2NksOEe8vlIE01mDnRzxfZdRDA9j9xhd/k97oEGiv25GALv7KEk6Sh0n8cqjecSUvQgptHJFH+nCuhLEq/8ebmntLA4ckTQHCmNrIeD1215o3R8YFdx9rhLaKlarc01n3SUr0nANTFFljL5t03TtsDgpooL1WwkUno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmUbajNA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmUbajNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16AD1F000E9;
	Tue, 23 Jun 2026 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782211984;
	bh=Ui+LP8SUlSYqe3kQsI/NFdqT7EnftJCDCXQUtkDt5dI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KmUbajNAyai3qUbi/XVERNUGurrGaWY1qfdoPCyFjOEIQ9jT9/bwK6LwKxG5XQ9uL
	 EAu1gtlv2TjvjVelU9l1WbS9P4VqQ+Ft9vPb2Qr+5flfY0dxN89fUS7qFaXRI9khSp
	 XGh9tdx5jKtzITsg5OlR9YkNQf4b65sUgtpEDBBF4E9OZLIrmDTps/Xx6VMzZ0x/7Q
	 9AvOSKDsUv7D8j7P3k1cihr+rZLc0682aTCpBK5UU4mZFUFVt3ifLGh1GUl0YMBDku
	 Sg/2VsaC4+WedSBRCbi1XonmVCpkgi4dAgZ51tdoUWlxlBTeQXP9ptb5PMTcSMKzcJ
	 rudyK2dIku1/A==
Date: Tue, 23 Jun 2026 19:53:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yudistira Putra <pyudistira519@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/probes: make file offset error message
 probe-agnostic
Message-Id: <20260623195300.01c0a52b4c649afbed594d5e@kernel.org>
In-Reply-To: <20260622160032.99834-1-pyudistira519@gmail.com>
References: <20260622160032.99834-1-pyudistira519@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 12:00:32 -0400
Yudistira Putra <pyudistira519@gmail.com> wrote:

> The shared probe argument parser rejects file offsets for kernel probes.
> This path is used outside the kprobe event parser too, but the diagnostic
> currently says "with kprobe" even when emitted from another probe path.
> 
> Make the diagnostic probe-agnostic.
> 

Looks good to me. Let me pick it.

Thanks!

> Signed-off-by: Yudistira Putra <pyudistira519@gmail.com>
> ---
>  kernel/trace/trace_probe.c | 2 +-
>  kernel/trace/trace_probe.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index fd1caa1f9723..fec0ad51cf61 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1228,7 +1228,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  			code->op = FETCH_OP_IMM;
>  			code->immediate = param;
>  		} else if (arg[1] == '+') {
> -			/* kprobes don't support file offsets */
> +			/* Kernel probes do not support file offsets */
>  			if (ctx->flags & TPARG_FL_KERNEL) {
>  				trace_probe_log_err(ctx->offset, FILE_ON_KPROBE);
>  				return -EINVAL;
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 15758cc11fc6..6162f066c2b8 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -516,7 +516,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	C(BAD_MEM_ADDR,		"Invalid memory address"),		\
>  	C(BAD_IMM,		"Invalid immediate value"),		\
>  	C(IMMSTR_NO_CLOSE,	"String is not closed with '\"'"),	\
> -	C(FILE_ON_KPROBE,	"File offset is not available with kprobe"), \
> +	C(FILE_ON_KPROBE,	"File offset is not available for kernel probes"), \
>  	C(BAD_FILE_OFFS,	"Invalid file offset value"),		\
>  	C(SYM_ON_UPROBE,	"Symbol is not available with uprobe"),	\
>  	C(TOO_MANY_OPS,		"Dereference is too much nested"), 	\
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
