Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492721;
	b=Q6OTdaCto4DJBo6ITp4TaTFRFQsUmNbM8wbwT7UGkOgFk47emMvv8Wc85BMTWWBn5CtO
	 GQolI4rePb9CSqD/QgL5sA5ymHX8CAj8ShRWhoNZVT8aZTTuvHdJ2avywcFrMr+uK/1ic
	 shRvwZFBmW3veoVwCxB4LAbY/Su+/zllCwatUiUthHlSoxFd5DP9oKmvTshKUl8b2SGYb
	 FqSBypnJ2h/G1V7mtfYF386NLIGF6X82P2Jp1DF0peezGwjS3yygQTg2+x4lHdKPfIclL
	 10/rEBDhuxQs2PtCiQGvwFRrsnOWGHVS7qdVg6VRQNm5D15SVAGvNSUTe1CKtpMZnhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492721;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3NibvVX7brdWZ5di1wlbFuSrC2Qb7MkLd88yZGvu2wI=;
	b=An0CtR6VilmS7wfcNFLE9ej1PCQxL63tQ/a1ZEZM370kUDDGl8HQrClIN8orgb5jbetD
	 pkZFb5VJr8A9VF4QQ7DEulTwcIbVKTljb1lSXK6qJ5XYrwwc8tAQrxaMPoFdwOx2+4fIb
	 K3s/h66OT8YC/xcEeLflwrdjw5lPygqd/6UV+8YjPZrKT1Cv9Z9SbNW3WWdYZ4x9wp7XK
	 Oj9MjZHsLAB3zlujkwM64TmorXHqCPlAY+cjk6GK8/ZFU7WCLKXdo7HdDjfdcqNjN2Pq+
	 C9s0LueYkljeQ9nXIsUhK5bvwyZDV0dsMqf2Uo00OzC5xk8hQNYlEjW7wwYaAWGuy+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anaCq1hQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DD606A31C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=anaCq1hQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AA21F00A05;
	Thu, 12 Nov 2026 14:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794492721;
	bh=3NibvVX7brdWZ5di1wlbFuSrC2Qb7MkLd88yZGvu2wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=anaCq1hQ99Bz/39uZ39613C2lZtoSvIu9N1OwemXOz0ZW4/VUabdpHJex1uhBm/sj
	 wXDdmvXMdmfhLqK6vhiA4zoNna20CDHDPVRntCwVgdJJ593a1HseAeYW9aB7/AvDZE
	 /lIbPPjt/tYHZiZqMu3Or+D2haI1Ej4O/V7CJ2Dxs3eUVF39ARwWZuWXG/iIjblVIY
	 RbkATsqqdS/JSuTWh9bJXDmh7qyx5hjxDiux8B6/awpfiXQK6aj3neh1+B3ffPMl7t
	 9RBk1BlATti5snfC7OdADOZO34Iu94sF8KMWOXuid9ASzB6xZCdM6ohQUqu11GwLx/
	 1P3enhPWcb5dQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write
Date: Thu, 12 Nov 2026 23:11:58 +0900
Message-ID: <undine-1794492718334370450-11efabb5d6c81b89@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-210125@kernel.org>
References: <179444679892.345731.5271591537517106679.stgit@devnote2> <179444682679.345731.13247927117747302891.stgit@devnote2> <sashiko-outbox-210125@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Thu, 12 Nov 2026 01:57:04 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] tracing/probes: wrong bitfield lshift on big-endian in
>   parse_btf_bitfield()
> --
> 
> commit e5cd5bf4ce18aa0d644893f624a1f1a581f88aeb
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> tracing/probes: Fix BTF bitfield parsing and out-of-bounds buffer write
> 
> This commit updates BTF bitfield parsing in trace_probe.c to compute byte
> and bit offsets consistently, select a matching unsigned fetch type, and
> size FETCH_OP_MOD_BF shifts to the selected fetch type.
> 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index a880a90642d7c..3a57fe6b67cce 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> 
> [ ... ]
> 
> > @@ -858,13 +876,22 @@ static const struct fetch_type *find_fetch_type_from_btf_type(
> >  }
> >  
> >  static int parse_btf_bitfield(struct fetch_insn **pcode,
> > +			      const struct fetch_type *t,
> >  			      struct traceprobe_parse_context *ctx)
> >  {
> >  	struct fetch_insn *code = *pcode;
> >  
> > -	if ((ctx->last_bitsize % 8 == 0) && ctx->last_bitoffs == 0)
> > +	if ((ctx->last_bitsize == 0 ||
> > +	     ctx->last_bitsize == BYTES_TO_BITS(t->size)) &&
> > +	    ctx->last_bitoffs == 0)
> >  		return 0;
> >  
> > +	if (ctx->last_bitsize == 0 ||
> > +	    BYTES_TO_BITS(t->size) < (ctx->last_bitsize + ctx->last_bitoffs)) {
> > +		trace_probe_log_err(ctx->offset, BAD_BITFIELD);
> > +		return -EINVAL;
> > +	}
> > +
> >  	code++;
> >  	if (code->op != FETCH_OP_NOP) {
> >  		trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
> > @@ -873,9 +900,9 @@ static int parse_btf_bitfield(struct fetch_insn **pcode,
> >  	*pcode = code;
> >  
> >  	code->op = FETCH_OP_MOD_BF;
> > -	code->lshift = 64 - (ctx->last_bitsize + ctx->last_bitoffs);
> > -	code->rshift = 64 - ctx->last_bitsize;
> > -	code->basesize = 64 / 8;
> > +	code->lshift = BYTES_TO_BITS(t->size) - (ctx->last_bitsize + ctx->last_bitoffs);
> > +	code->rshift = BYTES_TO_BITS(t->size) - ctx->last_bitsize;
> > +	code->basesize = t->size;
> >  	return 0;
> >  }
> 
> [Severity: Medium]
> Does this calculate the wrong code->lshift on __BIG_ENDIAN_BITFIELD
> architectures?

Hmm, good catch. I only thought about little endian case.
(the bit-offset order will be inverted)

> 
> At runtime, FETCH_OP_ST_MEM copies t->size bytes starting at bitoffs / 8
> into buf, and fetch_apply_bitfield() shifts that native-endian integer left
> by code->lshift and right by code->rshift.  On big-endian systems, BTF bit
> offsets are numbered from the most significant bit of the first byte, which
> is loaded into the most significant byte of the integer in buf, so there
> are ctx->last_bitoffs bits above the bitfield rather than
> BYTES_TO_BITS(t->size) - (ctx->last_bitsize + ctx->last_bitoffs).  Using
> the little-endian formula shifts out the bitfield bits and records
> corrupted values in the trace buffer on big-endian architectures.

OK, let's fix it.

Thanks,

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/179444679892.345731.5271591537517106679.stgit@devnote2?part=3
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
