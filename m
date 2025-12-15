Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4111264638
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Dec 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765824031; cv=none; b=r2hKnYPK5PJ1fshFV4t4ly9SLzyCjIfPW8muXYFLtkqI7K1+gcF3bAqwjL3vbM1b60/ov2OoIEE07HT7CAjNNcDFbfO7zhXnU5H8+8nknYW7P8GdAbE21Rsp2yddP/gzmPOd6kdijmsWnJMON7WHB6zlvFSnwtNEBDoPFLb1XRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765824031; c=relaxed/simple;
	bh=6hoUMae+zoavzekjPs9P3WzMrcf6cGWD6wDiGzH7o4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUqzry5wj77PadSrIh5uuUg0SizMxYCuhQmwMDIhtsfgpp69lObhJfWWQXVCjqV1JskC74YTuPoduT41XKMrtGXcAzXVrdfhksnWpPUfHHl1yNEbOU4PueBqScxqxpWT5PWxEoh/o8C6Y11tH+YkG2x1iSrBMl9AGAFMdk408Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AV4NejQH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AV4NejQH"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so27179325e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Dec 2025 10:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765824028; x=1766428828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A40oinP7976d+3LuAJAHi9zbdg3RWJDbF+TA1DrtdNU=;
        b=AV4NejQHujPyGjVI/u5DTrl+ZIfaJdZVe2ZsAjF+YQxZaOKZ0F/21Veo1mbHjowHhD
         ic+wnbBMSK2knwxMf4Ws07OuSyxxw0mYgAeqk/vOuRjyPPAZzeAD59wHpLMPzi4+HdBz
         7Eb0uCwd3Pq2eihu1OE8yz7gvv+dl25B7uCfkz8xafPDi8wDnOIGpTvH0/4F6ppGgkrr
         BnZg12F8MaB4RvVUPFt+wHa8MUTuKDX7apNj3IsKr1h0a9rQpWkaUo5jKwNT7q8Na3fu
         Wocc6LlS+QOiK4cEJxJ97twkZR4og6BOnOUVJAqsXbW5eWPYTfFMlJtN9u/lv1BwCWMG
         Mmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765824028; x=1766428828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A40oinP7976d+3LuAJAHi9zbdg3RWJDbF+TA1DrtdNU=;
        b=X5yt2lqUsF03JeuhDdpHNu8lThBIDiO8/CZMSyshPKLFrr1AOVB6kCUQ+laJ0xTxhv
         O1Uf25q+X+Tn4KFfKq8Qk9g04yBHpuPy2EKBkl7zK5dQXjRfbuYPJOzbWTPvKI+qngrY
         pwOh37lxRkdBUacSfD3+zKUFrCgWig5bzsu12LdNQU51KxssGkjLMosWeY1/gC3Kr+rM
         J3DcJUxboS7LXBujfeVZCMSXjfIfU6NZkAFYeWjx7VAnIRJyONXX5QnVo0y3lMqnojxG
         oRGd8OSrbNgPHlh+5vmccn5bLQtK3LL8xubwMf5HRHS17IB8A8LzQXCh5trkWk9Wejca
         48bw==
X-Forwarded-Encrypted: i=1; AJvYcCUVhyGSdVZ9F3TcSH2T0A43zJqiPceHhMd3rOJ+RxGGVL/MqtfEDTrzmhvzC+ZcYyTc41cCosJfSDcVx1+VEj9ea0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3MMVegkiV5CKX2EfCRl1ChlAa4sl2222PL2+XXkZTb6meQXmU
	y6chOqz3sjatz8Jv+InYUFWCLISrnUGLFGt/s66Z2dxkMb5W70SA1XZGRC4VO91a4G6Vk10FYlz
	DOXuVupMhOHCPZ9ffg4ZF2xdRFmiJNoE=
X-Gm-Gg: AY/fxX4URqkQEYd62PlZBdVman2r7gvtBq/w+c+Elpy/ZzeSnjigeMmDAV1QArYyB+b
	CGrQzGT8/+7y7EqtJuVhu2pn4SvK1jWZ3BdlTbPpqFat1JiHUinbgqgipzPN2YYy1bkBrs+TFLX
	Mn3IJOlLT8PMu416rAKwgTGfs5gd1fb7CFyTHtEVMfntXDxVYuZezOyZsFiBFsZx4zD2KGN8C2f
	0PDOaJ4WfX6KsUoqhzk4ntAvGGXkDx10G68Wm5yvfb+jIYlGs+tscv4u6Na5WKr9RqeEr5Fd9Cq
	HIJCAtehrvym0tSYk+7dMltrGOuJJ0qGYmYPZXw=
