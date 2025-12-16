Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577A21E0E14
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 01:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848472; cv=none; b=JvfNmZIj5ut4kIDPkva6sCN0ROWsdBI0xdaM2ORdaLAjloBKZBPe/zXODzo1wyhNj0GTJGvdJIsQs/de2smKnf7AXo/LNYRiqfnUAPK24MYQYwOX/u1VmcDetHwKLRSA7cOd5zZ20hdvvKcvCb7Lpny+XtBbLRzBrmIqEuOPP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848472; c=relaxed/simple;
	bh=zQ4WvcVUI1CqBQ2niHl2SMISwbxlWiyGpJqXTIzhWQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rkjpsdC8GOnHLPHsMUF2g4VN2y5ZW4QsPLWeQZUFNjGt4dkugx2j8ARfCVaz9j5xhMIzmoSpfmM9H+1icTBIa9pZ4hTHQxq7wvOvfTo50Pjm7RtPwkIkUK/kJE2zG/tzpV0HNl3f4LvlYbOrB3fqbRIk1w38lGYJ+a8UJ39XL2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZaMr54xm; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZaMr54xm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765848453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0RrFiAMOgIT9n77Eb4RRA4QZX8jYfBN/zYM5/IzU8kc=;
	b=ZaMr54xmA1hQUFcq9/kR48cS+8Z7kQ42inStwg/uAGbJf6bldMjmk/WYHvIL5mDepuR6Kr
	D6fFeVpbpAt6lEiGS4rIuBXo1f1Oj9tpR54Gga4VjYQk/yhxFTaVKz3mn9IzFRbCIWynKI
	5fjx51i3LdPiMuBdEbYcZAlorxvpXa4=
From: Menglong Dong <menglong.dong@linux.dev>
To: jolsa@kernel.org, rostedt@kernel.org, revest@google.com,
 mark.rutland@arm.com, bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 menglong8.dong@gmail.com, song@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCHv5 bpf-next 1/9] ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops
 flag
Date: Tue, 16 Dec 2025 09:27:21 +0800
Message-ID: <12802095.O9o76ZdvQC@7940hx>
In-Reply-To:
 <95c13c0b793604796037ca67c191e1bfce22770dd020107c7179a698c5d49b91@mail.kernel.org>
References:
 <20251215211402.353056-2-jolsa@kernel.org>
 <95c13c0b793604796037ca67c191e1bfce22770dd020107c7179a698c5d49b91@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/16 05:31 bot+bpf-ci@kernel.org write:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 015dd1049bea..505b7d3f5641 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 976d89011b15..b9a358d7a78f 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -214,10 +214,15 @@ static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
> >  	int ret;
> >
> >  	if (tr->func.ftrace_managed) {
> > +		unsigned long addr = (unsigned long) new_addr;
> > +
> > +		if (bpf_trampoline_use_jmp(tr->flags))
> > +			addr = ftrace_jmp_set(addr);
> > +
> >  		if (lock_direct_mutex)
> > -			ret = modify_ftrace_direct(tr->fops, (long)new_addr);
> > +			ret = modify_ftrace_direct(tr->fops, addr);
> >  		else
> > -			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
> > +			ret = modify_ftrace_direct_nolock(tr->fops, addr);
> >  	} else {
> >  		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
> >  						   new_addr);
> > @@ -240,10 +245,15 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
> >  	}
> >
> >  	if (tr->func.ftrace_managed) {
> > +		unsigned long addr = (unsigned long) new_addr;
> > +
> > +		if (bpf_trampoline_use_jmp(tr->flags))
> > +			addr = ftrace_jmp_set(addr);
> > +
> >  		ret = ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
> >  		if (ret)
> >  			return ret;
> > -		ret = register_ftrace_direct(tr->fops, (long)new_addr);
> > +		ret = register_ftrace_direct(tr->fops, addr);
> >  	} else {
> >  		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
> >  	}
> 
> After this change, register_ftrace_direct() receives an address with
> the LSB bit already set (via ftrace_jmp_set) and stores it as-is in
> entry->direct. This address then flows through to ftrace_find_rec_direct()
> which returns entry->direct unchanged.
> 
> In available_filter_functions_show():
> 
>     direct = ftrace_find_rec_direct(rec->ip);
>     if (direct)
>         seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
> 
> Can the debug output show misleading symbol offsets? When the LSB is
> set, %pS will resolve addresses like "function+0x1" instead of just
> "function". This makes ftrace debug output harder to read for users
> trying to understand direct call attachments.
> 
> The fix would be to strip the LSB bit before printing:
>     seq_printf(m, "\n\tdirect-->%pS", (void *)ftrace_jmp_get(direct));

Ah, this is a good point. However, it's totally another problem, and
I'll follow up it.

Thanks!
Menglong Dong

> 
> [ ... ]
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index bbb37c0f8c6c..b0dc911411f1 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6017,15 +6017,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >  	if (ftrace_hash_empty(hash))
> >  		return -EINVAL;
> >
> > -	/* This is a "raw" address, and this should never happen. */
> > -	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
> > -		return -EINVAL;
> > -
> >  	mutex_lock(&direct_mutex);
> >
> > -	if (ops->flags & FTRACE_OPS_FL_JMP)
> > -		addr = ftrace_jmp_set(addr);
> > -
> >  	/* Make sure requested entries are not already registered.. */
> >  	size = 1 << hash->size_bits;
> >  	for (i = 0; i < size; i++) {
> 
> [ ... ]
> 
> > @@ -6146,13 +6139,6 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >
> >  	lockdep_assert_held_once(&direct_mutex);
> >
> > -	/* This is a "raw" address, and this should never happen. */
> > -	if (WARN_ON_ONCE(ftrace_is_jmp(addr)))
> > -		return -EINVAL;
> > -
> > -	if (ops->flags & FTRACE_OPS_FL_JMP)
> > -		addr = ftrace_jmp_set(addr);
> > -
> >  	/* Enable the tmp_ops to have the same functions as the direct ops */
> >  	ftrace_ops_init(&tmp_ops);
> >  	tmp_ops.func_hash = ops->func_hash;
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20247816064
> 




