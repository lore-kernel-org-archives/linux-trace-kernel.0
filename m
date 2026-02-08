Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367C726B764
	for <linux-trace-kernel@vger.kernel.org>; Sun,  8 Feb 2026 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770556099; cv=pass; b=c3/3xO5x1/MoRQfilWNScBcqiA9oe4aBN05I/aoyXe/nY8pTTtVePkGw07IyNu7JlmTJ6b+xX01/9e+hDtDcEbaRI6nfa9x1yowN486eGzT34iGH1fVHRKS1AKKRGJ/EF7bRcO5V+Jc6M1eWxLi7LvM08ZxOZIFW4xuWUzAIaO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770556099; c=relaxed/simple;
	bh=9OJqdnT6R5/4E5JMOG7ZtX0T+HXSx64sLiypnTWLM2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxG6evySKfTlTjU4oDoTQJctEkOviOm2dxUTJOwEOZNiS5E/5FLzH/UyXoGkzE28K/YDaKeWrRE3sAoCKqfEy7Rxa1EOx0GisU/JSexeT5t2eTxA64AcPrEGmCAmLNJId3+pSER9DHvhWkOtf2kbbsweEbIkBeiNz/JOvAY8Q7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjY60c9Z; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjY60c9Z"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b885e8c679bso283688466b.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 08 Feb 2026 05:08:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770556098; cv=none;
        d=google.com; s=arc-20240605;
        b=MhG0mtM0vOgZ+ztYKcZvUjvokdAnDe9+dLW3KZtQUkH78+txRj9ulYNjZRD1NaDb9S
         e+j9OB7Z3/D7YKEJ16dpxjY42hKlKbagBJd2IMSx/gZUfL2QNA8A6G6PkYKiwVnCU3n3
         wOyD6RuWnbIDruce30AJMKggP06lFWuwnPJjKMNfhcfbxBVQ8JOqfsbFm913Pq/eHEQr
         AXl1SqXgU/zDEw/nOv7cKIz4GXDmu1tPm5G1td95MM+II6eaWoA/RFkgB8RtBWxRzzd4
         2r+x8G4fHZPEtPgoorzlChBQXEPEVuhFG4hWZu5qx8nMWm38hnpqc94xRM3NCsm32E2C
         SK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9OJqdnT6R5/4E5JMOG7ZtX0T+HXSx64sLiypnTWLM2E=;
        fh=hp5Cc0HtsvfJCenMrsv/eZWt0/IXXl0AlffxN8NwZaM=;
        b=MaTjkPSDvWmwS/ipjbH0wcS72IQ+BX4REW/CgBsC+5fbSC/IpfVG28AShJPV3upgOI
         3jhB4Odk+WWrBO0GU0r79AVxkf8lcmykuSuiPmC9z7xJPiodymPw9ZGkqh7A3IMZolLF
         OByoJW/gK6i63IZIzxZMoTU0pAxM5tIQbX31hCPC4LbA/W+XEbDILvqCW52kvNYxlSsl
         Ccm9N3kOuoHMD6/nNlQ3Sbg8p7am/6KLll4w3jfg1L0dHylmikHypgUrou1vKRyxWfXa
         PXE1JXbTEU+XCkKdnl9+QT/Mwp/GoyvQNSFgOnD1Bq/iKCjTlBdwaVihQxRrMHq63bFk
         h3vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770556098; x=1771160898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OJqdnT6R5/4E5JMOG7ZtX0T+HXSx64sLiypnTWLM2E=;
        b=XjY60c9ZWHYsyEZIxYugWU9bCDqy5Iv14GgRP1DdykTLRU6Nd3qRZCkHKz0jnoFLcL
         m6X8uGAWNE1dgSZn0X0lM3CwSund7SQzdHBZRoNJx7EV6n4VY/5cRZ5ApvzD2gODItWj
         pKXxCOKkQa/YliZK6/6IDRrUMV/fwqKL3p8bIJ/xH7ycPCzxTdvOUBHFC4K2EavDGnFP
         x0r+dz7qN9MTSYjQujvsG4UQ7uQ6iyxpkQ5lxcjsBOZ1Pw0Yr/a6sn/7qZp0aOWHmRvo
         +BXrKbTN9oWB0TDGTvhDZl8El7ayfdnmUhe0OWFZBUVe31F3aHdobsVJ9dxiOkHZnycE
         NVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770556098; x=1771160898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9OJqdnT6R5/4E5JMOG7ZtX0T+HXSx64sLiypnTWLM2E=;
        b=Zh28MHrtz/k8kyrS7qWOo5tIigBDqAtuVon9oMjI2JF7Xy2T+WQFpxHk3BZymzDm2S
         wgFX5f3Ca5jXcdDPNxuNWMZLSt+hPG19OBRE1wSDlGmLjwN2aaj/sSGcuz4Ej/lTYf05
         wbHF9pQRs9qW11foJgt7Z4KCbVRYxguh0llHJUi/wpsaZkTyoBUc8oQQvaR02sX44q1s
         0B/n25XJrWTUp3YbqvZbmfQCq8j9kPA4rkECZLv6/82sAJVHlCBUejJZI60lwQCT2xah
         FsnFqdnoh7nrJAg+H8JyN1N5RLUKsetPj0K8YCYfY51g82ORQIGXez3/OIWx3HwMO9v6
         X8Rg==
