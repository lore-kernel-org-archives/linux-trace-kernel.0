Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795556892;
	b=a2Yn1mb5nuTpwfVn6miZn+zoZ8sHv5f6CYvS71UBPy5DwQryF7pZAleD9QbtL0LdxYRC
	 S9d5KSfG7UcrQg93RDH4StCxlEEWYddw76GYsZL8PTT5TUvafnjA6YwABwveyfJneJ/Uq
	 f1/LQr70oK2qQo3+6/hTmZiwPJ+RgETSyW5Ru4nR6kpwAXblcbqN2Amg5hQWnZ7Oa6Csw
	 XQr5KgNNgNBfppijZWlhp4vp+YjM21JLQStu5zcMTBZNmSzcYKzchKnyBkehqa1fP1R1C
	 +xRJ2wz+QSsHcDPDUnO4QG0JL7CJDz4Z8N2GtHlC2IpPGk3mQKXD5trnHMTkHSs9PCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SgapFXyCDKFt+peJ7rxw0qXMyT6IhM0lKM6Lr08CTds=;
	b=q1K17+sMirAnWGdSaKEbYr5TejoVqnyTlflend1xWRK14BSkVD9eYfhCk7IERkbe7xHm
	 Quf3NdSd9Rd5qj/DSNrg7FMImYVpR9UtpjgwY9Oeq7/dSyzn0SC88QJ8Ie9HLC1Hc/JYp
	 B1/ZmiPEwrhQGKDjSKfp0+jcasFABc1lZHxIo/6q8jjt89RVcXxYdtlnC04xRC3xV1+iC
	 etboBooQZtYl52Hxcy2GZQOSf00cVZt1waRSf4XdjrQoOEU9CsvV83IapHScnKeGX6/R4
	 +EsQbDdbzxPXdqOs3O+GsPJqfEozMdSvPPoivzKRtP9P7iB7zWkp5FMlfHiNQmPlgNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJVqJJ+6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B2606A31E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 21:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 248B2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJVqJJ+6
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so3879991f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 13:48:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795556890; cv=none;
        d=google.com; s=arc-20260327;
        b=QOzSDm1o3P2QLDKBtSreS/TfAwS3b9Il7hN1e+rdHkI7L+NoTM8Ckg0KvdXRMQ9ZKk
         X2nWK1nz5OQKaYr2IH9/yG/bZ25kqG0F+n4uxb2TvfX1xpRSA+folwm4wbiuH9vn2Mjp
         72DRmNNFYdL6F1wsghgPHDXbsAy+hajixSRhHUcnh8+f5M1EOOAUhzabj0ketv1daSlI
         JtU9t5M9NjcSM52/IbGwQhS67TkXtZDfude63vLWCc868fqZW4o+fENdE9ryMJzGk4EN
         N3FGmvo4dPlxpl60BN601YN3vcDPsyDPdEQOZe3AGqtLZmOheI5q+gg1ZdP0SmpTsXn2
         aNsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SgapFXyCDKFt+peJ7rxw0qXMyT6IhM0lKM6Lr08CTds=;
        fh=lnn3WlgjLfNJIlz1vSpLOo05/2xmwKFxNyW6OX07bSc=;
        b=eeugwpgKVIXjzlOwu9cvaX7Y7dGQr3I+Z9MDqrJ6Aq3Om2mk1n4I/IoHu7kEFB/JZ4
         X0wExDygC8yUlSrBVaa+E2h/136uUkVcVrvJNX10A3UKXRpVqVqqjZe6uGNdCOGeF/pP
         Wx8ufmqaAJ8kcxZEILpyKwegYtPC8RpkJV6iZeKHBoisoThfMsP+LtZwOidptFA0fUt/
         srcKrH39o+buqhxZrXrFzy7nN6zccNoM6RwSE7DyFK4EMonm9NcywaIDee6ovlevdSaq
         xTcwiNBpl5LVarKQ7aIY1DSsRhq2fVxWuSkt3y0jhByY2038YE0GlCGMe0FNrSrhYUAG
         wxKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556890; x=1796161690; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SgapFXyCDKFt+peJ7rxw0qXMyT6IhM0lKM6Lr08CTds=;
        b=PJVqJJ+69ydWTdAOwldeOa/Zj/oB1g/WO/zF7iEkoC4mDRrbViIThuul+JuPovnSy8
         VZPYecWWf8aLtnEwNQ1utKYSshKRanMRv1jps/aMfaq7R+ooeavz+OMJtKggZDXQrRBV
         2zZ0eoHWjD0KfpS092rbqq+ea6adZ4qiN904dMbpY6gsgLZgfKqCjThFUnPFowdFu2dn
         VM/qbz3/7AuMADxjYBaLk/MlY4MJzP8iAKicfOjMwlO7P2ZKWxFsPLg8dhMeISZJq0FD
         oNe9kLD/juIUFXh6NekvH99kcZz7l5tRMesdS1E/YznaTja0wQ1rsYYfz3w5C3w3Lszd
         UrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556890; x=1796161690;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SgapFXyCDKFt+peJ7rxw0qXMyT6IhM0lKM6Lr08CTds=;
        b=AHrcs95b9XRn5pSTSgh5cLKz++YxaKSVFno2QdVt9iCumGr7z/K42cKEuVEgKQNhy4
         z5Vts/u8QaH2yMcwlkGLoGATBWP3CmEEWCMqjrh7/89sC3xYb+WFqnfn28q7bYEzRKSS
         oBZkoigtmyYQ4F+jvflFcC0K6JEeWjqxzuUWqnok47zDcrqZtPYL51cm34uz6Jbe9hk3
         zh6fY4HYKZB1R3+6IGgzXV/5LN7pY1btC0hzVyiP0n8fme3razWmRBtddIlT0aU0LnRc
         amdXc6k5AvjOIp0iCPcYymiWi50ak6T5MtsXl18SqZI7hjcCK9+iTqlP+p1EvczwLr2m
         2mew==
