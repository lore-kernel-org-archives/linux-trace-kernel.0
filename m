Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E15423F372;
	Fri, 28 Feb 2025 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782788; cv=none; b=KZEyZSuc3e9KLSb+ZmRaGLHQni/+/u2jDr4T68/NJ+FYjpeV0PyxnkLFmLjfTEy3r9IhEIOYvBZaRFCDBmXOqEuUu67Ug0sRS8NDAabzqAjVGIVfeG5ldj/wHLq5lKPnvzHTok0MtFcgnXs5jzkk8d0xuGDf7jd1RQfjdFN0+rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782788; c=relaxed/simple;
	bh=nf6nYmm4zc+i2pBm9AUoXsjNIM7O0LuYmHZq/Hapx4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMVz54+HRmVbx2SXx3CV6CbE7F9eJdO20EH7VPTAm8F9oGSuMvl79rn0eu2sceAlYylWi0bVeeHEcFCxadFV8uKOKvjWA5yV1ZqesJVvX9+j2As8sG3DyVcte/Q1OSx1AmSyB0VfioYR38zY11xteN+4Wq91vItKze3gwzcIJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59AAC4CED6;
	Fri, 28 Feb 2025 22:46:26 +0000 (UTC)
Date: Fri, 28 Feb 2025 17:47:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probe-events: Add comments about entry data
 storing code
Message-ID: <20250228174712.44e03694@gandalf.local.home>
In-Reply-To: <174061715004.501424.333819546601401102.stgit@devnote2>
References: <174061715004.501424.333819546601401102.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 09:45:50 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add comments about entry data storing code to __store_entry_arg() and
> traceprobe_get_entry_data_size(). These are a bit complicated because of
> building the entry data storing code and scanning it.
> 
> This just add comments, no behavior change.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Closes: https://lore.kernel.org/all/20250226102223.586d7119@gandalf.local.home/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_probe.c |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 8f58ee1e8858..2eeecb6c95ee 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -770,6 +770,10 @@ static int check_prepare_btf_string_fetch(char *typename,
>  
>  #ifdef CONFIG_HAVE_FUNCTION_ARG_ACCESS_API
>  
> +/*
> + * Add the entry code to store the 'argnum'th parameter and return the offset
> + * in the entry data buffer where the data will be stored.
> + */
>  static int __store_entry_arg(struct trace_probe *tp, int argnum)
>  {
>  	struct probe_entry_arg *earg = tp->entry_arg;
> @@ -793,6 +797,20 @@ static int __store_entry_arg(struct trace_probe *tp, int argnum)
>  		tp->entry_arg = earg;
>  	}
>  
> +	/*
> +	 * The entry code array is repeating the pair of
> +	 * [FETCH_OP_ARG(argnum)][FETCH_OP_ST_EDATA(offset of entry data buffer)]
> +	 * and the rest of entries are filled with [FETCH_OP_END].
> +	 *
> +	 * To reduce the redundant function parameter fetching, we scan the entry
> +	 * code array to find the FETCH_OP_ARG which already fetches the 'argnum'
> +	 * parameter. If it doesn't match, update 'offset' to find the last
> +	 * offset.
> +	 * If we find the FETCH_OP_END without matching FETCH_OP_ARG entry, we
> +	 * will save the entry with FETCH_OP_ARG and FETCH_OP_ST_EDATA, and
> +	 * return data offset so that caller can find the data offset in the entry
> +	 * data buffer.
> +	 */

So I'm still not 100% sure what is happening here, but at least these
comments can help me figure it out if I spend some time gawking at the code
a bit more ;-)

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


>  	offset = 0;
>  	for (i = 0; i < earg->size - 1; i++) {
>  		switch (earg->code[i].op) {
> @@ -826,6 +844,16 @@ int traceprobe_get_entry_data_size(struct trace_probe *tp)
>  	if (!earg)
>  		return 0;
>  
> +	/*
> +	 * earg->code[] array has an operation sequence which is run in
> +	 * the entry handler.
> +	 * The sequence stopped by FETCH_OP_END and each data stored in
> +	 * the entry data buffer by FETCH_OP_ST_EDATA. The FETCH_OP_ST_EDATA
> +	 * stores the data at the data buffer + its offset, and all data are
> +	 * "unsigned long" size. The offset must be increased when a data is
> +	 * stored. Thus we need to find the last FETCH_OP_ST_EDATA in the
> +	 * code array.
> +	 */
>  	for (i = 0; i < earg->size; i++) {
>  		switch (earg->code[i].op) {
>  		case FETCH_OP_END:

