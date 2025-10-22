Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E98C13790B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761095122; cv=none; b=Q22aM8clLCqsb5xx6LzBw0DbzSL2s4Eejp6qvx0DAJmJVJhCfiOfc/DmmP2wlkUgX2QifP7vNXE2oWxUFSXNGAWo6KfSRKPGOX/nQRYPENVNcBmnwCF121tXoS6ZSYi6C2vwKl3HiaUpu1UGA4HGeaIZ/1OviigUQRd9lVjC0HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761095122; c=relaxed/simple;
	bh=4rmLUQu1le5r8D+swi25K4jEmqaVPWc7lJ6PHq6tcyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ishtiKzqH96KYSolga5uQVoWh+nw6YBGdAzLsgQCkNK7DTNopiwOSvkrs7JuK9dJ6C/kgEGjuXkDX5qmw15NeRopJXmIFEEj8poWFRoaoyNNzkgj9Od1eu0ksrYcCPEgdKkSnEFOsVgLAUITNg4t/FzoZeqeCr8YwomiFvfdhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDCIcUu9; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDCIcUu9"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-781421f5bf5so72165397b3.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761095119; x=1761699919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpBWUMQUyNYztr0Z+6+lgRKFyM4PGQRNG3RtejXI1dQ=;
        b=HDCIcUu9l4Uhbwu7zyX3X3VuVKCyI+HKGSp+LI2xNLz2NFyfdscIQyW79bnFihm5DG
         z1suO+SaaItuy4Hq2UCxlO7iyTb/+ayXNTFxxvuLWpI0j6DOx1QxjufvksL7ImfSD2Z8
         96S2x+n9F7eUFdKsVsaO9Zv59SiqrmJbXaoSSzRmYoCWuR//TW8kRR2oQeHyP/cINZ+B
         He3v3uo6tWAnxRwUwX9IME4SQqMIvZKpUwxvsfzIx3UlY0Hrdf2qfgkFPXn6RMeKLPsS
         bEztIWcL7Ctf9ulY2Zgbs7SpXq52QX8ysVLQ4QAHdayRVZasehc2+Smw3CWM3iFayeoY
         m5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761095119; x=1761699919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpBWUMQUyNYztr0Z+6+lgRKFyM4PGQRNG3RtejXI1dQ=;
        b=QfZS3vWMfdQGZyhJR8FETbnz13f9VRJeLBDgDPK9G6p5H9x8SoAANL9Qk4U1P4dqC7
         5/PyWlNyv03LuhSJlUo/OhvTNMDgJhgVasY0IZFFOgaBYlVhNi7iEC4qBsbkb0H/FKOM
         v4Audjd/Q1hfuDthOk/URW+ghP8MDlu6IVzA2/nxH709PIXeV4UuugSzyQJ9WP9IT4QV
         LgwNJJHGhltu3oY7FWKSI5R+MRGlQa+OztRJJgwGkjcln0YRFzfLkswslM4n7lrqe99Z
         4eZqkFfPw+6oZ1IvMTTcWFrPUoCwCW2iDkYSsL8MXPXyZMKbOWitzVk/jMrDtsIZLnNA
         9PjA==
X-Forwarded-Encrypted: i=1; AJvYcCWyk7zpgbQmkHzaG17vxEfhSxnEsjU0bewE+/D4ufvX++rBoNuGWd/ZSlM/jPv0PUUVqofxVINGsgeYHjmH5jmDMUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoeFzP3Zoi+OrjUkcwAktm69ctjIGJRpc+6sbl/boF/mVA4mSX
	J9J64LWN+f2pUTFzh75BxZ8AHriYuixiQis80kCp+d0FjnPt1zMYKU7BBHJrB4kZ2JPiSz+fU/l
	xw2TojVTCcl0irjIrw6sPcrVDvvkb7cw=
X-Gm-Gg: ASbGncvE6qPK7W5N5G7Wg3Hm3J9pHRZF+g1S6idgGwuq3Spc3MUidai/vqr+Jj+/vYA
	J8B6XN4P/EtTMDolc+R7d+RZx/xyc5Oi+Sc5gqDJgqdhhUcObd3Xri4Nh3YFerK+doiVBJxbo1c
	6YorlE4U2jifZLVlrJJZnRmwuyitronUcDhWIph5m9aLj1LU81B/fY0Ix3mZYY9rkkcpwCrSR09
	mZxMCM6z7mQNBAajQ1tol0YkhoTA6xGGocz+Yru7rm0W6fTZ41usn7OaYA1SoZGHPnitjE=
