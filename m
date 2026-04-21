Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A6331203
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761733; cv=none; b=BBnvgcnSLy+qisPpw8jDvzBmY+1VNsupGQZyPlhGNYtzPsU/MbRrydV+ic9fW2wW9IPev6mdVw9xSnK4ch4d8pM83/GKqhcpdA4z49orqh2toFvpJSVbhyvmR8i80wEKZESDeR3PSNVx5b6qgBmjzLNInBH5Oh6lV0el2oVCofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761733; c=relaxed/simple;
	bh=zp8m0hZfqXYdsZ8Gpssb//3/JgQgTLa24jkQvLUpf3o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxTGOe+JSDDnkm3hChaUMm2MRl5iGckW1oJLAV6Sn9I1+DYUh2qs/lVF5bWr70PA0LkKzFj+LT7tJlx/Y4WD31WKfHhZLVUN0LVzi6KNNnl3T33PsVCc3VyQQVtBEceku0QMcZppc/JQZzrgztY/oWNWPK3yOk6VVm+7PkHWd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LThFAbjs; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LThFAbjs"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso53245165e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761729; x=1777366529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDeAb0ooy5qQHA5qWOHd2pXo48UvQ+5ANorl5Zuk5Uo=;
        b=LThFAbjsyMAQ0b5zNpcUjvatr1t3/3w9OTqTlXYc7SffylrT8g/aVvG/FmYUUy4MGy
         nOPcsuYZS+I+nUjMdMZ7pB9y/wYuP9AF1DQNlx//PJVo1kjsLg3aCaLqwuW3KOv6ai3m
         /sxkJ6LR63i9vCCbpkp6QQX37hj/RMcFu9FXElML+/5Hz5efg8VaJOGcjnCKbTkFAEQE
         TcqWHcT18PwFD9cgF5794Q8G93QCWo5w8hyKPlkQXZsTuTYgA/Q1SyDN0vev+mKB3uRd
         itqmDERyUKTFk/ZjfwZtJuvJhkWQ+G1Q2bCaS6X+j+D1QvMQBbOIvIVqIyb8WwQQ3jST
         1k2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761729; x=1777366529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDeAb0ooy5qQHA5qWOHd2pXo48UvQ+5ANorl5Zuk5Uo=;
        b=ZTpPalXJjP1k2dK+ZktfbSbeL5KB/J3wqpyS9BvYX7pnqg/03eWtjzIl1t0eSWCme0
         oSOGkz22ZtW9IIoYAvK0l2U4PaFi5yF9SrSWTCmL/SK7L7SumLQVgqLOdDJqLOYCQV36
         5iG+EMJ83+I3USPPtSGTebo2YRBTHY2lbIafYRuo8B7FtiOXiAHrxJwKdMsxFDKBxtcy
         Wd7hucSSwWmIeAJKnfRE6ajN3xV+DsztbOdW/PxnrChAaRz9lyP7U4Aw3OjjdaYCu9wp
         piixpB4eR1cugz1wGI26RouangDKQ142rhFeZVO6hZ+scUT1pOjqs6H5Ft590Ul25Olw
         anEw==
X-Forwarded-Encrypted: i=1; AFNElJ9RPtv+yLUi9vdCYQIxOQkGLnb0QLqcRwCA4DsxUN1VA/c0JahCeDVBETh+HbVwIBfEuRBW+rla1NhhyJbZfh7mHuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz9dyijcPTGJu+1TIpNxzXEMCgcem719udIrHOt53udab1aVRE
	THKPXVxqtiRKBnuPtb+hosGYTIHNf1mM1MgGVEPwzd7MRPVVy5XpuhLw
