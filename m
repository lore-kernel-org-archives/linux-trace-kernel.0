Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802A242B750
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770306977; cv=pass; b=I47issZBnorreRnVsB60AGaQTaADGTfMmepmqnOC+LwMws690HBpjtJ22WCN+lNc1c/B+9W8w8CR+8vfu0PqAsvw1PkNywuJnPXIJXOP2uj4V2n2HA/6O1sgFdGdWUD4rgU0fDB1cz6lAaawPS/IhbpxapGTJ7wwhdkxR+yg8f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770306977; c=relaxed/simple;
	bh=b4akzjXyB7HtuQ+xQvw9DogbnCKf/L3PB1vqHiBOiXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEIqOg0m460SLOKV4Fta4tWMEPa9Jdm23tw4YZmoXFUOoXs+DI1OIK7aj8gmpCF8KUT7pU565tExSC+phthfQ3PGKmB3J4jOekdD3JzE7450lyDb3+4GfShrgbXTfwiQWQWAuHxdoUuT7dupiT+NW9ej3g2FMa6b1i3SCziNyS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1dKpPbb; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1dKpPbb"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so939781f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 07:56:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770306976; cv=none;
        d=google.com; s=arc-20240605;
        b=WZu5pzTyDr6YJJ2hDlvUGWlSeEjoCzbWdH4LLM4HXZ4cJsfjqBaWaGfr5+De54SMvV
         IG4faiM4R7f6J0hZHkys5OdoOJ/AawjRBHBTGFfcmAGt48IMS4yO8LPoPuPwGJkc0OM8
         4VlMquqOYn2Xj4/8ISXB3+Y2qY9x0y9LOUtsCQu69tJznIb9sGy/doxReGhHhIF+8xmW
         x0F0SFMh3Ka+PxPDhZfJF/JPFYWJJOjSKA4OpfddKw6tAvPqj9Mb99E8MqdHkZsz1cq0
         1Yp0alUnqiUR0tM+FQdHgEctdw870kYuvntxv/NZXQyiDjpDak7FB7bqzK2v8qHLooTG
         Cg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b4akzjXyB7HtuQ+xQvw9DogbnCKf/L3PB1vqHiBOiXI=;
        fh=xy9YYCQVSVLL7LxYWF3VFyJ0BwUebRn7Rs99phUoSgA=;
        b=Wq9IiWfqBoPqPDwdOV0mgVRtBxZyhIsGdvrG8+tMHE48pffD3dCHqeDG8vPpz5RoYH
         wGPtOlOBvqUCg1XeP2yvEF6rcqdGmOeOwIrv/TnAcOD0THkEfqaz/0NJdHcDSArD+feX
         29BS2Wlrplto/+iGa75N0OzlqczBaBWaQuUvxNi8NLCBJ0EIjr7eVQxqNFWfNs1hUnYC
         2o8YF+6gGveQ+lMaiWWR/NmZ/UO8iIXRRfbMw5a/UCerexjdXtMUOmjbvcIYX4JJJajz
         SDn/MEMHeJU3AF5dfMFTlz5xjsxM8L/v2nGEBYX/jwyfvEKwXiuNVUuX6cWgUqkk9JNr
         iOMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770306976; x=1770911776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4akzjXyB7HtuQ+xQvw9DogbnCKf/L3PB1vqHiBOiXI=;
        b=e1dKpPbbuYZ4qRc9IZBQbEBh/NLfIRwGTLQvagt1u6U+6piLSFDf2upy6zjr0Q2Flk
         MRAP66k+nquUtvOe4Wqzt2eo0sh5ZM1MtvjuPbi2ACLhLLJ8we9nABLj7C6Mh89kReIj
         pN+9fN34zQAOStgxSQjyhAyE/V91L8nqP/7fboBJ/8LZVhJBK4PI4SNW4K46L3/d8ACD
         S40lPjlgeohCAct3ywMtuem6d80loW5XKf6aPJsHT2py7C8LufyA++gA7Tecmh5I9nCr
         CsY3wGpEAID9VRMTuKpWEWKnEylhOD6eRyivlSvtZo02Tk6zhczaahqaz29Ei1Sa+lwg
         ccSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306976; x=1770911776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b4akzjXyB7HtuQ+xQvw9DogbnCKf/L3PB1vqHiBOiXI=;
        b=Rd2DaVA9xuu94i42mmARXIvgIeKUuMAkQ0W4+iiP437DCxSn1Btm3R8jdatcgLP1G9
         ByVOrATJi34MFToTtqZQ/rbIr3Sr8teIlX12xlrN1jhMVxsGoEbnAHLlcIj6ZJtDaiSd
         cKo5m7Mod/do+9Yw2ksb9mP19PSxPa8pVs7vLdvAZkV/T00UW7vMym7fw/MmJ2jnV8py
         pmzStOMSOeCgLLIPrkm8lhY6udoQvYjM3V+n/ROQ62j1b1nXSsYXHuPJgxK+vJxzceox
         utTpAx59NgPOSGDtkjixoePTja6BM7HPK2QB+8BimuJrLLWzBKATJO7XhxRaBINBf2Ir
         Z3DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUapAi4RN15FvZaBYwFs5z0jxPGjhKUnlgh9+rVki5lRx79XSKkdnVDVJ58ObGkCipy2morDeMB3y6IB53gVF1AZw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtySDzchOV+kk4kwzxRgAAY3vetIJf71P4GBCCQefe0cF5X8W
	C32BZP2PvaEVUMfQNhEmFANStnlv8forDBX19ZEQ//h5b4YOdO9BSefVgIh/QNDn67vAPyp1dbv
	HO7at4QwXT2RUeL4qyVG0wgf5MKEP2SI=
