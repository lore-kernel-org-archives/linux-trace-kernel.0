Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16834E764
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546592; cv=none; b=JKequOtFwI9DPVtpwiY4Sef/luDKGK4HP+nu7ehKT0rQEVLm2ThS+iC9vcXyb01ikSnyZZxainx+lPQla9Lbc3FHv8tr8r3CUFCtzmVybc+lKpW8o4xKILZ8tx6GQxzgdKJDdeYXsL7aPb/dkYsyy4FlKI4jL7lM3DAcEEyWk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546592; c=relaxed/simple;
	bh=IouruH1wyjICtY+CKH8bTvwmHZwP+tPZuUV8U6LOyeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pgAVKUN9W/q2CSV6rzaX3061XmHHdSBWgU0Q+CL/fqOh6VGjJHr22d3Up8HMZLKNJmjdDgT8H4lELQdJS3c2tZBsMJll5IoJlxC3HHQaXJ/CaK4ZbHW6c37rtEUUOW5Vh/o/BDbfsHSt9WJGEM4oEiu41IFspMsu+WomzBUAFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sbRyK+Li; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sbRyK+Li"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768546578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qk0mL3VptZFxLDuzRgThSiMzfUC3hfj/FBMELIOnOsI=;
	b=sbRyK+LiZ/K4YOSn0SlAoNPGORCHMQl3yhjcsmYGA3P4yETqZznQ1BJrJlJftyL1R0uth8
	0RAODAIjWNhV89VKspNn+3UrgmLOrsxJnNyYkyEZE5bL135BWjspNlLFdRMeqX8B+mSE3f
	WyTfCkLSJ+M7n+z2tSO5PeCS3oSBRJI=
From: Menglong Dong <menglong.dong@linux.dev>
To: menglong8.dong@gmail.com, ast@kernel.org, bot+bpf-ci@kernel.org
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, mattbobrowski@google.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject:
 Re: [PATCH bpf-next 1/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Fri, 16 Jan 2026 14:56:01 +0800
Message-ID: <5069848.31r3eYUQgx@7940hx>
In-Reply-To:
 <bf8e99a4398ad6c1383a82fd33fa1e0cfdfc6b935c8d4d8f5216a64cafccb660@mail.kernel.org>
References:
 <20260116035024.98214-2-dongml2@chinatelecom.cn>
 <bf8e99a4398ad6c1383a82fd33fa1e0cfdfc6b935c8d4d8f5216a64cafccb660@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/16 12:20 bot+bpf-ci@kernel.org write:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7a375f608263..223e5b483bbd 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -23321,8 +23321,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >  		/* Implement bpf_get_func_arg inline. */
> >  		if (prog_type == BPF_PROG_TYPE_TRACING &&
> >  		    insn->imm == BPF_FUNC_get_func_arg) {
> > +			if (eatype == BPF_TRACE_RAW_TP) {
> > +				int nr_args;
> > +
> > +				if (!prog->aux->attach_func_proto)
> > +					return -EINVAL;
> > +				nr_args = btf_type_vlen(prog->aux->attach_func_proto);
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> The attach_func_proto for raw tracepoints points to the BTF func_proto of
> __bpf_trace_* or btf_trace_* which has an extra "void *__data" as the
> first parameter. For example, a tracepoint declared with TP_PROTO(int a)
> results in a btf_trace_* typedef of "void (*)(void *__data, int a)" which
> has 2 parameters.
> 
> Does btf_type_vlen() return the count including the hidden __data param?
> If so, a tracepoint with 1 actual argument would report nr_args=2, but
> the BPF context only contains 1 argument. Calling bpf_get_func_arg(ctx, 1)
> would pass the bounds check (1 < 2) but read out of bounds from ctx.
> 
> The bpf_trace_run* functions populate args[] with only the actual
> tracepoint arguments (see __bpf_trace_run() in kernel/trace/bpf_trace.c),
> not including __data. Should nr_args be adjusted by subtracting 1 to
> account for the hidden first parameter?

You are right about this point too. The wrong selftests made me
ignore this point :/

Thanks!
Menglong Dong

> 
> > +				/* Save nr_args to reg0 */
> > +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> > +			} else {
> > +				/* Load nr_args from ctx - 8 */
> > +				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
> > +			}
> 
> [ ... ]
> 
> > @@ -23374,8 +23384,18 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
> >  		/* Implement get_func_arg_cnt inline. */
> >  		if (prog_type == BPF_PROG_TYPE_TRACING &&
> >  		    insn->imm == BPF_FUNC_get_func_arg_cnt) {
> > +			if (eatype == BPF_TRACE_RAW_TP) {
> > +				int nr_args;
> > +
> > +				if (!prog->aux->attach_func_proto)
> > +					return -EINVAL;
> > +				nr_args = btf_type_vlen(prog->aux->attach_func_proto);
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Same question here for bpf_get_func_arg_cnt() - should this subtract 1 to
> exclude the __data parameter from the count returned to BPF programs?
> 
> > +				/* Save nr_args to reg0 */
> > +				insn_buf[0] = BPF_MOV64_IMM(BPF_REG_0, nr_args);
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21055137351
> 




