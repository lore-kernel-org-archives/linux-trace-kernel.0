Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84696364E81
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695778; cv=none; b=ojBFnoH950hD28gKeLpcB8u5WKpq9UVVN7G6/0/lD5ev7ZRwe66VIYn5icyqyED0dZfJ47kJaMTOpu1y8XkLNRJODlBrDiFrehLSCtzZQpx1nxFSn9/WPxlMB4ZMM3p2pOVF5RjxcA+p7Jo05qHkB6mm/wp+Dcr5WhnWTA072oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695778; c=relaxed/simple;
	bh=OA4bOPES/QxE18UADiEgPG2TNThQsMS9DAeThPzDc7k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aosYrzo1HbhVIG9WWY6nHRmJOxb7A+nZO7fvt1fBuIOgJeAAjOOHFppPMneXiZT+KzXyrJFtQDdUtAOuxmR072Pd998KxOBwkcVU981YmBDSF0L+/etBNYbDG8T/mmcGCZ9Y0Q1HI2KbKibSaXjrh+TpI4TDR4i+HuEojMmDVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWtvYO8i; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWtvYO8i"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso42847565e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773695776; x=1774300576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c/kGgTmWR76vGODikeUVpePXIA4/UzKwJYC7CVcZZqQ=;
        b=UWtvYO8iOgOTaj/G1hRopzvI7ObTyzyLyLVvLjeJiSS92eUOlfxzOQBfizP0/0A8Vz
         8IK6bvCCqEUCXJdIQ94WX/Z00RMPWPDEYHfADreBuvnXBYJXM1vg7l6msslLQIvgzakK
         nrcxBtqn2N9FNLIOfRgP9FeeHsHKzCwhmULs9GPw7Sb/ax65hcoi9Dd7OpmOkbwkMlMi
         UhoD6fnphiv5nYQnYMtoPB1cYgUy+HjNdn1boVLRzmzLTb9yBbXEYZFiXfOjOoX4MhjM
         L/IZOTiPZlOpSUBqgozSQJ6wsZTVSSFOvo5KAvVmBRXRF5Xe95QGQA1L3cZqjme8obLZ
         59AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695776; x=1774300576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/kGgTmWR76vGODikeUVpePXIA4/UzKwJYC7CVcZZqQ=;
        b=KbAtPCnW9mkvBE2gDhPaH1LhznX09pS/rOmOlOFpDSMZ4n20bl6IXM69WblmeXO5YF
         +L1BWKq5+GFnShfZDfkZXx2Y2cXF/64LF4sN3HPuRqmRhu/3ZNcTyarb0Zfuqw6PZ7oO
         59c/b1/2GEIHZncvQtgrRs9dkjelR0/h7EmkLpMbYVX9NLc5rNWYT332sofAk8T5aiCt
         C1H+hq0FZZGHZ4U+y1t4btL66nNtwIUqKlF1PXUb/dmFMu5KeDoXQIuebWhN/71ohce+
         gg/KA07LHXomf/kWvBE5dnk0e55md7VTic+Ps6SrfxqABO97wMzUClNUdSr4DHUUs5/o
         qlOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWOTLa+bbKrkvvy4f06KL49TGXp5vNElbARzt/EsmwqZ6HX6Aiw41x+nPFOAnhqrbHDllUe1nkPzatHBHTQ2koMCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZLxHeFYoPtIo1Ig6Y0Q1uUCRq/yMuP83XAZVClSQVtYJFOuW
	AGTgBnu0jomJ/OeNZ8QfsKgpzWIKk+9+87LsNOnlJ0mejF4k2mpnzBOW
X-Gm-Gg: ATEYQzzO+VbBxzxQk1eri8T2DiCNmFQxhMWszqsbw1B6S4i07zc+lwhLDeNN9fpkHKn
	i78UXMaEhBdOzBXrPPWMUmnjipMVOTJQ4IhyPq93nl1hhnK5SDYxdIPb1G7XGZ1sSMVXau89MA2
	qW5yClbksXr2iTL3EyFMil9zqGUY2eiuib7kssRcs6lptO75bsXkHWx+Nv32T3cRPO1dJzGVMFn
	79SsnC2gZ3ItB3dJ8KLFV4pVgvk/Mi27xLNBCWIpwD/kLDBc5DEn8RzTyZQXld09ZpZb/ZPMgWt
	GzzcrOVNxSnbb5QpdU8V1NvsRnWq7Epb9xwOoR4/nHoGijQX2+xaB7QF9xsXakEYo70J+o+5b7v
	eSaRVU1OZr8IJZkkrb9ZAFlQWuMClpsrHPOfd7x5ZiwYcF8mNLLXVuwUafq9P7STDUxXVUYWDw8
	LjJvGKg2ygnZw=
X-Received: by 2002:a05:600c:4fc6:b0:485:365f:b4e7 with SMTP id 5b1f17b1804b1-485566d2c9dmr244798025e9.14.1773695775483;
        Mon, 16 Mar 2026 14:16:15 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c387sm23228205e9.8.2026.03.16.14.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:16:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Mar 2026 22:16:13 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 14/24] libbpf: Add bpf_link_create support for
 tracing_multi link
Message-ID: <abhzHZb2rep9222R@krava>
References: <20260316075138.465430-15-jolsa@kernel.org>
 <a34d2de2bc6db3cad91a50bb298bd687fa6ffa8701a14d6e7a07a29e7c34ffc1@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34d2de2bc6db3cad91a50bb298bd687fa6ffa8701a14d6e7a07a29e7c34ffc1@mail.kernel.org>

On Mon, Mar 16, 2026 at 08:35:10AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -454,6 +454,11 @@ struct bpf_link_create_opts {
> >  			__u64 expected_revision;
> >  		} cgroup;
> > +		struct {
> > +			__u32 *ids;
> > +			__u64 *cookies;
> > +			__u32 cnt;
> > +		} tracing_multi;
> >  	};
> 
> Should the ids and cookies pointers be const-qualified here?
> Every other multi-attach member in this union uses const for
> its pointer fields, for example in kprobe_multi:
> 
>     const char **syms;
>     const unsigned long *addrs;
>     const __u64 *cookies;
> 
> and in uprobe_multi:
> 
>     const unsigned long *offsets;
>     const unsigned long *ref_ctr_offsets;
>     const __u64 *cookies;
> 
> These arrays are input-only (passed straight through to the
> kernel via ptr_to_u64), so marking them const would be
> consistent with the existing convention and would avoid
> compiler warnings for callers passing const arrays.

yep, will make it const

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23133791558

