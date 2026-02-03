Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155373C1961
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Feb 2026 16:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770134462; cv=pass; b=TIr+k+WLA/0qYC87Znvi+5mUugHzp6sGQJz/BdMYMMYhsX//tPiFun1rxk5Tvd8UhaE4LT5Mi8Ah15d5q04su1NIZGU+Kw0Ist71kRv0UpZMfPSADs0S2QTH99dxy/6nhkk5iPt+Yaqg7xMElFfTrEHpfh3v/u2DJJJvd8ous0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770134462; c=relaxed/simple;
	bh=deO57hxzyS5UzkvPh4r4kvjZmU6hULG6xhnk9q4NzV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGq/dcqAbCxBmRBG21vHM1SWIdu6EKOF82aKVFA4N/YdUBAPgf7sDBFZWSsWSOt+9IMVO33q367K/u+Y6sOnY9C2kDjdTT+bkiV0xN9iqRmJ7a1EljYaYlL4/yMXtK9qoRf2YIgmEGwIt89wcWanINus6kqJ+ChvdgloOJrzWPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ8ZUjAh; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ8ZUjAh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee0291921so55699935e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Feb 2026 08:01:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770134459; cv=none;
        d=google.com; s=arc-20240605;
        b=KJ8NHjeX/X7UCosRsSPqXV2QNYVichBIuQNQky29ieaptK5ZxGvqfDUaK0tPUW1RfI
         rexQg0zoxPfW1ffveVYnAS2Bd3AnKboqki9cttJMq6aCMhD2rhyDXLtKpdGVR8quc5oQ
         wiGIEn1NkR8gx10HjfeuUfy2huRtvXk24+vpOFkVNzhIgRKzI/gJF1MrSX/6mnYsBgjt
         +vsE2m+VwJ83d/snhfIDqf/V135Le4904a/8TK27/R7d4kx2rNBAJQBQPXP+xVp0doDS
         J3hXpp8nxICIfF7Ipi87DMqzJPCyCwJ2/JpN+Aueay1KpQAbEg7oqJLXY7tsD/JiBsyD
         Oz5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A0rdFZkSZwICcKcvSlfIIEDfERHEMj/nUefLkALNSBg=;
        fh=8yYZnn4ZZsJLsFWps0UE0SG+ZtNpUFqQ7ed1VA36wsY=;
        b=SbNh4hX1SmrsiYOYVWMbVL4Ycm9dcbfnUOep3O5oG4ub1aDThqPByu9k8a+5Ln/+4W
         hWKmKtk/2QqZfSstfyNGA7fzswAjpB+78gMukWT44ZCn+hwWEDr7LyHBB1dEE2YsHD6i
         6DDIkjpNCeKQUFMVtya8U7Lraq4mcDS/oZTA+4Sg7TIpzqnwuQGlhmLWdPw1LOMiujHH
         GmVQz1hW1vpUNbzLzfzbXT8ozmNqGPEZRnbnQroe0ooZacew/xQ8VFX5MS4yQgJta8m3
         SG4N4kbMakGPj2UBywm4OTJ5vRufEIoPAqMWbl61tDe3FInrdDMeXhrTSj5D6b/coB3Q
         zvog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770134459; x=1770739259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0rdFZkSZwICcKcvSlfIIEDfERHEMj/nUefLkALNSBg=;
        b=nJ8ZUjAhc6eyDne25zx7/5W93JUZhndR2w7dRdvcwKJ20B2SZTtJsT3anhwAUAJY1Y
         GKHyuGWhVkkxs8vO6/apwmn7lgHC4dAPihLNgQ+vC8RxF4OKpqDoS47K0MgWtwSfw6G6
         7Lzn38y3HWegvH1M696KA1i5NKKW54nfXOE4JErIC+dwESBKMbkN+7QlAARvXe3UwjTv
         aZJh668ldT7M9WNPL/PHnk77HGZyj3WbRgYtZP6DUuLD1pNkjOeBwxUajylodKmpMdsD
         33K7msICw5VnXr9rbYEr2pbPyXXqb+kgH94YAsLC2dxLJLfSB+xOC9xlDz85E/uy0TIi
         NIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770134459; x=1770739259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A0rdFZkSZwICcKcvSlfIIEDfERHEMj/nUefLkALNSBg=;
        b=vPxdSXj0KqUIULQnimxGm63SebXpZ2wl7C8/I1EEqFtNJgPkIb5g1VI4Apisd/WpjL
         pcDOThnYBkIWrPVLjCoPrrA4KST39S6QjCGCa2TU2WPZ9VOXlhigRbNP5WDfQ9dp8JMr
         q6w2leCYPQlL9Ar52YKqgprayMWgsurvi7Tz6BsVLdqZ/mrMLVJxQO0ZWQY30UmqE74j
         aZoEEncinODtO6eC7PFcjwuUmRKLOaaEO1+9+BI+H4DFGgDovrA6Z670RbC1LeNt97/O
         s+Id4FrFkUTlYdeNYGS561cOXsRGC4/jX04cC8V0pUWyNXqQmh23SI0kDXtzrbB3Wx8z
         SJhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqFNpE9+eE10Dy9M3ufCxIZET7G/xGZKxtOfRDdSRXKXffUGFi8K/sO5yAT8ivNoCPGg14jBV/0Out2USx47l9xaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5qLXN0YOlqSF6sgIVG7y9J0zWxjfeFGB0FNehRBx+dhHlbCYy
	eVTNzNvqGem4vuMaHILoa8n4eJsQbPrkve1hiOoFMkjywHY8fDJSw5C0ssBZ5/sgDKc+yWtDf4q
	+G1KHtApeqBV24odW2zmzHOqp8VsqIes=