X-Forwarded-Encrypted: i=1; AJvYcCW5XhJ+TkiRpnBcO+DDcrmMV0LxhtHUCrVAm2CmBC9F95nnPQlVQ5p+y6/k6jvcHNrDS3w7KPF8U/kuO3F+tDZjT5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3ug7EKyaQpw2O2NaLr39th+NgG7Nbvo2et+rvHni07jLaQZF
	AwO4JEp5UJc2H9yo0VFhrWE181ZOpGQwMgoYgwDrs4Qmldm+OzuVFoynqkH4rM7LnwVtXflyfcu
	RjdMThFlUbjCt/Dy1ULYCIySNbOv/mxw=
X-Gm-Gg: AZuq6aLt4DZgILdxqfduZ2W4o8NiSMRjP0cXkSWlLSEmsCxOEWyGJWILoBZhIy5U7dR
	uyUfvUmEDYi1dQQumbfJSZPFrZ12BIzGoRxXEP7IYTXVkAUwJHLU20Ok/EugQhR07A2iGLWRQC6
	tGBwVfJDVP1x8eCzGK3bk6VPD7GW39UdEbuj+ntLlZsQo1Wy5WZU7PGmrbp4IkPTtDba/lpmGzo
	uZ8e8xghtCHxS7PwPZlShCQGzHl7S6ZbrmtwPbm/bdXlzDJPVh5KH2yQLu5c59EafHhaRhl
X-Received: by 2002:a17:907:2daa:b0:b8a:f9d7:1aec with SMTP id
 a640c23a62f3a-b8edf14ca69mr505910466b.10.1770556097276; Sun, 08 Feb 2026
 05:08:17 -0800 (PST)
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
 <CAADnVQJgM0W3aQVGi5_35xWc=D7Ruzt1xV0REM+RnnvtooeC5w@mail.gmail.com>
 <CAErzpmsC0qHL41KoRTxQ2-Xy=t74NnOZQxrv8VMFRSt3eoFrRA@mail.gmail.com> <CAADnVQKrAcSzTYbSEHkWiWS0Ot5wAQ8_Q_v6-J=6=O4MxLpbpQ@mail.gmail.com>
In-Reply-To: <CAADnVQKrAcSzTYbSEHkWiWS0Ot5wAQ8_Q_v6-J=6=O4MxLpbpQ@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sun, 8 Feb 2026 21:08:06 +0800
X-Gm-Features: AZwV_Qieeug1LxlBhiGFK7rwN1TwVDWOJW9C6yLIevkRt3nhVeuKkqX9xXTmh2g
Message-ID: <CAErzpmv547nBOT95ZYv6KLD6esVUKY4he=EKiWvmuVPXZfSaYA@mail.gmail.com>
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