X-Gm-Gg: AeBDieuCfGJS4kwndH5LpgAVLkWXK6vioZWqjFgWVFXS0ojnUQaS/9pi7J+cdTYpRa9
	TE1+0/HOtD5u8VfcS8AHMu8lMCl3FZ+CjltjdxYaXGstUJvMX30mrQ04h2agzkai4/9LwG2gPE8
	ncyzlZA5LRkKM4DadBi3gUQwlBjwTWP6Ylh8kdxsqDHo34uSfiN2HvjFhbGF4RmjuLHzj/9D4EQ
	+AgugLROLA7q4GMqDDe/mUV0+m4G/pC0sSSQmdO6F3mTTlJT4tSm7NLwQu806C+YUtiofjETZ4Q
	BQNBTP/Xk4PWAUWQf2Ll+pC03QGw7VJprXYWTnLx0ltPaaoaFakzBZx1H+flhB0NgJMS3MmwcLW
	NZiE1oC40NYI8Pd9LUCkUu6c+W1+wMWegwdpM9/zuPp+6wfYUnwPbOe22a+ZX403Xzl/Z37KPLr
	5LUVHJRT/ER1jy4ev5mA==
X-Received: by 2002:a05:600c:a30b:b0:488:a639:b772 with SMTP id 5b1f17b1804b1-488fb7467e9mr172104105e9.7.1776761729296;
        Tue, 21 Apr 2026 01:55:29 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm169553525e9.1.2026.04.21.01.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:55:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:55:26 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	hengqi.chen@gmail.com, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kafai@fb.com, eddyz87@gmail.com,
	songliubraving@fb.com, yhs@fb.com, menglong8.dong@gmail.com,
	rostedt@kernel.org, martin.lau@kernel.org, yonghong.song@linux.dev,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 08/28] bpf: Add struct bpf_tramp_node object
Message-ID: <aec7fuUhFjKLt6iQ@krava>
References: <20260417192502.194548-9-jolsa@kernel.org>
 <fb38d0f3976f2225ae9781d2292bb79f4d787183360f050c08de3b4490790974@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb38d0f3976f2225ae9781d2292bb79f4d787183360f050c08de3b4490790974@mail.kernel.org>

On Sat, Apr 18, 2026 at 06:10:55AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index 50103b3794fb..b97d9f68fc40 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> 
> [ ... ]
> 
> > @@ -827,14 +827,14 @@ static void bpf_trampoline_restore_args_stack(u32 *image, struct codegen_context
> >  static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_image,
> >  					 void *rw_image_end, void *ro_image,
> >  					 const struct btf_func_model *m, u32 flags,
> > -					 struct bpf_tramp_links *tlinks,
> > +					 struct bpf_tramp_nodes *tnodes,
> >  					 void *func_addr)
> >  {
> >  	int regs_off, func_meta_off, ip_off, run_ctx_off, retval_off;
> >  	int nvr_off, alt_lr_off, r4_off = 0;
> > -	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> > -	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> > -	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
> > +	struct bpf_tramp_nodes *fmod_ret = &tnodes[BPF_TRAMP_MODIFY_RETURN];
> > +	struct bpf_tramp_nodes *fentry = &tnodes[BPF_TRAMP_FENTRY];
> > +	struct bpf_tramp_nodes *fexit = &tnodes[BPF_TRAMP_FEXIT];
> >  	int i, ret, nr_regs, retaddr_off, bpf_frame_size = 0;
> >  	struct codegen_context codegen_ctx, *ctx;
> >  	int cookie_off, cookie_cnt, cookie_ctx_off;
> > -	int fsession_cnt = bpf_fsession_cnt(tlinks);
> > +	int fsession_cnt = bpf_fsession_cnt(tnodes);
>                                             ^^^^^
> 
> This line wasn't actually updated in the diff. The parameter was renamed from
> tlinks to tnodes, but this call site still references the old name. Does this
> compile?
> 
> The same issue appears later in the function:
> 
> >  	cookie_off = bpf_frame_size;
> > -	cookie_cnt = bpf_fsession_cookie_cnt(tlinks);
> > +	cookie_cnt = bpf_fsession_cookie_cnt(tnodes);

ugh, it clashed with latest update for fsession,
and I skip the build test for some reason, will fix

jirka
