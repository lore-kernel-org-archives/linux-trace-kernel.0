Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46A79CF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710211460; cv=none; b=iAxA6bhbGHJljiJjyi0WJ3MpsBF/b6+GgDY/z3V2z32y5Ulz0mT0DbCGLWaEuYh8bcTvkqQC6xNW0u/n8ejI6q5AM8eej5KNZiXgE0ifWf5EW6F9mgwE1ou/64jxDgDmhaIr0jtWKy6g2GsiHBTRN2Qh9KnEYtlEByMFDHSbxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710211460; c=relaxed/simple;
	bh=w1TsuMUWzBMAa4sluemyX5myNv66iSIjpefpYiqw6No=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSzrFkheoI/I8RUKJbuFMVNYgD5544tf0R03sa0RsierdS46oO0/xA+2acAGLLAYJVorpE+Vq3s86ntuUTl0cFf9MBTYhZ6CYikRjuZq1hCH8Ji2BXeRVtcFt8pel2BPQkM+4eMcQ3fEg8g4lqkgVmxTXMj9YXTOyYZ6zP7wwsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RWHroVnU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RWHroVnU"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso4534096a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 Mar 2024 19:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710211458; x=1710816258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2/zqf8TfkF7fmO3ryrALVmJ2Vqgii1SZQQKBoGp30M=;
        b=RWHroVnUxNq25PSZi9Z1RDXpYssydo+icth3tlZHvUmzLWeeWJzk9/8oklJblkLmuB
         aLY8n3upiIeHo772B6JWHGk6j1AmhgZUYqqRtK11vAn0dqqCgS+i0Xea1aRj2XObWMlV
         GGtH4hmTLW6qB5m5X6qmZH7Qd+C309mkMQJtASCj6R/C9LRKIzLYTNVjir7O6A3j1AOx
         SEMM40o3rSP+SU/BynrAGdj417Vo85UMZpPC9h+l2bhxh8D1IGJ1PIo+Ia7c+AFSdRgB
         9pUnQCB+PgaiQQ9ymeXfsCRNGTtrtMfB06l2yZzNAqVhsGP0NU2vsHVz4r1qqxpYWi/4
         cWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710211458; x=1710816258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2/zqf8TfkF7fmO3ryrALVmJ2Vqgii1SZQQKBoGp30M=;
        b=vi/n1al+Y4U1ipWCdHBtxhMYLmiW0pl4AGTJS1FrO/RrQOozrlQJPPpR3yZ+nm9q+j
         Wy/mIXTjTXFSNqthLgALpRfJe3Oe1r1n3l9RSW921L71PPlxYisC/9MhzwUGxxw4yT3X
         cd9BtIlph+NyD0sSyurb0vIuAVezmAEFqTjkQX9qImdxSJl7VYt9xzO/xMvbVU2uYLSk
         CT+Jjy6vP3aLEsRU9fIbCXD7hz+SGBFeh8S6c69EClJJxgzuZ7yNirjjv4mpTkUGa/lp
         aM5cdZ1wYJPxrkNwDr5zMVK4jc7TBw0LljAbknfk+FByzgFPXb9JXULeSP//bWETU5kC
         sqKw==
X-Forwarded-Encrypted: i=1; AJvYcCV5i61mVBLQauAe7vcAQ0Yj8GR2OEVHz+6fzwbbxhk7lalHEKb+MZ84yTiyOmVnKs+sLH7WD6redb/5+PtsUHqcRxFXD2DQIxS/08cpGZYZaYG/
X-Gm-Message-State: AOJu0YzGgVsEoQjL9tKsq8D8lSOB2hs0qg+M5RJ/oStk8s2p6gsZ38Oi
	vuwr2CPiK+sO/ULwgdueXK8yA4TJICtMpNNIfFo8RGaVxWGMtqs02pkrNJsSY5EcajojtnbAdw+
	QJtw5b2lrFQCloOHlGDxKI7jG1flpUy/T0x7kuQ==
X-Google-Smtp-Source: AGHT+IGvIums+DTS3WHK+W5NCGfLkPUVfEDar4QbCGrncl6WQdDDS8a1T8ll9cvRYezwajGoT7cszDUrP5tYmNtBalM=
X-Received: by 2002:a17:90b:3ec9:b0:29c:4082:2d0b with SMTP id
 rm9-20020a17090b3ec900b0029c40822d0bmr49744pjb.28.1710211457742; Mon, 11 Mar
 2024 19:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-9-dongmenglong.8@bytedance.com> <CAADnVQK+s3XgSYhpSdh7_9Qhq4DimmSO-D9d5+EsSZQMX4TxxA@mail.gmail.com>
In-Reply-To: <CAADnVQK+s3XgSYhpSdh7_9Qhq4DimmSO-D9d5+EsSZQMX4TxxA@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 10:44:06 +0800
Message-ID: <CALz3k9hZxsbUGoe5JoWpMEV0URykRwiKWLKZNj4nhvnXg3V=Zg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 8/9] libbpf: add support for
 the multi-link of tracing
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 2:35=E2=80=AFAM Menglong Dong
> <dongmenglong.8@bytedance.com> wrote:
> >
> >
> > -               err =3D libbpf_find_attach_btf_id(prog, attach_name, &b=
tf_obj_fd, &btf_type_id);
> > +               name_end =3D strchr(attach_name, ',');
> > +               /* for multi-link tracing, use the first target symbol =
during
> > +                * loading.
> > +                */
> > +               if ((def & SEC_ATTACH_BTF_MULTI) && name_end) {
> > +                       int len =3D name_end - attach_name + 1;
> > +                       char *first_tgt;
> > +
> > +                       first_tgt =3D malloc(len);
> > +                       if (!first_tgt)
> > +                               return -ENOMEM;
> > +                       strncpy(first_tgt, attach_name, len);
> > +                       first_tgt[len - 1] =3D '\0';
> > +                       err =3D libbpf_find_attach_btf_id(prog, first_t=
gt, &btf_obj_fd,
> > +                                                       &btf_type_id);
> > +                       free(first_tgt);
> > +               } else {
> > +                       err =3D libbpf_find_attach_btf_id(prog, attach_=
name, &btf_obj_fd,
> > +                                                       &btf_type_id);
> > +               }
>
> Pls use glob_match the way [ku]probe multi are doing
> instead of exact match.

Hello,

I'm a little suspecting the effect of glob_match. I seldom found
the use case that the kernel functions which we want to trace
have the same naming pattern. And the exact match seems more
useful.

Can we use both exact and glob match here?

Thanks!
Menglong Dong
