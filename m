Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B367278E5D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759954142; cv=none; b=JyZIZeiBCKcLH9qdg8luw2AZm733UfFzxGI6eSiWqzE9IRuoI5puvSYEPQ6UT2uKD10+nh6gvubZDHg8T86Vrtlg4otrZKyYWAE567pCNlw7Oh6EQwZd854Cs8em+MoDJ4wn1OP+8TJllx5iRQYnP8sqCt6EXkRvXoYChcHsKiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759954142; c=relaxed/simple;
	bh=+Jz94DqaV5+iKLV52tI1MBLzkq7tXiHQZ1RwfsddtlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxMlQJpHnC1zJXy4qRmWJvGNVVUG9w4C+ck1JqAiYA0Zwt+Q/r/UA/5gd3BKtyYJryz+IAWNZ8fAdb4dUERhJ6Wtm9oya0hbe5sz59SIvy+UI+DFC13D00oBVTCTMXVmfJHCAQXvu6jz9nnu1Qi8TZYLLe5uaIB2Pf+7s7Y5HFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf//uEyu; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf//uEyu"
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-6399706fd3cso356277a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759954138; x=1760558938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke8jtUXlpIlqR4j9qkChpdFTIiht1S8htIX7XlQ02Ac=;
        b=Xf//uEyu8uQZnQqmmbhe9L4tcs1B0dRf2Ql2m/KuqSnj0Lt6rCA/jtwYmbAhoIqQlO
         v+pB/MNwJUanHAW5LHH02TL9xApvnUbsU2r0l5tZNMH1MhUsH6TcbYJFiPTA9N8CPYHY
         TAWqZ8I5szg2WJCI4ILPQ5XXT22JM1FNjJgz8dLuQnP2kk0T9ZGlwH+M3m1d7oa0WBhT
         FvBBQuaVW26NzS34x1WmBtVWu50mCesCDszhSp/TjIKmGhKTVHl2W28zehsv28mldwkN
         R+fih7ZFgcWFm++GOQdp5jmFm3C1D1d55rJea++YJfg6MgFiHIQ/hBUnb64IFJ2KrI+k
         d/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759954138; x=1760558938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke8jtUXlpIlqR4j9qkChpdFTIiht1S8htIX7XlQ02Ac=;
        b=Ufr0d4cV9uo8Na4Q38zKkAJDJzx2Bag/7V1ByK0IjeQNgQYgBAZDotpXTF+Pq8ZyjD
         93gYVe+vmJzSrz2dFVoCAoeHWP0jwXFHdsUtg6tkTldwnzIR8jlkTwQKMVcKwN0JPTDW
         qMliYR3kwuQnR2Sr2HKWXAKX8vCRXveglu16AJaPoFny9zQPTcuh9oO+FZB8mwMbP2z7
         Uu1qOB6jnR3uIfyn6G9eLpUGzM8SKxwen3lmhpED1P3HUqD5UtexZkvqLgvrInJUhd0X
         HXDogL290/uoBg34qRBLnx68ikBkf0CAyD2Yd8siC1QXfl4sYO3yj7su+57ObVFkFvvQ
         5W2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWluhqGvR0bzm5KdN3DOx/WM9tqpbBWw3GoCgqib15/sSTJZD+kWiaWGw7Tyk5wFxtDypKdf+eta2aPxZAe5a0bNZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6jccgOmR1soTdQyhsFSng4FNus0hf8pLH6UdYIc2eaJZxp2I
	zatPgqgHqfocPUN/u/Lenn1MKrOUpDVHdPUhxtWrEmqZFzvRB7iveAfiUoeHRM82RubJS+l0HBv
	G4Sfy/hYbXP0grZBfCrhvmfv9prKPo9Dp/akGXQbIYw==
