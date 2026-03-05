Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911A27E05E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719368; cv=none; b=RuK/MORYbehAYTaq0TUwIrWkotOp+qa5Qs19EUXmZPg0CtEWYUHnSn4xgCfCNbtG8L75BqYhtPj9wXU4i9dZymoBctjMzh1GSDaMJ0v2mQThFwXUhjOot+JNSzQeRAzHMUjlLndsfwMB1EVCf+KFJqqGZh0PGPekrZWwY0AQoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719368; c=relaxed/simple;
	bh=bgz9O3COzJWKZFYXwI62/DT5ZlfVX6Tgi6hBu0rXcrw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAodXLTEO7rnnC4AsWChRanKjH9CYT56dbvNi9AAwzS4TRIR5Ge75BkCdxU4CNMNAYioAhAOFgaHBQG+BCwYaM73BAMvsnoY2DV+6uBJVI45OQxDsVuWrhfExQxKHWTaXvEWxyFNTA4rB67X70KxRnZUkHysO/H8gCsPzAbg9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncU++pEL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncU++pEL"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-660fb578f8eso3476595a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Mar 2026 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772719365; x=1773324165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5F2Z+dABDZHtAocG8UHmP/srpFxbX53GysJp892PCRw=;
        b=ncU++pELtcJqxZ1GBX84i82Oiou/Rmw/xuN3dKUWGTE3gEYGihUADBw10nUwQHxoDB
         qavPkNz71mZtfLFHpo021iIEJqLL6D78TkFEa5Z5qnnZcRKPKPvYyEt7kCBwPGJpgGAf
         +F2eAE75qgenIj6ANj76aqZ7tvj+c/5QUimpjSCO8y8cWpIsbaCDUsyDmB2zYgWrjrvg
         LQLqjEXhK8u3/Qa8CYHDhMAltQeHezoPc1u7mc9tNggEEMzbfj+V5ycCnkRkslMhBFBZ
         /Y0kfyT2J+92lm7Y35nR3Ic9GzJF4dPj0ZixHZtYOYaZZhLKG3xaYMY5ltwX9gXHNZRw
         bAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772719365; x=1773324165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5F2Z+dABDZHtAocG8UHmP/srpFxbX53GysJp892PCRw=;
        b=EUTegK/yU8k7I0KkPXy2aFuHtZEFArHeS8z2qgrI6JC3J4PKlj543ajNbsWsxDqc//
         NLIxC213ME6V3Ra3Zkg/fTX/XIsZWdQJ+RTF+7KmkjfPY5nRwhnwA6dgsd277VTz0My1
         TriGpOo4klhKbDqUTDZJl2GPNjdVdWO78ESQbIGrg98BxgVXZkugynBZCK7yRYYkqBV+
         owIDIzIcbRnBXnKPZkPoIm+JXqyPhekuvDz4dSdx3X6/B7n7hA0NBTQwdljfa1r6CbqX
         1cy+m0zmIsMtTrdzkwOyR+0Xp+V5CH0hw3iqa6GTN3W3HwP41o5Acj+cilHuZJcyQvzm
         +t0g==
X-Forwarded-Encrypted: i=1; AJvYcCXVOFq5Gl/OGJZMlMx0RO/7XSSRnje/+pRaMxzubrgwqhHrIbs9sIuEwYXffPzg3R2bEoi+TjhTPMpSjNAWsMHJUaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjIQcszLj/GpR4pgGZcAnonvwvCmRNTwnBDH0wrKox6Wb68wik
	t12D9MYDbrUf9m+Wq/qIumk69PZFLc6NOCLHOCCDW23/DzaaHpQH/QiF
X-Gm-Gg: ATEYQzwy1Fn57maJWUqJF7t4K4eB7pRTSGPcEOYB95YK+2h2FZsjICqQNFaJw+1P7My
	6CK94Njx7z4soCSYS81MWSoSy7UUmnCXi/6MqhhK0F3Pg82RMbw0aJviyxU8WvYWvRZ+KtzO0uL
	EkG8LB6LytaJwwSRC5qGS+y9ot0MPsgFE1QeFI63bCEvXzthceOiO8wiC5FdWpOm/EiEBrme7Qi
	tF0Kix/0iRg3iH8hVA50Pn+ELau8w7He2WXT9w+17HFs9Z7Rklvj11fFeZXWNHUl4ocyy8A6a2B
	OHnmMSk4CHQ3LhRhPQmGt9DK1p47Z9cNYkMMzx4lI/O6srXPN7D3lcUb1Q0LIa90aYJLpHu9kIC
	j+CjLaoDkAxrnw8qC/0hAfN70b5wGn4iTtr09hyJhkC6QRSGWXXcTTHyUu+fz3vCrfr0C9JgY
X-Received: by 2002:a17:907:e895:b0:b84:40e1:c1c8 with SMTP id a640c23a62f3a-b93f14dba47mr407420566b.33.1772719353405;
        Thu, 05 Mar 2026 06:02:33 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b503424fsm35859009f8f.22.2026.03.05.06.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 06:02:33 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Mar 2026 15:02:31 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 06/23] bpf: Add multi tracing attach types
Message-ID: <aamM95ydg4RFY-MP@krava>
References: <20260304222141.497203-7-jolsa@kernel.org>
 <90246a2d7a691e7374b18d699e0778f10b750b85fd0739d485c96960925a822b@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90246a2d7a691e7374b18d699e0778f10b750b85fd0739d485c96960925a822b@mail.kernel.org>

On Wed, Mar 04, 2026 at 11:02:33PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d92cf2821657..832a87da5a86 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> 
> [ ... ]
> 
> > @@ -25173,6 +25181,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> >  	case BPF_TRACE_FENTRY:
> >  	case BPF_TRACE_FEXIT:
> >  	case BPF_TRACE_FSESSION:
> > +	case BPF_TRACE_FENTRY_MULTI:
> > +	case BPF_TRACE_FEXIT_MULTI:
> 
> The new multi types are added to this switch, but earlier in the same
> function bpf_check_attach_target() there is a check that prevents
> BPF_PROG_TYPE_EXT from targeting fentry/fexit/fsession programs:
> 
> kernel/bpf/verifier.c:bpf_check_attach_target() {
>     ...
>     if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
>         prog_extension &&
>         (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
>          tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
>          tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
>             bpf_log(log, "Cannot extend fentry/fexit/fsession\n");
>             return -EINVAL;
>     }
>     ...
> }
> 
> Should BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI be included
> in that check as well? The comment above it explains that extending
> fentry/fexit programs is blocked to prevent
> fentry->extension->fentry->extension call chains. Multi programs map
> to BPF_TRAMP_FENTRY/BPF_TRAMP_FEXIT in bpf_attach_type_to_tramp(),
> so the same concern would apply.

but multi programs would never have tgt_prog/prog->aux->dst_prog set,
and that check above is under 'if (tgt_prog) {' check, so I think we
are ok, but I will double check, thnx

jirka


> 
> > @@ -25202,7 +25212,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038