X-Forwarded-Encrypted: i=1; AL+hErFt01V5p6jOWO29kzJTquqsL040NUCY0kac8M8IBGZlABdu+PMDuo2/VwmorRUHHoXIvMyOemLHlJOgynYRMeLaSC8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FKlr0kgCgOX7Pmi3EEehGlmFSnq1VigmGPm2T9vCBp2U5bVMS
	pukUOB2/lqlzgY+uH+aKD2zMpnEX4fD+SjPBX8ljRLIqnuUCbQG6CsGlBPuphKyxp3McefSFKu5
	iXwBsF+rT9Ank0UEnl+tMXA0jsLMCi9Q=
X-Gm-Gg: AZFdTZf+ym10WPlnF2YzMkgAjMzcS8tBJGj4+pk1Gn/JZw690kMHlLF7yP8Qx8cEVZT
	adOociuQiTYuSNi6lezYU8SbqL9l0wmjmWuu6KpyMr6hFKPilUOGRMXfhBPBxdxvzQJeoikQwPI
	IK1h+AtWI05LHxgrmC139JxPwJieYDD17BYc+qQL6Ff86i7yBP69b4jk9r2xP2CNqpSrvQbk1eH
	4GpplrlvL2RMdayuhKOdMa8fm5sTOlttQAEQwQXexxA8vO6hQizwSdsJOGJjHhmbzuCCkFmYE0d
	pUqC12jaxIgmJ5q89kT2YZyXbWDjPal9FtTQCHMBtKo+Wvwx59tvOAcueJI427zZqqSRn5eUZ91
	mmm9F5fe5BnkRUKNJHPjgl3rSG0Z2mIxC2BZ0CS0WFcseb+nq7OwTASHFqldlerUhF+ORKbmq9P
	GohH84y65L4IYqeTByJvY=
