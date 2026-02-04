Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFC227F749
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216745; cv=pass; b=UeA4IwUSh6ocvwIYJg1U+hEOPmMBZwuEG8SH8/dcuSq0kaEp1Pv9W5go44cNXGL+zTsGAPTw0/nvZ1tHzw4qrWx/g83xZb5+pNSotqjS6X9yy5g9bKWYj1PJTR0FZGjjNAS2S1Bh5F/jBPRwtds3SSzKoppVbuSc1mnr3Qc99eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216745; c=relaxed/simple;
	bh=vAPrTpVvtjDoYqyCk5qlFEtzMqAPTstr/NkSMREnjU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qiu0au5pF38ZBfP5WWAWyyxLSh02wXVB6NL8mc8GoD44MpmMKn9gh8UPVNWtQozVrh3MHpivN/xpRGoTe9+vDiWCuc6qTxvp42OKuBjODC7Z8ib7tUBFBPCcIS3N+L/Nf63fSQ1z32gKqB5zHVBCxHfMkkMWbNUFOHUU+aoz5wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmmCkk8i; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmmCkk8i"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8838339fc6so206279966b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 06:52:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770216743; cv=none;
        d=google.com; s=arc-20240605;
        b=W1wiJwSkUCTBYKmlhnHKCONeblno99zgAbDDdV0cmY6mfuSzvx97yS+AlXQRH4Ojnf
         yt7yBvQwSuQgplc8pHwzo2qiTJOMs2tYkroN/eeJTGgnz/BFd3QnIzh2nN6VSXiBpXuv
         Zbakx7COal+6+L7OKc+xqhCRsAii8pKLplNY8ailbZODXDFJy6X0DNiRkyg2wOqxja42
         lSvlGle3ukosl1ruR/TjakFHzqCrK4hpOAouoWnknyVgzvknGkBJ39qKk/2O5Syn9HY7
         bHjVYokH2wftRVauFGe7TVFzPaO3EP56wfvand5cqV3nVZwiiRZNR3cw2nG4FiLUqJ32
         uxIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7ae/2zsLX1SITkee1l+dAFeZHbUj9ZwEYK3HL0LzMcs=;
        fh=GU45HfFaWEXzwMmCJkZS0KKdcFbguLYYPKnB75tQWVM=;
        b=ljvuGHYifipmU+PTdCjZHtPIcbQIVwUZjbdVXRGr59xywnWLg0LPdT7xsKhz6z9LXy
         0HUV/YTqqsHCdzS+4DUeSO+YTTUM55pPEoG8ac6y9tT98JpJwCl9tWr7G47Fpep/Vx96
         omaedcHVYs5UXk+3Qq0alHZAElliG/2LRNii0Ig8H9egp33qYU92QsAQdkzJr2WadPUR
         Ly+VeltpBXvF4+jjIZGFlYLV6RXlm1nrSCEwAVGh1T+WgYo4+qdjaBoTRQM1SP7c6fza
         +kMAyrxurovkyLBrOaNbVhE8a8MhsfdMmC1lskQn0FN3SfSjui7Twuw/DIDxiSmtBycb
         3clA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770216743; x=1770821543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ae/2zsLX1SITkee1l+dAFeZHbUj9ZwEYK3HL0LzMcs=;
        b=KmmCkk8ilN7MwW1HOtn3JeITxCIHDlsKvKcop8WAgvKvXkoISiw8AP1tLRIaaNeRjs
         7wfS2KxGF4XskI56h18aOdcohK9j5toE3kP3VPzDUDodap4CdfYWQDdxPaIIQJ0YvzIt
         QO9nS6fk/QDd3tWDVIY9R3Uz45GrT49RwHL9V92o81SPiifhjuCiFdhgYGXvbMkL2aCt
         qwTM6D4ONkquVtHlGryMOldmsiZcBZOfA8dWfwYWhfbhfbYRoGRxIPR2UK0UEb+EtNmZ
         UYJcyANj8/0ZoQFR5pJlrF+e5oLG/51ZoFfZYZD/ekiOHRH2aX+SORfVUhaNQ09wveLt
         iR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770216743; x=1770821543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ae/2zsLX1SITkee1l+dAFeZHbUj9ZwEYK3HL0LzMcs=;
        b=niP3Ip1kyDUs6IFwmZuNIzmRGOTaiqFpXcFDfo8aHexN0dyRExpHIP4NoSp7XQ58tc
         KLWcCGB8y3lUaltDAz2pYekV2PoXhf9PgYxNCGmKNsC1QCuqacAEE3Es8sRCO4k0y8FT
         8eAoo3bFKTkChZZhnUTmEkokfsKI27w/hk8tiPnYlp6DSUq5mqMA34VpJitqJiKYAsdD
         VWh0xbfyiwM8LApjlMfCNyfi3LYHucI8Hk4SAyQkUKn3H2n1zEO8VHRbNuERr9qfMxFy
         ED7U8itPdGzakq8hZ2zYlNwKP/m/5cue3/cRfKX786NSUta7joxGozdLjaQVTnejdLpl
         kyhg==
