Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7ED19EEC2
	for <linux-trace-kernel@vger.kernel.org>; Sat, 15 Nov 2025 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763174392; cv=none; b=Ra+hmI4QYR4KJfByEMva5SndUpknEODCh/IioPmWtKK5iEu8Y6TzncgZ5+1OdK2WTEMcTWO99kI0T76WyIjRZMpy6VliIpbupulCKSDxX1qjhls9hliK4v5mtUgBVM/idfJBh/I7Ez9SBxTF1LXsE8ZY9Y24P5tUC597YUkjcbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763174392; c=relaxed/simple;
	bh=gqysG4ug2z8wG5aRkdFy1JFZ/fXY6FPON2mpAtQGFfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYkokhai6g6mmnA2E/v4V8NYKztW65flni18B0ZQZEpyIItruC4pRZQXF80Ykn1Fj1S0PCPENcO4O8a54IkuEwL79G4Rol0UitgasKDm2ilvWufxXICFYBn5/higcznCNiI4lMSPeqjjE2z9HyK8tq+sO8dVBaIIYU5RJJtgdL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsaboFvS; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsaboFvS"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-71d6014810fso21279927b3.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 18:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763174389; x=1763779189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpFfOEHt1yzt3Q9cYV8WgHC2Py1Yh2XlB5O8fzKjYvE=;
        b=CsaboFvSBfWSYNRWkJ03ywp0+jhckhLxX3NnUe7qTZQfYMFWbSXu2M5x+aw5vSjKgJ
         hxMs0jsHVnAZMc/j/ABjHxa8HefZVQoXaOjub8oOe728XUJwy0pdOds0Dv+L5Q4mR8nI
         LQH3R0sbCF4BVEb2jhQP8wdtFNphjeoAn6htq3bEI5gNIPVOOOhfxV+mu9VGtJVg1JQd
         xnmRgaYEZsoTJY6QLUDPb6wrdYbbtN01F0sbtgC9KT3AtiXIiZorYkbKNmkqd0LpZBDf
         sNrERBr9M1wDuLqQW0c8ZFCkCluF0CkJisn0ygOV7h4mj8DwHSAsvMlR0ZtIV531hFIt
         234g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763174389; x=1763779189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TpFfOEHt1yzt3Q9cYV8WgHC2Py1Yh2XlB5O8fzKjYvE=;
        b=Z82/z8NPFZiF8DKabH1q9UXAEilEKGfEfO16OL8FkiVEYL+I9vj0VeN1MridgrC2Qf
         Y69ont2LdBzE6jZU7x5l0b8oG0OBXjTGlZSzvRAaNcR35pBjWT8eZOcZdnrd3loE0/wI
         Y+YOp4qPpZoVY0bUeywo7PoJzc4+08GwgEKgkTtvSnoyPV5l+xKphP4ymfA68xQAG0JR
         cV0tyJ3/d+Hu3OyIP/XC06LtJLAfOYNdL+cWuiqo5g2MTafbBxn1VcGP4sfhGstIUeP8
         WfZE5kpsn3BNi4223IP5nSjLVJWZSEW9pGwtbWt1GnAYXfgGBwLZZNejPRfJYoaEZviX
         1qQA==
X-Forwarded-Encrypted: i=1; AJvYcCUd+TKbjO/fNCwC0Sbj0DMIrxyhbZfHYAfh0WQ6VanW77iok7I/my+NhWL6NwCfFMriM83YjY/5GvRsh4/hQgb4mNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/ci5RwNbN34pHTv8fGuyA59SKymFVU6rAHUeGV9PLANmQAWy
	Ao2M6FEdnMc2v/oc0eGKBOoZITXvA5EKzbJSsbr1nPGeV03LrGFmgf+3gGpCHztnH08KCAQSMtm
	gtoCKYUN7SfJ44206TDPFQl/94B4uHfQ=
X-Gm-Gg: ASbGncsmpkR5wGpx4tfHac0rTMPVyl1sXNNmUzaZ3tq0kelbXkKlu7E15LzO8ziMwb1
	izTEvdobk6cGzMyjax+JsO4qqKuFTmdOPSaHnLuAqqFKiureyUe4Pezk+6dD2faPrnvinSp0MSu
	gw03JBZNWekJyhR65QGb65OOsC0T1LZO+kgiUWh1pWfxSiCcKWOjbDeoro5wQWICLECbpnWETcu
	rnJRxYixbnnoMKPzrUjpcHQ3i1S0gD31GVBDBxIProMRf9s4v+bnaZNAVKtINL1xpRUWiA=