X-Received: by 2002:a05:6000:27c1:b0:4a5:26ff:13d0 with SMTP id
 ffacd0b85a97d-4abb0f3b5bdmr20496747f8f.14.1795556890344; Tue, 24 Nov 2026
 13:48:10 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com> <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
In-Reply-To: <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 13:47:58 -0800
X-Gm-Features: Aa3M54r4cLpLVpvm5Jm5CUzi10h61k0_Z20IJHqjjVNyNuLE3oFuveUgR2mZQgg
Message-ID: <CAEf4BzavErcSOZhGobqEo68d+2bCnJ8vFxxT_vqb+oQw1j1d7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: mikeba@sentinelone.com, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	JP Kobryn <jp.kobryn@linux.dev>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:21=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 17, 2026 at 03:29 AM Mike Bazov via B4 Relay <devnull+mikeba.=
sentinelone.com@kernel.org> wrote:
> > - Marked programs are not fixed. A program with a per-CPU map or a
> >   tail call loses runs to preemption as it does today.
>
> I suspect users will hate the behavior introdcued by patch 2+3,
> since adding a per-cpu map will suddenly make the prog to miss events.
> But the idea has legs.
>
> Earlier I proposed to insert bpf_preempt_disable() by the verifier.
> No need for that. bpf_prog_exit_run_ctx() can do it when per-cpu access
> is detected. Like below:
>
> > One question: the marking is automatic. A flag that the program's
> > author sets would avoid the second trade-off, but existing programs
> > would keep losing runs until they are rebuilt. Which do you prefer?
>
> No new uapi.
>
> >   series #2    42.34 [42.12-42.78]  39.87 [39.46-41.38]  41.53 [40.79-4=
1.75]
>
> Good enough. let's keep the walk. No need for the array.
>
> +static __always_inline bool bpf_prog_enter_run_ctx(struct bpf_prog *prog=
,
> +                                                  struct bpf_run_ctx *ru=
n_ctx)
> +{
> +       struct bpf_run_ctx *ctx, *old_ctx =3D NULL;
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +       old_ctx =3D READ_ONCE(current->bpf_ctx);
>  #endif
> +       run_ctx->saved_run_ctx =3D old_ctx;
> +       run_ctx->prog =3D prog;
> +       if (prog->percpu_state) {
> +               if (!prog->sleepable)
> +                       preempt_disable_notrace();
> +               /* sleepable prog should be using explicit bpf_preempt_di=
sable() */
> +       }
> +       for (ctx =3D old_ctx; ctx; ctx =3D ctx->saved_run_ctx) {

do you mind checking if unlikely() around ctx improves performance?

> +               if (ctx->prog =3D=3D prog)
> +                       return false;
> +       }
> +#ifdef CONFIG_BPF_SYSCALL
> +       /* Initialize the frame before interrupts and NMIs on this CPU se=
e it. */
> +       barrier();
> +       WRITE_ONCE(current->bpf_ctx, run_ctx);
> +#endif
> +       return true;
> +}
> +
> +/* After an enter that returned false the frame is not linked, and the r=
eset changes nothing */
> +static __always_inline void bpf_prog_exit_run_ctx(struct bpf_prog *prog,
> +                                                 struct bpf_run_ctx *run=
_ctx)
> +{
> +       bpf_reset_run_ctx(run_ctx->saved_run_ctx);
> +       if (!prog->percpu_state)
> +               return;
> +       if (!prog->sleepable)
> +               preempt_enable_notrace();
>  }
>
> I think this should minimize the breakage and fix the issue.
>

So basically to opt out from this behavior BPF program would need to
stop using any per-CPU maps and just implement its own poor man's
per-CPU storage? And even using SEC(".percpu") would still be detected
as per-CPU usage, right?

Should we give a way to opt-out of this protection explicitly while
still using per-CPU maps?

> pw-bot: cr
>