X-Gm-Gg: AZuq6aIA6fVygRKTAtuA/6JTMarDd9flw5GbMy/P09MNrPI8Oar7xn7NlW+eeyVCQQs
	YWO+O+o8T1sMK+LKNm0aCei2PWKKuywEaneIfamHKlHjRKwY5liGs/EUniUwR2lXAriK4IaphEq
	NpbQwwngZMod6o/F9sKrwgtE5jluxbIuhaX4aSxnI1DPBIPfwcBvWjMN+0rWPnfvLJqlqgamWZ0
	mlv/fz+0S8a/ls2KFuKQ2CP5ItUBzQ9o3HPE7I6HHxEV9IuPjhqoP8utAnhCH6dHXluKomPNacI
	K7iZJvqd19bwL36F+uPM97MShr2Y08H4YH5VZYV9QyR4BWKjdY5B6Og1RCbrzz1BI5095Nxi
X-Received: by 2002:a05:6000:2207:b0:431:3a5:d9c1 with SMTP id
 ffacd0b85a97d-4361805500amr9966917f8f.30.1770306975650; Thu, 05 Feb 2026
 07:56:15 -0800 (PST)
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
 <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com> <CAErzpmvtJwB7nTD5EFHP9SxPxH-rc3NuJp5xLGSTB7YPbUX8YA@mail.gmail.com>
In-Reply-To: <CAErzpmvtJwB7nTD5EFHP9SxPxH-rc3NuJp5xLGSTB7YPbUX8YA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 07:56:04 -0800
X-Gm-Features: AZwV_QihuuP3z2J76lmeYSQjSgbNK5taZrRT9R4w6RLFqNKBj9OV5WRgklhng0I
Message-ID: <CAADnVQJgM0W3aQVGi5_35xWc=D7Ruzt1xV0REM+RnnvtooeC5w@mail.gmail.com>
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

On Thu, Feb 5, 2026 at 1:21=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> On Wed, Feb 4, 2026 at 10:52=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@goodmi=
s.org> wrote:
> > > >
> > > > On Tue, 3 Feb 2026 21:50:47 +0800
> > > > Donglin Peng <dolinux.peng@gmail.com> wrote:
> > > >
> > > > > Testing revealed that sorting within resolve_btfids introduces is=
sues with
> > > > > btf__dedup. Therefore, I plan to move the sorting logic directly =
into
> > > > > btf__add_enum_value and btf__add_enum64_value in libbpf, which ar=
e
> > > > > invoked by pahole. However, it means that we need a newer pahole
> > > > > version.
> > > >
> > > > Sorting isn't a requirement just something I wanted to bring up. If=
 it's
> > > > too complex and doesn't achieve much benefit then let's not do it.
> > > >
> > > > My worry is because "cat trace" takes quite a long time just readin=
g the
> > > > BTF arguments. I'm worried it will just get worse with enums as wel=
l.
> > > >
> > > > I have trace-cmd reading BTF now (just haven't officially released =
it) and
> > > > doing an extract and reading the trace.dat file is much faster than=
 reading
> > > > the trace file with arguments. I'll need to implement the enum logi=
c too in
> > > > libtraceevent.
> > >
> > > If you mean to do pretty printing of the trace in user space then +1 =
from me.
> > >
> > > I don't like sorting enums either in resolve_btfid, pahole or kernel.
> > > Sorted BTF by name was ok, since it doesn't change original semantics=
.
> > > While sorting enums by value gets us to the grey zone where
> > > the sequence of enum names in vmlinux.h becomes different than in dwa=
rf.
> >
> > Thanks, I agreed.
> >
> > >
> > > Also id->name mapping in general is not precise.
> > > There is no requirement for enums to be unique.
> > > Just grabbing the first one:
> > > ATA_PIO0 =3D 1,
> > > ATA_PIO1 =3D 3,
> > > ATA_PIO2 =3D 7,
> > > ATA_UDMA0 =3D 1,
> > > ATA_UDMA1 =3D 3,
> > > ATA_UDMA2 =3D 7,
> > > ATA_ID_CYLS =3D 1,
> > > ATA_ID_HEADS =3D 3,
> > > SCR_ERROR =3D 1,
> > > SCR_CONTROL =3D 2,
> > > SCR_ACTIVE =3D 3,
> > >
> > > All these names are part of the same enum type.
> > > Which one to print? First one?
>
> Another option is to print all matching entries, incurring increased
> overhead and extended trace log length. However, I prefer printing
> the first matching entry, though it might be inaccurate in rare cases.

I disagree. It's not rare.
I wouldn't print anything. Let user space deal with it.