X-Google-Smtp-Source: AGHT+IFb+jDBe31e7HX+TiBg+mt1mBaEF/5hsKb7P5tbtIiOt+ZGS0svam4CseMmqbzT0217NRPbnTYJZtlq2BzDl98=
X-Received: by 2002:a05:600c:6912:b0:479:3a88:de5d with SMTP id
 5b1f17b1804b1-47a8f91dac4mr131143095e9.36.1765824028110; Mon, 15 Dec 2025
 10:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210131234.3185985-1-andriy.shevchenko@linux.intel.com>
 <CAEf4BzZQ_OJehh=5jJgVBUjJBNAkWh2o8Yd9UTa9nFrRO4oAFg@mail.gmail.com>
 <CAADnVQKtvRhbAVunHrwj_pCsmazddADRvRo5zp5O+k5kc-Eoog@mail.gmail.com> <CAEf4BzbZwmOCgqhKeyAhEUT0MXyz09cy2dcpB9WCKWP1ikBWdA@mail.gmail.com>
In-Reply-To: <CAEf4BzbZwmOCgqhKeyAhEUT0MXyz09cy2dcpB9WCKWP1ikBWdA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Dec 2025 10:40:16 -0800
X-Gm-Features: AQt7F2qo9Dic_5H-tRJ57RrTlzYTnKH98jjg0KpMK2QYhZ0CAgyeFP-Fhj-4s4c
Message-ID: <CAADnVQLZPYc0HWqQw7ma=G-t9UMXXo+aXomVkYAzoQt=0ZrQ=Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] bpf: Disable -Wsuggest-attribute=format
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 10:23=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 15, 2025 at 10:13=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Dec 15, 2025 at 9:36=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Dec 10, 2025 at 5:12=E2=80=AFAM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > The printing functions in BPF code are using printf() type of forma=
t,
> > > > and compiler is not happy about them as is:
> > > >
> > > > kernel/bpf/helpers.c:1069:9: error: function =E2=80=98____bpf_snpri=
ntf=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 format a=
ttribute [-Werror=3Dsuggest-attribute=3Dformat]
> > > >  1069 |         err =3D bstr_printf(str, str_size, fmt, data.bin_ar=
gs);
> > > >       |         ^~~
> > > >
> > > > kernel/bpf/stream.c:241:9: error: function =E2=80=98bpf_stream_vpri=
ntk_impl=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 for=
mat attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > > >   241 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt_=
_str, data.bin_args);
> > > >       |         ^~~
> > > >
> > > > kernel/trace/bpf_trace.c:377:9: error: function =E2=80=98____bpf_tr=
ace_printk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 f=
ormat attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > > >   377 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt,=
 data.bin_args);
> > > >       |         ^~~
> > > >
> > > > kernel/trace/bpf_trace.c:433:9: error: function =E2=80=98____bpf_tr=
ace_vprintk=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 =
format attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > > >   433 |         ret =3D bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt,=
 data.bin_args);
> > > >       |         ^~~
> > > >
> > > > kernel/trace/bpf_trace.c:475:9: error: function =E2=80=98____bpf_se=
q_printf=E2=80=99 might be a candidate for =E2=80=98gnu_printf=E2=80=99 for=
mat attribute [-Werror=3Dsuggest-attribute=3Dformat]
> > > >   475 |         seq_bprintf(m, fmt, data.bin_args);
> > > >       |         ^~~~~~~~~~~
> > > >
> > >
> > > I just want to point out that the compiler suggestion is wrong here
> > > and these functions do not follow printf semantics. Yes, they have
> > > printf format string argument, but arguments themselves are passed
> > > using a special convention that the compiler won't know how to verify
> > > properly. So now, these are not candidates for gnu_printf, and it
> > > would be nice to have some way to shut up GCC for individual function
> > > instead of blanket -Wno-suggest-attribute for the entire file.
> > >
> > > Similarly, I see you marked bstr_printf() with __printf() earlier.
> > > That also seems wrong, so you might want to fix that mistake as well,
> > > while at it.
> > >
> > > Maybe the pragma push/pop approach would be a bit better and more
> > > explicit in the code?
> >
> > I suggested using makefile and file level disable to avoid polluting
> > the code. Even when attr-print applies it doesn't help definitions.
> > The attribute is only useful in declaration and in our case it's not
> > going to be in vmlinux.h or in bpf_helpers.h
> > So having it right or wrong in .c is misleading.
>
> Makefile is fine, even if it's a big hammer, I don't mind or care.

I rewrote the patch, commit log and pushed:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=3Dba=
34388912b5326aac591508c953a0be67a15d5a

> But I think instead of Makefile changes we should fix the root cause
> here. And that seems to be just wrong __printf annotations for
> seq_bprintf and bstr_printf. They are not printf-like, they should not
> be marked as such, and then the compiler won't be wrongly suggesting
> bpf_stream_vprintk_impl (and others that make use of either
> bstr_printf or seq_bprintf) to be marked with __printf.

yeah. commit 7bf819aa992f ("vsnprintf: Mark binary printing functions
with __printf() attribute")
should be reverted,
but that somebody else problem and the revert would need to silence
that incorrect warning in lib/vsprintf.c too.
