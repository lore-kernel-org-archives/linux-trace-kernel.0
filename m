Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C3F257AC2
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759952052; cv=none; b=Y6nnIPIh8NUz9fv+uOZXeh3aNal6v1L7iU5oljiEAHDgFAt4s5Bydg0q20qLG6QJ1znOaCUK8g5JE1zbOT1GK2JG21NNwXnbwJlu+EZzAWL/1D/I5VaiYraUGGO06GgDH+MSx26mKQAdQjzA6qpOyW63dag6WRebAfmi3i6JkEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759952052; c=relaxed/simple;
	bh=b0hZbloqVuXRwfWVW9YjmR3ScQKKb3XKa8zno4WIYFE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eVqM4KMi2HggQB0mD4YJerbkRFp/rYywg5AKuzMXVnQWgqdKH5CcdMOF3C57BBpGN1XRepIfmMVFML3c/L89fKCd3M6vFbYOKI1bHjzmhyMzthumk/dqvCWp0e29GxXRW2AQahaMwhCrlPt0htEhjLCb0LEdWvAvNg22+2f3uYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWSM9GM7; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWSM9GM7"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-794e300e20dso210017b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759952050; x=1760556850; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UYZQTVTtG+XbI2IH88OfJMmnXJlJbNQSlkapCgOrKq0=;
        b=IWSM9GM7Jd+CCvpP30FBm22P0OPO84g0q+s/wpsJN4iui+xsrxc5IqheMEshmHIDGT
         9k/9ernDdISl87gzBCdcZ0c+2hyi4wE6vHsphmEzS2z94IoIHpDKGeRpMmCd2RBPNcBc
         5CC54USGCVYp2sXuU034fZxHdGXOp+u4uNxnQ8KTbSNUY8aAMaUanQGXf+CLDrZfLhoI
         I9xhIcTI7tOhg4w57PzslmBJhH8MQG3aPX+45BVnmvB7ZOGWl927HK26Qm7+ldNwhSyx
         6T765VeNWjqXNpF2QT/OPOYwmM2KtWzztGQK5iMfl2whoBay0+bc1bOFImCRBGfkKDv3
         MpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759952050; x=1760556850;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYZQTVTtG+XbI2IH88OfJMmnXJlJbNQSlkapCgOrKq0=;
        b=AkEZhfEzgulpzMGuf3Qk88Lnzjpj2L3+Ll8Jw9sGjWlPubXvi2ODxTjEeaCAKqAhks
         rX8rXJ9BRR+zn3LNEplBQ8n4HZOXdSHjVYIqr1RxS33dcDXUDDcoaltmcMHjcFKnEkcg
         kGhnPzSVByoTi/R1dHnWVwYVBoKPpIGhCvXyOm2iwXiaz0DeQkHsVR2ivxpPq+SLpigA
         Ot9uQ6nfGNzehTw48NSbKnIc/roEhqXHGsPI2mOSZDmaIMtITFbxeOhx0oTNbROmth8Q
         21Cj3xgU/UAAe3/bA0ZWIRgVdVZ5/ZibxCK9rqujdWaojCExMdwh6L0rUGxeEbxd8cbz
         Gydw==
X-Forwarded-Encrypted: i=1; AJvYcCX+2sw7lWNFdorN/DtV7VDHtSUrA9PlK3+at0gI605MzJf1mXQ5lespYWHBnVV2hPfS0OVHnqWKzmZdi913uwxIfYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuGOnEhfEdOb8ZGI7TlvoXFZjlqa0Aa8XMGa9EZkXZZdVKchaF
	TwmoBGhiqaC3//vR3vOMuh2TMZiiaE8UGh8WwWWfxhl6TfqV262p/59U
