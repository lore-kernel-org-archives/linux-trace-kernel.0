Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC672FD661
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761933480; cv=none; b=fBkjUybQjM8CbGxOFas6dewzwGp25dSQuQrM2wwbueByfiYEm5mFKM5ZDZfVjpzXImADP0GwZvxQzWLhLw/YhWN2TiZgnZc++9N/r81b90buHRfDyVqnffk+kY+0y/GhpUUzGhxdDf2SCyqNGdfHtGbXY4deVnudHFVmv+JuRAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761933480; c=relaxed/simple;
	bh=gRQf4DDIntfkModSJwsw4MX9R1zmj1elsC1COyx3zCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BFGmhm2464aq+syacSCFZnAh0UNJpkwUoUQG5dxu2sl4DGj8UZwm6XInzhsNtF+CVmmZpopVObhx9r+MfSerJOXyMpuIkbHAR6H0O1+XQm9DbJTbx1e2JXg/5ohrD9EfLVZfStjUIBHQqsbX5MW15cBNN7QmtPc3qf3/1VG3VP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoG7ThPv; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoG7ThPv"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429be5d31c9so901641f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761933477; x=1762538277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2P9FiL2QcoZ6ExIK9RVYgePRv5ASEiG42T2wP0ZQq0=;
        b=AoG7ThPvzB1BcfBYDiL/CzWCWBBMINM1WT5aVFIjqpRWAht2iVnOnY++THZZTIUovH
         zc0COMAaWgec3OvqS5kuzYIH28cGiJV1Sf0k9qhsm02zUEjlv5r7VrVSauY6jS9gp5+d
         ahVuSF42p/DvekGuDzPFjZ3E5beN7Gc03XpoHm3K+yIe0OxKdWFNx+Pjlicl/iDiqL/g
         F2W5JKRW9YMD3jSw7eGAGS4yH8E7lPv91fhKS7jEo6ErQ2/OpwwyeXSN/aqe0YSRIfkB
         nIEmQrb4d4zzD6bZdGjfjeJdN6p3rwAzZryxj/CeTbEZJkBjz2fGZeSDIGan943QSzcM
         XXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761933477; x=1762538277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2P9FiL2QcoZ6ExIK9RVYgePRv5ASEiG42T2wP0ZQq0=;
        b=PpxEI6UwEeGr+6tJiSKDmYp6lWiqKdxO02/yLyBGlNdvIWvFl0I0MLNRYylx70WasL
         qws7gzpUx0Bd+xY78rb58IQq11hO/RiXZYY1yZr5a4KC9KrYzKkv7NTHWyE3bv7x6UaG
         Qbk6+6svKK0l7yDiSMctwbKkhsELkp9mVy8EC5CVvH2l/Cj9Cgm0LyB9/hEKDCu47QdS
         BDfqgrHgxlqk2Bj7WSg3wQxEjY///JivpR93qffKM5d8sXLddcYv/WbQRWp3R+S/BM5I
         ol1lg6RYpTMvCkrwEdRxYL+x5FyAjvQYIaKW5nMMsEyu+pXdieSFVggXf0g00PxL0PLW
         CqkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXd1SNmpkiuP6Jedcs1CD5tZbQKgkoI9T2657+Ify3LrSrHBMjktky6KSxqYZreovpaekzg+MbLJVxeSqZtz08cbHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3+/zKwqPxUKhHjXAUPjVJ7IjF7nLEoJm/CvJi5z4zhpPLf+Uv
	/Usg8iWn0EHbmHGKzF/zBBz4WxHcSQGpcCWv9AcOfbhJSPcB+WAeOSygkihO87xCzVL7MjvRvq/
	G67U/vDWpvRFp1OwEMtHPZtHFcAH5fCo=
X-Gm-Gg: ASbGnctJpHb+8RqBScJCTCST+hDL3rJwVYrYq5afSCV2d0Akv7PdMBmREdbndTURfe9
	i+tbBzsTjfBUefwwgQlgv/O96kB0oGS0JftG4q5ArpuLpGr8RZRFrHszBMbJUOlsAnCE+oyQZ4c
	aS03UzPsstx6n2CH6gJdzsDpmjsvfGx1oHUrUKlN7yIX0FRQJWCTvr8XJ3YSoclQPVFc6L82dvz
	LRMfxDUeGtckvDAu5ycqIAbWNag18e9E1nVpO2u3bpWNjowOKwYk30+o1Tdf96aV5GIpzuUZmA4
	RhlUF8vPIWlcjakKj0ooFQPLIOSo
