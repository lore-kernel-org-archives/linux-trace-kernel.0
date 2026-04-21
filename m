Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4039F165
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761780; cv=none; b=oJ2CG2UKb0bsM4jSXtcmpJkB5497Et8345Twrw6W9Y1/8MCuPN3ydHyAWjlPjTdYorasbh3A8RcRz9xM+hmJr6xbeuOSE3UQVvX3fFQXgVLFoqf7G1D4sev3DA0KaHfnPrOBpMUloGzGcbwC3hYU8UieDnB4gGLc4HGg9fRMMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761780; c=relaxed/simple;
	bh=Cd94GWEu42bL1dMQIvtn85mO0ia9/1NDBg9ezYAtxNY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9W+d83jRNeXpq+2xsIlJDr89WdiwqxvDa5D0Zgyz/lTJXceqiO0kVJ2mYlNziWgz5XmGiDkK9cUKb5Snt0LwU10QfrtkdokOx92yrFJj0ucGJFnioOIIzVhH55+o2kVOdfIUKVdNX9CxNZEOQeocksYQ6t5+qeKlEhmPiApoJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAe+TxdK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAe+TxdK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso9988045e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761777; x=1777366577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2XQeGosdUgi1sGFXQhGDaX1YvzJIBu55Tc1f0h9PCw=;
        b=XAe+TxdKfWx0TitzUULI5vYM7DV4Rh0ydzzQM2+wcuwS8Ikb2VrO6PtW/JwnRzvtlW
         H2Mf3UTYF8ZFeklnQBy19eS1AfiF3UtiAXDOzfjQfSI+MW6FKgyJszD71KWaq7zu/vnp
         PCy+VWoBB0zUfxk5S8armT+4bBb+6dTmJ4Uw5HDNP7dxovk2tQIysngoUOAj2+ivhBcW
         KvarwqfIPvfGAXyLNhhbrbyKCc+ojxRKADN5H1C0bsoJiNxcHtUuqcnLdY6R5v+Nc0Zx
         2t+wHLUI9SKL0mXfzHp0PM1ccoUXVz6DxUnZ4QvPwzoZw9ipgYOOuYrbl4XrVgYLXnh0
         CPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761777; x=1777366577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2XQeGosdUgi1sGFXQhGDaX1YvzJIBu55Tc1f0h9PCw=;
        b=DYUFhdbNVZIHwStiMbLQjqIyOwZ/53MuwdqVUhqUnPHIenZXttp1Gu8LgbcUEjoyag
         nLw7UJNV+MsR4rmGSmW27acw5hxnSq2sjDRofaHgmxVp97436aKCWvSucFVIxnlSESDo
         Es/ZeYrCie9jTjPgERP+/9pIMBHauCzmzORoSQs6r3GewG1FaZk4B1Ge9NODZk/zPNtP
         rvNfo/pg0a9HzBW75MxmTe6cbHvehZBiFjpH74YBsoR+Al383R7SzQnTDVpAzVaaQBIP
         6vBu30ds6AE81dx/u4/lC6/NceGpC7PewhYfHFwp3/411sjduDzeiJNk8DWxWMJw2W45
         NSPg==
X-Forwarded-Encrypted: i=1; AFNElJ9wIeusfx+R1INOOAx7TL504vMwqu6euPwzOFFmg2ibbyvNGYalrh29hlyFDM0Z8FQEyEY4722Q9zZMi6OqVRThOkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1OQt4EhYFb8cZ1TogXvL4G7It/cj7GFxhZY+493HSxZSktP3y
	bJrvlUqKjN5qIGYH6eFK18zclh+Z2kgCquX+L1BS52HdvHv5UZlFvfnN
X-Gm-Gg: AeBDiesH7n0NnpE/jHaziXwOFp1F9h9pTksdvErbiW1xD7O7rHsT/ELL3b3pb4YfmqI
	j2DR8h2pCqf60TEUI1/44bIu5J96sJ5atUVxe74Wr0e97M3riygsNmbJh6OD/9oBUdHDPohQOxu
	iECuCUe5qw+1cGLW+HJLfehXtimkiQWfgEcF5wxfFHORfIAtl7hBpcHvisuFQ46wjF78ccSTfRS
	DYKGvs8imnIadlVl4nrnbQloJSvpCmmhy9DAMLHMFIdF6RO1QWmxQo6Lov8Fqds9HiyLA1BuDRE
	6mwHMxR9fYRK7LOmvjYNvnl83nY0aeEqOHZYBG1DJVleK/O+PCu25bxD58bjSKdUpY2AAzKkfre
	mYzvVbJBZs7RbTFIIppdC1+TWeq5uI2T7501wvwMjkveqmyGCKPZjWSYeMVdHLDDSrnFl1wbDyq
	drtE2u2b0=
X-Received: by 2002:a05:600c:3e17:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48a5565ee64mr29705855e9.22.1776761776754;
        Tue, 21 Apr 2026 01:56:16 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78becdsm165500085e9.5.2026.04.21.01.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:56:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:56:14 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 12/28] bpf: Add
 bpf_trampoline_multi_attach/detach functions
