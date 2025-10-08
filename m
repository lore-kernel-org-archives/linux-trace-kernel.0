Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BCC1E32D3
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943373; cv=none; b=giOwCwuo747i59nPPXXPNCbpZR+JXSkGRkJ5LG2cUsYcoEKZEx50saeQC6o0/WU3HYvRIzUl0QvsU9pGA+qIbacn/vZDlTve48HH+XJxaFv4vXLe7fminLgXuf/gqTiYI9SYmawZ1bheNgg1MQjB3njbx6HImRNk1Fm1l+lNGgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943373; c=relaxed/simple;
	bh=q0rNAxg4DjEP/hoHH/PTjQm+3uqQRVCpSz5pRz7Z0hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeW1Z5BmrX3C8q6x+ntLlmJo/tvJufe0bBKGsq5MeM5OfjScLS+GIOySjYd4gFcRNIr1kKkUMoWF3Dn36LDx05a0bC003piHzZYaKFbt9bId27ZZNiJ4JTl6e23M3dNZJBqUzjpx+jArxfI3YhgfIUzYuacCFX5CAP1XnK/jUeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgBEjyJz; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgBEjyJz"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b4539dddd99so7343966b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759943370; x=1760548170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jz9qwl9ylUOWf25zEeAiwwPcUX4IEwoawwp4R3pWXHk=;
        b=FgBEjyJzNM9OGRqFNZpXFY0dBGMwEWd4ta6hRrvGKG9z7E1HAVdDubpHVJY5MfLbB8
         P4JQfI5WLl2H7AojzD/DZ/XOJfHkc1wGucai4fgCqhp9lSGLmT82b70b05czoOq96mE/
         kiHuYUvfyVHAk6uCjp96V2HEdV571X2kqShuwUvQvXEm6uy1WY/LqOzKb82SAPuntCng
         M0bHef679eOa6qn8Fq7S3MfbM+Pc+p0TBTiFEN5cbOQsR0AGQeVIzMWSu1u68BTFnt+H
         xsRLOsXHXeIXw+++gopYXn8js/kZM1Gl+aiVrImIZi1fHfsRPz2ex8DR950ru+2PFgUH
         kItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759943370; x=1760548170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jz9qwl9ylUOWf25zEeAiwwPcUX4IEwoawwp4R3pWXHk=;
        b=P78jUykuD6HEyklblpfDc9VE/j9C9CfpiYmft8AvdJPqOVF2ptaef+dG/fiP2M52gH
         6fJTOm43h2Q+Vu2QyOxQPeigpfeje7j3e50TrCqd73fRrsNP+zZ2BtOcKUqTqxHjGg2G
         iJ00sE4L3Lz8/R0QXTKERNhSBmQSjc8dIU8TPiAKKBgn1DNZmuLSblPyJ6tbAtqsqt5d
         kiD51Z7zNdTZntpJseSy9976yHDHChwVTeFz4CppdGjDKWVWeScEdIv9hDtgjw137zp8
         1HWpXJPm5fwhCaEWHjW+7ZMxc+Tjb2EvwP35xQR1ZW8nckWafIuXpYhfHaCkj6b13J1D
         44+g==
X-Forwarded-Encrypted: i=1; AJvYcCUVYFX4+dqznZJhB1HQCDXctVEWYbhdxoJpFmSpRIhxI2wxE4bYjFE8uhYtSizXEL2B7F9//mzPHwAnxr0ONg1/D3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6V3YEEO2CIla79dQS+7Ir/ivermxEame9IidyOA9nyB6WZNs
	Mb4tacTwpxaCg5tpuVzwcVUMhV0al/+Zxw6rwAAS3QOnx9KXFJJxg77IQNjYnxL4su3wVYtQIgb
	4Ho24UUfWKN14FIeKXSnZEjPjIx2qYqU=
X-Gm-Gg: ASbGncsrMso+bO0LN/qL9G9oMPUBoMwCuZWqWdByAPpzbceh0PZtTDjKsaVtHE6zJwC
	gjfSDlIMrGYNtKFFcDvW1lxNqAUmhunb5xlw11O94qG8SJ+DOX9JU01r3pxDJUuAV47dhEJ9zXe
	PI26YZZOQuuRrmDTCBlHTq4h/oZocyWh20GqsJ2ouyexGQRzUSSYMTJhbnmu5l4Pv6gOLWFvyJ7
	5GnHuilfHRT0pXWHX5+2+a1nDhOM05Pga9my3kOw1YMMsd0ssQSEAxfvBIjNdIh
X-Google-Smtp-Source: AGHT+IGWKbwFn3pQh+oqiRBdGn/RoV710Mep4oesQYjLCtzVy294+wOH2skWT01UGyugGuSxO5vuBFKgvwJqzotX83w=
X-Received: by 2002:a17:907:ea5:b0:b3f:f822:2db2 with SMTP id
 a640c23a62f3a-b50a9c5b35emr469591566b.11.1759943369545; Wed, 08 Oct 2025
 10:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev> <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com> <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
