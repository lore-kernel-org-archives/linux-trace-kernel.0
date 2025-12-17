Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9442A336ED0
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765960823; cv=none; b=j+H2xjo3clDwQtazhhxSyfSOzdTZDL6FkHmLfr7f2ZircSjO8w4dVhB9jWVKl42uRqicrbnLKtMAnYcDclKMra4blxyCsGUjYuGoFu5zXEzAt6+sMo80da/cQuIDGZeNaL2whqOaNKBH0ZtQvVQMYhyvGnJVO6WSEBWwo+f5V8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765960823; c=relaxed/simple;
	bh=mdjEHEEPLujhO8mEKW8YB3oPGh1bwWoJcPHXtpbySKU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpHB9jm5d/7NjaPZ7hfubp6mFPaUU9snB/Opl/fcEUBhnSLWvkNYZxkKiCUfN3KsMj/ZxajWgh8f7ieETp7mAbvXK43PVzDwRaOv2YkLniDvDi92TkKIo3r2jq322QEp/43SlAL2UVZ2kE3O+gFo+kQx94AGpfYuCvYiDx9c6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThEIaek3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThEIaek3"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so1915695f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Dec 2025 00:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765960819; x=1766565619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WyEicKDWvbOdhrtnqhenW6ok8Fe3+pewjhCT1n7IggM=;
        b=ThEIaek3qs670NMoXFfNLMBP8MIKjIvv+QJnmIAf02cVLRln7GQmswR0e9J+MYa+XA
         7RAgEkdMjJziSkFFV2SQtpkJDAKUtULKyL/6JCUcFLVTxyCroQwOvRJnTESROPs07f+7
         EXflPviKMy9rrteLwi/N0M4fZ3/lb5mecSOUAryP2UEd2R9dJoerh7Zh55xhB/fQ64y6
         8d6skOrSBcimXkeEF5CfUjfmApN82k0A9OZfeQS7PpX0pF9GtmL6K+WS5tkv2a3gXgrJ
         sH7DpIL89z234P95c355ol3EA6Z5vF/Kl9T+azdZBlbCfCekDzpcqB61ENhqK33BtQqO
         5lbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765960819; x=1766565619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyEicKDWvbOdhrtnqhenW6ok8Fe3+pewjhCT1n7IggM=;
        b=DGpCTGqOhucjgxppLp5PYL++4Aw4gF4S4RUvfCJ6lU4LtqKOvoFHYtyrR8KoX/G8nt
         TG9rDFt9YRpplhpucyz2LaBi0fDaE0WeQ6KbGQGhwOqBR7etMbmWrbFV538IvN9sE2QC
         8xSzwL1iBVuiC7FEuCyjz4Sv5unMPnDpeM6GQRSQFy/vI0kSQ371rjjOVO1Hr6dyoaql
         kDuWjxqaxpYp/BAHBD5YU04JH2cBhPcuIZLHJ44QHPWFHMC1AmaHDRRyzaJOPHdh9N+4
         9/ejSR+e/D5ss0Vul4MKv9N/VCDtP0IN0QYCaBD6p/3k2IOpQrUMX9K7kKQ82UdNGvIm
         B8ng==
X-Forwarded-Encrypted: i=1; AJvYcCWFG9WLL6cGA0Sb4tFoltb+huts4Qq1IZn0jGvRxvte63uwVZCsDvsIhKLfb+GHAbtzMnj2mamp2PhmYecikNm7G3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvs4H1DGl+ixawwq3vkJHpRpkjewkkPR4mdFUPxI1goYKZjTYT
	ugTAb7hRZMloMbKys3rZjpMnzWXd3r8DMgv091FMVyY152GmbT1ZoBNB
X-Gm-Gg: AY/fxX6oiH8CwABryuSd6ukrIQV1QCKAQ+vzvsYM+kY+2x19nzu7x9kM1QBQkZMqJHX
	uWaJ1zfzYwIQ0ThpfHMjVYEHmtBQu3NkwLeysMuQ/vWTICgjkh5qp8GEnviMIJG5DItGr/EczMW
	TOHnvmIyc72V7qnZ1JDE6aYaQttPr8AxMTehbmF9xKPMbnD8uDhnSHj8L3oNu/+FSI6iZzkyNap
	ihXtBYoA6LWSubwRhJ1kKZwqKbNsbUr+90SuxxKNeFPFEP3zeldOB3gyikSa+0bbhSuas+8tgRF
	jc7vjsp+JJBaXHee26bBtswa0kc3YuuU1BAKFKmSMiUrTJf0huExOpAFlczFkSaOTZ4aau5awhc
	faNR3rf6DPFLFY/875IUGEfknBZy7qRpsT1bfiiVyDyKnv6mVTcEYh0wmlcORv4wgi8WcFgXyRl
	Lqmer83Y0wVA==
X-Google-Smtp-Source: AGHT+IGoh419rwOYueEWLJrPRU9q7UxlpRrhqIOwtlvWqYF627uT3OFlm5Gvl02pYhi1ZP6rxwR5NA==
X-Received: by 2002:a05:6000:26cd:b0:431:35a:4a97 with SMTP id ffacd0b85a97d-431035a4dcdmr5954508f8f.59.1765960818614;
        Wed, 17 Dec 2025 00:40:18 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adacfbbsm3637780f8f.12.2025.12.17.00.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 00:40:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 17 Dec 2025 09:40:15 +0100
To: bot+bpf-ci@kernel.org
Cc: rostedt@kernel.org, revest@google.com, mark.rutland@arm.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, menglong8.dong@gmail.com,
	song@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 1/9] ftrace,bpf: Remove FTRACE_OPS_FL_JMP
 ftrace_ops flag
Message-ID: <aUJsb2up5zHDfIpC@krava>
References: <20251215211402.353056-2-jolsa@kernel.org>
 <95c13c0b793604796037ca67c191e1bfce22770dd020107c7179a698c5d49b91@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95c13c0b793604796037ca67c191e1bfce22770dd020107c7179a698c5d49b91@mail.kernel.org>

On Mon, Dec 15, 2025 at 09:31:51PM +0000, bot+bpf-ci@kernel.org wrote:
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

hum, there's no such function.. AFAICS it's t_show called through
ftrace_avail_fops->ftrace_avail_open->show_ftrace_seq_ops

> 
>     direct = ftrace_find_rec_direct(rec->ip);
>     if (direct)
>         seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
> 

but yep, it's related problem, that Menglong said he will address in
separate patch

thanks,
jirka

> Can the debug output show misleading symbol offsets? When the LSB is
> set, %pS will resolve addresses like "function+0x1" instead of just
> "function". This makes ftrace debug output harder to read for users
> trying to understand direct call attachments.
> 
> The fix would be to strip the LSB bit before printing:
>     seq_printf(m, "\n\tdirect-->%pS", (void *)ftrace_jmp_get(direct));
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

