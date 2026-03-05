Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406771E1DFC
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719300; cv=none; b=LswQUIOhupLBJMhhljMpMx1EzGkT+Hi2gbiGbDXVV5Ap4dSdAEtP6YTQVBuCnhy3ypKPD1wxl2jgisWdWtcOEA8Glt0xm5bqa0gTcd5sx5IilAx2TjcSr0cBW/VUGvAm8IPOznVHRtnAlbbxkLYgkQb9riRRWvAcU5JwxP+ctFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719300; c=relaxed/simple;
	bh=+30yiLCRKCaT7AiCG1LUhJlbqL+3pTt+h7boXDH8K6I=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6MyFM+OkqX6nCmTQxHcQshDC+QUH6YDPL/xR0YoHAA3LZLH/++H3egZuN/ykWYi1twSHRcNO14JsmBYm9mHg1zJ9T7H2gRq9wxT6ard3z5jeFd2+Q4Efx1hqQEUIdpG2kjGnMh6ATAnPc/zwlmpZBGRzcd1SDkro5CEwIwpKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsjBdErV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsjBdErV"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48371119eacso96273785e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 06:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719298; x=1773324098; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=URJ4mr13CHs0XGdHNp/cTfn6rBGk2NbDJqmtLd5hK2s=;
        b=JsjBdErV/MbI/E/+d5+eI5Dt2wvma6U0zjwS9BL/wb/xCkIWNtzM9vLfpnhujKYcYM
         K7O3QF9vpY63g1QuPjkcq+T2cNVaTGGVSJCoTBNM3Jm5f2dMJHPcpanJGdPNYXbn2u0X
         MrqKjfvhkLTnKXZlsVx0cj0m7w7c7EEcajd2jiSks8J/5qROX1s3ZiEgB/sxzFt+i6s6
         uMk99R3k4NeYKEH6fteA0lFQTWrs46InNgIOMqHUljsR1NYBfEnto8KFPUUI80NdscN2
         xRalhlUJnaEP6JaIjIHeSFEwUIF1D1Mb/L6TiTWo5rDtFdkUTG0fqVoDY8y/AbEaDDXO
         Dp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719298; x=1773324098;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URJ4mr13CHs0XGdHNp/cTfn6rBGk2NbDJqmtLd5hK2s=;
        b=petKBP5tQtTNIu1bAAEHlCPHA98VL8qocaLpBwOVNuYCXy3kvOElSGw0sxA7gquKY3
         xkKDjatjoIqGLryv7Frw5pooz/zOhpaH7NEWTQBDafAVPVkJCXqUoXPg730QnlDFkjur
         NIC8PN1pBePMBA88HdNhPs9tQ3cvL+03VYscRsZxQF53yPlSfppwh/2beKpFGjjfDP+0
         TssoBIERdNW8Qklr5Xyc8R/tDyHMOby33ARtTrw+KaufbOYYDrXPyMCypCkVnrDpPpbR
         kk3dYQk632aAN6AREJ4k1gf4v5T4IH5Vw0z3Uc/Ac4qG8vObXLuuCgXhrrG6S1d9YcD1
         km7g==
X-Forwarded-Encrypted: i=1; AJvYcCWSVmwoa5MkQcfyctoINzZ1uzjINwXqV5qUfLOAP+tQjh0UFdnfn0W1JnwbG3n9yFgwUoHsYvWw1lX4Scfsum989No=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA//0CVnLCZ7Sy+7/wkE5kf7EdVV8w2NOUuVUrfswzf9QrAdIq
	Oh7X9NJD0hZzURfxR1P6qMHhxfqlC18P41RyCIODqrpXpwVfJhgYpQwL
X-Gm-Gg: ATEYQzw3rjgCzQfaiCa+WD12XSQDYm3S2FurbfT6dW27XNmO4+K+TPPMa0JSAtSct2t
	H2XduD10wGZssLfJm6HC02DPD9di+E+8cryrY2Ch0aO/H11SIKm0P/W/m/lbh/BwctBUnTorsc3
	kZexwmIm+XgM9B2y8pVAXLm6KcGAyffenB9+2IDEGWLjW5A6a9TH6hZ4YE/HcTuJJXP+IILfpeF
	UmsShphrE1A1MVWLCvNWGakURUVE7vu7ST6TqhMbtjBV5KcDRjNfd3sAvdVJ5zr//6wFyLKBemx
	RpTNgrpWkUZnuZKtBt4XV1V5eQ4hV9ucY83LQFV9Dpyre6BAU5ap6KS/rnN1Psx7myIKH2tZ+jl
	LlJHSVynXmxITFCl8dVune0aD2WxMgk0Gp5dKF6XHzJlpO5vlVpMStz/vGLQo+dCABfMqJ+P2
X-Received: by 2002:a05:600c:45c6:b0:483:c12b:fe4b with SMTP id 5b1f17b1804b1-4851984953emr97181465e9.9.1772719297394;
        Thu, 05 Mar 2026 06:01:37 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad2b26dsm43352905e9.31.2026.03.05.06.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:01:37 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:01:34 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 12/23] bpf: Add support for tracing_multi link
 fdinfo
Message-ID: <aamMvvzUJTl50J81@krava>
References: <20260304222141.497203-13-jolsa@kernel.org>
 <77554f42f56834088eca284c1a787f51e4402907c616f8194942c82530a9ce6b@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77554f42f56834088eca284c1a787f51e4402907c616f8194942c82530a9ce6b@mail.kernel.org>

On Wed, Mar 04, 2026 at 11:02:26PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> > +	seq_printf(seq, "%18s %10s %s\n", "cookie", "BTF-id", "func");
> > +	for (int i = 0; i < tr_link->nodes_cnt; i++) {
> > +		struct bpf_tracing_multi_node *mnode = &tr_link->nodes[i];
> > +		u32 btf_id;
> > +
> > +		bpf_trampoline_unpack_key(mnode->trampoline->key, NULL, &btf_id);
> > +		seq_printf(seq, "%18llx %10u %pS\n",
> > +			   has_cookies ? tr_link->cookies[i] : 0,
> > +			   btf_id, (void *) mnode->trampoline->ip);
>                           ^^^^
> 
> Should this be %18llu instead of %18llx?  Every other BPF link fdinfo
> displays cookies as decimal:
> 
> bpf_kprobe_multi_show_fdinfo():
>     seq_printf(seq, "%llu\t %pS\n",
>                has_cookies ? kmulti_link->cookies[i] : 0, ...);
> 
> bpf_uprobe_multi_show_fdinfo():
>     seq_printf(seq, "%llu\t %#llx\t %#lx\n",
>                umulti_link->uprobes[i].cookie, ...);
> 
> bpf_tracing_link_show_fdinfo():
>     seq_printf(seq, ... "cookie:\t%llu\n", ...);
> 
> With %llx, a cookie value like 255 would print as "ff" here but "255"
> in every other BPF link fdinfo.  The hex output also lacks a 0x prefix,
> making it ambiguous whether values like "10" are decimal or hex.

yep, should be consistent, will make it decimal, thnx

jirka

> 
> > +	}
> > +}
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038

