Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18B7337690
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Feb 2026 04:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770351006; cv=pass; b=EO6reGc+zSoVjAWy9eGsRpzraCAzpirGP6j6D+c4xteYl+LhkYjkR9RAsAc7HDGS3rUmn5c5uYIES57ZJ3hiS6qa8zMNMixp7PAgowyManXpUk/xAf/n6OS1A3p+NrYpZi17e6+2ESDpGHQ43FGSusVGjGrOf7zf/jw0/eFytB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770351006; c=relaxed/simple;
	bh=iYpwTYkFbebeWOXjdGzbXWMLC1RCQ0MzEk69HOZm/4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xs2TGqIIxzDxNjpC5AMzYb33weAupBEZz2tW9Vmwl8UImrEUhOPwe2R7nwS5fGQWVsTcHrZSaKK9e3TOVBVGvlCedhkllFq410CxvboIw8mUDgNOpn5L+ym1lBrOBU7my7CCLzJXSN7zJo6SyHfTbptkIY16sK+JxqSr66RwH2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpWKB0Uu; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpWKB0Uu"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8710c9cddbso26858566b.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 20:10:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770351004; cv=none;
        d=google.com; s=arc-20240605;
        b=IIKb1Ho3zKYBC4I2sw5z6hPXuyaBg7F6Qz0jHRS6RVtep5QJ0tfNmFP5qQmik4vHCH
         /krHqfHEeMF9XXC9E2JyokStc/WBn4CwDU/sMaceBBwr4htMo08767qaeCBMqYVT7gKY
         geNTJ234rPsFvuzad9DjrDey19edo1CX3Di7bdo8jhV6XHwnMf4aBEiQF4C+nZYfa0yN
         4WDhjoveTi+zc59uBVP6PTAuVUW5YtFL6g6aSImSZEQnFD6CzS/z/cvk5BDVqPBSlsDa
         xjZqFYJHOG8NZ4m8TZ415XSJ5omv8/6RkUWe6zGDKnn+rZRxajvfJg2wgO1Ozu08p/eo
         sp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iYpwTYkFbebeWOXjdGzbXWMLC1RCQ0MzEk69HOZm/4g=;
        fh=kgkazf9JAY1rSbCuPjixOvQViIbJgmucrV5u7MAL98A=;
        b=O3Y3ydv8+5P4fFYw6224pDwNgAdCs89asM2CPaHR8tTMHiqRe6/Dg9gZX3Q8WjnEiK
         4OKAi4ptjF+hON1JDdZrayvUH1prLoT2sdS3qkSzLWuBbeQHyn5+SvSO8amJbJeV9S0K
         ivyznwQ7G1CKhBVS5QNKDORAzyH4etgpSE5XjUiAYSjxoaA9ILwJ3o+SEMaMH8zSz6p3
         zCmNPAQAOspLeKNOu3RogDlUtrpR9bMWj9FsshPdO2X2UVeACV+ITtLRUUVCoXTwhdCi
         RbOFS8n0J47sJ91rGa4WkMqn9/DlY3fUrNtuiQpRiQKeDOOr9t8uUiXSqlQGzs34Znji
         WqzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770351004; x=1770955804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYpwTYkFbebeWOXjdGzbXWMLC1RCQ0MzEk69HOZm/4g=;
        b=WpWKB0UusxXul9U9xdQlw3wzAufITslB9IHz3SPSXreh04kXuATvUtpbmQqfa5qCan
         /A9oupjusRYO8aP2jNxP3NaWQcQOkUADDlz6xFsRcJ6J+Nis77R0641aFTJj0JOsdsQa
         /cg1Wlh1iTq7LCcffxjgxnG4WK7mH0Anu7p7P4fSRKOwwG2n9MLvE8D8DWmXYlSX7uVn
         CufFJe+8aeJYAnLmJEcIx7d5ZwGSt4s7wh38U1jdiNPIihcpU/kzaNE4yrrn0XTJ50uj
         Dn48xaE0+0X6h9/0+Kpu97i7sXnX0iG8i/11hF6cdn2Jw5pEPbuQzXCWV4RvbsP+6CeL
         BknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770351004; x=1770955804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iYpwTYkFbebeWOXjdGzbXWMLC1RCQ0MzEk69HOZm/4g=;
        b=F9Qvv5FtH7OSN2vwClHvGJfyEX3Qty3w5aNWnQrUKXuTOkgYVOgX4dgX0aZg7tlmTX
         2AB9DY+6ox7TCT6rFiQ4CyQE2nwntGNbgA1gSwiQqROuAHkHQcY8gmA2yQzc04+IWxt+
         uYw/nHALsHLa9bsQYr1ggintxbeuTKiASnhBzq8HDFgZx8y+PLlCPJMGR0/ffDmeIvAl
         73/+hcvWOoStjg1zvWZARCmtSyE/Q/rXNolX0XB5me9MV/tVuUJwHoC6Rqazh0DyffcY
         IRnPO79tOZkeHkq8ZXFnSV+wfzro+tHzMYKZdumLB2VSn9gRaMgfboqwACDFueKXt1QJ
         VVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdatqD8kBt1t4ap5tLv/CX2wCfhD9TmpWoJuOnIJmKmxtp7Gi3kSEG0NNup/oLg7MdQjhVpIQNt32O2PyT5aQJduM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxyCS1BSiIsFECSIHkefUhwnU8MaICpbuYWvKDIF4SEaUCN+i+
	YyF3XvPIz1FRGkqlJhc1Q28kHD5fOiF28Et2DA1mcLzStgWmevkmHQG+CEyYSNICD2XHxkNQHIV
	PS4k1ZD9vrQ0HHcAB5VDLOdS5EaJdNOc=
