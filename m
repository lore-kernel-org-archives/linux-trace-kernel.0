Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB825FA29
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778614731; cv=pass; b=E20muJtsvVLoGaJGiP1ApOwc28H/0zW3EC8oUKIZZddCWH7y3S9ju/u6z5m9DKC3wEsznoxEsd/m3r5peVxy0/FyfXH8MzEtDLDoWkg3+6G6eGDcOQajObdSxPZVUkwOHRcjw9RC0Xs3zS85tRrUh/sGEuklpSeCYP7k0sqdcBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778614731; c=relaxed/simple;
	bh=z/n4l+tnD0xY6u8oFv5FhpmWDe1bwms0P4exdidL/5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7hGfAalo+pSCgdr4CDfeNkearjA63T3r9P0dHi6yHiiT+a4LKxN7+I8OHWeuoe92hqY0YLOKj6oJ6jXhCKHGMEJ5383lrcO+CFgBKy9T5gZr7hpVJblI/N31kFbhZ8EJAJz99vFvV7vdSVmzwcb7v0kaMiCoEh16O0sssZ3eA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXxcKabm; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXxcKabm"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3667cf0136fso4137816a91.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 12:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778614729; cv=none;
        d=google.com; s=arc-20240605;
        b=CSPS6g6G1wxJmVn+7l4Lk3soO1rllpwdHUCkUpfNk6lvYYFXwXaeDokxpFOIXP9Jfp
         VdIOxzotUcTkhAhzx934Sh6uzvw+vPidqsPMwNZia/LuONWNJMVxA2FBUKZ1UPuhlYfo
         CQvyJwfi38Hye2KWvmsp9YWonLeyKmCKfHOZsZoMEEwAIvsuYzi5XXzKW0L+31PZQKBR
         y9l839p/d2Qh/0N5/SAA4rOy2STf/52YzBiInD55lIiWlKAOwrO684IG5RDEeq2V1mbb
         YejcVOJgU3s2X/wJQ0nXOIBYIvnZfT41IgtUDXMH7OUP6oAtiiVhHLDIioXNU4d3abbW
         wTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lV5/9Lh09aeZxFXscjoWXpJTticrrygDaBuVo3TZXZU=;
        fh=y5YtdRBtTVEN5p4u5TUncgqe8FCFbPFNQ2b2PC55FKg=;
        b=eSpl9AK+Q1RDBADezG3q8LDaeFCspcR8UI6Zg9qvrYUJONswgdM9V8bN8aNihvJDF6
         QvtYoDgN4MDFaSDK6bfbITBoxWLu5deXOINfuf1S7PFbyC6y1W/9fDvkMvig/u712tla
         /KJGDoG0OxNSWlltTC1JqAZi+KhCZn8sOyzrVbPav5q7JILI96mTi04OuAos82kE4U3e
         D9kaipfjHQrbZ/UkGzVJm14xqsfb+ru8DkUU/un0oWaKC14LcmjXyKQEhAQvY0wKhTMe
         eGMRN+yZxeLC2aJrNLXeYTQ9zSZ98HDHW/ixyupqi53J1O1yZ430A6jpbunS0tQXtI9E
         MXdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778614729; x=1779219529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV5/9Lh09aeZxFXscjoWXpJTticrrygDaBuVo3TZXZU=;
        b=VXxcKabmkhYf/D8c646ZYuaq+gg5ofk/6I6DclgC0KbsaFaV+gUajmQega5u3MRTe2
         TophAmO94DYOaU0e8YVdlZ3znf+KXvuc5SfH2Qc8Q+8KV446Jg9onRo+89D0uW3pKAua
         jYzn5cKQA1mhR8Lk+2vEtJTFUFXOBYiASP6NCXakSVb9lshNKaqDi3h1oCaKt3GL8yGY
         OG+o6Gl3DMG/0A3pAsVgfoBkbVDeqj3Tvr9GKqqDXw46lKUOiO9Y2VHGt9s+TF0xjNJk
         LOKvaHgZiIld/0Q3pA435P2i//kVbprtzw50LLVzGQFYczrPlUZ4vdaJpXqSTercn2J+
         v6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778614729; x=1779219529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lV5/9Lh09aeZxFXscjoWXpJTticrrygDaBuVo3TZXZU=;
        b=Xl7Hi1ZnZdjUKc2GsKP539pKLHEzePDcn2g1EAGEHVvYb9xaF+Nsb9iBdAvc6Z5ima
         flm+54SY77GWldqU36n7em0bxhz6gIz9Crp92nwLTMvfOEwBpqGQie6oJv9cKBtv3IUg
         vxbvsg9oyLL63kj5fnqWuPJ8uz4lPxrd2s/SlRuqEME8aRgNYeFRFayVXHdtcf4bFwuC
         RYf5c0UjK40TZKmrX9RF0uVJDOSpLO8byNaualmoJ3LSvG2HYa0uIMUhhG5k3GzeBKmC
         AoV3r4T7yVsmRhdEC4MdVyOssQoImpiDyz5iyyU7WDWZxb9+PpsqIFUGj8dT1OinFyM2
         f/aA==