X-Gm-Gg: ASbGncsOjP9lcbiZXC8Zr9vRt6dxN1eYqbI3Gym/jSZoqCk1lg8P2PWy/eLU4O+nXH6
	yR/QfWZ/mX+dapfitU/TzA7Nl0i1wBchithoO0gNsypB7mAnxDBIROL65iGB0hNvLyvXfXkhe3O
	hIn9deqTJDvCNp5eXj76OMgjCt2MU4IppAJGcXh/cquDgptLKmR/A/z8p09irFnXzOxqF949iMQ
	oA6xzVO40IW873jn/vSxGHgy7FjCCso/iZQg7yui1XtqudTm3YPPnQYwLHGOo52rDbR1+E8teij
	2AqkyHukgSW0cXc3Ezv8
X-Google-Smtp-Source: AGHT+IHxM5CEHHYNSHpDunt8on4GI5kZYNZcQI+vzvGqpepaQf37+nRgFrKHSbRRUcFVNv2vbrMqwU69bVrlpNAZJxg=
X-Received: by 2002:a17:907:6d1f:b0:b41:6ab2:bc69 with SMTP id
 a640c23a62f3a-b50aaa97cf5mr524364766b.22.1759954138185; Wed, 08 Oct 2025
 13:08:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev> <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
 <CAP01T75TegFO0DrZ=DvpNQBSnJqjn4HvM9OLsbJWFKJwzZeYXw@mail.gmail.com> <0adc5d8a299483004f4796a418420fe1c69f24bc.camel@gmail.com>
In-Reply-To: <0adc5d8a299483004f4796a418420fe1c69f24bc.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 8 Oct 2025 22:08:21 +0200
X-Gm-Features: AS18NWAncctoHoktrPtSR3FECwREslCFfHw_6a_y-B9KdgoWQXhdjRttcGim4Sc
Message-ID: <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com>
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault
 to BPF stderr
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Leon Hwang <hffilwlqm@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 8 Oct 2025 at 21:34, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2025-10-08 at 19:08 +0200, Kumar Kartikeya Dwivedi wrote:
> > On Wed, 8 Oct 2025 at 18:27, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Oct 8, 2025 at 7:41=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.co=
m> wrote:
> > > >
> > > >
> > > >
> > > > On 2025/10/7 14:14, Menglong Dong wrote:
> > > > > On 2025/10/2 10:03, Alexei Starovoitov wrote:
> > > > > > On Fri, Sep 26, 2025 at 11:12=E2=80=AFPM Menglong Dong <menglon=
g8.dong@gmail.com> wrote:
> > > > > > >
> > > > > > > Introduce the function bpf_prog_report_probe_violation(), whi=
ch is used
> > > > > > > to report the memory probe fault to the user by the BPF stder=
r.
> > > > > > >
> > > > > > > Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
> > > >
> > > > [...]
> > > >
> > > > > >
> > > > > > Interesting idea, but the above message is not helpful.
> > > > > > Users cannot decipher a fault_ip within a bpf prog.
> > > > > > It's just a random number.
> > > > >
> > > > > Yeah, I have noticed this too. What useful is the
> > > > > bpf_stream_dump_stack(), which will print the code
> > > > > line that trigger the fault.
> > > > >
> > > > > > But stepping back... just faults are common in tracing.
> > > > > > If we start printing them we will just fill the stream to the m=
ax,
> > > > > > but users won't know that the message is there, since no one
> > > > >
> > > > > You are right, we definitely can't output this message
> > > > > to STDERR directly. We can add an extra flag for it, as you
> > > > > said below.
> > > > >
> > > > > Or, maybe we can introduce a enum stream_type, and
> > > > > the users can subscribe what kind of messages they
> > > > > want to receive.
> > > > >
> > > > > > expects it. arena and lock errors are rare and arena faults
> > > > > > were specifically requested by folks who develop progs that use=
 arena.
> > > > > > This one is different. These faults have been around for a long=
 time
