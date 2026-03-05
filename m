Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E811E1DFC
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719292; cv=none; b=edsMXORSaB01xr2AwWA2dpUpKvMy/hmUNsmatsiWs5Yag+R36l8LE+H3J+BgRRxpnnzjAAD7p0Nz3lVllU4zRmHkuy8oAo4fQGvZsi9/O/NCgoG+MRKhncwrH8lijvOfmdw9KcMMLfak1UdVpjWm+PTf+lWczt9oXbz9RBN+CAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719292; c=relaxed/simple;
	bh=uovAo/Gx0CWGIidfY8/WCaUzAkvury0l7kGquOAD9hw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAGZy1XBz+8dDUB/tAb/eBE7+yTyNa0R0G/HcG+xgN9LMudPRaqQZH9SgYPI7BKzOeRU6Sme4ccPS4T1YZzue60MFABBHdCHXyKdZ2AGaNOnlFnicXpB1aGdM08b4Ier7RyB+wM3AymJakYaniIj7KwlpmC0XH5XqiZDTWomfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TpeAp+py; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpeAp+py"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4837634de51so34949575e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 06:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719289; x=1773324089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ql55XKoX4MqofymlSVVMUy9DuAyuxTTa+E3Q1bwfRoo=;
        b=TpeAp+py6h0Nou/ZjwqcKob+yMudLIZASLOpO9PYMDgAXI2im1axeDmWD0Y2frxads
         jlCemdRiawfehWM+RM86tXDMM9FgP1Hx+CQl+wHUA7lt8DP0G/qQTwS4Lz86WCKFeKwy
         B7DWR+NoqYja8b9F7RXNJ7Q2HuG+qd9ROeW+2W2F9htw0VV7ghWtv7WFqRmcMCEYtMLK
         GlhFWsLrLhcuovrxiIYkS0oKE2lESx9pncRoreRXsS9qcB2WznzfsaHFqJRimaBEWGiX
         iINAwjPU1tDb1/pyIcb3T9lTbg+tKOhYWrunKvMHV//WcMVE2HIAK+r9EwYwGFTIGZch
         qvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719289; x=1773324089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ql55XKoX4MqofymlSVVMUy9DuAyuxTTa+E3Q1bwfRoo=;
        b=kB5n3ZYqwY1esvZ5/cpmfr2FcmcKKbvs/SDsVHv5396lvhD9AP8MB2L2TOnXBQxmCh
         4MYNKqfbyJSWYdZ97Gd5iLM1s2oc6pZrwz+L5SlG23rYwQQFyC2ttVc8eT0jhW1yZxyb
         SsiBBfjxU1odLvLuBPZOTq9g8TMhTsfNZQg4HEwW6MjX58aS5fZYlkeagbTr1UrviszA
         JQug+quCrMFHez3rIFRcw7PQT8uncAJPHIWNqe5+VBpzsEkWwPg8uWAIbAesjrUEZg04
         KoGcu+jyG/nrGMBMs49wgA4qT3gcBjyuAIkgL9+t8USOzE8kollwQU3Ye722ZnnAIvvK
         M8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXfW/XVBJ5IXKN8E/y9f52fkHKId7Yyz4rOr/evju79L7knt7qyX3P3uKU7TGorhYnuSiMw6OCUUgOLKmGih2XwCSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzboW2O4QAhVXnMolTjfNkf+uaw/BaioWfQLojcRl3U7naHUutD
	qGbugchNb6zMjzWDhaIwYKtAErzxCmMEKa9Kt1dlqZQARrXq/Ynqt6cO
X-Gm-Gg: ATEYQzwk7Fp/1+iaU7eDN3b2r+ksD9jFiSkWLwbg0MzVM7FWezN3G+fsv5cc/W9wuCc
	AweZGVzE6gqOl6XyKBPoZxBKxz8d9zAnq8JC9Mlclfdd+Qbm+CijzgdqTp5qmW5UWU6nQoZ6nsO
	TXVaZBAmSWFNW6b/oxTseZbGuXWm56VO6V2gq45KsUKP6tL15fOh64Ka122PLUBcdcO9z9WRMB3
	IAZrS6FOUPLkpXmslemtaj/hpI21DqMbflaNiq6gP+qzA/G6UmjfwHeKrCdTzIMn+XPrMx/RpXD
	Tx3+HedQ/sk/gAaAHZGCWOdsWNxXXijBp9vaIet5OxVwRUzqIn8czBe1U1EltW46zoUgL0bQMTP
	sY0qBTzMMrkT3WaHu5TCJAfGHlVuZnTZzODY4LRNf/U28/mW4uWIPyKnBk9NuAyPniGyjDNzTzM
	NqBvck+fA=
X-Received: by 2002:a05:600c:4e8b:b0:477:6d96:b3c8 with SMTP id 5b1f17b1804b1-48519896e5fmr107327715e9.23.1772719288459;
        Thu, 05 Mar 2026 06:01:28 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8955c1sm49467415e9.1.2026.03.05.06.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:01:28 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:01:24 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 14/23] libbpf: Add bpf_link_create support for
 tracing_multi link
Message-ID: <aamMtNYtlW7H3ZN1@krava>
References: <20260304222141.497203-15-jolsa@kernel.org>
 <ac763f388094863ef5c4d3a60d5606ea40406f66c91006fc9dd0e47573154a72@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac763f388094863ef5c4d3a60d5606ea40406f66c91006fc9dd0e47573154a72@mail.kernel.org>

On Wed, Mar 04, 2026 at 11:02:23PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> 
> [ ... ]
> 
> > +	case BPF_TRACE_FENTRY_MULTI:
> > +	case BPF_TRACE_FEXIT_MULTI:
> > +	case BPF_TRACE_FSESSION_MULTI:
> > +		attr.link_create.tracing_multi.ids = (__u64) OPTS_GET(opts, tracing_multi.ids, 0);
> > +		attr.link_create.tracing_multi.cookies = (__u64) OPTS_GET(opts, tracing_multi.cookies, 0);
> 
> Should these use ptr_to_u64() instead of a raw (__u64) cast?
> The ids and cookies fields are pointers (__u32 * and __u64 *
> respectively), and every other pointer-to-u64 conversion in
> bpf_link_create() goes through ptr_to_u64():
> 
>     attr.link_create.kprobe_multi.syms = ptr_to_u64(OPTS_GET(...));
>     attr.link_create.kprobe_multi.addrs = ptr_to_u64(OPTS_GET(...));
>     attr.link_create.uprobe_multi.path = ptr_to_u64(OPTS_GET(...));
> 
> The ptr_to_u64() helper casts through (unsigned long) first,
> which avoids implementation-defined behavior and compiler
> warnings on 32-bit builds.

yep, should be ptr_to_u64, will fix, thnx

jirka

> 
> > +		attr.link_create.tracing_multi.cnt = OPTS_GET(opts, tracing_multi.cnt, 0);
> > +		if (!OPTS_ZEROED(opts, tracing_multi))
> > +			return libbpf_err(-EINVAL);
> > +		break;
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038

