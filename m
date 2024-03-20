Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044AC3CF6A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941064; cv=none; b=WQXCsHTSGzuTaRA1BIjEucHaAJ3rRuDZtuf9hN5JH0WOpAAr+K9zB56NHP6Kf5v8HRthzPBJ5bTezJhgLMYtLa1qSa6EeZuqw9bmTUEIeAyJudnhgPbAFnmTlSihPAOqxjFpgDFgsMC0O6KRGBAOpkA/sMSHb5hwXcv5XzzdqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941064; c=relaxed/simple;
	bh=H5qvjIeb5LMN60mkGk9Nb0AxzzKJM9zyl1lkpGQngh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmiDGSDSsx5i/wJSm4S6l2S8IsSm5dlI7Nhk9xcIoiFfXuez0b1X4vY8jnOwEn3fVmHuMm4PUzRTfnq6FAPMoNPsYCPdKOiSWnyUMFlXId9Z2k0qW9d3kYgDbkFrOXiA4frnKnstP85VAmEUxC/aB5u3o1IDqunOmewjVHkgKj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F00C433C7;
	Wed, 20 Mar 2024 13:24:23 +0000 (UTC)
Date: Wed, 20 Mar 2024 09:26:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probes: Fix to zero initialize a local
 variable
Message-ID: <20240320092647.6e783483@gandalf.local.home>
In-Reply-To: <171092223833.237219.17304490075697026697.stgit@devnote2>
References: <b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain>
	<171092223833.237219.17304490075697026697.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 17:10:38 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to initialize 'val' local variable with zero.
> Dan reported that Smatch static code checker reports an error that a local
> 'val' variable needs to be initialized. Actually, the 'val' is expected to
> be initialized by FETCH_OP_ARG in the same loop, but it is not obvious. So
> initialize it with zero.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain/
> Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kprobe and fprobe)")
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

>  kernel/trace/trace_probe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 217169de0920..dfe3ee6035ec 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -839,7 +839,7 @@ int traceprobe_get_entry_data_size(struct trace_probe *tp)
>  void store_trace_entry_data(void *edata, struct trace_probe *tp, struct pt_regs *regs)
>  {
>  	struct probe_entry_arg *earg = tp->entry_arg;
> -	unsigned long val;
> +	unsigned long val = 0;
>  	int i;
>  
>  	if (!earg)

