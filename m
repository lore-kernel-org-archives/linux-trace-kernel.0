Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BADF397E91
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761765; cv=none; b=vArI0ogTM/77BkkdYtwG6LdPFLQ5ctQbRIQBpcTqyrFECdjyIknAF83y7tSYyaGQFKc82R2l+M1k6JZ8L05KJBTioso3FcF6t8MxXtDnv+c9BEQk0gjQnOL6VslGmZZPPiW5UEpje9l4BzEwuxbB18UnASyrVgnNWikpbJGWtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761765; c=relaxed/simple;
	bh=MGt0FvaHSEA8vyoptly4+r/ngCg7KVqJHnQFPexQiWw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0OhaG6IwTbtaa5xMIt7KmDPcPRu3OU4SwmEWPtQAapMzRwfsSUOWLcK3FOETQ36CvhGmwtHvkUrh9dukKwj5cwtW/E0rUMQeK9SKcxmA4naOLabQDtfsugIqTaQ8WTxkx3CJhwDQSJA8h+pkS+6XyyqXUtiul8G0zC4URP1TyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJmG4mHz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJmG4mHz"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso14364315e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761763; x=1777366563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DCpwGbtTCJG1uA3TlSpG/g9yb5Mi4N1uhpZJfyD/MTk=;
        b=IJmG4mHzCcuI+nP6ayctBiBpeI2Kgm7Cuzb+o7wRmRolCfPV8+yy2A0Ta/F3BiOmGn
         cvpyuv0o9j1xbrBjHZMqFBVCRQVyYN/cltnMJVoexidyenHxvG7np/q6dyAcUXnWueLL
         /yvp0Dqum5M89YzL4umfoxwChB5IXNO1xR3hJ26Ljdo9Yu8SeFiCA2lJK//7kzuNfgyK
         2iYxsWrb0FRKoGl1VqYRZFKXlfnM8E+9f9Pawks63CmXMgDtDmrUIW7PnveMffzjVoxQ
         5D8ozwP8u4zVJKZ2QlVCl2r/Amcpr8Z0aKii+1jb9MSbIn/Xk8RlxKnyVfHrYvIPenNS
         PWQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761763; x=1777366563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCpwGbtTCJG1uA3TlSpG/g9yb5Mi4N1uhpZJfyD/MTk=;
        b=oUNhwy2cQ5UvQZmqwuhiA6wLxQhLoiRjqhUm4JxVrZOPp/yYO346RDyjEJ5cE70uCw
         sIS0tZTfG4ZQgfrHTHgc8/wmsMOgPUzKpjuiX8DYg67GNOqlm3lYeIqLNYD5tsNacfZS
         jU5YKXROb3bpHXNJEPB7Ia516gdL7YEruFMoSvRs0fqXHznQa0/EjoyLWa9v0f3RJ6/5
         JnFfBwWfSmjEQ28EMQs+FHey/i3e2gERUYT0tbeHIgc5tLkHkAGV5bymyIDSb4zSP4ok
         hpXYOHKpKyO1adS+IBC2H/0xXEvnN+dIbL2CxITYDivY6P81yBw0XoSZgy2uUZg7DwP5
         xJkw==
X-Forwarded-Encrypted: i=1; AFNElJ+xFy3gmdeZhjhrLqzs9K1cKGBPICusIMSPMDCX3jZ2HGc1Xq5yyhqDtTO11YbF1n1N030bgExKVmQ66wRphM5OFpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCEi3LQ0ntgSLQCNLEms0mlzZMRWM1Rc1RjeDq0035dc7NrtfR
	4/OLmgLLeATLqh0O0JYdDfHzvVXYI01/p4xGKamdKuU3Jygv5pkzEasF
X-Gm-Gg: AeBDievKrgw7hf6JuTNQaZSswO3S4RVprBN8M8hofucbzvSzt1mPiOOtdr817OlDEcI
	ErPSnngTgtvFmvz/3AAa8WZZ/HpMNKDU0fzA1p8gXlJV1FwS7GxJJSrTXZEchWCL63jxKC99ljN
	19kIhdjvCjUwAd72JKpKDlQr5M/PzylL6bIOcg49Makts/uvfHoRxaYrVOp+YSejg2NZ/ywgcjm
	aLdQu3kxnnKn7zX00yVJFn+oTciw6/pCrhoSKdGZ2d8C1bXNFqLUj/28ujEvhWfyGCKwvzCqeSP
	WzePY/XYw8TjpM9HU+kwzzLkS4Gh46Qqibvjo/Gs01yyp2KJteZIg2/UrpejUQ2LKiyawvoFE7u
	rWl44bnSNpbCkIAgRRSZsFpfreQARO68M4NpUeI7dVUqsKKZf4w13Vgaeogv3DBT4Tkpm3ftCj8
	6utc7xPfs=
