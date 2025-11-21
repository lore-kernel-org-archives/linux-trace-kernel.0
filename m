Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0A52EF660
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733190; cv=none; b=siKZ2cYDuaR7e85si5w1TEv7rQdr1nnkQQT3AeU04lfxDLPS5W1uU6f5Y7hLR6rBZcWemRNt0K/8wkl/GKQ1bn6JlrRDGSwG8F9JbX6QjPNhtIicRGineSXbKd58WsKymz5Ml2zu9VhWnAmicoEOFztgeCNSM62eS3jBVv6JtXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733190; c=relaxed/simple;
	bh=Vs0n9+plsNCzPFHj8LtJuwnYS7N5jF9XX1ybVRqv2Po=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smSKxCmQ30LsVb2imBPZNR7Rz9Tn8rfxMYu42S1sj4EojwgkBlzNkvzKDCGXAdwdm3w5eJC3Jctbhecfqd+/R1OX7gfrMVMskxRTxiy/mngwUNx7brWdtYIOCVVxxBpk07BrzBW+Yr3zsP+qKZj+ae4pzUscWuVfXeml4PTgVBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cF/GBOse; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cF/GBOse"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47790b080e4so11451495e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Nov 2025 05:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763733186; x=1764337986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9ZHAU96zRwC8rydbydanUtXN3FsFzz3+3+B+AWK6x0=;
        b=cF/GBOsevcacIQ1JV48DLuklvFOV+eBbikcHVIO1iOk8TGBztjNhb2DJ+r25+nzzEk
         ICkxPHk/Ao2onluv2xJXyHkaP+vhSYf7uS/tCONjc+s7e+82ZJmSzaNm1n7mBdNONU/z
         hOvRIsAz6eU1u56qLg4eJ/x91aSVtKHrwA6jVVfAu+Z0XW4nWKcaZfHbUk7XHSuvA6pX
         6Sfckl6Kycnw5rCGQJGRHmro9vEDcC1sLTAAqYMuetNZy0Qgs4bSkjmtcFi4FI96i9ca
         SZBeKMr5pA7HA9KaAsQLTuCxoJ9YgJckfyXleuhie/gp3TGm5hx3pjlCS2Duza7vEaCb
         c0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763733186; x=1764337986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9ZHAU96zRwC8rydbydanUtXN3FsFzz3+3+B+AWK6x0=;
        b=rIAuXHuulPHTtorjN8/uBiIGMODFhVqzGGGlNa9hDLayhILzQZpyuiB31QTEVwxsXX
         zY9DK5soqfl9yuYeK/BErcYOK3QhNFDnmfcJemyhWSenpd40fHv1Xl/54VNSj1PBchq8
         k1TB/tVgfS5AxqdQ3qOJBYzXp+1/Y1aZj2urCKsMQAw/6bY8wUtxTUBcp34WjPXMO+hX
         7jMb0h213BRTZCOFS6uSHo8ngC8KUbus3s0DA15w7dfQYfpYDISiSEbcV1niiU+tKHb7
         7AsS9pv07GFUT87udRGVaEJj2KDxV95g8k4YrLCNvmmAA+5HKq8+bDfdBEttBmJsp+Jb
         NMDg==
X-Forwarded-Encrypted: i=1; AJvYcCW+1Xo8fkM4DaiG7Eb8J+kbbjfRhrU+SDsGpvivS9PBxbYlK1mNdQloFDKRcsJvCkeR4tQFA5LH3gJuqvFEKRZw+0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YykkCiGmUgIuxfXK7C83GsPMSi3AxLCCDGCDVviyeUaZTZP2Bkx
	WeQOHxmTixOTBf7aSghEk5FCZ5Pz9W65xx7ZW1zn3wmlc7WyuHPAw18T
X-Gm-Gg: ASbGnctUX4hDfuL7FKzsOBFiBpG1mZ5A5IoXzVu+TMsJRgSQPwQ3brCjy7NgzTNmKD/
	A+gkQ/Cr4XoKsKaZO8IonHbFOxvgQY2ekpplO2FTaghJEge3xMlR9j/gdGchTu/edusx8hk6S+X
	bVWdyJnPE77WIH9VC1rw7Xhlk/qdmEsGXe6feB7KoA/Qfr3OyNxiEtcI/nfwL/R2xzNrTAajoa0
	isTzzDCPJ2VJW7mJ8PhE3wTm9e3btZ9wP0oZkop5L8cOWclLsJAX2IVga+sDqXFmzgXTpyw8STc
	0maiPndLHbyvim3YzJgJ4eqXLks2SOmm3t8nWxUbGabow5BHrdYtFERegB+oT3G5p+jqe7OHQ2P
	tjGF/hFXF3oXf04213IPqHi6WTny0bUTAoZONyXE1spkRQNwGdP7pmA1YXFmY
X-Google-Smtp-Source: AGHT+IFuTvsjtGwTRPEN026FC2pczcZ8IxCeMFrd96paI0v/3ChPKOPZkThC91+ughQf8nM8pWwgpg==
X-Received: by 2002:a05:600c:1caa:b0:477:8b77:155f with SMTP id 5b1f17b1804b1-477c10d4935mr23861215e9.8.1763733185974;
        Fri, 21 Nov 2025 05:53:05 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm87267315e9.8.2025.11.21.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 05:53:05 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 21 Nov 2025 14:53:03 +0100
To: bot+bpf-ci@kernel.org
Cc: rostedt@kernel.org, revest@google.com, mark.rutland@arm.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, menglong8.dong@gmail.com,
	song@kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 5/8] ftrace: Add update_ftrace_direct_mod
 function
Message-ID: <aSBuv8Ab0y8SeAHS@krava>
References: <20251120212402.466524-6-jolsa@kernel.org>
 <a302c70bc1914835ea69c8b30105741b1d1d06d549ef95b9650d0827e0ca276a@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a302c70bc1914835ea69c8b30105741b1d1d06d549ef95b9650d0827e0ca276a@mail.kernel.org>

On Thu, Nov 20, 2025 at 10:23:47PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index c571deeff..4e2c0ed76 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> 
> [ ... ]
> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index cc730a8fd..5243aefb6 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> 
> [ ... ]
> 
> > @@ -6486,6 +6486,74 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
> >  	return err;
> >  }
> >
> > +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
> > +{
> > +	struct ftrace_hash *orig_hash = ops->func_hash->filter_hash;
>                                              ^^^^^^^^^^^^^^^^
> 
> Can this crash if ops->func_hash is NULL?  In update_ftrace_direct_add()
> and update_ftrace_direct_del(), there's a defensive check:
> 
>     old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
> 
> But update_ftrace_direct_mod() dereferences ops->func_hash before any
> validation checks occur. The check_direct_multi(ops) validation happens
> later, but the dereference occurs first at function entry.

update_ftrace_direct_add is called before update_ftrace_direct_mod which
ensures the existence of the filter_hash, but same as for the update_ftrace_direct_del
case in the other reply, it's probably better to add the check for future

thanks,
jirka


> 
> > +	struct ftrace_func_entry *entry, *tmp;
> > +	static struct ftrace_ops tmp_ops = {
> > +		.func		= ftrace_stub,
> > +		.flags		= FTRACE_OPS_FL_STUB,
> > +	};
> > +	unsigned long size, i;
> > +	int err;
> > +
> > +	if (!hash_count(hash))
> > +		return -EINVAL;
> > +	if (check_direct_multi(ops))
> > +		return -EINVAL;
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19552032346

