Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E1F3F0AA0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 May 2026 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974025; cv=none; b=st5nOQIY3JBkHLm4USsdmAG+9poJeeE5mfz+RHCqW5wJtDfgaTAvY07TWDNUcPDJga6e0fA+vmCxcJ5I40JRNA6v6nynBpS55V1M7uLPQISonleidSeQK7C5KJONMDtc6qI0vKcJyH6Yut4HqFuxjADZlETVZk/KIRzPT02tBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974025; c=relaxed/simple;
	bh=iNaI+nFEr8C9DO/sPmeOA7cPTZbWkxfBn4enxKJCerc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jncHUC+B/lYN0kbeGhzEGdNh0i/q5oqdVpgBp4/QAPxvTVp1uVzg+7QREiYvK045yqnpamZHsnEWN88ykgTkIRbetBsEqG0jK07vByAheASdeVhtFShyKyfH+fpfJRj8LZt0EiCQoZtIK2EET4V1oYfm6Nrw08HXJiigV4aPp8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq5+KUCt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq5+KUCt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso11074200f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 May 2026 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779974022; x=1780578822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PVPqbiZ2BmYnKxbQOHUMOlkHdxsA7Q8DniMbt0NdK3Y=;
        b=Lq5+KUCtydK/IKDkyDJ/V0bQg3/OcSEIhVuhWvkVmGU2Qw1UleMw2RuAscUsY7oDzl
         ICMqQzF6MnnlO30GjdpRbEbj6Ei3aiXzEnMnQpQKNy242RY0yAusrD1tuaPOm+kDgrIK
         9Muk8NV5DgVizIoLXjj+FQJs7fmHrNUdjnYOj5ZprhArYX4vqGzMTPEC0h5tEoTnLIgB
         PGu9HlF52bh1u9IqIkCASCncYo94ka4oiYngYknTmN/scbT1MT60ZciSxHvfHNjj0pAi
         kePT1YticKtSCkA/uyMq2D/Jf1g9BjbUv9BGRGJOLPwDO0lSscD3ThAP7ecxpu7JHKY0
         K0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779974022; x=1780578822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVPqbiZ2BmYnKxbQOHUMOlkHdxsA7Q8DniMbt0NdK3Y=;
        b=HzVSxVS/gojmNGPrnObnc+JRYAGD1krjT0ukGp0SQal/o8jPdzSu1wu9MHSlfvnA4a
         JQCJlBQOzWQNjITnaGOmFfK3T08TUVxD9CeLUqdznxKR3/Dpz+Z0hGq6Wbu6MUT+oVMA
         Mfuuuuy+soBMuCTdjcp1X7jidYMDWl+ms884cAGBHSh8q2SIw4GbSMI8rHLAFQCASW2B
         /VKnh1G1iUoMYCa3wYvUGEcIpcV3YwtcX2CxS9SpPsS8LcjQu+9fVpNO008YlPoq4dJ9
         CjKW8+PpDaEtjL6AEbicAGGz4MpBZ3r4VstgugJD2W/vIywpQZQS+pwBCdBv49UJC0Ze
         101w==
X-Forwarded-Encrypted: i=1; AFNElJ/VtUdIKNbPwm7xT+KbThtUTqzvYJQEeni+tx7Zg3lifgQOshnqMUNSMhzEQ5M8KD9VucINGHZ3d3vBXAdas91XyDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxre+IWLEWIQ+TU1codQ37Hj2t2BdMPdarOcEcC5oA9CG7Dg6Hr
	pIaBQyc//VjC/7lJ6uEO0Lyx8YKwfhrEzEpAYNkXlBHBe6Y9wPeOiS36
X-Gm-Gg: Acq92OH+rBJUWdK0z3rRVbgDd3iE7PY1if9dtnYnVVQbX8HYY1ixm5yjA922xjUrBfY
	3MGpZk32kyu+NMkuD6vXOJh4woeV4Ip/jgxfFyiVOTrXbaHfnJtj7k/04QZk1yHmtJswGj6+LZH
	3KFJ/iDXSSHeaBHhTziSXsU9iTtDkFALgI/8xsHdplKMlBEXZDS8ICWJts2StVI2w/lLF/nEf4+
	NzkJG7Nx1IE8lJlmvWSUaol9zERqLmC/Jo0vCgGvBoDb1nXGkc/8CoLU9VlvLwTwk8WTEP3AMpg
	56N7SMXzcyVdtDKMcNykvfOY3Hyjp47k1uDaeyPUfKbpGKVIkcPCdo3gZ2M93fOvZNNjilt0WHz
	RIdA0dABv/To4zxUHoyA4FqfQ8buWn3pZEEvYFxMiH/+ZpPqFXzdozBn2rZuRAKmcoYnF0Kn3/T
	geDzhw7QUl53xwi84vpY/7AD6F/Q==