X-Google-Smtp-Source: AGHT+IG+d+7QAZA0xErMbJ0NyWCYUvKpdfaBvgqLGvune0WcMzLatX4OGFfjH6u0/Q/LC1O9RWYZIabduWoXl8G5pMg=
X-Received: by 2002:a05:6000:26c9:b0:429:bc68:6c9c with SMTP id
 ffacd0b85a97d-429bd6e16c9mr4127349f8f.48.1761933476978; Fri, 31 Oct 2025
 10:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <20251026030143.23807-5-dongml2@chinatelecom.cn> <CAADnVQLfxjOUqbbexFvvVJ4JTUQ2TKL0wvUn3iHv6vXvGfitoQ@mail.gmail.com>
 <CADxym3Y4nc2Qaq00Pp7XwmCXJHn0SsEoOejK8ZxhydepcbB8kQ@mail.gmail.com>
In-Reply-To: <CADxym3Y4nc2Qaq00Pp7XwmCXJHn0SsEoOejK8ZxhydepcbB8kQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 10:57:45 -0700
X-Gm-Features: AWmQ_blSpNQKxutUQA0l1ONzoOEPG4gd_ei1OnH1dWU8KItcMpWG8yzuqTLrnDg
Message-ID: <CAADnVQKDza_ueBFRkZS8rmUVJriynWi_0FqsZE8=VbTzQYuM4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:36=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> On Fri, Oct 31, 2025 at 9:42=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_entry =
and
> > > invoke_bpf_session_exit is introduced for this purpose.
> > >
> > > In invoke_bpf_session_entry(), we will check if the return value of t=
he
> > > fentry is 0, and set the corresponding session flag if not. And in
> > > invoke_bpf_session_exit(), we will check if the corresponding flag is
> > > set. If set, the fexit will be skipped.
> > >
> > > As designed, the session flags and session cookie address is stored a=
fter
> > > the return value, and the stack look like this:
> > >
> > >   cookie ptr    -> 8 bytes
> > >   session flags -> 8 bytes
> > >   return value  -> 8 bytes
> > >   argN          -> 8 bytes
> > >   ...
> > >   arg1          -> 8 bytes
> > >   nr_args       -> 8 bytes
> > >   ...
> > >   cookieN       -> 8 bytes
> > >   cookie1       -> 8 bytes
> > >
> > > In the entry of the session, we will clear the return value, so the f=
entry
> > > will always get 0 with ctx[nr_args] or bpf_get_func_ret().
> > >
> > > Before the execution of the BPF prog, the "cookie ptr" will be filled=
 with
> > > the corresponding cookie address, which is done in
> > > invoke_bpf_session_entry() and invoke_bpf_session_exit().
> >
> > ...
> >
> > > +       if (session->nr_links) {
> > > +               for (i =3D 0; i < session->nr_links; i++) {
> > > +                       if (session->links[i]->link.prog->call_sessio=
n_cookie)
> > > +                               stack_size +=3D 8;
> > > +               }
> > > +       }
> > > +       cookies_off =3D stack_size;
> >
> > This is not great. It's all root and such,
> > but if somebody attaches 64 progs that use session cookies
> > then the trampoline will consume 64*8 of stack space just for
> > these cookies. Plus more for args, cookie, ptr, session_flag, etc.
>
> The session cookie stuff does take a lot of stack memory.
> For fprobe, it will store the cookie into its shadow stack, which
> can free the stack.
>
> How about we remove the session cookie stuff? Therefore,
> only 8-bytes(session flags) are used on the stack. And if we reuse
> the nr_regs slot, no stack will be consumed. However, it will make
> thing complex, which I don't think we should do.
>
> > Sigh.
> > I understand that cookie from one session shouldn't interfere
> > with another, but it's all getting quite complex
> > especially when everything is in assembly.
> > And this is just x86 JIT. Other JITs would need to copy
> > this complex logic :(
>
> Without the session cookie, it will be much easier to implement
> in another arch. And with the hepler of AI(such as cursor), it can
> be done easily ;)

The reality is the opposite. We see plenty of AI generated garbage.
Please stay human.

>
> > At this point I'm not sure that "symmetry with kprobe_multi_session"
> > is justified as a reason to add all that.
> > We don't have a kprobe_session for individual kprobes after all.
>
> As for my case, the tracing session can make my code much
> simpler, as I always use the fentry+fexit to hook a function. And
> the fexit skipping according to the return value of fentry can also
> achieve better performance.

I don't buy the argument that 'if (cond) goto skip_fexit_prog'
in the generated trampoline is measurably faster than
'if (cond) return' inside the fexit program.

> AFAIT, the mast usage of session cookie in kprobe is passing the
> function arguments to the exit. For tracing, we can get the args
> in the fexit. So the session cookie in tracing is not as important as
> in kprobe.

Since kprobe_multi was introduced, retsnoop and tetragon adopted
it to do mass attach, and both use bpf_get_attach_cookie().
While both don't use bpf_session_cookie().
Searching things around I also didn't find a single real user
of bpf_session_cookie() other than selftests/bpf and Jiri's slides :)

So, doing all this work in trampoline for bpf_session_cookie()
doesn't seem warranted, but with that doing session in trampoline
also doesn't look useful, since the only benefit vs a pair
of fentry/fexit is skip of fexit, which can be done already.
Plus complexity in all JITs... so, I say, let's shelve the whole thing for =
now.