X-Gm-Gg: AZuq6aKpBPrWdSEaAYi8edqBVmhJOa3svBtzBA+KUHmjOXiXc9cpZL81EMGVp7NsKQl
	mYsW1MoLYgrZcZpm50R56L9obbzpTkjW7SnM52NKR0HdNnFPZP7Y+7BvZgAt2SLEOg1HHo1jyOc
	9ssBbsXTOUttU14bQ4KOvGQfGL5nZbFVYhhnYqc8YifrPsOYsNoY5WwuZfUkFAgslTQH5gl7l+X
	wBG+g/i0AktUevMsVnkrKGeq7jJYQ7Wod+ZJAvFxeWtY/Jgk7uJEITDridyJxCiuMpSnat1
X-Received: by 2002:a17:907:6091:b0:b88:5385:59d7 with SMTP id
 a640c23a62f3a-b8edf14caafmr70992166b.4.1770351003846; Thu, 05 Feb 2026
 20:10:03 -0800 (PST)
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
 <CAErzpmvtJwB7nTD5EFHP9SxPxH-rc3NuJp5xLGSTB7YPbUX8YA@mail.gmail.com> <CAADnVQJgM0W3aQVGi5_35xWc=D7Ruzt1xV0REM+RnnvtooeC5w@mail.gmail.com>
In-Reply-To: <CAADnVQJgM0W3aQVGi5_35xWc=D7Ruzt1xV0REM+RnnvtooeC5w@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 6 Feb 2026 12:09:52 +0800
X-Gm-Features: AZwV_QiHtOYxxPJvq-D2Vb8pnfHmY5SKlgGaNk_QBcR7mOob47oiA5NF3J8engI
Message-ID: <CAErzpmsC0qHL41KoRTxQ2-Xy=t74NnOZQxrv8VMFRSt3eoFrRA@mail.gmail.com>
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

On Thu, Feb 5, 2026 at 11:56=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Feb 5, 2026 at 1:21=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
> >
> > On Wed, Feb 4, 2026 at 10:52=E2=80=AFPM Donglin Peng <dolinux.peng@gmai=
l.com> wrote:
> > >
> > > On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@good=
mis.org> wrote:
> > > > >
> > > > > On Tue, 3 Feb 2026 21:50:47 +0800
> > > > > Donglin Peng <dolinux.peng@gmail.com> wrote:
> > > > >
> > > > > > Testing revealed that sorting within resolve_btfids introduces =
issues with
> > > > > > btf__dedup. Therefore, I plan to move the sorting logic directl=
y into
> > > > > > btf__add_enum_value and btf__add_enum64_value in libbpf, which =
are
> > > > > > invoked by pahole. However, it means that we need a newer pahol=
e
> > > > > > version.
> > > > >
> > > > > Sorting isn't a requirement just something I wanted to bring up. =
If it's
> > > > > too complex and doesn't achieve much benefit then let's not do it=
.
> > > > >
> > > > > My worry is because "cat trace" takes quite a long time just read=
ing the
> > > > > BTF arguments. I'm worried it will just get worse with enums as w=
ell.
> > > > >
> > > > > I have trace-cmd reading BTF now (just haven't officially release=
d it) and
> > > > > doing an extract and reading the trace.dat file is much faster th=
an reading
> > > > > the trace file with arguments. I'll need to implement the enum lo=
gic too in
> > > > > libtraceevent.
> > > >
> > > > If you mean to do pretty printing of the trace in user space then +=
1 from me.
> > > >
> > > > I don't like sorting enums either in resolve_btfid, pahole or kerne=
l.
> > > > Sorted BTF by name was ok, since it doesn't change original semanti=
cs.
> > > > While sorting enums by value gets us to the grey zone where
> > > > the sequence of enum names in vmlinux.h becomes different than in d=
warf.
> > >
> > > Thanks, I agreed.
> > >
> > > >
> > > > Also id->name mapping in general is not precise.
> > > > There is no requirement for enums to be unique.
> > > > Just grabbing the first one:
> > > > ATA_PIO0 =3D 1,
> > > > ATA_PIO1 =3D 3,
> > > > ATA_PIO2 =3D 7,
> > > > ATA_UDMA0 =3D 1,
> > > > ATA_UDMA1 =3D 3,
> > > > ATA_UDMA2 =3D 7,
> > > > ATA_ID_CYLS =3D 1,
> > > > ATA_ID_HEADS =3D 3,
> > > > SCR_ERROR =3D 1,
> > > > SCR_CONTROL =3D 2,
> > > > SCR_ACTIVE =3D 3,
> > > >
> > > > All these names are part of the same enum type.
> > > > Which one to print? First one?
> >
> > Another option is to print all matching entries, incurring increased
> > overhead and extended trace log length. However, I prefer printing
> > the first matching entry, though it might be inaccurate in rare cases.
>
> I disagree. It's not rare.
> I wouldn't print anything. Let user space deal with it.

Okay, I will implement this in libtraceevent first. By the way, would the f=
irst
patch [1] introducing the for_each_enumand for_each_enum64 helper
macros be acceptable?

[1] https://lore.kernel.org/lkml/20260202111548.3555306-2-dolinux.peng@gmai=
l.com/
