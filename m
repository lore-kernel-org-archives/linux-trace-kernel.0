Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF5392C5B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283284; cv=pass; b=enn6LBZ/zp1kTo4hNAgTR9T8cGJYLzkFMnGcrdb1mR0o+rciAoZgQC6kSipji3d89T/x8ZAPnfOeAgn+BOWA6leUrldUfVow3WV6xdxkVuvf5gt2fFkevLllW5iqZZqp1kstSv24i+SArKVEikRf2FUTYTa4eMiEDR1mBfsPKWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283284; c=relaxed/simple;
	bh=H9TJNHkisUEr4z39rBi90p8f80JBCtp4uFnDx2T9EUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOQhlCu+TaKVQVn8iR/XJXgtJwTe7EnAopB5QTCSxvEFgZ4zDJKqLehJfg2s/XtIyGWxANwgHDhvDxNuaKY7v2Mt3VZ3liuPjYyy0oQHMzHXZiVdoxMjuY9P+27uPOmHwDOXL8nQI6JSDUQ6Jn5o88qljV5JSytr5cmrBvY/6kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLFi+UPk; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLFi+UPk"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b885e8c6727so166656766b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 01:21:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770283282; cv=none;
        d=google.com; s=arc-20240605;
        b=hLQos74dMXWQESkb/lOm9UEmSU2Rmp7Y95yfnDdGkh6khfEcxE5nYMP+udv0iir4am
         9spInq1/xDADvAPoFx5/aij2ioR8zYw9kOD9d/QBYU/qqXyh8gKGQsDthYUFFJPU5A3p
         qFJaA8Nqh7IqArNbNuD5f50o/+pWpJF9bXfqK76+qG+Ae/ILB1JAuo8caFulM3CLlrdc
         RylmZzH/i4sP3N4uq7Th2nE7lVGbbDVbHPJzi5gm2PzbMgDU87L+WIO9w6k/i5/crKl+
         TQGV3F1RhyrvPB0e1RKFqxd3bTM1dGNQGGOHG6EwA4w6MVcpPskT9e4bNznsT07x/513
         tnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IalgGCN2Gqp+8rAz+6lD8MM8rro1ne0RtIUJXyB5u2c=;
        fh=2GfWII+2/GW77I5YqiKHR+W3AGh0v5ZHUhnYlhNy75U=;
        b=WXIHZm4/+pec0T3QqxDqLR4iDNGgvmaPbMhxXrMqOfWB6olGUdoEARArDQWLUBhPki
         f5KIOi+2hxqHxJJ0tRHOBxYY2DO7gp2xIbmucBGRVJxzt7JnUYQ2nJfu8vOfqS0GHrHs
         bJah7lOC9wjH22+RfA3YXS0yNIZRfOqAlMcmSngZlXfkn+yyvmmfThZOBOQyQsTdEi80
         b857nC/ypx5YvsiWPKTqLuVBKySYiTwH2HrQS4qC2r8BSAbNw2GLY7VxpAW9GFNZZFcP
         ykc6685CdssfW2dWXViYzKt8XSwnMyqv/TqtNpYOBPrPWf+DYULUvOBsMqJoYarX4GHl
         IvkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770283282; x=1770888082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IalgGCN2Gqp+8rAz+6lD8MM8rro1ne0RtIUJXyB5u2c=;
        b=aLFi+UPkU/J1L8MI4XywYY6RUA673hLsPtAsH7MkE6SIEIMe2fMjl2oTdhb0SyNEh/
         TPI+KGVRxKBHeU7isX9hSVdCXOds5aV+MkOJ4zfSl2E1Nxi1riy9Bg6eANse7IIQMxx9
         3M6/OpXHy8erDw3isR4Tp18f5FI1fR06teutGpuQGmXQyojcU93udewR0XVh2/eiRP2H
         odvMUONSBcbbjH4q/3dsMOWUPQ4ZQE2cbROjms0F9isuFSoe0CxUC+jrVdH0LMkhvUpK
         P6tCXmj+SrTc10OnUNPoFYjPql4y/3fPJl5aL0+62G9HycwRMbSSWhbJUm6UbYVsl4xm
         z+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770283282; x=1770888082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IalgGCN2Gqp+8rAz+6lD8MM8rro1ne0RtIUJXyB5u2c=;
        b=bjBMYVLBww+d/NRmnBGhA4DThQxAbJG4g694Tw7dyMy0TvSDiFApRshJUXLGDR7eR3
         aSq+SD+Zg68v9LCV35WwAxemXUo+Axb3upbG6ULThwfUtHWruwJ+zMJlst1UY5wA6zFe
         z1Bs/p99XO02pN/qxNFdsjFRwPbJviALt/NplQ6KfIVi3auHYmn+i4+XFep5pj096iLP
         Dp2cbotKQp/5MWyHGLt2Yb7qCk5ngq9dyDdI8c+m0SBO/0PWveljNnogc/oC5LLHUEw9
         a+ORw5KOKUdnVjGPfFlOYcfTU6TPox7hRe/tz7UVq1zgcOdlv+DGZoJIQqeVkICcTm5C
         2aFw==
