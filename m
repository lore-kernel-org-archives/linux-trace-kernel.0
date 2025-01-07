Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E63B770FE;
	Tue,  7 Jan 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264465; cv=none; b=CdPtomu068GTszuowuVzQjjdIC1ChT+I2QF1Eh5jrPnu48UZ9GD97TYMaufcZ96Nmbx6lbweatLDy9TObtytbwqlGP4CH/UAT6Azq4fWMrpyJ8Q3dD/bNmc/3fahJkJ0QVlk+WZvPrhFAwHhrqgOiE4n8K03XMZQHIbwud7wCFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264465; c=relaxed/simple;
	bh=AaumMR8LR9kCMhILKWJEuN8SOt2ZJMfO8h4iLw82/Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmR/bZXW8z62pcV1Zdzi//7ed+hFcz2A0m/rz1BfW0D0KQ90q4z2kO7Gz9zZpFAleAup+jHdfoPJfolA3Nty+21fXu7Cxsi8+h0xygSLpcg/ofAh6/GXW+eW57XOdc1G59al9ClzIZpxtKMBSexJDFXajVZnTwgSODuLezniIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5B6C4CED6;
	Tue,  7 Jan 2025 15:41:03 +0000 (UTC)
Date: Tue, 7 Jan 2025 10:42:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] tracing: Use __free() for kprobe events to
 cleanup
Message-ID: <20250107104231.06eeaca8@gandalf.local.home>
In-Reply-To: <173625063552.1375434.16867809967348842161.stgit@devnote2>
References: <173625060316.1375434.11048027439794595989.stgit@devnote2>
	<173625063552.1375434.16867809967348842161.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Jan 2025 20:50:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -1898,7 +1899,8 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  			  bool is_return)
>  {
>  	enum probe_print_type ptype;
> -	struct trace_kprobe *tk;
> +	struct trace_kprobe *tk __free(free_trace_kprobe) = NULL;
> +	struct trace_probe *tp;
>  	int ret;
>  	char *event;
>  
> @@ -1929,19 +1931,16 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  
>  	ptype = trace_kprobe_is_return(tk) ?
>  		PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
> -	if (traceprobe_set_print_fmt(&tk->tp, ptype) < 0) {
> -		ret = -ENOMEM;
> -		goto error;
> -	}
> +	if (traceprobe_set_print_fmt(&tk->tp, ptype) < 0)
> +		return ERR_PTR(-ENOMEM);
>  
>  	ret = __register_trace_kprobe(tk);
>  	if (ret < 0)
> -		goto error;
> +		return ERR_PTR(ret);
>  
> -	return trace_probe_event_call(&tk->tp);
> -error:
> -	free_trace_kprobe(tk);
> -	return ERR_PTR(ret);


> +	tp = &tk->tp;
> +	tk = NULL;	/* 'tk' is registered successfully, so do not free. */

I wonder if we could change the above to just:

	tp = &(no_free_ptr(tk)->tp);

?

-- Steve

> +	return trace_probe_event_call(tp);
>  }
>  
>  void destroy_local_trace_kprobe(struct trace_event_call *event_call)

