Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615859;
	b=ft8z0ycGy5eTRnOJKfGn77EhrmiI3akVtho7IxC5oMVFP0jxJ/IaGf7jd4xO5EQPL+tv
	 Y2h9MyJy5rLk0uAhLCnz5Ol0BJX3bMTWF+4nhb/CIy7kawDa/MfdIwSWH5BaT31kL9gKn
	 pB1mnDbmXINtMeuZjn/T6wqRvyODfegxz5PBmLzbFlwbqe77irvHbV4x0iqjaOyCyqT4G
	 eoiB02k9ABg5765/+qoX5XXoFZ9FKPPGLEWjNeQVXhbykieouWyLu+MW06F89GiJCjqgp
	 lpNxpm3k+HrbcpxwR+upQUOsdVwZ+QyF5eshzBjosVVBduiCQ5yas5xeLd9475aO9zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615859;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0Xvg3I1HWCMPW23lSHsT3D2rlPgaLHExKS6ftCEthzA=;
	b=ttQ00hxneOhqlNNkU/jLDqtRKlZro/sRF/ujogAoBORalJlC5HfIEeaYiNHeFDcxAxgy
	 k+htTeb3FXPq+TzqfHl8tUO3arGi85X7uAZxiD/R2YwhQBLPZNtIc09YiBJk9UWrEKf+b
	 dJ/XO+WDCQ8U1tFhwP13C4rsakDCBNSJmBUSTKGk9eUvHKFd/1YwRDozv6mgHznp9j1jt
	 Whv0Rzg1RQmJCxMPKDWhbg1RkJ1P1nd1HNuMTLaLUX0Vobs1kyu2bOGfGMCs6e/DiUE/+
	 jpCANHMKv10TTAnYRwoadSomnEecD6PWLzaAA4M1MlZ5X6H11bmTuA5GxEdy64LTkqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxMEBs84;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C493A606A6AE;
	Wed, 25 Nov 2026 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxMEBs84
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF051F000D0;
	Wed, 25 Nov 2026 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795615859;
	bh=0Xvg3I1HWCMPW23lSHsT3D2rlPgaLHExKS6ftCEthzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fxMEBs84pTRxoU80TE7bF7l8+KwpHHRT1O0V0VHkELcep5LOn1d1RFDSeH7WmdSqP
	 WAw6Segi/Md0XL1W+7EFvkEiYvKuXTeKmgDSiEfZ9I+MJ+DPx7+MO4xc57LSl9YqYQ
	 PdBQLk5XlDzyFBO15n0MQE/VzcRCMH7KmIpXSah+hjaAMYtR6IR9eD9ZUq5A17gH31
	 Po4zxefqPQi5KNrN8fmF+GMemNVjsbk09kxyEuh8zRKUbwoEHwmpGLpQ0LnTxTJrdu
	 OJhyX/rojDKiUNoGjYcU9TwgFiBdfla8Plqk2g6IgmTsuuzUgTTzdq4zDqEPURg+UI
	 5bUn0L8ACXpYw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v8] tracing/probes: Zero out faulted dereferenced fields
Date: Wed, 25 Nov 2026 23:10:56 +0900
Message-ID: <undine-1795615856537354496-67bb12372670e122@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261124092447.4dbf5233@gandalf.local.home>
References: <20261124092447.4dbf5233@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 24 Nov 2026 09:24:47 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> While looking at tasks global descriptor tables, I discovered the
> following anomaly:
>
> ~# echo 't:sched sched_switch prev=prev mm=(task_struct)prev->mm ppgd=(task_struct)prev->mm->pgd' > /sys/kernel/tracing/dynamic_events
>
> The above creates a tprobe on the sched_switch tracepoint and records the
> previous task_struct pointer, it's mm_struct and the pgd the mm_struct
> points to.
>
> ~# trace-cmd start -e tracepoints:sched
>
>             bash-1050    [000] d..3.    90.829478: sched: (__probestub_sched_switch+0x0/0x10) prev=0xffff88d30b623600 mm=0xffff88d30108c600 ppgd=0xffff88d33352b000
>           <idle>-0       [002] d..3.    90.836024: sched: (__probestub_sched_switch+0x0/0x10) prev=0xffff88d301870000 mm=0x0 ppgd=0x0
>      rcu_preempt-15      [002] d..3.    90.836031: sched: (__probestub_sched_switch+0x0/0x10) prev=0xffff88d3013ad100 mm=0x0 ppgd=0xffff88d33352b000
>
> The first event has is a user task that has both a valid mm_struct and a pgd.
> The second event is a kernel task where the mm_struct is NULL and so is the
> dereferenced pgd pointer.
>
> The third event is where things looked strange. The mm_struct is NULL but
> the dereferenced pgd has a value! That is: NULL->pgd produced something
> other than zero.
>
> The reason for this is that the probe_mem_read() and probe_mem_read_user()
> do not write to the destination on failure. The process_fetch_insn_bottom()
> loop does not check the return value of the dereference (as it is the last
> one), and does not update the event. That leaves the value for that failed
> field to be whatever was in the ring buffer at that time.
>
> Have both probe_mem_read() and probe_mem_read_user() set the destination to
> zero on failure to read the address.
>
> Now all pgd are zero when mm is zero.
>
> Also update the stage 2 of process_fetch_insn_bottom() to not return on
> fault but to just set the value to zero and also do not even bother
> dereferencing the address if the value is already zero. This allows the
> code to continue and fill in the zero into the memory location on the
> ring buffer.
>
> Cc: stable@vger.kernel.org
> Fixes: 533059281ee59 ("tracing: probeevent: Introduce new argument fetching code")
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Looks good to me. Let me pick it.