X-Forwarded-Encrypted: i=1; AJvYcCVDmwJaN/Mj2sXJVb5Q1x+yglxESdTav1ebxAYsrvQs/WJo8t9/ANMjLLXgseRDETH9U+5fVl17dMws2zmO/Kn2NME=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+AQC/lUA/lQDKxUTOTCNZ0zOqWXBGzKEKqFytlCB3rte51ZB
	H1AfRPdcCeLD26sEsjQLTJZhfmgbFOA19kUSFfV/tb1Tpw2TN9m5DihJnVZXtBYdIAZnu38KFKH
	IFskGUsnJp4Ds59Xf/Go8W5P856+Ra3Q=
X-Gm-Gg: AZuq6aKf7+hPDSEbAz7wyshJG8trRAEfctcHyVJ9CQ/UYtQWvTk1Od7R5olMoYIpg5w
	5inbfsFo3/Ir0o7HuoODtG1GY5VBc1vRZrEQAoHX6H3b9kN+B+I8RcqtOJ3F6z7OmCeKwLyNZ/P
	mMxHFCYIiNA96OCZ8eU3mjTIW1ADZvrra7w/6WKmWdhbqalrNKwxqTrF9Bvlm7XSwlmVkkUDW0n
	BgVCjmdpzZfboZLmApXEVsyPC7nvikYFIsri5g5GKsQYxZOYGxha5Pv5WL4o7GVnSV6JqDf
X-Received: by 2002:a17:907:72d2:b0:b80:40ea:1d65 with SMTP id
 a640c23a62f3a-b8e9fb81038mr249447766b.31.1770216742630; Wed, 04 Feb 2026
 06:52:22 -0800 (PST)
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
In-Reply-To: <CAADnVQKXMzTsbrD8j0spJETXL77x=r30fEiPQLCiNr=XWtgB+Q@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 4 Feb 2026 22:52:11 +0800
X-Gm-Features: AZwV_QhyUAnBXEaRMJ8cNNq58o_SXW6uwD6sX0x2qOdpKoR92KuetEKRu2ZVyQ8
Message-ID: <CAErzpmu9mNXTOw-WwkSGEdvmJY2VjyUbGWZD=5s6kXNRE_YkJQ@mail.gmail.com>
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

On Wed, Feb 4, 2026 at 12:00=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Feb 3, 2026 at 7:16=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > On Tue, 3 Feb 2026 21:50:47 +0800
> > Donglin Peng <dolinux.peng@gmail.com> wrote:
> >
> > > Testing revealed that sorting within resolve_btfids introduces issues=
 with
> > > btf__dedup. Therefore, I plan to move the sorting logic directly into
> > > btf__add_enum_value and btf__add_enum64_value in libbpf, which are
> > > invoked by pahole. However, it means that we need a newer pahole
> > > version.
> >
> > Sorting isn't a requirement just something I wanted to bring up. If it'=
s
> > too complex and doesn't achieve much benefit then let's not do it.
> >
> > My worry is because "cat trace" takes quite a long time just reading th=
e
> > BTF arguments. I'm worried it will just get worse with enums as well.
> >
> > I have trace-cmd reading BTF now (just haven't officially released it) =
and
> > doing an extract and reading the trace.dat file is much faster than rea=
ding
> > the trace file with arguments. I'll need to implement the enum logic to=
o in
> > libtraceevent.
>
> If you mean to do pretty printing of the trace in user space then +1 from=
 me.
>
> I don't like sorting enums either in resolve_btfid, pahole or kernel.
> Sorted BTF by name was ok, since it doesn't change original semantics.
> While sorting enums by value gets us to the grey zone where
> the sequence of enum names in vmlinux.h becomes different than in dwarf.

Thanks, I agreed.

>
> Also id->name mapping in general is not precise.
> There is no requirement for enums to be unique.
> Just grabbing the first one:
> ATA_PIO0 =3D 1,
> ATA_PIO1 =3D 3,
> ATA_PIO2 =3D 7,
> ATA_UDMA0 =3D 1,
> ATA_UDMA1 =3D 3,
> ATA_UDMA2 =3D 7,
> ATA_ID_CYLS =3D 1,
> ATA_ID_HEADS =3D 3,
> SCR_ERROR =3D 1,
> SCR_CONTROL =3D 2,
> SCR_ACTIVE =3D 3,
>
> All these names are part of the same enum type.
> Which one to print? First one?

I think these cases are not very common and printing the first
one would be helpful enough, and we can add documentation
notes in ftrace to guide users.

>
> another example:
> enum {
>         BPF_LOCAL_STORAGE_GET_F_CREATE =3D 1,
>         BPF_SK_STORAGE_GET_F_CREATE =3D 1,
> };
>
> and another:
> enum {
>         BPF_SKB_TSTAMP_UNSPEC =3D 0,
>         BPF_SKB_TSTAMP_DELIVERY_MONO =3D 1,
>         BPF_SKB_CLOCK_REALTIME =3D 0,
>         BPF_SKB_CLOCK_MONOTONIC =3D 1,
>         BPF_SKB_CLOCK_TAI =3D 2,
> };
>
> I'd rather not print any and keep it integer only.
>
> pw-bot: cr