On Sat, Feb 7, 2026 at 12:05=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 5, 2026 at 8:10=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > On Thu, Feb 5, 2026 at 11:56=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Thu, Feb 5, 2026 at 1:21=E2=80=AFAM Donglin Peng <dolinux.peng@gma=
il.com> wrote:
> > > >
> > > > On Wed, Feb 4, 2026 at 10:52=E2=80=AFPM Donglin Peng <dolinux.peng@=
gmail.com> wrote:
> > > > >
> > > > > On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@=
goodmis.org> wrote:
> > > > > > >
> > > > > > > On Tue, 3 Feb 2026 21:50:47 +0800
> > > > > > > Donglin Peng <dolinux.peng@gmail.com> wrote:
> > > > > > >
> > > > > > > > Testing revealed that sorting within resolve_btfids introdu=
ces issues with
> > > > > > > > btf__dedup. Therefore, I plan to move the sorting logic dir=
ectly into
> > > > > > > > btf__add_enum_value and btf__add_enum64_value in libbpf, wh=
ich are
> > > > > > > > invoked by pahole. However, it means that we need a newer p=
ahole
> > > > > > > > version.
> > > > > > >
> > > > > > > Sorting isn't a requirement just something I wanted to bring =
up. If it's
> > > > > > > too complex and doesn't achieve much benefit then let's not d=
o it.
> > > > > > >
> > > > > > > My worry is because "cat trace" takes quite a long time just =
reading the
> > > > > > > BTF arguments. I'm worried it will just get worse with enums =
as well.
> > > > > > >
> > > > > > > I have trace-cmd reading BTF now (just haven't officially rel=
eased it) and
> > > > > > > doing an extract and reading the trace.dat file is much faste=
r than reading
> > > > > > > the trace file with arguments. I'll need to implement the enu=
m logic too in
> > > > > > > libtraceevent.
> > > > > >
> > > > > > If you mean to do pretty printing of the trace in user space th=
en +1 from me.
> > > > > >
> > > > > > I don't like sorting enums either in resolve_btfid, pahole or k=
ernel.
> > > > > > Sorted BTF by name was ok, since it doesn't change original sem=
antics.
> > > > > > While sorting enums by value gets us to the grey zone where
> > > > > > the sequence of enum names in vmlinux.h becomes different than =
in dwarf.
> > > > >
> > > > > Thanks, I agreed.
> > > > >
> > > > > >
> > > > > > Also id->name mapping in general is not precise.
> > > > > > There is no requirement for enums to be unique.
> > > > > > Just grabbing the first one:
> > > > > > ATA_PIO0 =3D 1,
> > > > > > ATA_PIO1 =3D 3,
> > > > > > ATA_PIO2 =3D 7,
> > > > > > ATA_UDMA0 =3D 1,
> > > > > > ATA_UDMA1 =3D 3,
> > > > > > ATA_UDMA2 =3D 7,
> > > > > > ATA_ID_CYLS =3D 1,
> > > > > > ATA_ID_HEADS =3D 3,
> > > > > > SCR_ERROR =3D 1,
> > > > > > SCR_CONTROL =3D 2,
> > > > > > SCR_ACTIVE =3D 3,
> > > > > >
> > > > > > All these names are part of the same enum type.
> > > > > > Which one to print? First one?
> > > >
> > > > Another option is to print all matching entries, incurring increase=
d
> > > > overhead and extended trace log length. However, I prefer printing
> > > > the first matching entry, though it might be inaccurate in rare cas=
es.
> > >
> > > I disagree. It's not rare.
> > > I wouldn't print anything. Let user space deal with it.
> >
> > Okay, I will implement this in libtraceevent first. By the way, would t=
he first
> > patch [1] introducing the for_each_enumand for_each_enum64 helper
> > macros be acceptable?
> >
> > [1] https://lore.kernel.org/lkml/20260202111548.3555306-2-dolinux.peng@=
gmail.com/
>
> Just that patch alone? What's the point?
> Refactor for what? Does it read better? No.

Thanks, I see.
