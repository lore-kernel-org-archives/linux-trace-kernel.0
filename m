Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C25264F96
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940841; cv=none; b=l86mpTOBb1gPKaLpxCrY6QYT6dnjF0ZyWxd0WAysW1LiswLBoJqj/inQFUrYVODzZ9kC+gY2Ifh8k21XjmTcP/GpypbIR2CO9U+QLxewzBQm6us0FAq5vzUVYevfs4ZE5BMGIWi6qDhkdYk4PPbuHA4lrqvV5KYc3rp6eLmt+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940841; c=relaxed/simple;
	bh=ESYUvIrXIZf8LOINPbGCLLFX0IwDLy3Yro+8H8/WXj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOQOQOWqnP4OldRkaaYb/B6K/ZE9Ic8JV5Wk9u/F5++RylhesbDLGspT43ok0jMIl8yg5qvogsvbRRgf5jqGJF3eWZsgX726lHtrInrpXnwGYcVLIcsuuzj0bq9V4yihGVO/dD+GJyRs1O5Zhk5jHwPyI0LFbqDJHaay1bq8z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktKijQ2Z; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktKijQ2Z"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso90836f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759940838; x=1760545638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMmT0yBvVqJ1w9268h9UX0+UvY7Ypnz5qKgFPlEn+l4=;
        b=ktKijQ2Zz61w+9Nb65gDjpEk7FqIES4Vs7UEtdWcb1yuqrDQmiGLWaU++F5+xO3mL6
         9w8OgLBWH63jLJdGb6AAVn81KE9aExlZ/Z+mU34bAVfb1FpMym95A1KD5msOPDtkya1I
         12//hGl9Xx+eOWhTH7MFL4q+xwtFkijLLzCigSTnYKgztpYfo9xhc04WpfQJLArGLXtv
         Wvl80hcH9mAE4e85d05k2yvtG2/Gq4y+XRFKSP5ktgBy1z3n22QfeND6khI3IezBkZ4N
         TIwvOWXazNv4zqXu1lB/ZpOVUvBItlAvMP6dmQxGaWhYIIeNPiiyN7pHQYwV6iY8d0br
         dHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940838; x=1760545638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMmT0yBvVqJ1w9268h9UX0+UvY7Ypnz5qKgFPlEn+l4=;
        b=bBWzVxFSZO481dwqF8lkb+ARAbafXhGYDzAjaP/SrYKSgNEXV0eFmF9wlqnxVcOZzN
         94pPNoW+u4RFWteJKdPKTUUbDyAPSeZPpP7hO0F8TSEiVc+isaPGzFQkQiR15AlSVwv2
         yntIxnazbzw1SCuVGqEopXswVUWCJjjusxteEP66FgKai+ggzPKOQnQAL0n6LPLYj+Bg
         9tN83jqhB7VnQRFzhDqP7rAmjpgh9o/fmNB8TOecVFi8g9mMdF+JAAOD8Kd7fRK7Ovn2
         KQh5lyggvUVTJlR3squCCkQf4c/Updo6t1VdhwmgX5BomN3ksZwPeq4vcUj1p7Z9QLRV
         YDBg==
X-Forwarded-Encrypted: i=1; AJvYcCWKDVlpPpYMaHf5kz6Z5Sq2t8A4sS//Yhsf8B1eXqJsCdhNnp1Y2JJCuMdnvEQJq9HYFYaa4c1tKuhaR1L4HBTQwkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ7JNYtxXs8hv+svd0ASHQaQH5l6DWpv/x6dDCVxjL1j48Lsha
	crD/h8buL7I2N1i9LBoDG++0c+EwJDW9S07zof7pT84P1hfTGYYfobhGQdxQ+nre3UKtaOUpb8a
	XZKlW/yrtc2CROzDzRGbJKuiUXgKNec8=
X-Gm-Gg: ASbGncsXBVYZrIQMHVTOrDNatg5g47PE9TwSzeodjJI0gpjmGAaCMHvOsh7AWLGdHtm
	LzTIKz9GkzViZAn0n5KFwuOYxCwCM0nWQh/f9SZWnF0Pr9Mi4tN+CAl72nMRLZ0ecbEqx98yqqd
	1TaGFt8eQVNwOUjlP5tbKY66SxI8wa058TevZQfzeFn7b/OPvedNe+7xXmiT1fx/GVORL9GsKUb
	0DgOAkksU9Uh5pkMrf49FuTukA1wQxKNveiJC1dV41FY04jpdfZ5ZP3rQ==
