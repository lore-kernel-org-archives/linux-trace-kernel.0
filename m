Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17865248886
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Feb 2026 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393907; cv=pass; b=uoRt1cASVT6zYtUdlLseXa8KW1+ewJkpItGY5l6cqS5JXE5gTyBqMbsl80DlFy3UOo5AhdWDYo/mAjUsYizfnuyZ/mqLieH+zXpr+E4njrv3Jz+yiuuYgwi3tX2pPj2yzryvcJoBhzhg7DfCf41Scza88faR9IE+dgl/yCmFoLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393907; c=relaxed/simple;
	bh=8AUOgLGnMMIEfqB+Rfe3dTR9LWMxVZqOBCh7oFBO4Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gbOOMlrOG0HfBrFIkoPHP9jQJx8GvJlmdjWBBQWf8rjVNSMARjvhkop0S2I8Jm2T4FDF9NvFU61QZ0CagH6krozps9kslc4ADN8Pn3W/glgFfZ5dlCR5BGdcOmbMQmwsioWBvs/ACP69lTWAzDB55ywljxKYVrWAc8jHomGjHKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUQz7tUu; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUQz7tUu"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so23512535e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Feb 2026 08:05:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770393905; cv=none;
        d=google.com; s=arc-20240605;
        b=aAbKAHx4lL6Y9ehLl+SjbBVeApqX4UF/8xT97z1lkQ6WmR/bCz7j249jbdRafXyQwt
         CLrzM/e+zpjtmNIEjE8T20lhVwpZcFrq9b3w4eY33zevy7kmE2ZXeDC7XY90+otT/oOg
         rxXwkIT+qz15qSnQ2jGvfNCw4ZpyOhOv8xK90DywtlDCUcUTOBrqDjgmPGtxGc/qDCG4
         +uhDMwlAozAUd0OQqCx/HlWiOjdz5acmKmQjPZ2nk4UFKeBl7ZP1W7sukplsowAcNbEW
         GoRund6u3NAq6LJhEvtCktUKEijZg+Q9H554vPhAQT9WYFt+bjrlDVQNgsxk6xmUISAb
         WXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8AUOgLGnMMIEfqB+Rfe3dTR9LWMxVZqOBCh7oFBO4Zo=;
        fh=eljcSJOF5KnAoNLT9Dw8aCWTyfxZkk5k4mLxI1+sEsU=;
        b=NkT7l0eYUYHSACxydv7cxX6F81tuupiEVfwG9Dxm3Has+Tgox7gYkt5Xrfj5cukI09
         ZXfdB0ce/zGOMjMIuUK0AH3lbh3bo0pYXT9r5d1C1fGKbTQUcI6e4rXHb1lUjT0hvF18
         e0pQeSwPWr5NGiCauKf48OaQzK9Koq2ZreleF827ipX531zjocJpVxd4echV0n2MxAWd
         clKFi59LzozBKD1+LvPsPXTO+DcBxPx9nv1Pg1+rGPoWEg7CQMrSd5XUdqkqpJIJbG+n
         VAMNrl5kxNJjxVn1PAm0Jlt3EaQxIUa5diNb1qUrwNtYjTA+gV1une/R1QghPf6hlLMf
         bl3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770393905; x=1770998705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AUOgLGnMMIEfqB+Rfe3dTR9LWMxVZqOBCh7oFBO4Zo=;
        b=WUQz7tUuC3BzUZBSiSNXzjiHf/QhZoz70WSbC5QNKjNRYgjUVkM79P/DjYKSwJqt9O
         QO5peGz+feW0mIKTE/lP0jThvvr4exeIe/SZBQMcAImWnB+KK9QBy54DJ1OxH6hGNgu6
         mPhsa8oxNd1c3eVs8x7Ewul7ph1rmVJypOwtLPaTtdZaFW1GNXJTGqCknj9wt8+9bVIB
         RHeIZP1axnHN87yM8bjz7GuswLbjHHV/bm6xz/Q0NPglbwyDMi87Z/vRvHYbYqC9tvo/
         +AJ6Q9ONqomIu0lw90haB7X1YpiOJnxB/qFu4m6vWk4qgckUPBTt9mLs67Il7rC1xjdb
         ttmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770393905; x=1770998705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8AUOgLGnMMIEfqB+Rfe3dTR9LWMxVZqOBCh7oFBO4Zo=;
        b=kk6Iu0EkZTfxwKUeX1bCu+5zsJSe0GNLfSK9Ep2TjhRzCKKAavhyiKZ6F0Rg9ugqvK
         tUv2F5z6jHIo3YTaZEXIGh98WdEEwEkqyLmiONe9klB5qrL3Js2tEjJbSdAb1F7/JroW
         9aUBX7YonjR35UceLt3LGcMOy0MfWXGC7nPZWwPEqOidInegm/IE2an8OZvMBSiueJ2X
         ioNTD5c5mvP/KmsfmCuUc4CaNpkeTeICcVofkoDxEPgOe9DvxSd0oSBoA6WTMfrf7MSH
         OPlYhRoOsmzJjRNqDk+aTOzXLR549nqJfcRZmlbTJtlJ95MfoguAkAw8VdRS8ZeXqno+
         rCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsGfnYRNofs6WfdaLaPfHsu4Wz3Ox3ScBtNs8tpNO3Kk9BiGGiE/BZh6Ik0Hp7J3OKXm/gYZeCNSQgNyoG46Pn9UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4dZLwC1Haj0PBzqQesrdkErlCFigO7nTkdSucK1n6X1nQvRv1
	lXWwPJTMfymSreF7p3MgKY4KD23bdL74cnhzYtFzU8n71UXXipZMexl3u5M99EgZrhvFs8+Fxqq
	MQltYlgRCmnuSCwfb0HTqPXW+1qGBS+U=