In-Reply-To: <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 8 Oct 2025 19:08:51 +0200
X-Gm-Features: AS18NWA7odH1HErK1kZmm5Nkkhj8jiRXGwc5vRm03R1MTC7gsrTHfFhzY-YDTH4
Message-ID: <CAP01T75TegFO0DrZ=DvpNQBSnJqjn4HvM9OLsbJWFKJwzZeYXw@mail.gmail.com>
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault
 to BPF stderr
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Oct 2025 at 18:27, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 8, 2025 at 7:41=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> w=
rote:
> >
> >
> >
> > On 2025/10/7 14:14, Menglong Dong wrote:
> > > On 2025/10/2 10:03, Alexei Starovoitov wrote:
> > >> On Fri, Sep 26, 2025 at 11:12=E2=80=AFPM Menglong Dong <menglong8.do=
ng@gmail.com> wrote:
> > >>>
> > >>> Introduce the function bpf_prog_report_probe_violation(), which is =
used
> > >>> to report the memory probe fault to the user by the BPF stderr.
> > >>>
> > >>> Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
> >
> > [...]
> >
> > >>
> > >> Interesting idea, but the above message is not helpful.
> > >> Users cannot decipher a fault_ip within a bpf prog.
> > >> It's just a random number.
> > >
> > > Yeah, I have noticed this too. What useful is the
> > > bpf_stream_dump_stack(), which will print the code
> > > line that trigger the fault.
> > >
> > >> But stepping back... just faults are common in tracing.
> > >> If we start printing them we will just fill the stream to the max,
> > >> but users won't know that the message is there, since no one
> > >
> > > You are right, we definitely can't output this message
> > > to STDERR directly. We can add an extra flag for it, as you
> > > said below.
> > >
> > > Or, maybe we can introduce a enum stream_type, and
> > > the users can subscribe what kind of messages they
> > > want to receive.
> > >
> > >> expects it. arena and lock errors are rare and arena faults
> > >> were specifically requested by folks who develop progs that use aren=
a.
> > >> This one is different. These faults have been around for a long time
> > >> and I don't recall people asking for more verbosity.
> > >> We can add them with an extra flag specified at prog load time,
> > >> but even then. Doesn't feel that useful.
> > >
> > > Generally speaking, users can do invalid checking before
> > > they do the memory reading, such as NULL checking. And
> > > the pointer in function arguments that we hook is initialized
> > > in most case. So the fault is someting that can be prevented.
> > >
> > > I have a BPF tools which is writed for 4.X kernel and kprobe
> > > based BPF is used. Now I'm planing to migrate it to 6.X kernel
> > > and replace bpf_probe_read_kernel() with bpf_core_cast() to
> > > obtain better performance. Then I find that I can't check if the
> > > memory reading is success, which can lead to potential risk.
> > > So my tool will be happy to get such fault event :)
> > >
> > > Leon suggested to add a global errno for each BPF programs,
> > > and I haven't dig deeply on this idea yet.
> > >
> >
> > Yeah, as we discussed, a global errno would be a much more lightweight
> > approach for handling such faults.
> >
> > The idea would look like this:
> >
> > DEFINE_PER_CPU(int, bpf_errno);
> >
> > __bpf_kfunc void bpf_errno_clear(void);
> > __bpf_kfunc void bpf_errno_set(int errno);
> > __bpf_kfunc int bpf_errno_get(void);
> >
> > When a fault occurs, the kernel can simply call
> > 'bpf_errno_set(-EFAULT);'.
> >
> > If users want to detect whether a fault happened, they can do:
> >
> > bpf_errno_clear();
> > header =3D READ_ONCE(skb->network_header);
> > if (header =3D=3D 0 && bpf_errno_get() =3D=3D -EFAULT)
> >         /* handle fault */;
> >
> > This way, users can identify faults immediately and handle them gracefu=
lly.
> >
> > Furthermore, these kfuncs can be inlined by the verifier, so there woul=
d
> > be no runtime function call overhead.
>
> Interesting idea, but errno as-is doesn't quite fit,
> since we only have 2 (or 3 ?) cases without explicit error return:
> probe_read_kernel above, arena read, arena write.
> I guess we can add may_goto to this set as well.
> But in all these cases we'll struggle to find an appropriate errno code,
> so it probably should be a custom enum and not called "errno".

Yeah, agreed that this would be useful, particularly in this case. I'm
wondering how we'll end up implementing this.
Sounds like it needs to be tied to the program's invocation, so it
cannot be per-cpu per-program, since they nest. Most likely should be
backed by run_ctx, but that is unavailable in all program types. Next
best thing that comes to mind is reserving some space in the stack
frame at a known offset in each subprog that invokes this helper, and
use that to signal (by finding the program's bp and writing to the
stack), the downside being it likely becomes yet-another arch-specific
thing. Any other better ideas?