X-Received: by 2002:a5d:6f01:0:b0:45e:e95c:8106 with SMTP id ffacd0b85a97d-45ee95c81f4mr3625956f8f.13.1779974022153;
        Thu, 28 May 2026 06:13:42 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5584b8sm12912642f8f.11.2026.05.28.06.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:13:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 28 May 2026 15:13:39 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv6 bpf-next 10/29] bpf: Add multi tracing attach types
Message-ID: <ahg_gxSxmDNhoGoA@krava>
References: <20260527113951.46265-11-jolsa@kernel.org>
 <23ab5817f619274a252b35119e760817c383e3c20f9ce9facccbf4b4fec9dd58@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23ab5817f619274a252b35119e760817c383e3c20f9ce9facccbf4b4fec9dd58@mail.kernel.org>

On Wed, May 27, 2026 at 12:59:43PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 435ae6efe961..27ad0c265c95 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -41,6 +41,7 @@
> >  #include <linux/overflow.h>
> >  #include <linux/cookie.h>
> >  #include <linux/verification.h>
> > +#include <linux/btf_ids.h>
> >
> >  #include <net/netfilter/nf_bpf_link.h>
> >  #include <net/netkit.h>
> 
> [ ... ]
> 
> > @@ -2904,6 +2914,11 @@ static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
> >  	return 0;
> >  }
> >
> > +extern int bpf_multi_func(void);
> > +int __init __used bpf_multi_func(void) { return 0; }
> 
> The signature change from v5 to v6 creates a potential issue. In v5,
> bpf_multi_func had 6 arguments (matching the initial verifier setup):
> 
>   int __init __used bpf_multi_func(u64 r1, u64 r2, u64 r3,
>                                    u64 r4, u64 r5, u64 r6)
> 
> Now it has no arguments. The Sashiko AI review in v5 identified that
> context array bounds checking could fail when bpf_multi_func's argument
> count doesn't match the attached function's argument count, and the
> author acknowledged the need to disable direct context access.
> 
> Since the initial verification happens against bpf_multi_func (which now
> has 0 arguments), but the verifier previously allowed direct ctx[0-5]
> accesses based on the 6-argument version, is there still a path where
> direct context accesses could be allowed? If so, would accessing ctx[0]
> on a function with 0 arguments lead to out-of-bounds kernel stack reads?
> 
> The earlier review suggested either:
>   (a) explicitly disabling direct memory accesses to the ctx array for
>       FENTRY_MULTI and FEXIT_MULTI, or
>   (b) enforcing the use of bounds-checked helpers like bpf_get_func_arg()
> 
> Was this implemented somewhere in the patch series?

it's implemented through bpf_multi_func without any arguments,
then verifier won't allow any access to any argument,
including ctx[0], which is 1st argument

jirka

> 
> > +
> > +BTF_ID_LIST_GLOBAL_SINGLE(bpf_multi_func_btf_id, func, bpf_multi_func)
> 
> [ ... ]
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c8d980fdd709..58450cb88beb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -18837,6 +18839,11 @@ static int check_attach_modify_return(unsigned long addr, const char *func_name)
> >
> >  #endif /* CONFIG_FUNCTION_ERROR_INJECTION */
> >
> > +static bool is_tracing_multi_id(const struct bpf_prog *prog, u32 btf_id)
> > +{
> > +	return is_tracing_multi(prog->expected_attach_type) && bpf_multi_func_btf_id[0] == btf_id;
> > +}
> > +
> >  int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  			    const struct bpf_prog *prog,
> >  			    const struct bpf_prog *tgt_prog,
> 
> [ ... ]
> 
> > @@ -19094,7 +19105,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  		if (ret < 0)
> >  			return ret;
> >
> > -		if (tgt_prog) {
> > +		/*
> > +		 * *.multi programs don't need an address during program
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
> >  			if (subprog == 0)
> >  				addr = (long) tgt_prog->bpf_func;
> >  			else
> 
> [ ... ]
> 
> > @@ -19122,6 +19144,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  			ret = -EINVAL;
> >  			switch (prog->type) {
> >  			case BPF_PROG_TYPE_TRACING:
> > +				/* *.multi sleepable programs will pass initial sleepable check,
> > +				 * the actual attached btf ids are checked later during the link
> > +				 * attachment.
> > +				 */
> > +				if (is_tracing_multi_id(prog, btf_id))
> > +					ret = 0;
> >  				if (!check_attach_sleepable(btf_id, addr, tname))
> >  					ret = 0;
> 
> The multi types are not included in btf_validate_prog_ctx_type() in
> kernel/bpf/btf.c. That function validates which attach types allow u64*
> as their ctx parameter:
> 
> kernel/bpf/btf.c:btf_validate_prog_ctx_type() {
>     case BPF_TRACE_FENTRY:
>     case BPF_TRACE_FEXIT:
>     case BPF_MODIFY_RETURN:
>         ...
> }
> 
> Since BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI also use u64*
> context, do they need to be added to that validation list? Or if direct
> context access should be disabled for multi types (per the earlier
> review concern), should they be handled with special rejection logic?
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26509800686