Message-ID: <aec7rmkXnZknylGu@krava>
References: <20260417192502.194548-13-jolsa@kernel.org>
 <11459a06ee7d070bdbdc3699d59adcdca12d5178eaa6ebd15286e0f51cc27141@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11459a06ee7d070bdbdc3699d59adcdca12d5178eaa6ebd15286e0f51cc27141@mail.kernel.org>

On Fri, Apr 17, 2026 at 08:22:36PM +0000, bot+bpf-ci@kernel.org wrote:

SNIP

> > +	if (ftrace_hash_count(data->modify)) {
> > +		err = update_ftrace_direct_mod(&direct_ops, data->modify, true);
> > +		if (err) {
> > +			WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->reg));
> > +			goto rollback_unlink;
> > +		}
> > +	}
> 
> Does update_ftrace_direct_del need a guard here?
> 
> When update_ftrace_direct_mod fails, the recovery code unconditionally
> calls update_ftrace_direct_del(&direct_ops, data->reg). However,
> update_ftrace_direct_add is itself only invoked when data->reg is
> non-empty:
> 
>     if (ftrace_hash_count(data->reg)) {
>         err = update_ftrace_direct_add(&direct_ops, data->reg);
>         ...
>     }
> 
> If all trampolines being multi-attached already had cur_image != NULL,
> nothing is ever added to data->reg, and the add call is skipped. Yet
> the recovery path still calls update_ftrace_direct_del with the empty
> data->reg.
> 
> update_ftrace_direct_del() at kernel/trace/ftrace.c:6511 does:
> 
>     if (!hash_count(hash))
>         return -EINVAL;
> 
> so it returns -EINVAL, and WARN_ON_ONCE fires. No further damage is
> done since the rollback_unlink path still unwinds correctly, but this
> is a spurious warning that becomes visible whenever
> update_ftrace_direct_mod fails and data->reg happens to be empty.
> 
> The undo should match the guard used for the add:
> 
>     if (err) {
>         if (ftrace_hash_count(data->reg))
>             WARN_ON_ONCE(update_ftrace_direct_del(&direct_ops, data->reg));
>         goto rollback_unlink;
>     }

right, that's the fix

> 
> > +
> > +	for_each_mnode(mnode, link)
> > +		bpf_trampoline_multi_attach_free(mnode->trampoline);
> > +
> > +	trampoline_unlock_all();
> > +
> > +	remove_tracing_multi_data(data);
> > +	return 0;
> > +
> > +rollback_unlink:
> > +	for_each_mnode_cnt(mnode, link, rollback_cnt) {
> > +		bpf_trampoline_remove_prog(mnode->trampoline, &mnode->node);
> > +		bpf_trampoline_multi_attach_rollback(mnode->trampoline);
> > +	}
> > +
> > +	trampoline_unlock_all();
> > +
> > +	clear_tracing_multi_data(data);
> > +	rollback_cnt = link->nodes_cnt;
> > +
> > +rollback_put:
> > +	for_each_mnode_cnt(mnode, link, rollback_cnt)
> > +		bpf_trampoline_put(mnode->trampoline);
> > +
> > +	return err;
> > +}

SNIP

> > +	/* Check noreturn attachment. */
> > +	if (prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI ||
> > +	     btf_id_set_contains(&noreturn_deny, btf_id))
> > +		return -EINVAL;
> 
> Should this be && instead of ||?
> 
> This condition rejects all BPF_TRACE_FEXIT_MULTI programs regardless
> of whether the target is on the noreturn_deny list. The C operator
> precedence makes this `A || B`, so if the program's expected_attach_type
> is BPF_TRACE_FEXIT_MULTI, the entire condition is TRUE and the
> function returns -EINVAL.
> 
> This breaks FEXIT_MULTI attachment support. The caller
> bpf_trampoline_multi_attach is the multi-attach path that supports both
> BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI (see is_tracing_multi()
> in include/linux/bpf.h).
> 
> The equivalent check in the single-target path, check_attach_btf_id,
> correctly uses &&:
> 
>     } else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
>                prog->expected_attach_type == BPF_TRACE_FSESSION ||
>                prog->expected_attach_type == BPF_MODIFY_RETURN) &&
>                btf_id_set_contains(&noreturn_deny, btf_id)) {
>             ...
>     }
> 
> The intended semantics are to reject FEXIT_MULTI attachments only when
> the target is on noreturn_deny. The correct operator is &&:
> 
>     if (prog->expected_attach_type == BPF_TRACE_FEXIT_MULTI &&
>         btf_id_set_contains(&noreturn_deny, btf_id))
>         return -EINVAL;
> 
> Additional evidence:
> 1. The comment says "Check noreturn attachment" but the current code
>    rejects all FEXIT_MULTI regardless of noreturn status.
> 2. The indentation of the second line matches the alignment pattern
>    used when lines are joined by && rather than ||.
> 3. bpf_check_attach_target handles case BPF_TRACE_FEXIT_MULTI as a
>    valid attach type in its switch.
> 
> Note: In this commit, bpf_trampoline_multi_attach has no callers yet;
> it is infrastructure wired up by a later commit. Once the link creation
> path invokes bpf_trampoline_multi_attach for a FEXIT_MULTI program,
> every such attach will fail with -EINVAL.

guilty as charged, should be &&, will fix

jirka
