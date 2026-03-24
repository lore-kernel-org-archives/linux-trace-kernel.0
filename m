Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553353FEB33
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362598; cv=none; b=NMZFZlM3X2HNN0NAFfv1rSRCTvWHpFnr7UlRMuW0Qyi8+Fxny9LTeq+AA3GHIVh4ZqRrVTL1MesBP8guLUNLllnnvg8F0SMxpJsVqNcQ2+qYsS26ervZ9ME9e7PlMtYbi66rsDPuCNvib+bjPiygBn+iIyDVq3BP4IvIlOImov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362598; c=relaxed/simple;
	bh=E6Y2FdCy/f/e+8zK80Dr0ynfhIX+vpcJc+lUTC+NU2U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofVgui8Eeya57/4Qo7G5wnC20FHTMWVzc2tqsf6i2Je1+Jug1CohpL1obMHvLBvo5RKkXNTGF9o8FwsHnsMJ2k4QAn6GPhyxf0D3OPdfvyH94nPU3HL0z9NPdg5/neQCP7fsNjutfQiieVLxcSQJrAsGX/id/Jcq5Y6cpOJIHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axUFB5Kh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axUFB5Kh"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b40003d13so3450385f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774362596; x=1774967396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E89vUjALggeOtl7qNGgSw0ZoutJo1ub/f/s63I2JU9g=;
        b=axUFB5Kh95pvk/ZizBbhYsrzHgvEuZqgu3cJqOqrvnvCOyDhEsuteF8eraVSX26T0m
         X6FwK23IbnhuYwTp7jRpz5MRr5VObfg6UCcx1WWqSmQgnywNtiQyVez+pIYII5zqBWrs
         bY5xHm3jBFH0U/+OWF4WQRB4bPcSmK4zf9I4Z4Fgpv5WxiuV+VvD/9VrW2HsAyokcsSZ
         ymvFxbwTk1IArptmartlRSG/C5sYxElG7H4V/arGPGhNrHjAcEgXBy5NXqiT92IMtmQy
         qiYVD4O7xealBjlfYUwGeZsaHTsAcUPTfELtjtm/Q/kvxeFKTj/Vqn9IUVrcqs0c5Wyk
         HfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774362596; x=1774967396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E89vUjALggeOtl7qNGgSw0ZoutJo1ub/f/s63I2JU9g=;
        b=ESmcQu6K1jYE1VfKAkiIm2DIx4ZEe0LHGsDd/vuUw5OrmnFR1Cxp4irSrhRP1UBqWY
         VwtEYAbk5QHxD2WIziwgfrfTKs69x+3mk1yPx5iR18rQC3VZqFOh4s45mlFdCn3V3pLw
         mV8JvKjGHCOtjeR9cQCK2tsEVeJn8eSBFtNzF7CgyOLqv2vZUXONTPS7RWaJG9fnLke9
         Y6yvDzAQHt9he8tK/rSMJ1fwLQXOglbUQ05qYgjECj+muLK2KZKMvFj3y/Xf0bMk1Tjb
         BxYWgFDOsBzpkZpuZVp8BvX3t/Kv6wf2w0hdf4J0I7506aaUIc6C1LqSrGlrhrioySzl
         RF0g==
X-Forwarded-Encrypted: i=1; AJvYcCU+ixt9wwuzqIPrmcdRLv+q7B7bjYmuw6YL2T9F4ot1W2kb9JzwoFtT8jand2x0EXeys9gk7yCOurh8EQbeGZpA2MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmCDiLSL/Ktkn/i1ocBuHC0xHQI/6zLH/+tUUDa28yH8Ykn4pY
	DsS9hFzBJVtKyuHvHLohBpeGX/x3zP5TXzIikR5PqUiuYc8qXL0VeM88
X-Gm-Gg: ATEYQzwylkPtx2D6KdcRe5RugF+8sTanStsOxIScqjgkD+3E/+1CP5IPjoIyiEYNHTi
	cUsSepB7L/bkf4QEV/el1fmoCaDleiMCTMtejkZVG2a8kWS5EmlRFzwBT2KXVY/XFuiLDcuIz2s
	e93yijdJ/3AZ+gsDahqRWXqefoL/mK/EnhX34su3Al8XL4IsHVwZ5kPRhyyZg+Au65owl6qMSTo
	CU3DBUZUqOJEbzhgZA1Rm0mNnvYhjVvTrHpBjA7shWe+TJTHqTIcSF3+/g9g+ZTW2k45mNaljkz
	Cw3WP/xNdta7axZ+WARb1nZLcrepPGBcLBcW0j2W8YaGbSDtoaZuX6ScmSf/PBYsFH3dvngVkVX
	9M4RyLe18w6II9CzMaKiJY8MAl6nl0oeucPt+XBNy68CdL2TkM9TockKewgeGVjQGcxgRjGWnhj
	/U/U36Ob0lsPQ=
X-Received: by 2002:a05:6000:1786:b0:439:afea:aff2 with SMTP id ffacd0b85a97d-43b6425304emr25280387f8f.23.1774362595579;
        Tue, 24 Mar 2026 07:29:55 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae37dsm39594694f8f.2.2026.03.24.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:29:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Mar 2026 15:29:53 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 bpf-next 16/25] libbpf: Add btf_type_is_traceable_func
 function
Message-ID: <acKf4bNmIShhfz74@krava>
References: <20260324081846.2334094-17-jolsa@kernel.org>
 <164b58d37098843f85298dac240da89e8383c552500148fa53f642d40d72b682@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164b58d37098843f85298dac240da89e8383c552500148fa53f642d40d72b682@mail.kernel.org>

On Tue, Mar 24, 2026 at 08:58:39AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index c6cd6ccb870b..139df8484edb 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
> > +bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t)
> > +{
> 
> [ ... ]
> 
> > +	/* No support for struct/union return argument type. */
> > +	t = btf__type_by_id(btf, proto->type);
> > +	while (t && btf_type_is_modifier(t))
> > +		t = btf__type_by_id(btf, t->type);
> > +
> > +	if (btf_is_struct(t) || btf_is_union(t))
> > +		return false;
> 
> It looks like t can be NULL after the while loop exits, since
> btf__type_by_id() returns NULL for out-of-range type ids.
> btf_is_struct() and btf_is_union() would then dereference it.
> 
> The kernel's __get_type_size(), which btf_distill_func_proto()
> calls for the same purpose, has this after an identical while loop:
> 
> kernel/bpf/btf.c:__get_type_size() {
>     ...
>     while (t && btf_type_is_modifier(t))
>         t = btf_type_by_id(btf, t->type);
>     if (!t)
>         return -EINVAL;
>     ...
> }
> 
> Should there be a similar NULL check here before calling
> btf_is_struct(t)?

I don't think so, __get_type_size has btf_id as argument, so it needs
to be cautios, but while loop in here takes type from proto->type id
which must exist unless we have broken BTF data

jirka

> 
> > +
> > +	for (i = 0; i < nargs; i++) {
> 
> [ ... ]
> 
> > +	return true;
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23480161822

