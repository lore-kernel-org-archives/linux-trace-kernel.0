Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A12D7D59
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695795; cv=none; b=sT7aC9TYSFmrc5CFhKU0JA7Gp/R/Spk4ZA2dbsR29lYnX1wDFrhZ5jTnExAI3s6eRpHk0J4vcaCGN8KhfDWJYxhW6v6s1e4i1ZAF+TiO79FUGQIMFCN+D3MRclk+HPGT1WK5fd8HZrAiZHojm6edDUdhXXllX06hi+AmY5Zd+FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695795; c=relaxed/simple;
	bh=FM1PWifg/T65KUSuVshGmA94lZunx0CTmQ1de/BkIHA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb3nSbl6tt3KSxY3CMGoUjPcpoNxwFuSsd/Dp2N//te2kSop3sLjknySa86c2D0PXD7ZJrf1S3xTuTymTc9dB7PGiz7sZWBKUz9FM/Z0QCHXpWMsG3QfDy+pdEpkLzcBaa2rLgOoKNtcmHqnLKjOe7/cgzQscSXWe3d0HzoZm6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8jLTedf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8jLTedf"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-485345e1013so824565e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 14:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773695792; x=1774300592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhHsu2je27aHKAcLA2znQehxHwpTKNN8Iv8PWABIrhc=;
        b=C8jLTedfElXrI+x0PrfqxqlN7UF06U01FUoV5jckFRrmKM8aP7uX+/jjHIU60DU3RI
         9nSB5dCJX6z9o2WwKH+urFcNTo4fEA0r/WeCnceUWhtOPSCjIs87TKUIMAQxnG8iXPHG
         m1xAaEdAWGknJ+EwkxPC05rJYmU01qRbBNFfi5/sB+Y7UOCbf6xCvK8QcocS7aeWeUGr
         y1FzeVgE5XKaMaUxQ45YvyHIgyXjSuhhRFrtNI/5u8a0UJ0H9dHIsbaU9p6CLDGUudoS
         beVB+MvN6SvyY9xL+AGmRucIh5u9NekvFeRe3DN+TKFiAc9K08IfjYCdDQ7OBDrmdNOd
         s9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695792; x=1774300592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhHsu2je27aHKAcLA2znQehxHwpTKNN8Iv8PWABIrhc=;
        b=O1Ns1vEOq2awYx4j7gppzu0Tu65Z6D+VD98mvfnmovYt+mp87B7zgGEphZlm+Aoy03
         lM1ZijJkTyzsnt+8z6Jdw/qNQY06NL3ThsZ9LfKWPZjfIrBOEnGGd8Uk5UcO9EpKW/Jl
         VHwul3DjCx+1Wlezvpvpo5mSbUjsLNTSpiHExzoOmrPQxMNLH/wsaWDJeiX+Z4Mi0OSi
         i9YgMFjbLx8oxNlBDAjFBDotqeLRfP4GvdGnQDXicMLpA1F3j43lP7MEsAbdmTVHHBEA
         71jVsciinBdd5gyDrZHoeAfUHfewiHYZqk37WvSHpjjxBKuAvmfXPUL8c7pTS4D1jYbz
         QiOA==
X-Forwarded-Encrypted: i=1; AJvYcCXFfII5/+CapDnYa0Vy/03NDUPos6qEghWSZlslCeQLfFJF80qPw6JnvuPhLQnRjQ97Htqf1lfp8dOOmRTlBjAr34o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9URn5dCzKGZOHMXtmhhCCERAlV8pUmL8e1U7y7lq01lyyJxD
	VAIcB/Kn1OD8OIf0NwqXQNmUwj8ynPE+q0ndVRm88hw/qKbcRewYzs+C
X-Gm-Gg: ATEYQzwcGw+zqsxK4KgjFdYhCjZ6ls49ybMopdtIPz04/cjd6kDTY92dIVZfwFnHXkQ
	K4Fqi7nmAP07/OXhz6IFK1KEapTvTlUMirpvhOdpOpZ6yNy9/0UE5Ha3GEDKnlNO2T98Vo6gfWE
	aT9tAP/PK2Cx7T9Zxkm8QWWUEFMCrlswQg/KVpO6VHjTAz7lGPwrU+SARP+9l6c9hkYNvSr07PE
	VsGER19rCWd7G0mWluNgW8t/NQdUarusPEaR70/cc4ruO3sQie4jwfEbMSuCVGZp5zwC2cfIJpE
	Btt9Brn/Xpi2uMQQsZtRgUgCdey+LtnFzLNT2OH8MPGsNgd8i9ZL+GF/4yRkwVmYzIF0t1ny2jA
	oA1G1Xpm9i+AWL0n4cBLmQO48Ir2o4MOhbGeBNaW5ViOu4Ynxt36Cup3kp38FFFKL16yv0JQY0n
	3pgZbs4NQxLCc=
X-Received: by 2002:a05:600c:4f92:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-4856eadb12amr13270955e9.13.1773695792006;
        Mon, 16 Mar 2026 14:16:32 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856eaa3b66sm19815135e9.11.2026.03.16.14.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:16:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Mar 2026 22:16:29 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv3 bpf-next 08/24] bpf: Add
 bpf_trampoline_multi_attach/detach functions