X-Forwarded-Encrypted: i=1; AJvYcCWTR+xSaMZvJllPmCYoIZ5UE/IL67PxcQu4VDgl+UOxo1vR+oyl7mhrnSwC66flw41YHn3VHXI9OHdHfUDoXp0jzsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxedYWSCdz56EuLLGCV77YnXE7PAemxpksCvAusuvAmMogtNWvC
	Rbv4Ozslpn8HCG/gHFvgw23F9QOqTPRxp+duRBMEecDa4R7ZazjA2VRzXKz77GcfIQOvFcFwHbZ
	//gs3KzszDDFUQiz7fuKDGUS/UYA/SGo=
X-Gm-Gg: AZuq6aLspTEHlZ81z2I4ivj93x/5/0mdhqmJmrVeq2ub9hL5RfTCd7KJxtk98MPO+n6
	dMz1cShzDpOz6OHKDQWrYLfm+ejMQnYyj6qzaW2GQT+GAWWWFfNiCPzE9XFV/VhxnO0BDJwVrAe
	PETD9e6m4kPMqrYTW9mfuiIcL6OJITW5wlQip5Si689NUuTCllpDRMH7u/rg+LEo32hUdJ7/pSu
	8IEIROZ3PSf3uIYrRSgVaQ3tAj+UURD5imSAZeCiaB99T/wv5efh/31QR9z93iZjeUg2cqK
X-Received: by 2002:a17:907:94c2:b0:b88:3877:d922 with SMTP id
 a640c23a62f3a-b8ebaebf0b0mr159376266b.10.1770283281676; Thu, 05 Feb 2026
 01:21:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com>
 <20260203101707.52965eb0@gandalf.local.home> <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
 <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
In-Reply-To: <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 5 Feb 2026 17:21:09 +0800
X-Gm-Features: AZwV_QgyCP5qHv6wmrjDl43TBmC7uiqpMqCxslLuXWGhiI-yrqFKJcJ-V81-X70
Message-ID: <CAErzpmvtJwB7nTD5EFHP9SxPxH-rc3NuJp5xLGSTB7YPbUX8YA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 10:52=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > On Tue, 3 Feb 2026 21:50:47 +0800
> > > Donglin Peng <dolinux.peng@gmail.com> wrote:
> > >
> > > > Testing revealed that sorting within resolve_btfids introduces issu=
es with
> > > > btf__dedup. Therefore, I plan to move the sorting logic directly in=
to
> > > > btf__add_enum_value and btf__add_enum64_value in libbpf, which are
> > > > invoked by pahole. However, it means that we need a newer pahole
> > > > version.
> > >
> > > Sorting isn't a requirement just something I wanted to bring up. If i=
t's
> > > too complex and doesn't achieve much benefit then let's not do it.
> > >
> > > My worry is because "cat trace" takes quite a long time just reading =
the
> > > BTF arguments. I'm worried it will just get worse with enums as well.
> > >
> > > I have trace-cmd reading BTF now (just haven't officially released it=
) and
> > > doing an extract and reading the trace.dat file is much faster than r=
eading
> > > the trace file with arguments. I'll need to implement the enum logic =
too in
> > > libtraceevent.
> >
> > If you mean to do pretty printing of the trace in user space then +1 fr=
om me.
> >
> > I don't like sorting enums either in resolve_btfid, pahole or kernel.
> > Sorted BTF by name was ok, since it doesn't change original semantics.
> > While sorting enums by value gets us to the grey zone where
> > the sequence of enum names in vmlinux.h becomes different than in dwarf=
.
>
> Thanks, I agreed.
>
> >
> > Also id->name mapping in general is not precise.
> > There is no requirement for enums to be unique.
> > Just grabbing the first one:
> > ATA_PIO0 =3D 1,
> > ATA_PIO1 =3D 3,
> > ATA_PIO2 =3D 7,
> > ATA_UDMA0 =3D 1,
> > ATA_UDMA1 =3D 3,
> > ATA_UDMA2 =3D 7,
> > ATA_ID_CYLS =3D 1,
> > ATA_ID_HEADS =3D 3,
> > SCR_ERROR =3D 1,
> > SCR_CONTROL =3D 2,
> > SCR_ACTIVE =3D 3,
> >
> > All these names are part of the same enum type.
> > Which one to print? First one?

Another option is to print all matching entries, incurring increased
overhead and extended trace log length. However, I prefer printing
the first matching entry, though it might be inaccurate in rare cases.

>
> I think these cases are not very common and printing the first
> one would be helpful enough, and we can add documentation
> notes in ftrace to guide users.
>
> >
> > another example:
> > enum {
> >         BPF_LOCAL_STORAGE_GET_F_CREATE =3D 1,
> >         BPF_SK_STORAGE_GET_F_CREATE =3D 1,
> > };
> >
> > and another:
> > enum {
> >         BPF_SKB_TSTAMP_UNSPEC =3D 0,
> >         BPF_SKB_TSTAMP_DELIVERY_MONO =3D 1,
> >         BPF_SKB_CLOCK_REALTIME =3D 0,
> >         BPF_SKB_CLOCK_MONOTONIC =3D 1,
> >         BPF_SKB_CLOCK_TAI =3D 2,
> > };
> >
> > I'd rather not print any and keep it integer only.
> >
> > pw-bot: cr
