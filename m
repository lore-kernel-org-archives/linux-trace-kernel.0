Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53021E3787
	for <linux-trace-kernel@vger.kernel.org>; Sat, 15 Nov 2025 02:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172857; cv=none; b=aa3CfMHddzx7h117githqNnNOvYdAvzQbLnqmdnnfwU+I6CKlCkxnhINh0RRDRdkrJ3CxqrC24frSls4JEciQR0p3W6ktjqGO/B+Q0ZnvV72F/Cz7kC5GlHXXyLpOQ4BSUBiI/mNQjhWw6XwgGfB3Y9lD7gIW5b83ncvcSd7ct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172857; c=relaxed/simple;
	bh=+m60YjmlqfTe/IuZN5tAdQGIgUv5mVLfsgQlL5jkVv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR03Bn70Pt411777qHXFbMorC84y1RisytYSpA/PCLpuRn/vOO/P3imX/5k6icREwn2matVt3wYk6XS/SyJ+ATrt7BSJ5y48es4CW1lR6Nruf91PkrSPgTn9LBwZGg8FV+YecXUqBConL7PehUjfdHOlanz6vW3rdLZVU7T5lwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5RhoKE7; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5RhoKE7"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-787d5555274so26881967b3.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 18:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763172855; x=1763777655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypHiODfqvhtjR5/PkxQuREAV0OnJoKZAgpPoPF8g7XE=;
        b=d5RhoKE71EvY/GvQ5qoLPGGwvDUhC/FaB5XvD83vY9VbJ8Eg6jT7yS5xF6Mx/Ub2s5
         iiGi2g2MsBSJUfUNqEzyjRyGl4oKwvVj+D7Xge8q3dN9+oo5v0L7dCVIlyyDIjbb4+pE
         TP0ynqwRelOlCABnqmPtcpXk20nfSISfEovS/XIe0Zm5M/0guN4vabWSR+pt1u1ZZ1Bv
         ywdWhstZkvlI7trMcHe929GJBpFwiHMoIOWK0HLrlcwKrZS5Wpjob+PfmeQx1w4jR2i8
         hFftyu+eb+WxTgwoAXrz+55zmI8a1XnfhkJ+Anm8vhreOOiN5FKberr9RryFUtVPc7yd
         G0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172855; x=1763777655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ypHiODfqvhtjR5/PkxQuREAV0OnJoKZAgpPoPF8g7XE=;
        b=oLySONQh2mlba6bh5oZLuOc3fDcifNeZEezSidJVf9xn1vCasoyO7tMh+iSf59lNDJ
         enooDRNiE9lBgmxQoDhnf/JvnbuodEBTR9D/+ZBN0B6j9iJU1DWAGglrpoLdj6xkV5Bx
         j4JWzGD+x5XggMEE+YZmOnG/tuyp02bQqjzEumeK0PkxLkRPToK4pISd74PnnxyLH2f2
         tDG97RM3f/E9N7F4a2hzY7XFEqSPz0Blc6LO9WCtsvfb4uxSrRb/lPOZSFZlgniTj0HY
         pFHEDV2Xx8zFkPIoJ3fldrbMgv27GERbm3k6NsZuEn0VCRkJbk6cAi2Wbp2kiBAq5Wjw
         tNSA==
X-Forwarded-Encrypted: i=1; AJvYcCUmnP0DBGEhQhGTKnFKLJdZDD7e6fzK1gJ7akwIQRMemvApDPpBftFEKQsQEDmQnVYfwm+K1rDmdAZBts0ATHwfIyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJPc/orEJiKsXd3iGtndW6Tf45MNwwvesSi+5i3GJnndPF6lrI
	sjI4NDwdUzx0O34dhkPJuUAELBE17MGKNyLaWt7fUwxXN18BLdwjNjW3r/4gYw+faSDSngcbQjE
	UWNW/8gsBzqKKVyOvWF6cTe93hPMp/Hw=
X-Gm-Gg: ASbGncvtcx5VlFi7pAnjkxgLpsVBuW42sEydhaVrII1goRLAXhjDkZcUifD+/MC/6pG
	dmWC1s16eJr8SAj6xRL50NA66Krq+oKd6Fmo/ybE6qwW8vNkD0U87MpSbNNTWG42GwhCQFhXto4
	N5XgN2PQiFkR+7zkDGQ1hWfR1Awr/czY7DPmviI2I13dBPlCZrEYgxVV6gIx42r5UDSuzd3Sdf0
	2HZTp1364aYvPUT63gX8IPuRcqOjIGIa0SRN69ylbdXqnbP3C9Iyyl28GkJD6aNmFf9NEg=
X-Google-Smtp-Source: AGHT+IEZRehbbAVxb6HJsyS6vM8ac8eTWfXaOWmpx2XOFR03rskBetT5Bdil02SpZoBr41srGSaazYv3kD+abX5VVjc=
X-Received: by 2002:a05:690c:e3ca:b0:786:8adb:8ae with SMTP id
 00721157ae682-78929ed9753mr49681907b3.44.1763172854859; Fri, 14 Nov 2025
 18:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
 <20251114092450.172024-5-dongml2@chinatelecom.cn> <CAADnVQJU39q9amZMuVLzsg7CK5MLT_xFr0K4Bx9zp7P5C6MCRw@mail.gmail.com>
In-Reply-To: <CAADnVQJU39q9amZMuVLzsg7CK5MLT_xFr0K4Bx9zp7P5C6MCRw@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 15 Nov 2025 10:14:03 +0800
X-Gm-Features: AWmQ_bn9NAseH0LF8VNiBXBHj2voVilxDIw4c6Woqc_dG2KzsnEmofP3sbNmqAU
Message-ID: <CADxym3agZw6yzDdwpxYnRmzvT_R9aAQyML5_DGW-AknciB2Ceg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 4/7] bpf,x86: adjust the "jmp" mode for bpf trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 15, 2025 at 2:22=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 14, 2025 at 1:25=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > In the origin call case, if BPF_TRAMP_F_SKIP_FRAME is not set, it means
> > that the trampoline is not called, but "jmp".
> >
> > Introduce the function bpf_trampoline_need_jmp() to check if the
> > trampoline is in "jmp" mode.
> >
> > Do some adjustment on the "jmp" mode for the x86_64. The main adjustmen=
t
> > that we make is for the stack parameter passing case, as the stack
> > alignment logic changes in the "jmp" mode without the "rip". What's mor=
e,
> > the location of the parameters on the stack also changes.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 15 ++++++++++-----
> >  include/linux/bpf.h         | 12 ++++++++++++
> >  2 files changed, 22 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 2d300ab37cdd..21ce2b8457ec 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -2830,7 +2830,7 @@ static int get_nr_used_regs(const struct btf_func=
_model *m)
> >  }
> >
> >  static void save_args(const struct btf_func_model *m, u8 **prog,
> > -                     int stack_size, bool for_call_origin)
> > +                     int stack_size, bool for_call_origin, bool jmp)
>
> I have an allergy to bool args.
>
> Please pass flags and do
> boll jmp_based_tramp =3D bpf_trampoline_uses_jmp(flags);

Ok, I'll do this way in the next patch.

>
> I think bpf_trampoline_uses_jmp() is more descriptive than
> bpf_trampoline_need_jmp().

ACK.

>
> The actual math lgtm.