Thanks!

> ---
> Changes since v7: https://patch.msgid.link/20261123213246.00440bfc@gandalf.local.home
>
> - Have all the helper functions test for null pointer before
>   dereferencing (Sashiko).
>
>  kernel/trace/trace_probe_tmpl.h | 103 +++++++++++++++++++++++++-------
>  1 file changed, 83 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
> index 8acc0f0ebd7a..b9fd2f61a0ca 100644
> --- a/kernel/trace/trace_probe_tmpl.h
> +++ b/kernel/trace/trace_probe_tmpl.h
> @@ -96,7 +96,8 @@ fetch_store_symstring(unsigned long addr, void *dest, void *base)
>  		return -ENOMEM;
>  
>  	__dest = get_loc_data(dest, base);
> -	len = sprint_symbol(namebuf, addr);
> +	/* Do not dereference NULL pointers */
> +	len = addr ? sprint_symbol(namebuf, addr) : -1;
>  	if (len < 0) {
>  		*(u32 *)dest = make_data_loc(0, __dest - base);
>  		return 0;
> @@ -133,13 +134,65 @@ process_common_fetch_insn(struct fetch_insn *code, unsigned long *val)
>  	return 0;
>  }
>  
> +/* On failure, zero out the destination */
> +static nokprobe_inline int
> +do_probe_mem_read_user(void *dest, void *src, size_t size)
> +{
> +	int ret;
> +
> +	/* Do not dereference NULL pointers */
> +	ret = src ? probe_mem_read_user(dest, src, size) : -1;
> +	if (ret < 0)
> +		memset(dest, 0, size);
> +	return ret;
> +}
> +
> +/* On failure, zero out the destination */
> +static nokprobe_inline int
> +do_probe_mem_read(void *dest, void *src, size_t size)
> +{
> +	int ret;
> +
> +	/* Do not dereference NULL pointers */
> +	ret = src ? probe_mem_read(dest, src, size) : -1;
> +	if (ret < 0)
> +		memset(dest, 0, size);
> +	return ret;
> +}
> +
> +static nokprobe_inline int
> +do_fetch_store_string(unsigned long addr, void *dest, void *base)
> +{
> +	/* NULL addr gets zero size string */
> +	if (!addr) {
> +		void *__dest = get_loc_data(dest, base);
> +
> +		*(u32 *)dest = make_data_loc(0, __dest - base);
> +		return 0;
> +	}
> +	return fetch_store_string(addr, dest, base);
> +}
> +
> +static nokprobe_inline int
> +do_fetch_store_string_user(unsigned long addr, void *dest, void *base)
> +{
> +	/* NULL addr gets zero size string */
> +	if (!addr) {
> +		void *__dest = get_loc_data(dest, base);
> +
> +		*(u32 *)dest = make_data_loc(0, __dest - base);
> +		return 0;
> +	}
> +	return fetch_store_string_user(addr, dest, base);
> +}
> +
>  /* From the 2nd stage, routine is same */
>  static nokprobe_inline int
>  process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
>  			   void *dest, void *base)
>  {
>  	struct fetch_insn *s3 = NULL;
> -	int total = 0, ret = 0, i = 0;
> +	int total = 0, ret = 0, i = 0, offset;
>  	u32 loc = 0;
>  	unsigned long lval, llval = val;
>  
> @@ -147,25 +200,26 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
>  	/* 2nd stage: dereference memory if needed */
>  	do {
>  		lval = val;
> +		/* Prevent dereferencing NULL val pointer */
> +		offset = val ? code->offset : 0;
>  		switch (code->op) {
>  		case FETCH_OP_DEREF:
> -			ret = probe_mem_read(&val, (void *)val + code->offset,
> -					     sizeof(val));
> +			do_probe_mem_read(&val, (void *)val + offset,
> +					  sizeof(val));
>  			break;
>  		case FETCH_OP_UDEREF:
> -			ret = probe_mem_read_user(&val,
> -				 (void *)val + code->offset, sizeof(val));
> +			do_probe_mem_read_user(&val, (void *)val + offset,
> +					       sizeof(val));
>  			break;
>  		case FETCH_OP_CPU_PTR:
> -			val = (unsigned long)this_cpu_ptr((void __percpu *)val);
> -			ret = 0;
> +			/* Do not dereference NULL pointers */
> +			if (val)
> +				val = (unsigned long)this_cpu_ptr((void __percpu *)val);
>  			break;
>  		default:
>  			lval = llval;
>  			goto out;
>  		}
> -		if (ret)
> -			return ret;
>  		llval = lval;
>  		code++;
>  	} while (1);
> @@ -175,17 +229,18 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
>  stage3:
>  	/* 3rd stage: store value to buffer */
>  	if (unlikely(!dest)) {
> +		offset = code->offset;
>  		switch (code->op) {
>  		case FETCH_OP_ST_STRING:
> -			ret = fetch_store_strlen(val + code->offset);
> +			ret = val ? fetch_store_strlen(val + offset) : 0;
>  			code++;
>  			goto array;
>  		case FETCH_OP_ST_USTRING:
> -			ret = fetch_store_strlen_user(val + code->offset);
> +			ret = val ? fetch_store_strlen_user(val + offset) : 0;
>  			code++;
>  			goto array;
>  		case FETCH_OP_ST_SYMSTR:
> -			ret = fetch_store_symstrlen(val + code->offset);
> +			ret = val ? fetch_store_symstrlen(val + offset) : 0;
>  			code++;
>  			goto array;
>  		default:
> @@ -193,27 +248,33 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
>  		}
>  	}
>  
> +	/*
> +	 * Once val is zero, it is pointing to NULL. Any new dereference is
> +	 * also treated as a NULL pointer.
> +	 */
> +	offset = val ? code->offset : 0;
> +
>  	switch (code->op) {
>  	case FETCH_OP_ST_RAW:
>  		fetch_store_raw(val, code, dest);
>  		break;
>  	case FETCH_OP_ST_MEM:
> -		probe_mem_read(dest, (void *)val + code->offset, code->size);
> +		do_probe_mem_read(dest, (void *)val + offset, code->size);
>  		break;
>  	case FETCH_OP_ST_UMEM:
> -		probe_mem_read_user(dest, (void *)val + code->offset, code->size);
> +		do_probe_mem_read_user(dest, (void *)val + offset, code->size);
>  		break;
>  	case FETCH_OP_ST_STRING:
>  		loc = *(u32 *)dest;
> -		ret = fetch_store_string(val + code->offset, dest, base);
> +		ret = do_fetch_store_string(val + offset, dest, base);
>  		break;
>  	case FETCH_OP_ST_USTRING:
>  		loc = *(u32 *)dest;
> -		ret = fetch_store_string_user(val + code->offset, dest, base);
> +		ret = do_fetch_store_string_user(val + offset, dest, base);
>  		break;
>  	case FETCH_OP_ST_SYMSTR:
>  		loc = *(u32 *)dest;
> -		ret = fetch_store_symstring(val + code->offset, dest, base);
> +		ret = fetch_store_symstring(val + offset, dest, base);
>  		break;
>  	default:
>  		return -EILSEQ;
> @@ -237,11 +298,13 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
>  			if (s3->op != FETCH_OP_ST_STRING &&
>  			    s3->op != FETCH_OP_ST_USTRING) {
>  				dest += s3->size;
> -				val += s3->size;
> +				/* Only update a non NULL val */
> +				if (val)
> +					val += s3->size;
>  				goto stage3;
>  			}
>  			code--;
> -			val = lval + sizeof(char *);
> +			val = lval ? lval + sizeof(char *) : 0;
>  			if (dest) {
>  				dest += sizeof(u32);
>  				*(u32 *)dest = update_data_loc(loc, ret);
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