X-Gm-Gg: AZuq6aJosSVNvnhY0dUTIEU9ySIU5ncVg09tBaCLFtDZ5xCYgRPAqs8zwdsyazg0tpF
	G/QQsMlPNEg1otYSr6/4X4Mv+gQB7UonYPJMoTnixcsIghyEj3Utmk/0NjCra03X0p9tAhDHqmj
	I3wTQ4BLVsiDrQ3ajjBcJGijc6j1L/UYdKhxsM/gXvoO3d3rDWXqdw+zAj21CwOKNnZZMhrkaVc
	KiIqpvlJEDLwE40DBXIrhowV6YO6GGw/4cN8+aGpCrIMDtbQ2Uav/aplOXZzYAmfYqH7IvZ3iYg
	HYUL/xtN2BNz1Q9tzLusV+uT0Sh0SoX6ytXn/KOA1eO4H2mOfInVsuf8QdKKnt5yC7oabA==
X-Received: by 2002:a05:600c:34d5:b0:47a:81b7:9a20 with SMTP id
 5b1f17b1804b1-4830e930f67mr1621525e9.9.1770134459065; Tue, 03 Feb 2026
 08:00:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
 <20260202111548.3555306-3-dolinux.peng@gmail.com> <20260202111249.649ac338@gandalf.local.home>
 <CAErzpmuFQqT3+7cSjq4HrYj0Bp_qjagJSh313_ePJxs+0QjVFA@mail.gmail.com>
 <CAErzpmvgR7QgUTkcEfYstci9wNfGZBksczbkMv5w0ijoUcsBwg@mail.gmail.com> <20260203101707.52965eb0@gandalf.local.home>
In-Reply-To: <20260203101707.52965eb0@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Feb 2026 08:00:45 -0800
X-Gm-Features: AZwV_Qgsf-FoXB1pc5mel06UTxL9uWyAFVjyhN8Kz0H72J6ymSV25GKNwS9ieHQ
Message-ID: <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Donglin Peng <pengdonglin@xiaomi.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue, 3 Feb 2026 21:50:47 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > Testing revealed that sorting within resolve_btfids introduces issues w=
ith
> > btf__dedup. Therefore, I plan to move the sorting logic directly into
> > btf__add_enum_value and btf__add_enum64_value in libbpf, which are
> > invoked by pahole. However, it means that we need a newer pahole
> > version.
>
> Sorting isn't a requirement just something I wanted to bring up. If it's
> too complex and doesn't achieve much benefit then let's not do it.
>
> My worry is because "cat trace" takes quite a long time just reading the
> BTF arguments. I'm worried it will just get worse with enums as well.
>
> I have trace-cmd reading BTF now (just haven't officially released it) an=
d
> doing an extract and reading the trace.dat file is much faster than readi=
ng
> the trace file with arguments. I'll need to implement the enum logic too =
in
> libtraceevent.

If you mean to do pretty printing of the trace in user space then +1 from m=
e.

I don't like sorting enums either in resolve_btfid, pahole or kernel.
Sorted BTF by name was ok, since it doesn't change original semantics.
While sorting enums by value gets us to the grey zone where
the sequence of enum names in vmlinux.h becomes different than in dwarf.

Also id->name mapping in general is not precise.
There is no requirement for enums to be unique.
Just grabbing the first one:
ATA_PIO0 =3D 1,
ATA_PIO1 =3D 3,
ATA_PIO2 =3D 7,
ATA_UDMA0 =3D 1,
ATA_UDMA1 =3D 3,
ATA_UDMA2 =3D 7,
ATA_ID_CYLS =3D 1,
ATA_ID_HEADS =3D 3,
SCR_ERROR =3D 1,
SCR_CONTROL =3D 2,
SCR_ACTIVE =3D 3,

All these names are part of the same enum type.
Which one to print? First one?

another example:
enum {
        BPF_LOCAL_STORAGE_GET_F_CREATE =3D 1,
        BPF_SK_STORAGE_GET_F_CREATE =3D 1,
};

and another:
enum {
        BPF_SKB_TSTAMP_UNSPEC =3D 0,
        BPF_SKB_TSTAMP_DELIVERY_MONO =3D 1,
        BPF_SKB_CLOCK_REALTIME =3D 0,
        BPF_SKB_CLOCK_MONOTONIC =3D 1,
        BPF_SKB_CLOCK_TAI =3D 2,
};

I'd rather not print any and keep it integer only.

pw-bot: cr