X-Google-Smtp-Source: AGHT+IGydoa+Uq4878Yb/9h/myuPsA/hLU+ClnU6wU58PGmdNNA/S+SuciJyS4EWhUfyI1GnU9R2Dc7R6qET/aovPX4=
X-Received: by 2002:a05:6000:1449:b0:425:8559:5d17 with SMTP id
 ffacd0b85a97d-4266e7dfebfmr2645912f8f.30.1759940837904; Wed, 08 Oct 2025
 09:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev> <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
In-Reply-To: <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Oct 2025 09:27:04 -0700
X-Gm-Features: AS18NWBNt40LsuCSwzLCuqapaMgwYyUIMoVcfLF6Ag31yVFMBDU-uVz2cE-RisI
Message-ID: <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
Subject: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault to
 BPF stderr
To: Leon Hwang <hffilwlqm@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong <menglong8.dong@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 7:41=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
>
>
> On 2025/10/7 14:14, Menglong Dong wrote:
> > On 2025/10/2 10:03, Alexei Starovoitov wrote:
> >> On Fri, Sep 26, 2025 at 11:12=E2=80=AFPM Menglong Dong <menglong8.dong=
@gmail.com> wrote:
> >>>
> >>> Introduce the function bpf_prog_report_probe_violation(), which is us=
ed
> >>> to report the memory probe fault to the user by the BPF stderr.
> >>>
> >>> Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
>
> [...]
>
> >>
> >> Interesting idea, but the above message is not helpful.
> >> Users cannot decipher a fault_ip within a bpf prog.
> >> It's just a random number.
> >
> > Yeah, I have noticed this too. What useful is the
> > bpf_stream_dump_stack(), which will print the code
> > line that trigger the fault.
> >
> >> But stepping back... just faults are common in tracing.
> >> If we start printing them we will just fill the stream to the max,
> >> but users won't know that the message is there, since no one
> >
> > You are right, we definitely can't output this message
> > to STDERR directly. We can add an extra flag for it, as you
> > said below.
> >
> > Or, maybe we can introduce a enum stream_type, and
> > the users can subscribe what kind of messages they
> > want to receive.
> >
> >> expects it. arena and lock errors are rare and arena faults
> >> were specifically requested by folks who develop progs that use arena.
> >> This one is different. These faults have been around for a long time
> >> and I don't recall people asking for more verbosity.
> >> We can add them with an extra flag specified at prog load time,
> >> but even then. Doesn't feel that useful.
> >
> > Generally speaking, users can do invalid checking before
> > they do the memory reading, such as NULL checking. And
> > the pointer in function arguments that we hook is initialized
> > in most case. So the fault is someting that can be prevented.
> >
> > I have a BPF tools which is writed for 4.X kernel and kprobe
> > based BPF is used. Now I'm planing to migrate it to 6.X kernel
> > and replace bpf_probe_read_kernel() with bpf_core_cast() to
> > obtain better performance. Then I find that I can't check if the
> > memory reading is success, which can lead to potential risk.
> > So my tool will be happy to get such fault event :)
> >
> > Leon suggested to add a global errno for each BPF programs,
> > and I haven't dig deeply on this idea yet.
> >
>
> Yeah, as we discussed, a global errno would be a much more lightweight
> approach for handling such faults.
>
> The idea would look like this:
>
> DEFINE_PER_CPU(int, bpf_errno);
>
> __bpf_kfunc void bpf_errno_clear(void);
> __bpf_kfunc void bpf_errno_set(int errno);
> __bpf_kfunc int bpf_errno_get(void);
>
> When a fault occurs, the kernel can simply call
> 'bpf_errno_set(-EFAULT);'.
>
> If users want to detect whether a fault happened, they can do:
>
> bpf_errno_clear();
> header =3D READ_ONCE(skb->network_header);
> if (header =3D=3D 0 && bpf_errno_get() =3D=3D -EFAULT)
>         /* handle fault */;
>
> This way, users can identify faults immediately and handle them gracefull=
y.
>
> Furthermore, these kfuncs can be inlined by the verifier, so there would
> be no runtime function call overhead.

Interesting idea, but errno as-is doesn't quite fit,
since we only have 2 (or 3 ?) cases without explicit error return:
probe_read_kernel above, arena read, arena write.
I guess we can add may_goto to this set as well.
But in all these cases we'll struggle to find an appropriate errno code,
so it probably should be a custom enum and not called "errno".
