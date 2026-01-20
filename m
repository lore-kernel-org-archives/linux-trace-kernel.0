Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0973E3D648C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897091; cv=none; b=V6c4Ns+JgD41XlTnQH/Zo9AUZASDKr/4A3gxVwJL+Hd46fqLXwWFsROtbdrNfUO59m9n3sZhHSFRIjg5YwjRbore9YOfvX0kUObEq32kILivCR1AAq82AfmQtphie3YwsMPwefNxgNss+A96HO9sWmZgCo/uhhFAF9ytIJPeLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897091; c=relaxed/simple;
	bh=V/Kq3GM7CdWxPmjGGXhopMN4k/ZB4/Fsz8cCFlNNsd8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqTqqEsbvlCA3mAiDN9IYnL2nVq6bWy/wNrmQk52ouHE6xOw53J24noqN8h35edN1zazUp4xk2NQgV7C8OJf/DY/+jWbLd3eleSkmGrSdm3Z50CXXDGOjEdt8zYFr4Xwx2kl1eI/4z32jLQwjcvOnZudmA+eIru+BZUYD7nWKpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bragcW9m; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bragcW9m"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso29425575e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 00:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768897088; x=1769501888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dvxdF1yW3erVUZtptDE7+oEUIWOlSFR799M0RZyknHo=;
        b=bragcW9m0iOSGuycHdBq3b6x5jDMNUawHUzwVNA18tioo+4GsDjexMPTPfDFVhOEk2
         tbZ9av0/dgUiR3VGKExvH3ltgz2E2HVXOOWev5YurRYHoPRXjEvIAIDs2NklCl9/i4yl
         mWdx/FSFpP68yLp6wPr1JnPhiX3W1bLk3i25R//4naqSAQz9UnFta86aIDkzCAUoosCI
         ae+yHx6SXjGHwmgO9fnL7jsXtifJ9QUanhTCYMvF43kkvSj7sQ4CB7duM6NWjNUHNpul
         /dtyzrZr198X7CHzldWySUCKiShAJH5XAsZLSpEh6PczzkiqwjAG/46zYI19nwve7aJJ
         ECSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768897088; x=1769501888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvxdF1yW3erVUZtptDE7+oEUIWOlSFR799M0RZyknHo=;
        b=YjTwHXBIL9K3gmK+OJRj2JggYk806R2R4x+RNG/ga1DNkHkYfxqBqhk/9WnkzN6q6f
         zu883b3zvGZzCLdrrRL45ilYTWu5VgZGEY5aGsGTVlR1QS8BTBYPdGDsdKB5dX6OwfC3
         Wujk+d7SGhKeZQVkmucRtzecHbmv1xTltm3yx3biDxs5Q2G93EXrrspvjf2m7tTE50zi
         WhzV1dkJ74Kmgex+fOqzQUi+5e/zsJxHG0AjAV/Tz5rwEXqxdf32/fydDTbFO0U0PT9B
         ltzLkL0c0bRWkTLMp/2dQlSYK7kAZjR7bBlyQw3sA8VaUop2n/CJqtENRnBS8rYwc0VH
         rwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMnmXn1EPjtd1UNLoQ0fYo07ASg1jNVxDpxkj5mFInLxCu2FRgv1rRzv20YQD2j5HA2ujui201bSuAE2d4XwCpT2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCSr2FeSH1+gaEDFxaMWn+kQ1u4Gian7MJWyTsd4886B4hgkkA
	Dp3IN5g26K3RxC5PxdlkoVqxXfOxIkXygRrvHwTK+/d5Ne3/yvKIIoRD
X-Gm-Gg: AY/fxX7Yro/UD05qskKc99YM8aAi8VrPpppegWQcm6ugSbG7PJ5DnzvYofgoqJte+dR
	NZBY7gjfIEGXNrQbRCHr5kq8+HJ9EDTZ2W62ZHet79wPfSxbDyoXHzqHX4LsWcm/KZ0HU0pZCJx
	gPbCk5lm9Jwq5nELLi7aRJwZaE8fhnzS461i5lirVcpy5EwHIEsSjQXJTtQFM/6Ogx/aO6f49Bf
	Ru/oBnyThtlpOtiuWEIYm6V7qbP9W0ZYnRQgbK4C+5B8UEuW2I0030f4WOOLSrPBCHwbqwlkQaH
	PRndX3rvfOvdrJwMPqmQJy9cfjMAgfmL0nZ5CWqdmqnlJjFyA4AEAkNr7A+dh+HA4LpPRI98nS/
	mon50PsccX/Fu8PX6oed3eMmsEu40UzGGBGfa4+UYmwBD9QtXP/Xp/4pnwVLi
X-Received: by 2002:a05:600c:8b67:b0:47d:3ffb:16c9 with SMTP id 5b1f17b1804b1-4801e342091mr141811525e9.23.1768897088056;
        Tue, 20 Jan 2026 00:18:08 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9ebc1bsm102170685e9.5.2026.01.20.00.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 00:18:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 20 Jan 2026 09:18:06 +0100
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, andrii@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com,
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, mattbobrowski@google.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: support bpf_get_func_arg() for
 BPF_TRACE_RAW_TP
Message-ID: <aW86Pqgipfb_59S_@krava>
References: <20260119023732.130642-1-dongml2@chinatelecom.cn>
 <20260119023732.130642-2-dongml2@chinatelecom.cn>
 <aW7APKlKCgg2_YvW@krava>
 <6099572.DvuYhMxLoT@7950hx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6099572.DvuYhMxLoT@7950hx>