Message-ID: <abhzLaMUFHVow7ZI@krava>
References: <20260316075138.465430-9-jolsa@kernel.org>
 <d97442169a77b667c7f12664cd684f51a8914d4e2c05ef64344aacaae11c3415@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d97442169a77b667c7f12664cd684f51a8914d4e2c05ef64344aacaae11c3415@mail.kernel.org>

On Mon, Mar 16, 2026 at 08:35:15AM +0000, bot+bpf-ci@kernel.org wrote:
> > The detach works as follows:
> > - we lock all the needed trampolines
> > - remove the program from each (__bpf_trampoline_unlink_prog)
> > - the trampoline_multi_ops passed in __bpf_trampoline_link_prog gathers
> >   ftrace_hash (ip -> trampoline) objects
> 
> The detach description references __bpf_trampoline_link_prog, but the
> detach path calls __bpf_trampoline_unlink_prog.

ack

> 
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index d55651b13511..9331cca8c0b4 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> 
> [ ... ]
> 
> > +static int modify_fentry_multi(struct bpf_trampoline *tr, u32 orig_flags, void *old_addr,
> > +			       void *new_addr, bool lock_direct_mutex, void *ptr)
> > +{
> > +	unsigned long addr = (unsigned long) new_addr;
> > +	unsigned long ip = ftrace_location(tr->ip);
> > +	struct fentry_multi_data *data = ptr;
> > +
> > +	if (bpf_trampoline_use_jmp(tr->flags))
> > +		addr = ftrace_jmp_set(addr);
> > +	return add_ftrace_hash_entry_direct(data->modify, ip, addr) ? 0 : -ENOMEM;
> > +}
> 
> Unlike the standard modify_fentry() which calls direct_ops_mod() ->
> update_ftrace_direct_mod() to update ftrace immediately,
> modify_fentry_multi() only adds a hash entry.  The actual ftrace
> update is deferred until after the link loop.
> 
> This matters because bpf_trampoline_update() unconditionally calls
> bpf_tramp_image_put() on the old cur_image after a successful
> modify_fentry callback:
> 
>     bpf_trampoline_update() {
>         ...
>         err = ops->modify_fentry(tr, ...);
>         ...
>         if (tr->cur_image)
>             bpf_tramp_image_put(tr->cur_image);
>         tr->cur_image = im;
>     }
> 
> With the standard ops, the old image is already unreachable when put.
> With multi ops, ftrace still points to the old image when it is put.
> bpf_tramp_image_put() text-pokes the old image to skip fexit programs
> and starts deferred freeing.
> 
> In the success path, the window between image_put and the batched
> update_ftrace_direct_mod is brief (bounded by trampoline_lock_all).
> 
> However, in the rollback path below, ftrace is never updated at all:
> 
> [ ... ]
> 
> > +	trampoline_lock_all();
> > +
> > +	for (i = 0; i < cnt; i++) {
> > +		mnode = &link->nodes[i];
> > +		err = __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NULL,
> > +						 &trampoline_multi_ops, &data);
> > +		if (err)
> > +			goto rollback_unlink;
> > +	}
> 
> [ ... ]
> 
> > +rollback_unlink:
> > +	for (j = 0; j < i; j++) {
> > +		mnode = &link->nodes[j];
> > +		WARN_ON_ONCE(__bpf_trampoline_unlink_prog(&mnode->node, mnode->trampoline,
> > +					NULL, &trampoline_multi_ops, &data));
> > +	}
> > +	trampoline_unlock_all();
> > +
> > +	i = cnt;
> 
> If a trampoline at index 0 already had programs attached through the
> standard single-trampoline path, and __bpf_trampoline_link_prog
> succeeds for it but fails for a later trampoline, the rollback path
> restores tr->cur_image to a correct new image but never calls
> update_ftrace_direct_mod.
> 
> At that point, ftrace still routes calls through the old image that
> was put during the link phase.  bpf_tramp_image_put() has already
> patched that old image to skip fexit programs and started the deferred
> freeing sequence (percpu_ref_kill).
> 
> Could this leave existing fexit/fmod_ret programs on that trampoline
> non-functional?  And once the percpu_ref drains during a quiet period,
> would the old image be freed while ftrace still references it?

good catch, we need the update_ftrace_direct_mod call after the unlink,
I changed the rollback test to hit the described issue, will fix

> 
> [ ... ]
> 
> > +int bpf_trampoline_multi_detach(struct bpf_prog *prog, struct bpf_tracing_multi_link *link)
> > +{
> > +	struct bpf_tracing_multi_node *mnode;
> > +	struct fentry_multi_data data = {};
> > +	int i, cnt = link->nodes_cnt;
> > +
> > +	data.unreg  = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +
> > +	if (!data.unreg || !data.modify) {
> > +		free_fentry_multi_data(&data);
> > +		return -ENOMEM;
> > +	}
> 
> bpf_trampoline_multi_detach can return -ENOMEM here without detaching
> anything.  In e80a839e3d2c ("bpf: Add support for tracing multi
> link"), this is called from bpf_tracing_multi_link_release():
> 
>     WARN_ON_ONCE(bpf_trampoline_multi_detach(link->prog, tr_link));
> 
> If detach fails, the programs remain linked to the trampolines via
> mnode->node.tramp_hlist, but the link (and its embedded nodes array)
> is freed by bpf_tracing_multi_link_dealloc().  Would this leave
> dangling hlist entries in each trampoline's progs_hlist?

not sure there's anything useful we could do if allocation fails

jirka
