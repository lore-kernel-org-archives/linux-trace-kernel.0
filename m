Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1AA35502F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049615; cv=none; b=gqu0d3dK53rThAB5iomAmmulNdYsdoLh5+twOB/bZbvdryX5Wt/XyF3CUiyMX78+xNHYP7Ppxxlk5RuWixS2k853w8oaRNaJSEU0fCVPhjexEclzhXD3krMQ3EUKSn/whtmomn+SBe7v547/e641RxTHrxfbdR8EJCl8zBSl24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049615; c=relaxed/simple;
	bh=Bk2Yi8IlMVkK5Th/TKv8hz5GIBxMcnyGwmnSkYoCwfw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0vniSf8lG2wntXY3zYUG1GzHSIIf+pezoih5ctPswPJpOCI6QIh6n3n/gMQsHRBcsWG2OORB1TGOQ9TnyPjPC/01DCqsIl+anjrgXSIfKTdrSwoS71EMnxhY0nABBlPGs7+rNW5Sk2CeY1MbKvY9s5UbMiU/iJHNaSkhc0yIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAFvYIks; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAFvYIks"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64320b9bb4bso2194276a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763049612; x=1763654412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gzb4D1GabgQR1ju/bq7TjXAWkIanxQvrQtrf25MzCcs=;
        b=RAFvYIksFbTcUElygENb+Rgi/N0hwx9HIVP71lQAko8IjJtyIMOnWhmNIZ5NhbChgv
         R5yIGtSRkfczmDEsT0LzriM7tby5CY+yriDqWoI1I1NHOc7Wi5zmdfdOhf2c1D1ZEONz
         NigaCZ3q55/AojXH8pQiQGKTrjHsAU91shyPbTfkWJyuxvCTarPGsVaTlerywzAC6PC1
         3IJFaKPDjQN9P/GcHp4Vb11GC9zKf2HTHxEAzEfzNUoHQbVsofM1vLcT1uzGy6G/yWug
         l6yEkYl/mqZLvznZ+wAvz2WuyHAWhQaYcSr6+e03bnu05v3HL7/Mw6b3lDUGCVkG6j+r
         +dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049612; x=1763654412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzb4D1GabgQR1ju/bq7TjXAWkIanxQvrQtrf25MzCcs=;
        b=Ldod+OL0cLjitwv3JyDTjdKrtYmS1q/oTk160wI3Edu2HbpKBEfAeY40/ZQJtt952s
         SIJsw1lMl3lcD82ipWt8kUHb5ndyu39xI0C+xSP0957Ns1lqYc2WjJCa75fEMAxbjAnr
         bRzk2ao6UuLCzYIoOP75cwnJoyI5oljTqOg6m3+C5GPs9V2pjjYP7lG+ELx6GB7VpPYx
         ggT2kVIUHcf/gtfSHYadyCzV7iugRP72MzCPDhk/1acGcIyF+NzjhVm5NWBFnvTvkpFG
         A1M1HTdzDU6v5gWall9ISvIcpaKE4TBNo2KrWtVvU1Mw9xGuExTu+/lIOFJYuDJ3gjdD
         dXGg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4Zx/tyUbzqtZNOZpvFPC3L/pgRvFHn3zWDAs3L8OfYQmWNuOEI2i7jiThI+Z9VDQFdHYJBvD1Aai4HZZlQc/4f0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr+UpdVSgffZC15lRDW592VV7tcFf/9NW6yHRdbEMkoBM95vWC
	0v160NkYdl32WR7flm+senF5YO/Q954pobUmccDyt/onjg/d5hcZyIO+
X-Gm-Gg: ASbGnculye5dGcm7xTW5Lt0G/9Gk9LOTLa4UdFK8/pkm25M8PhbuypExdRLRGYU8bQk
	m0iFEMS+tL17p7FisSwLNdPEgZROk0FgCy/qDG+wgdd3Nr3OgG7dp/Tbi2BxuV6/2jqf/RmIEng
	BjfOGiNyfz+maeNpXdWcSQmhNaJ6Nz7ujUfWvb+gGefMaNCgRThD8sb+JvaxyAZoXEMob9omzPN
	xzFntYjSO4yyptOllTaD4KH0hLX/qL3UjC7oVI1htWw4Vod4Pm595yi+8pLDoqYxm7Aq8OhYZyG
	22B8eZ2K/4voqj5RHSEgmilJKP7UwU8FBqnj33uUvefzdt50UYfyu2rOhE4PQ35T/2QFlvCk/KB
	sivCI1AuUYOERixL+VZIp+L3AoSNuoB8H7lm/PxHMtdQOXvujfFlTZVUGEXm2hDmg+h8Yq6C2F2
	IRw8h2WnjYsXoLBSVXT1P/qpA=