On Tue, Jan 20, 2026 at 09:24:46AM +0800, Menglong Dong wrote:
> On 2026/1/20 07:37, Jiri Olsa wrote:
> > On Mon, Jan 19, 2026 at 10:37:31AM +0800, Menglong Dong wrote:
> > > For now, bpf_get_func_arg() and bpf_get_func_arg_cnt() is not supported by
> > > the BPF_TRACE_RAW_TP, which is not convenient to get the argument of the
> > > tracepoint, especially for the case that the position of the arguments in
> > > a tracepoint can change.
> > > 
> > > The target tracepoint BTF type id is specified during loading time,
> > > therefore we can get the function argument count from the function
> > > prototype instead of the stack.
> > > 
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > > v3:
> > > - remove unnecessary NULL checking for prog->aux->attach_func_proto
> > > 
> > > v2:
> > > - for nr_args, skip first 'void *__data' argument in btf_trace_##name
> > >   typedef
> > > ---
> > >  kernel/bpf/verifier.c    | 32 ++++++++++++++++++++++++++++----
> > >  kernel/trace/bpf_trace.c |  4 ++--
> > >  2 files changed, 30 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index faa1ecc1fe9d..4f52342573f0 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -23316,8 +23316,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> > >  		/* Implement bpf_get_func_arg inline. */
> > >  		if (prog_type == BPF_PROG_TYPE_TRACING &&
> > >  		    insn->imm == BPF_FUNC_get_func_arg) {
> > > -			/* Load nr_args from ctx - 8 */
> > > -			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > > +			if (eatype == BPF_TRACE_RAW_TP) {
> > > +				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
> > > +
> > > +				/*
> > > +				 * skip first 'void *__data' argument in btf_trace_##name
> > > +				 * typedef
> > > +				 */
> > > +				nr_args--;
> > > +				/* Save nr_args to reg0 */
> > > +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> > > +			} else {
> > > +				/* Load nr_args from ctx - 8 */
> > > +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > > +			}
> > >  			insn_buf[1] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
> > >  			insn_buf[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
> > >  			insn_buf[3] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
> > > @@ -23369,8 +23381,20 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> > >  		/* Implement get_func_arg_cnt inline. */
> > >  		if (prog_type == BPF_PROG_TYPE_TRACING &&
> > >  		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
> > > -			/* Load nr_args from ctx - 8 */
> > > -			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > > +			if (eatype == BPF_TRACE_RAW_TP) {
> > > +				int nr_args = btf_type_vlen(prog->aux->attach_func_proto);
> > > +
> > > +				/*
> > > +				 * skip first 'void *__data' argument in btf_trace_##name
> > > +				 * typedef
> > > +				 */
> > > +				nr_args--;
> > > +				/* Save nr_args to reg0 */
> > 
> > I think we can attach single bpf program to multiple rawtp tracepoints,
> > in which case this would not work properly for such program links on
> > tracepoints with different nr_args, right?
> 
> Hi, Jiri. As for now, I think we can't do that when I look into
> bpf_raw_tp_link_attach(). For the BPF_TRACE_RAW_TP, we specify
> a target btf type id when loading the bpf prog. And during
> attaching, it seems that we can only attach to that target, which
> means that we can't attach to multiple rawtp tracepoint. And
> we can't change the target btf id when reattach, too. Right?
> 
> Part of the implement of bpf_raw_tp_link_attach():
> 
> static int bpf_raw_tp_link_attach(struct bpf_prog *prog,
> 				  const char __user *user_tp_name, u64 cookie,
> 				  enum bpf_attach_type attach_type)
> {
> 	struct bpf_link_primer link_primer;
> 	struct bpf_raw_tp_link *link;
> 	struct bpf_raw_event_map *btp;
> 	const char *tp_name;
> 	char buf[128];
> 	int err;
> 
> 	switch (prog->type) {
> 	case BPF_PROG_TYPE_TRACING:
> 	case BPF_PROG_TYPE_EXT:
> 	case BPF_PROG_TYPE_LSM:
> 		if (user_tp_name)
> 			/* The attach point for this category of programs
> 			 * should be specified via btf_id during program load.
> 			 */

ah there's the name check, ok.. got confused by the max_ctx_offset
check in bpf_probe_register

thanks,
jirka

> 			return -EINVAL;
> 		if (prog->type == BPF_PROG_TYPE_TRACING &&
> 		    prog->expected_attach_type == BPF_TRACE_RAW_TP) {
> 			tp_name = prog->aux->attach_func_name;
> 			break;
> 		}
>                        [......]
>                        }
> [......]
> }
> 
> Thanks!
> Menglong Dong
> 
> > 
> > jirka
> > 
> > 
> > > +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> > > +			} else {
> > > +				/* Load nr_args from ctx - 8 */
> > > +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > > +			}
> > >  
> > >  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, 1);
> > >  			if (!new_prog)
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 6e076485bf70..9b1b56851d26 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -1734,11 +1734,11 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > >  	case BPF_FUNC_d_path:
> > >  		return &bpf_d_path_proto;
> > >  	case BPF_FUNC_get_func_arg:
> > > -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_proto : NULL;
> > > +		return &bpf_get_func_arg_proto;
> > >  	case BPF_FUNC_get_func_ret:
> > >  		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_ret_proto : NULL;
> > >  	case BPF_FUNC_get_func_arg_cnt:
> > > -		return bpf_prog_has_trampoline(prog) ? &bpf_get_func_arg_cnt_proto : NULL;
> > > +		return &bpf_get_func_arg_cnt_proto;
> > >  	case BPF_FUNC_get_attach_cookie:
> > >  		if (prog->type == BPF_PROG_TYPE_TRACING &&
> > >  		    prog->expected_attach_type == BPF_TRACE_RAW_TP)
> > 
> > 
> 
> 
> 
> 