X-Google-Smtp-Source: AGHT+IF3FvmioM9BLiSXPvFefJ9mFTLeZP3TQOzmbGHlmIBl0/JtWtAgQ/j9lUo1B1DPYzFjyNFxiVtADeI/nOfgO0Y=
X-Received: by 2002:a05:690c:6204:b0:722:7a7f:537a with SMTP id
 00721157ae682-783b02e8f85mr264235697b3.38.1761095119351; Tue, 21 Oct 2025
 18:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
 <20251018142124.783206-4-dongml2@chinatelecom.cn> <CAADnVQLN96WZd0eWWb=__62g49y_wPfjTPKXaB_=o5jdVE7uKQ@mail.gmail.com>
In-Reply-To: <CAADnVQLN96WZd0eWWb=__62g49y_wPfjTPKXaB_=o5jdVE7uKQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 22 Oct 2025 09:05:08 +0800
X-Gm-Features: AS18NWBvheWbnEYFkDqoW2scTpYlV2lsYeAzkOkH1tIPcoLNZoG6fvzq48EGweo
Message-ID: <CADxym3ad72C+0D2AMDp799-zmLO-f2TG1+Xtbu-72Jv6LSzwSg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 3/5] bpf,x86: add tracing session supporting
 for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 2:17=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Oct 18, 2025 at 7:21=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >  /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
> >  #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)    \
> >         __LOAD_TCC_PTR(-round_up(stack, 8) - 8)
> > @@ -3179,8 +3270,10 @@ static int __arch_prepare_bpf_trampoline(struct =
bpf_tramp_image *im, void *rw_im
> >                                          void *func_addr)
> >  {
> >         int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
> > -       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rb=
x_off;
> > +       int regs_off, nregs_off, session_off, ip_off, run_ctx_off,
> > +           arg_stack_off, rbx_off;
> >         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> > +       struct bpf_tramp_links *session =3D &tlinks[BPF_TRAMP_SESSION];
> >         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> >         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_R=
ETURN];
> >         void *orig_call =3D func_addr;
> > @@ -3222,6 +3315,8 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >          *
> >          * RBP - nregs_off [ regs count      ]  always
> >          *
> > +        * RBP - session_off [ session flags ] tracing session
> > +        *
> >          * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
> >          *
> >          * RBP - rbx_off   [ rbx value       ]  always
> > @@ -3246,6 +3341,8 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >         /* regs count  */
> >         stack_size +=3D 8;
> >         nregs_off =3D stack_size;
> > +       stack_size +=3D 8;
> > +       session_off =3D stack_size;
>
> Unconditional stack increase? :(

Ah, it should be conditional increase and I made a mistake here,
which will be fixed in the V2.

In fact, we can't add the session stuff here. Once we make it
conditional increase, we can't tell the location of "ip" in
bpf_get_func_ip() anymore, as we can't tell if session stuff exist
in bpf_get_func_ip().

Several solution that I come up:

1. reuse the nregs_off. It's 8-bytes, but 1-byte is enough for it.
Therefore, we can store some metadata flags to the high 7-bytes
of it, such as "SESSION_EXIST" or "IP_OFFSET". And then,
we can get the offset of the ip in bpf_get_func_ip().
It works, but it will make the code more confusing.

2. Introduce a bpf_tramp_session_run_ctx:
struct bpf_tramp_session_run_ctx {
  struct bpf_tramp_run_ctx;
  __u64 session_flags;
  __u64 session_cookie;
}
If the session exist, use the bpf_tramp_session_run_ctx in the
trampoline.
It work and simple.

3. Add the session stuff to the tail of the context, which means
after the "return value". And the stack will become this:
session cookie -> 8-bytes if session
session flags   -> 8-bytes if session
return value     -> 8-bytes
argN
.....
arg1

Both method 2 and method 3 work and simple, and I decide use
the method 3 in the V2.

Thanks!
Menglong Dong
