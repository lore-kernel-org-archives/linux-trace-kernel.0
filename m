Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A2B30BB97
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365929; cv=none; b=sA5+fbHfQCJeztlq+IqfKWyz+5YmBWJClH5tXr6X+hj3CKURxmpJlF9X4SfvqMFPVkGW3RsClyq+adzgtnDH8a+1vPgn8Y3RGOVZ3kT1quRqBhvlANTSxQ/AIKkH7QQyxPgA1uWOIlRXfrgya4pTipq14icxSl0rXw0CCTdKoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365929; c=relaxed/simple;
	bh=8VTOp+JpA3YEgtR1igmL1BYWs323gtKL9YQ1bDjbsy0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaeA/03lnMiitHGGWixCsytQHnkkRuxLNmSDgfRgMDHnzJWgIE5k7YU0/vqARYtmFp626Mgpq3z0e62lA5HCAdsI7YTtM1+cDAftaherJLgXUOJ6L/k8QpEDPUWwMymlwf5/+ZrSY2t8FktGGACnp/RvD/jB4OWmev4iqujCIh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tw693UJD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw693UJD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48370174e18so30524585e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 14:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365926; x=1771970726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GIaSpSdncseBCd6oA9HXpHh/dLjSz2BM+1lYLoTGM8=;
        b=Tw693UJDnUUuMrTKXjDPzYd2k4MAn03HHZ5f/DyUYIgJHzEYdrzhyqpfHUQsmxdJh1
         zRG51fUWSDGmdA5S9h+kxOcNfjQSJ0KVGZmxjrX0gotwWJg5QF89Hi8bpcIlkWhCP6Kg
         4og4IoSKdGxE3N6Oqpdh9xE+VQihgHaGxMnBmFWighJT/v38ERgE5DSlLu9Rs+FMW4jd
         vceoeRMiG5ffMX1s26mfToRmpIlr3MIRvo88UOlYkJoNTgtnO6gSphzWk3hzOhcA7esD
         bxS48rbG/oQ/CZM8zdgHq5kGDoM5yaGzucunSTZJpNUo3Bp3MOzJJ718fPMJYJK91YDY
         aVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365926; x=1771970726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GIaSpSdncseBCd6oA9HXpHh/dLjSz2BM+1lYLoTGM8=;
        b=WbepmZGS/KIpN2tLAo94vgN9+7LGEIRKIhJ7pnIK5Iqo1t5bubXMCrjhwfOTYPjEqN
         SZK9c1AqUYcrJsG06OZCroqXH9C5qa8n+Z/+OOLm0rh0kmHQBj3RSKRhgozHfK/F4/F6
         /y0GNZMWIZj1Er0gTN1drclDNECSp6Tv9PNyo7SqnwdwrSkfcA2egzaafnol/9lbftZS
         KClSHH3HYqt4UhyNVdtB5kL8E2AIZ1VUS3HYdJh87G09WjGOOucs6nvwHIkXRfaLJMF/
         ADD7vyTor5Cyh4As9wQkHK9jdH4UrSADxA+TYN/OKoqddkZ23mwfdoOhGIXDypBXNATE
         9szQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX8wqfhUDJqqdZnBWxIDR/1UCDkYpu60+vdL6ByWx+lY3LAn1EhtQ9d/u8jyTW14brD38+6DVWLhs8iilIYdg/vjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9tI4AH3GYkxO9PV5lzlgA0ky9rmelxkkCVpfJjz48dS+/CJzW
	oGvT2LChTXXoEeVw4+wUEZTq8gd+3BwQdDsD12oQodmU8LNUL/AKQpkM