X-Gm-Gg: AZuq6aK1Cnh/MoBEM8/Mpd48BdtmBbpfTqY5dRg9ewuo2yTjBp6tCdD+G19Yiy6AOpZ
	8QEwWPe4XPpB1dkc8fk71Ceh8ARrOEvW90gIeFSXD+0KPs1tSvDQe1ptwyC+rgb7kKG+q0MiWj9
	xxboBxyv43f71hkcursfGkm96+jQPv4hvrj0NF9jkt4GIOqca9FRkILEm3zXroYEoeE7aHxTHab
	qCXbDyRjmPDIeixHFR6w/MtIygvR6pFaB94I1ihH4Zqite8szk5az17HsQd0a1DLm+LZLTTJppd
	CknalA92xDuCYOOBapEeWmkAFsHXwLqjD+6dlB11aHso2PXxyHjiaTJyGTqAmXQIUbY+RHZvQBD
	GCBwzboXUpUDFLhe6jig5qp3u
X-Received: by 2002:a05:600c:548d:b0:480:7162:fa48 with SMTP id
 5b1f17b1804b1-483201ecd90mr50571685e9.13.1770393905153; Fri, 06 Feb 2026
 08:05:05 -0800 (PST)
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
 <CAErzpmvtJwB7nTD5EFHP9SxPxH-rc3NuJp5xLGSTB7YPbUX8YA@mail.gmail.com>
 <CAADnVQJgM0W3aQVGi5_35xWc=D7Ruzt1xV0REM+RnnvtooeC5w@mail.gmail.com> <CAErzpmsC0qHL41KoRTxQ2-Xy=t74NnOZQxrv8VMFRSt3eoFrRA@mail.gmail.com>