X-Gm-Gg: ASbGnctM90mnCaIF7RQ4ucMZw3Sw8ie2rNYg9tJR1+65oYUMR3ALy/B50b47NJ7stfn
	kFpjI41860yyuS3nqhMzKJTAOsBLByvHzstAa/2a0KjS9EF8xJHe2tnM56nqLfn9uFlmtbCRG24
	yJQa90KpL7IHK57XFQ+A22kGtqFqEa3OHlQ5+KqD/4e3vSL0WkqmqURZ17GHoyLQevEq5X2hxZ6
	HJd9Aij4DFVU7SsdY06gjY8gQ5z6MXhUPO277GB+Amx5uVHcteFSPVug16KJmwXiGKJsQmzVNIk
	C8X+N+WMYLbl2KG4Sgf7b5/ZRPFMZFsQwL4VMF5jtDPKCZlPYrYk5fwpTz1gC1BLMBN5lbEnaHy
	N2KqN4SRXOlfvEySJD38geaJi4fQqMyiP1Pg+C2/7cyxuqiTZN7RGtBSguTbOcTlWmCLJ5/ta
X-Google-Smtp-Source: AGHT+IHJf+5k8iJ4XosU7eb7WGP/HcTVy1AOQbqUDOB+2QpTWkXvAgtG0nXZDZ3QkIuGgRGCUnh30A==
X-Received: by 2002:a17:902:f70b:b0:267:8049:7c87 with SMTP id d9443c01a7336-29027f0ceffmr51015335ad.14.1759952050132;
        Wed, 08 Oct 2025 12:34:10 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:f51f:bb9e:9f33:c390? ([2620:10d:c090:500::7:e1e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f35e6dsm5058405ad.86.2025.10.08.12.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 12:34:09 -0700 (PDT)
Message-ID: <0adc5d8a299483004f4796a418420fe1c69f24bc.camel@gmail.com>
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe
 fault to BPF stderr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
 Menglong Dong <menglong.dong@linux.dev>, Menglong Dong
 <menglong8.dong@gmail.com>, Alexei Starovoitov	 <ast@kernel.org>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
 jiang.biao@linux.dev
Date: Wed, 08 Oct 2025 12:34:08 -0700
In-Reply-To: <CAP01T75TegFO0DrZ=DvpNQBSnJqjn4HvM9OLsbJWFKJwzZeYXw@mail.gmail.com>
References: <20250927061210.194502-1-menglong.dong@linux.dev>
	 <20250927061210.194502-2-menglong.dong@linux.dev>
	 <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
	 <3571660.QJadu78ljV@7950hx>
	 <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
	 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
	 <CAP01T75TegFO0DrZ=DvpNQBSnJqjn4HvM9OLsbJWFKJwzZeYXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 19:08 +0200, Kumar Kartikeya Dwivedi wrote:
> On Wed, 8 Oct 2025 at 18:27, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >=20
> > On Wed, Oct 8, 2025 at 7:41=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com>=
 wrote:
> > >=20
> > >=20
> > >=20
> > > On 2025/10/7 14:14, Menglong Dong wrote:
> > > > On 2025/10/2 10:03, Alexei Starovoitov wrote:
> > > > > On Fri, Sep 26, 2025 at 11:12=E2=80=AFPM Menglong Dong <menglong8=
.dong@gmail.com> wrote:
> > > > > >=20
> > > > > > Introduce the function bpf_prog_report_probe_violation(), which=
 is used
> > > > > > to report the memory probe fault to the user by the BPF stderr.
> > > > > >=20
> > > > > > Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
> > >=20
> > > [...]
> > >=20
> > > > >=20
> > > > > Interesting idea, but the above message is not helpful.
> > > > > Users cannot decipher a fault_ip within a bpf prog.
> > > > > It's just a random number.
> > > >=20
> > > > Yeah, I have noticed this too. What useful is the
> > > > bpf_stream_dump_stack(), which will print the code
> > > > line that trigger the fault.
> > > >=20
> > > > > But stepping back... just faults are common in tracing.
> > > > > If we start printing them we will just fill the stream to the max=
,
> > > > > but users won't know that the message is there, since no one
> > > >=20
> > > > You are right, we definitely can't output this message
> > > > to STDERR directly. We can add an extra flag for it, as you
> > > > said below.
> > > >=20
> > > > Or, maybe we can introduce a enum stream_type, and
> > > > the users can subscribe what kind of messages they
> > > > want to receive.
> > > >=20
> > > > > expects it. arena and lock errors are rare and arena faults
> > > > > were specifically requested by folks who develop progs that use a=
rena.
> > > > > This one is different. These faults have been around for a long t=
ime
> > > > > and I don't recall people asking for more verbosity.
> > > > > We can add them with an extra flag specified at prog load time,
> > > > > but even then. Doesn't feel that useful.
> > > >=20
> > > > Generally speaking, users can do invalid checking before
> > > > they do the memory reading, such as NULL checking. And
> > > > the pointer in function arguments that we hook is initialized
> > > > in most case. So the fault is someting that can be prevented.
> > > >=20
> > > > I have a BPF tools which is writed for 4.X kernel and kprobe
> > > > based BPF is used. Now I'm planing to migrate it to 6.X kernel
> > > > and replace bpf_probe_read_kernel() with bpf_core_cast() to
> > > > obtain better performance. Then I find that I can't check if the
> > > > memory reading is success, which can lead to potential risk.
> > > > So my tool will be happy to get such fault event :)
> > > >=20
> > > > Leon suggested to add a global errno for each BPF programs,
> > > > and I haven't dig deeply on this idea yet.
> > > >=20
> > >=20
> > > Yeah, as we discussed, a global errno would be a much more lightweigh=
t
> > > approach for handling such faults.
> > >=20
> > > The idea would look like this:
> > >=20
> > > DEFINE_PER_CPU(int, bpf_errno);
> > >=20
> > > __bpf_kfunc void bpf_errno_clear(void);
> > > __bpf_kfunc void bpf_errno_set(int errno);
> > > __bpf_kfunc int bpf_errno_get(void);
> > >=20
> > > When a fault occurs, the kernel can simply call
> > > 'bpf_errno_set(-EFAULT);'.
> > >=20
> > > If users want to detect whether a fault happened, they can do:
> > >=20
> > > bpf_errno_clear();
> > > header =3D READ_ONCE(skb->network_header);
> > > if (header =3D=3D 0 && bpf_errno_get() =3D=3D -EFAULT)
> > >         /* handle fault */;
> > >=20
> > > This way, users can identify faults immediately and handle them grace=
fully.
> > >=20
> > > Furthermore, these kfuncs can be inlined by the verifier, so there wo=
uld
> > > be no runtime function call overhead.
> >=20
> > Interesting idea, but errno as-is doesn't quite fit,
> > since we only have 2 (or 3 ?) cases without explicit error return:
> > probe_read_kernel above, arena read, arena write.
> > I guess we can add may_goto to this set as well.
> > But in all these cases we'll struggle to find an appropriate errno code=
,
> > so it probably should be a custom enum and not called "errno".
>=20
> Yeah, agreed that this would be useful, particularly in this case. I'm
> wondering how we'll end up implementing this.
> Sounds like it needs to be tied to the program's invocation, so it
> cannot be per-cpu per-program, since they nest. Most likely should be
> backed by run_ctx, but that is unavailable in all program types. Next
> best thing that comes to mind is reserving some space in the stack
> frame at a known offset in each subprog that invokes this helper, and
> use that to signal (by finding the program's bp and writing to the
> stack), the downside being it likely becomes yet-another arch-specific
> thing. Any other better ideas?

Another option is to lower probe_read to a BPF_PROBE_MEM instruction
and generate a special kind of exception handler, that would set r0 to
-EFAULT. (We don't do this already, right? Don't see anything like that
in verifier.c or x86/../bpf_jit_comp.c).

This would avoid any user-visible changes and address performance
concern. Not so convenient for a chain of dereferences a->b->c->d,
though.