> > > > > > and I don't recall people asking for more verbosity.
> > > > > > We can add them with an extra flag specified at prog load time,
> > > > > > but even then. Doesn't feel that useful.
> > > > >
> > > > > Generally speaking, users can do invalid checking before
> > > > > they do the memory reading, such as NULL checking. And
> > > > > the pointer in function arguments that we hook is initialized
> > > > > in most case. So the fault is someting that can be prevented.
> > > > >
> > > > > I have a BPF tools which is writed for 4.X kernel and kprobe
> > > > > based BPF is used. Now I'm planing to migrate it to 6.X kernel
> > > > > and replace bpf_probe_read_kernel() with bpf_core_cast() to
> > > > > obtain better performance. Then I find that I can't check if the
> > > > > memory reading is success, which can lead to potential risk.
> > > > > So my tool will be happy to get such fault event :)
> > > > >
> > > > > Leon suggested to add a global errno for each BPF programs,
> > > > > and I haven't dig deeply on this idea yet.
> > > > >
> > > >
> > > > Yeah, as we discussed, a global errno would be a much more lightwei=
ght
> > > > approach for handling such faults.
> > > >
> > > > The idea would look like this:
> > > >
> > > > DEFINE_PER_CPU(int, bpf_errno);
> > > >
> > > > __bpf_kfunc void bpf_errno_clear(void);
> > > > __bpf_kfunc void bpf_errno_set(int errno);
> > > > __bpf_kfunc int bpf_errno_get(void);
> > > >
> > > > When a fault occurs, the kernel can simply call
> > > > 'bpf_errno_set(-EFAULT);'.
> > > >
> > > > If users want to detect whether a fault happened, they can do:
> > > >
> > > > bpf_errno_clear();
> > > > header =3D READ_ONCE(skb->network_header);
> > > > if (header =3D=3D 0 && bpf_errno_get() =3D=3D -EFAULT)
> > > >         /* handle fault */;
> > > >
> > > > This way, users can identify faults immediately and handle them gra=
cefully.
> > > >
> > > > Furthermore, these kfuncs can be inlined by the verifier, so there =
would
> > > > be no runtime function call overhead.
> > >
> > > Interesting idea, but errno as-is doesn't quite fit,
> > > since we only have 2 (or 3 ?) cases without explicit error return:
> > > probe_read_kernel above, arena read, arena write.
> > > I guess we can add may_goto to this set as well.
> > > But in all these cases we'll struggle to find an appropriate errno co=
de,
> > > so it probably should be a custom enum and not called "errno".
> >
> > Yeah, agreed that this would be useful, particularly in this case. I'm
> > wondering how we'll end up implementing this.
> > Sounds like it needs to be tied to the program's invocation, so it
> > cannot be per-cpu per-program, since they nest. Most likely should be
> > backed by run_ctx, but that is unavailable in all program types. Next
> > best thing that comes to mind is reserving some space in the stack
> > frame at a known offset in each subprog that invokes this helper, and
> > use that to signal (by finding the program's bp and writing to the
> > stack), the downside being it likely becomes yet-another arch-specific
> > thing. Any other better ideas?
>
> Another option is to lower probe_read to a BPF_PROBE_MEM instruction
> and generate a special kind of exception handler, that would set r0 to
> -EFAULT. (We don't do this already, right? Don't see anything like that
> in verifier.c or x86/../bpf_jit_comp.c).
>
> This would avoid any user-visible changes and address performance
> concern. Not so convenient for a chain of dereferences a->b->c->d,
> though.

Since we're piling on ideas, one of the other things that I think
could be useful in general (and maybe should be done orthogonally to
bpf_errno)
is making some empty nop function and making it not traceable reliably
across arches and invoke it in the bpf exception handler.
Then if we expose prog_stream_dump_stack() as a kfunc (should be
trivial), the user can write anything to stderr that is relevant to
get more information on the fault.

It is then up to the user to decide the rate of messages for such
faults etc. and get more information if needed.
