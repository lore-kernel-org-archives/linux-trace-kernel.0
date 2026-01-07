Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86014342535
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767814878; cv=pass; b=Pthe6sXKVUypAIe5K3TJRy82tL4IBbPnk1afRbacEhCMvmLxy/wjoDNyH1YN84T6vcbgHp6SrreERt1qi1cBpsWBlraEph52X3iutkGn3mlrauMOt0F0oLSNVF5pHe/MGez20HnnLXPgMTkYusgbzWbIkE17o/QRC+JudjWzgm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767814878; c=relaxed/simple;
	bh=TpN8Zjk+h7CJ6Zu9Qxqi67BnmexDNcacWFAjViisUqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfdZA+2OGB10DxMYbRiU7iwkVArV+Lt2VzrxDuwRyLfSUsEoityOoBmJyMeaFw9qLXrVelEYbeSwdJi8+MkvhDekO+7pkrIbL0YY4p7trNMRH4AcLiLddHRVKaVpyFiZ7pDaS+pLQWpK5A1wJ+lNNRbRZOp8pieQ/jhKkA44Hog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYSrEE0e; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYSrEE0e"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a1462573caso106135ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 11:41:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767814863; cv=none;
        d=google.com; s=arc-20240605;
        b=GWxDC/L7ps6Q1ICKanhvivaGtsJJK99KRsZ5fIeNoDYVH9wEQWqa9iC6EoLGqv+y4J
         8R+AAE54I094V7NZWbxCbWXgewWaddDY/hA4fOuSrL5mzuRFp3xhufTkjcHZZ1YYMcWN
         bwYYVGMtcIf2esZoOCPuT+8w4n7BLEwFWKzW4VV5Xx0clURvjzHZ4eYqF+/U4UYwbnnD
         r7EEpiViPtdKqzSmn5QJnv6Gd2C0WN6n57p1NzkAVUfXZ9Pqv9aSHeMpK4yuhVaGakXD
         lJAzwMkxVqGDHU2Nu7ZwkA4KzRAecmN5N784cnsh1h3DNmRmatzHu4rrnp3iorYIw+Et
         0jkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pXOIkoAttt+RmvGHLzFYY/zz91VQQIZitq/RcPyFzpg=;
        fh=LAqQV7uWcdkpivgaR64n+5f6rh74H/hp02C3/D1Jye8=;
        b=ip7samrcAZiX3WJUt249zu/YY3CAAzCAty/tmK2vFlCxxy3Dw1g3NfXhs5Ofy2O4ST
         DerlDUV26RJumkuQmhexihUJhGfY9WYI9ttyp1z3HaM0fG1QsqJ+mZz+IfKkSPSyKjk0
         4HJRIbo8fGgUy0WTq2IrENLOgWqVuNzwHD4tNELl6lxEefLYYyuHw1quIDuXPqsQxxBE
         h3vGMUlBms9UcscT4BKdpXCgZUtGux3S0oI35qrIatbUojA+eHM31zifX2aEgJMPQPdJ
         BqfUIexKK3Nwa5guLe+IxmrPj/DAAx9r0dvd70NWaJF7uem5cOMvuatzzUvRAQodMy4l
         DKiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767814863; x=1768419663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXOIkoAttt+RmvGHLzFYY/zz91VQQIZitq/RcPyFzpg=;
        b=RYSrEE0ed9RXQs39JptXhhGVyKbA0iNdlhyeR3znGMM+GMnv0eapbCIJ6FNbOfUGPw
         WT4mCyrBGYExWqAbgHoPd7XEGPeifWLJCITeaQk7Zg/AEWYV6UY5SEheFX0A2yUl1X05
         W8rv0CQ1O6loStRhl7ujM7dgxvb5LZMGPkiASpU4OHfyjcgWfKabeX8LX7E8vp2VyUKy
         R/KWREARGcTf4NcGIV9vLEWeiY5J8lMGoNMlwBrN+ft4yhT/zohsOW4TQlb+8RWE+sLE
         jcAedVSPMPKSMw6W4nK0yibZAwu3Gi6r9jfX2k/OQsUbhse77PEi0gc3gszNyIt58RqG
         tv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767814863; x=1768419663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pXOIkoAttt+RmvGHLzFYY/zz91VQQIZitq/RcPyFzpg=;
        b=A6y+6Ie4a3gac2IZY8okowlqc67gClGhIEES9wMahQIpGPrMlcvFQ8ydpbjIfFD9Oh
         gcLworCX0R5DV11KD0SpglfJck2aisbYtQA0tQMavmIlIfIvCfSDDmb7c3BFE+H90NHX
         JO9V0kHGVB4ZbOGE4/MxYx/zTgyxjDlLFUDfwbtWIdL7ZsCVCwLoCn1/x6FT394rFuRs
         6VGkeK18PJJSwcSazX/8SUY8TUU9/geVhwkp7Y+inv9txsNoqXIJrnA7rMwjIC3ItIz/
         W3oKFV/1jbd2U9Ap7HaDJBccT+85qQApxTlnYKKBxucGEppSEZiCRSDXsjl37ONYuaIM
         XS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoVhA4F97NIQakSyHca/9wpFcxbuVZUExDvssbgxyZp5GkC7abt0HFMOchGYOYwZYNVSo3316374MxrX43Gg3x4hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwzgupv7Hwun+8ynOjrMklIopNnEkRx6MVH3GIulLcKL4EHx28
	WeJgytTkUoNcHcfL+DDNaNO66l5qBWDX9lbrstirapZtLdh62bL8FFgKRn932LwDJ9EEi+j0uA9
	3FbdBnnXTUn4e+TilSC6YiIOhXYfbj+BSRdMLogfBsGGZ4CDcMh2JrZyW