X-Forwarded-Encrypted: i=1; AFNElJ8S7IMC4cyFu1w6Im/VxrXIuJVfZ/FwA79bcYOzjyMAtzhNjQALvifauoCkdWhEcJvzo1cpo9QNbB0v6jZKloTFHSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuQyLh1QGqZnGmWJY4xFEMnLKSjDo9FP34lUwQGMeVxNoDcLYy
	Y07J2uizxWFGZtlqGq/2eEpjI+41p8vbyyc6pX7PMc6SGvQjb+Q87bA+Qr3mDlnVVizwGAmS9AK
	uWN4Q1dOdtmmQj1cWUkXwI1kI+CjhFtU=
X-Gm-Gg: Acq92OHnryxKE+YnDcTNNVG9Ug3MDZrcMfbeRsBTg4VhxCh4F05uxqqMNYmgP5SSnvQ
	yMtHNqPpy7c0UDpHO175yQwdSuxHo0N4oRTmOLcy/koMtOgKlngYSrmQEJOWWq+0sMuMaCRC/5k
	nnjm4sv9yo6965trrJ2Ud91rlMaJADcfO5bVITGfHDN5LI3ephJYLXjKGTR4VrX/qgwrXDAgXK/
	0gLEWum2+8kdlwYU9KWo46zNEaY9QDqk3vgHcv3YgUoy+EPj8NTuii/8Lh4nLmmwOSj8DyExGDU
	/OwVSNOSJxOuacFrolQ4ftg=
X-Received: by 2002:a17:90b:4983:b0:368:147b:536c with SMTP id
 98e67ed59e1d1-368f3d183femr373798a91.13.1778614729550; Tue, 12 May 2026
 12:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509003146.976844-1-andrii@kernel.org> <agD3xq2MUyskd7X-@krava>
 <20260512141431.a70375744fdae263bda5b722@kernel.org> <agNeEzjiThzmJHiP@krava> <CAADnVQLfgxEzpSTLhsxN2BYWpSxJ+RYku03UMfrSTi4Abu5SBw@mail.gmail.com>
In-Reply-To: <CAADnVQLfgxEzpSTLhsxN2BYWpSxJ+RYku03UMfrSTi4Abu5SBw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 May 2026 12:38:34 -0700
X-Gm-Features: AVHnY4KOZOgesKLsiEao1QlpFEyAIoutj7tuM-2Hyb1lGjbSX6Zp8KuwqBV9yV8
Message-ID: <CAEf4Bza4sqLw8GHoq+MFBgsnhiJ_s91UUrMcA-paYeBr7=bz0A@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5 optimization
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 12:27=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 12, 2026 at 10:07=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> >
> > +       /*
> > +        * We have nop10 (with first byte overwritten to int3),
> > +        * change it to:
> > +        *   lea 0x80(%rsp), %rsp
> > +        *   call tramp
> > +        *
> > +        * The first lea instruction skips the stack redzone so the cal=
l
> > +        * instruction can safely push return address on stack.
> > +        */
>
> typo: lea -128(%rsp), %rsp
>
> you can also do:
>
> add $-128, %rsp + call tramp =3D 4 + 5 =3D 9 bytes instead of 10.

When I asked AI about this it explained that add instruction modifies
flags, so it's not a good fit here. lea doesn't touch flags.

>
> Initially I didn't like this approach, since we just introduced
> usdt nop5 and now need to recompile everything again,
> but looking at the fix it's definitely simpler than alternatives
> and doesn't have annoying limitations.


yeah, limitations are annoying, especially with those global "DO NOT
OPTIMIZE" flags... Jiri, let's polish your version and land it?