X-Received: by 2002:a05:600c:498a:b0:489:ad:7b5b with SMTP id 5b1f17b1804b1-48900ad7b76mr107411445e9.24.1776761762634;
        Tue, 21 Apr 2026 01:56:02 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5549f582sm14713935e9.33.2026.04.21.01.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:56:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:56:00 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 10/28] bpf: Add multi tracing attach types
Message-ID: <aec7oFj3YF3t5Vj7@krava>
References: <20260417192502.194548-11-jolsa@kernel.org>
 <23dc9c8f0305da291027f64f583beda22a65d77849bc00c08eb88f32e4651d95@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23dc9c8f0305da291027f64f583beda22a65d77849bc00c08eb88f32e4651d95@mail.kernel.org>

On Sat, Apr 18, 2026 at 06:49:09AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1154,6 +1154,8 @@ enum bpf_attach_type {
> >  	BPF_TRACE_KPROBE_SESSION,
> >  	BPF_TRACE_UPROBE_SESSION,
> >  	BPF_TRACE_FSESSION,
> > +	BPF_TRACE_FENTRY_MULTI,
> > +	BPF_TRACE_FEXIT_MULTI,
> >  	__MAX_BPF_ATTACH_TYPE
> >  };
> 
> In RFC v2 (Feb 4, 2026), Leon Hwang asked whether BPF_TRACE_FSESSION_MULTI
> should be added alongside BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI
> for API consistency, since BPF_TRACE_FSESSION exists and is handled
> similarly to FENTRY/FEXIT. You acknowledged this with 'good catch, will add
> it' but BPF_TRACE_FSESSION_MULTI was never added in any subsequent version
> (v1, v2, v3, v4, or v5).
> 
> Is this attach type intentionally omitted, or should it be included to
> complete the multi tracing API?

ansrewed in the other reply

> 
> Reference: https://lore.kernel.org/bpf/3015991d-2e9b-4bf4-9c17-26e00b5d5926@linux.dev/
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -19368,7 +19379,17 @@
> >  		if (ret < 0)
> >  			return ret;
> >
> > -		if (tgt_prog) {
> > +		/* *.multi programs don't need an address during program
> > +		 * verification, we just take the module ref if needed.
> > +		 */
> > +		if (is_tracing_multi_id(prog, btf_id)) {
> > +			if (btf_is_module(btf)) {
> > +				mod = btf_try_get_module(btf);
> > +				if (!mod)
> > +					return -ENOENT;
> > +			}
> > +			addr = 0;
> > +		} else if (tgt_prog) {
> 
> This isn't a bug, but the new multi-line comment here uses the old kernel
> comment style with text on the same line as the opening '/*'. The BPF
> subsystem guide mandates the modern multi-line style with '/*' on its own
> line for new code under kernel/bpf/, even if surrounding code still uses
> the old style.
> 
> Should the comment be reformatted as:
> 
> 	/*
> 	 * *.multi programs don't need an address during program
> 	 * verification, we just take the module ref if needed.
> 	 */

sure

jirka

> 
> > @@ -19396,6 +19417,12 @@
> >  			ret = -EINVAL;
> >  			switch (prog->type) {
> >  			case BPF_PROG_TYPE_TRACING:
> > +				/* *.multi sleepable programs will pass initial sleepable check,
> > +				 * the actual attached btf ids are checked later during the link
> > +				 * attachment.
> > +				 */
> > +				if (is_tracing_multi_id(prog, btf_id))
> > +					ret = 0;
> 
> The same comment style issue appears here. Should this also use the modern
> style with '/*' on its own line?
> 
> Note that another comment you added in check_attach_btf_id uses the correct
> modern style, making this inconsistency clearly fixable.
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24598000047