X-Gm-Gg: AY/fxX6nfuz8hTpWXf/aJvrnZ0/WJVo7CDY1xHSQivoH1DW1dhxRT6xizbVF/oYJ5/L
	NXyRGQxYUSQSwo5hCp6Q6VFEw1EC+G2itTRo8wQnu0qihYBJ1lt3kry0v/wv0TT2vlJw9dOr94b
	OUVD5GUwdCdWB17ZkdS9kMTVI83XYeck9K3yefkRxqVUH1uzzmL6PolR0KX6fg32UICsGCVpDln
	M+omR+PTEnYBltyJlWcIi1Dmtsp9C1FNt7YlfIngxRd0D0TCRBPUFXbUoN2NFrYsJCUM6x5dtDD
	Fgn83n6aFYZ9/CtCn2K/t5Vl
X-Received: by 2002:a17:903:11c5:b0:290:dd42:eb5f with SMTP id
 d9443c01a7336-2a3edbc4be8mr3343195ad.12.1767814862920; Wed, 07 Jan 2026
 11:41:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209224024.2322124-1-irogers@google.com> <20251209213135.13eb68f4@fedora>
 <20260107142632.0dec5b10@gandalf.local.home>
In-Reply-To: <20260107142632.0dec5b10@gandalf.local.home>
From: Ian Rogers <irogers@google.com>
Date: Wed, 7 Jan 2026 11:40:51 -0800
X-Gm-Features: AQt7F2r0mVUR27ijmsN2bSD6wiQNZSosXf6I2JvH_6Vt_V2udN5qfKo82In8gdw
Message-ID: <CAP-5=fUYEDqCUhc+SNpowxJWL4HSV=juxnxNqcZ8mPiPT=SHRg@mail.gmail.com>
Subject: Re: [PATCH v1] tracing: Avoid possible signed 64-bit truncation
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 11:26=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 9 Dec 2025 21:31:35 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > ---
> > >  kernel/trace/trace.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > > index d1e527cf2aae..e6a80cbe9326 100644
> > > --- a/kernel/trace/trace.c
> > > +++ b/kernel/trace/trace.c
> > > @@ -6057,8 +6057,10 @@ static int cmp_mod_entry(const void *key, cons=
t void *pivot)
> > >
> > >     if (addr >=3D ent[0].mod_addr && addr < ent[1].mod_addr)
> > >             return 0;
> > > +   else if (addr > ent->mod_addr)
> > > +           return 1;
> > >     else
> > > -           return addr - ent->mod_addr;
> > > +           return -1;
> >
> > Could we still keep this down to a single if check?
> >
> >       if (addr < ent->mod_addr)
> >               return -1;
> >
> >       return addr >=3D ent[1].mod_addr;
>
> Care to send a v2?

Will do, sorry for the delay.

Ian

> -- Steve