X-Google-Smtp-Source: AGHT+IHUg8m5nO6prqhXXrSop0u0iR1DdBAnMZvxLkNNj0vJkvj5xpmWgf1HYEe7mOE2U9QwaFpzYw==
X-Received: by 2002:a05:6402:4544:b0:640:9bed:85a5 with SMTP id 4fb4d7f45d1cf-6434f82b24dmr70380a12.8.1763049611134;
        Thu, 13 Nov 2025 08:00:11 -0800 (PST)
Received: from krava (37-188-200-155.red.o2.cz. [37.188.200.155])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3d8775sm1729153a12.5.2025.11.13.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:00:10 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 13 Nov 2025 17:00:04 +0100
To: bot+bpf-ci@kernel.org
Cc: rostedt@kernel.org, revest@google.com, mark.rutland@arm.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, menglong8.dong@gmail.com,
	song@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 5/8] ftrace: Add update_ftrace_direct_mod
 function
Message-ID: <aRYAhDqGsOHZzTL-@krava>
References: <20251113123750.2507435-6-jolsa@kernel.org>
 <c3260fe9e3d8ad79c75a6e8281f9fae5580beb3fcdd08e2015f417e11ec0a1b2@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3260fe9e3d8ad79c75a6e8281f9fae5580beb3fcdd08e2015f417e11ec0a1b2@mail.kernel.org>

On Thu, Nov 13, 2025 at 01:02:17PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 433c36c3a..bacb6d9ab 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -544,6 +544,7 @@ int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
> >
> >  int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_hash *hash);
> >  int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash);
> > +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock);
> >
> >  void ftrace_stub_direct_tramp(void);
> >
> > @@ -581,6 +582,11 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> >  	return -ENODEV;
> >  }
> >
> > +int modify_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
> The stub function name doesn't match the declaration. Should this be
> update_ftrace_direct_mod() instead of modify_ftrace_direct_hash()?

it should, my bad

> 
> > +{
> > +	return -ENODEV;
> > +}
> > +
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 345f3fdd2..627d05b57 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -6445,6 +6445,74 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> >  	return err;
> >  }
> >
> > +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
> > +{
> > +	struct ftrace_hash *orig_hash = ops->func_hash->filter_hash;
> > +	struct ftrace_func_entry *entry, *tmp;
> > +	static struct ftrace_ops tmp_ops = {
> > +		.func		= ftrace_stub,
> > +		.flags		= FTRACE_OPS_FL_STUB,
> > +	};
> > +	unsigned long size, i;
> > +	int err;
> > +
> > +	if (!hash_count(hash))
> > +		return 0;
> > +	if (check_direct_multi(ops))
> > +		return -EINVAL;
> > +	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> > +		return -EINVAL;
> > +	if (direct_functions == EMPTY_HASH)
> > +		return -EINVAL;
> > +
> > +	if (do_direct_lock)
> > +		mutex_lock(&direct_mutex);
> > +
> > +	/* Enable the tmp_ops to have the same functions as the direct ops */
> > +	ftrace_ops_init(&tmp_ops);
> > +	tmp_ops.func_hash = ops->func_hash;
> > +
> > +	err = register_ftrace_function_nolock(&tmp_ops);
> > +	if (err)
> > +		goto unlock;
> > +
> > +	/*
> > +	 * Call __ftrace_hash_update_ipmodify() here, so that we can call
> > +	 * ops->ops_func for the ops. This is needed because the above
> > +	 * register_ftrace_function_nolock() worked on tmp_ops.
> > +	 */
> > +	err = __ftrace_hash_update_ipmodify(ops, orig_hash, orig_hash, true);
>                                                                         ^^^^
> Does __ftrace_hash_update_ipmodify() accept a fourth argument? The
> function signature shows it only takes three parameters (ops, old_hash,
> new_hash). This looks like a compilation error.

the whole patchset is based on bpf-next/master plus Song's livepatch
fixes which change modify_ftrace_direct_hash function, it's mentioned
in the cover letter

> 
> > +	if (err)
> > +		goto out;
> 
> [ ... ]
> 
> > +
> > +out:
> > +	/* Removing the tmp_ops will add the updated direct callers to the functions */
> > +	unregister_ftrace_function(&tmp_ops);
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Can this deadlock when do_direct_lock is true? Looking at the code:
> 
>   update_ftrace_direct_mod() with do_direct_lock=true
>     -> mutex_lock(&direct_mutex)
>     -> register_ftrace_function_nolock(&tmp_ops) succeeds
>     -> __ftrace_hash_update_ipmodify() fails
>     -> goto out (still holding direct_mutex)
>     -> unregister_ftrace_function(&tmp_ops)
>        -> cleanup_direct_functions_after_ipmodify()
>           -> mutex_lock(&direct_mutex) /* deadlock */
> 
> The unregister path tries to reacquire direct_mutex that we're already
> holding.

I don't think this can happen because tmp_ops does not have
FTRACE_OPS_FL_IPMODIFY flag set

thanks,
jirka

> 
> > +
> > +unlock:
> > +	if (do_direct_lock)
> > +		mutex_unlock(&direct_mutex);
> > +	return err;
> > +}
> > +
> >  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19332026793