X-Google-Smtp-Source: AGHT+IH9DYY1lEwS+EOIcaPqX+5gOOxWet3rXc5XuQvWVm1J+6hFlHeq5NVMW5p3eQdYscXliQ3No3u/mXn51VBFNwI=
X-Received: by 2002:a05:690c:724a:b0:786:7aaa:a04f with SMTP id
 00721157ae682-78929e01443mr47780157b3.8.1763174389288; Fri, 14 Nov 2025
 18:39:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
 <20251114092450.172024-8-dongml2@chinatelecom.cn> <CAADnVQKw9PtRYooO+qKQ70xgNusEn8qusBFfzU+bZ7WXRg3-3A@mail.gmail.com>
In-Reply-To: <CAADnVQKw9PtRYooO+qKQ70xgNusEn8qusBFfzU+bZ7WXRg3-3A@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 15 Nov 2025 10:39:38 +0800
X-Gm-Features: AWmQ_bmgLFOwAJbHNJYZ4FX17GgYxKCY245TEOD8ciu-UCZuXrVOg-cZbkoq6oI
Message-ID: <CADxym3bKsw=mrG+wNErLouhPSeobuqY7sTZRS=HrNeQ=0=p4Jg@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 7/7] bpf: implement "jmp" mode for trampoline
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

On Sat, Nov 15, 2025 at 2:50=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Nov 14, 2025 at 1:25=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Implement the "jmp" mode for the bpf trampoline. For the ftrace_managed
> > case, we need only to set the FTRACE_OPS_FL_JMP on the tr->fops if "jmp=
"
> > is needed.
> >
> > For the bpf poke case, the new flag BPF_TRAMP_F_JMPED is introduced to
> > store and check if the trampoline is in the "jmp" mode.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  include/linux/bpf.h     |  6 +++++
> >  kernel/bpf/trampoline.c | 53 ++++++++++++++++++++++++++++++++++-------
> >  2 files changed, 50 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index aec7c65539f5..3598785ac8d1 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1201,6 +1201,12 @@ struct btf_func_model {
> >   */
> >  #define BPF_TRAMP_F_INDIRECT           BIT(8)
> >
> > +/*
> > + * Indicate that the trampoline is using "jmp" instead of "call". This=
 flag
> > + * is only used in the !ftrace_managed case.
> > + */
> > +#define BPF_TRAMP_F_JMPED              BIT(9)
> > +
> >  /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit i=
s ~50
> >   * bytes on x86.
> >   */
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index 5949095e51c3..02a9f33d8f6c 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -175,15 +175,37 @@ static struct bpf_trampoline *bpf_trampoline_look=
up(u64 key)
> >         return tr;
> >  }
> >
> > -static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr=
)
> > +static int bpf_text_poke(struct bpf_trampoline *tr, void *old_addr,
> > +                        void *new_addr)
>
> The bpf_text_poke is a generic name. It really doesn't fit here.
> Use bpf_trampoline_update_fentry() or something along those lines.

ACK.

>
> >  {
> > +       enum bpf_text_poke_type new_t =3D BPF_MOD_CALL, old_t =3D BPF_M=
OD_CALL;
> >         void *ip =3D tr->func.addr;
> >         int ret;
> >
> > +       if (bpf_trampoline_need_jmp(tr->flags))
> > +               new_t =3D BPF_MOD_JUMP;
> > +       if (tr->flags & BPF_TRAMP_F_JMPED)
> > +               old_t =3D BPF_MOD_JUMP;
>
> Now I see why you picked _need_jmp().. to alternate with F_JMPED ?
> _uses_jmp() suggestions isn't quite right.

Ah, some kind. The flags BPF_TRAMP_F_CALL_ORIG and
BPF_TRAMP_F_SKIP_FRAME are reset during the trampoline update,
and they are not stored. So the "_need_jmp" means that use "jmp"
for the new trampoline that we are going to update.

The BPF_TRAMP_F_JMPED is used to store if the current trampoline
is in "jmp" mode.

>
> How about bpf_trampoline_must_jmp() ?
> and drop if (!ret) fallback and BPF_TRAMP_F_JMPED bit.
> It doesn't look to be necessary.

I think you are right. We can check if current trampoline is in "jmp"
mode with the "orig_flags" instead, and remove the
BPF_TRAMP_F_JMPED. That means that I need to pass the
"orig_flags" to
modify_fentry -> bpf_trampoline_update_fentry(bpf_text_poke).

Thanks!
Menglong Dong