In-Reply-To: <CAErzpmsC0qHL41KoRTxQ2-Xy=t74NnOZQxrv8VMFRSt3eoFrRA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Feb 2026 08:04:54 -0800
X-Gm-Features: AZwV_QgRI0gmm_jNdS8JQDVd_GmShLrDbwSVBXnZrnR5RfecCaQcg6USmNhxez4
Message-ID: <CAADnVQKrAcSzTYbSEHkWiWS0Ot5wAQ8_Q_v6-J=6=O4MxLpbpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 8:10=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> On Thu, Feb 5, 2026 at 11:56=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Feb 5, 2026 at 1:21=E2=80=AFAM Donglin Peng <dolinux.peng@gmail=
.com> wrote:
> > >
> > > On Wed, Feb 4, 2026 at 10:52=E2=80=AFPM Donglin Peng <dolinux.peng@gm=
ail.com> wrote:
> > > >
> > > > On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@go=
odmis.org> wrote:
> > > > > >
> > > > > > On Tue, 3 Feb 2026 21:50:47 +0800
> > > > > > Donglin Peng <dolinux.peng@gmail.com> wrote:
> > > > > >
> > > > > > > Testing revealed that sorting within resolve_btfids introduce=
s issues with
> > > > > > > btf__dedup. Therefore, I plan to move the sorting logic direc=
tly into
> > > > > > > btf__add_enum_value and btf__add_enum64_value in libbpf, whic=
h are
> > > > > > > invoked by pahole. However, it means that we need a newer pah=
ole
> > > > > > > version.
> > > > > >
> > > > > > Sorting isn't a requirement just something I wanted to bring up=
. If it's
> > > > > > too complex and doesn't achieve much benefit then let's not do =
it.
> > > > > >
> > > > > > My worry is because "cat trace" takes quite a long time just re=
ading the
> > > > > > BTF arguments. I'm worried it will just get worse with enums as=
 well.
> > > > > >
> > > > > > I have trace-cmd reading BTF now (just haven't officially relea=
sed it) and
> > > > > > doing an extract and reading the trace.dat file is much faster =
than reading
> > > > > > the trace file with arguments. I'll need to implement the enum =
logic too in
> > > > > > libtraceevent.
> > > > >
> > > > > If you mean to do pretty printing of the trace in user space then=
 +1 from me.
> > > > >
> > > > > I don't like sorting enums either in resolve_btfid, pahole or ker=
nel.
> > > > > Sorted BTF by name was ok, since it doesn't change original seman=
tics.
> > > > > While sorting enums by value gets us to the grey zone where
> > > > > the sequence of enum names in vmlinux.h becomes different than in=
 dwarf.
> > > >
> > > > Thanks, I agreed.
> > > >
> > > > >
> > > > > Also id->name mapping in general is not precise.
> > > > > There is no requirement for enums to be unique.
> > > > > Just grabbing the first one:
> > > > > ATA_PIO0 =3D 1,
> > > > > ATA_PIO1 =3D 3,
> > > > > ATA_PIO2 =3D 7,
> > > > > ATA_UDMA0 =3D 1,
> > > > > ATA_UDMA1 =3D 3,
> > > > > ATA_UDMA2 =3D 7,
> > > > > ATA_ID_CYLS =3D 1,
> > > > > ATA_ID_HEADS =3D 3,
> > > > > SCR_ERROR =3D 1,
> > > > > SCR_CONTROL =3D 2,
> > > > > SCR_ACTIVE =3D 3,
> > > > >
> > > > > All these names are part of the same enum type.
> > > > > Which one to print? First one?
> > >
> > > Another option is to print all matching entries, incurring increased
> > > overhead and extended trace log length. However, I prefer printing
> > > the first matching entry, though it might be inaccurate in rare cases=
.
> >
> > I disagree. It's not rare.
> > I wouldn't print anything. Let user space deal with it.
>
> Okay, I will implement this in libtraceevent first. By the way, would the=
 first
> patch [1] introducing the for_each_enumand for_each_enum64 helper
> macros be acceptable?
>
> [1] https://lore.kernel.org/lkml/20260202111548.3555306-2-dolinux.peng@gm=
ail.com/

Just that patch alone? What's the point?
Refactor for what? Does it read better? No.
