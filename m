Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9554918;
	Mon, 28 Jul 2025 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753668446; cv=none; b=mvzvfT8tenMxnyiMsKPxK3o1+r54hWvZ638piqYo0KwCF88F3rCSWctkvedL++cgT/6bQUC/SJEssjRHeSU0hul26vMIv7XtWTrn1UZN18sHWYolY+Bgoy6UAON1klBLnzOiKtQMev5IC+JDb2XZZR6orQQodddOF1QrUluSBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753668446; c=relaxed/simple;
	bh=xsUgJyVXuf5+gMjt9glcjYW0BpsHXxnZVnKaMnI9BBo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VQgWBJWDSWjVJGbiryCdh7TtyF3DNc6mxhOQ+ik/gsrFrSY4+yMX5unHrAwzS1jKrRBquXwIE91mHhQ4FLE/P6ilpsCC4z4grX9kAKTMMlqHnPwtMGp91R8NCmi7AYpfWhefIbAu9/vMXJtiDmwopOquXQyUMepxBGzKuwaEBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9u799yP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9u799yP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BEF3C4CEEB;
	Mon, 28 Jul 2025 02:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753668446;
	bh=xsUgJyVXuf5+gMjt9glcjYW0BpsHXxnZVnKaMnI9BBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T9u799yPao0kA0ywO6diwYoKnKT+PZrTW9wdejGcpD2O6oYf1MmBA2/qB+LV4EOds
	 k0uWeda4ztNfUX4p+ZwTjbgstc/J2kR3l2OlGpFqKEbH7pA2lfY8tmpdpFXSM974pO
	 jk68RhcDbfrwq5pSiTxRM+uduvqsvbeEy71CwIfVWXO8ZZBQ2RHYXb0OjBxzCzdpXq
	 1uGFtZEM62K9iAxkjWOfOY5yRoReyaEdgNs4S2pzqbpbPNmEJEBnf2peuGnfCLnkUm
	 ZU8QWB7p54RPveMbLwqP2VukKvlmL/ofWm0T7X5g3c5NIVpOKoQvG+hEHd6cKuB7/w
	 TE7+7g6ZamHSQ==
Date: Mon, 28 Jul 2025 11:07:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] tracing: probe: Allocate
 traceprobe_parse_context from heap
Message-Id: <20250728110723.caf5846854d578e98db2c375@kernel.org>
In-Reply-To: <175323425650.57270.280750740753792504.stgit@devnote2>
References: <175323423662.57270.14650807176845939538.stgit@devnote2>
	<175323425650.57270.280750740753792504.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 10:30:56 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index add08ffb04d7..610f8d53be8a 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -1384,14 +1384,17 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  
>  static int trace_fprobe_create_cb(int argc, const char *argv[])
>  {
> -	struct traceprobe_parse_context ctx = {
> -		.flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,
> -	};
> +	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
>  	int ret;
>  
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,

Oops, this last should be ';' instead of ','!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