X-Gm-Gg: AZuq6aJ9jV4Rm4IyHMHkgCzCnqJRL6pITSHFNhsfogrhFLT1EL7kNN062hQOfLW8RYa
	tojtveI1XJ7dyXqbf6uEqw13cTy123UWshRLuKRiHcPsPaK/+jMi7EkAGrVx3XmWSN6wWWUGPUB
	viGwDzYCObQKSKiB6Hd3hjz+wKVi5UIv9WyY3SkzRrkXpNLIzeZgRrqCkijj+q1UU1pHOWbPnfO
	kzPqSINRu7VKb46U0Nqr9WYqN3tFRKotT4hIkxp40owjd+4GB9ptUQyP21gegStWlRiVD2Tpiv0
	YHk/znUha/CqtaCZr5l1LJ668/zOP4uvU7z+UWwnkrs6iaFUDt3vtszZ3mKcLLgkSyW8F22nT5o
	V9X/runD76w/+t/LwDssZeofp0BVQMKoJ5tH9xjBJuZjIT3hs+pO7UDvdvjeCEizAahS84NUx/z
	BpXk2/fIH46Bezv0cJBMtumyp3c9TnhbFO
X-Received: by 2002:a05:600c:3e0d:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-48379be7576mr209543885e9.31.1771365926470;
        Tue, 17 Feb 2026 14:05:26 -0800 (PST)
Received: from krava (37-188-249-12.red.o2.cz. [37.188.249.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48397423bb4sm4170935e9.8.2026.02.17.14.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:05:26 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Feb 2026 23:05:17 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC bpf-next 06/12] bpf: Add bpf_trampoline_multi_attach/detach
 functions
Message-ID: <aZTmHdWSNxuBktKP@krava>
References: <20260203093819.2105105-7-jolsa@kernel.org>
 <bfbbb9ef3aa022d56e5777597b48b596c4a959e606fcbc9d63f4ee1e6c07941f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfbbb9ef3aa022d56e5777597b48b596c4a959e606fcbc9d63f4ee1e6c07941f@mail.kernel.org>

On Tue, Feb 03, 2026 at 10:14:02AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 2be2f1d0b..b76bb5450 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> 
> [ ... ]
> 
> > +int bpf_trampoline_multi_attach(struct bpf_prog *prog, u32 *ids,
> > +				struct bpf_tracing_multi_link *link)
> > +{
> > +	struct bpf_attach_target_info tgt_info = {};
> > +	struct bpf_tracing_multi_node *mnode;
> > +	int j, i, err, cnt = link->nodes_cnt;
> > +	struct fentry_multi_data data = {};
> > +	struct bpf_trampoline *tr;
> > +	u64 key;
> > +
> > +	data.reg = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +	if (!data.reg)
> > +		return -ENOMEM;
> > +
> > +	data.modify = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
> > +	if (!data.modify) {
> > +		free_ftrace_hash(data.reg);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	for (i = 0; i < cnt; i++) {
> > +		mnode = &link->nodes[i];
> > +		err = bpf_check_attach_target(NULL, prog, NULL, ids[i], &tgt_info);
> > +		if (err)
> > +			goto rollback_put;
> > +
> > +		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, ids[i]);
> > +
> > +		tr = bpf_trampoline_get(key, &tgt_info);
> > +		if (!tr)
> > +			goto rollback_put;
> 
> When bpf_trampoline_get() returns NULL here, the code jumps to
> rollback_put without setting err. If bpf_check_attach_target() succeeded
> on this iteration (setting err to 0), the function will return 0 instead
> of an error code.
> 
> Should this be something like:
> 
>     tr = bpf_trampoline_get(key, &tgt_info);
>     if (!tr) {
>         err = -ENOMEM;
>         goto rollback_put;
>     }
> 

yep, we should, will add, thnx

jirka

> > +
> > +		mnode->trampoline = tr;
> > +		mnode->node.prog = prog;
> > +	}
> 
> [ ... ]
> 
> > +rollback_put:
> > +	for (j = 0; j < i; j++) {
> > +		mnode = &link->nodes[j];
> > +		bpf_trampoline_put(mnode->trampoline);
> > +	}
> > +
> > +	free_fentry_multi_data(&data);
> > +	return err;
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21625440628
> 
> AI-authorship-score: low
> AI-authorship-explanation: The code follows established kernel patterns and contains a human-typical oversight error (missing error assignment); the commit message has a minor copy-paste error typical of human editing.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Missing error code when bpf_trampoline_get fails causes silent failure under memory pressure, but does not cause crashes or data corruption.

