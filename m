Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958CCB672
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518587; cv=pass; b=uTLEb6bIoZaxkJyGdLDR/TuhRVeG0PLQwanRxS8X7brpBf/yCqmKOID2qMUt2HkBc4iA1IGx8aa4BNVumZ51vuMpJe0xMgJuy1ib49TExYm/4Y1boobDqqHhuYpG31+8yAF9Kj2xyBHs2xf2dNJD4f0+o/4R1/Kfwt3980pk0Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518587; c=relaxed/simple;
	bh=EIRtWQzGXXHZ8qZiB8cXYpRodTfsTbrOzIV44XAbX5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qT1nCb/OfN2cpZ73PMlJ9k/3EmQ+mA1MJnf+CNqHwXAd59aL4tFSa+oITL5UFNLLqeaPezWbutE62GlTuCy7g0xfOXlzQjyOO8MWP0D1m0adCMxniC3abGTnCmu0CSWEpFyABBQ/LwHy+t3FMmjAnRX5nryC7g56bh/qaY7S1ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpjiwuxS; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpjiwuxS"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bab82d75fdso24712735ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 09:56:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778518586; cv=none;
        d=google.com; s=arc-20240605;
        b=ZT9FQe3qWB/y5jyu2PkxQ2nL7WgVN12DZZePy3nm1lNU94BzhrOl30pWOwjEjahICq
         HPFLAhGuBmFUPpZbV1PKNbHCUbPfBRVA31843SoHnZKeLclUmXj1O6Of59k6S0wDd/4/
         HeH5jyoFr6bjJYgh+xd32LfmbZqQSZevg8UcbBGhR+e8JR0jjOvd5ymFwPRkbgbY92dp
         kk3mVS2qxbQAfHjZVoN3hERWJzxZf+if8nAuMgc17VA3QwaMK2TwQPfXsxQUAOJLv/4C
         kMhUyGDMR3V+VuAAq2JwuFiOkY1zIwpGf+Nvl6Jy6Atjh0PbonAUWXx0r8WSCtvZgN5K
         NoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/0CvEziVo2wtfpfqqcjJyEXvbgqMPtrtrISbGQRY7AY=;
        fh=0iLz0AgeYYgSzn0bUkuRgaxC2R5SYZzEwSpXaU5vAQE=;
        b=JHbCYSN/PaTXTMDg0twio1+SRIYGOUSKeoTxQSLHnxqpFAM82lzc6kOZiDkrOjcpVS
         N98UtahKrO+eyZhdFhDkr8ror6j0/tKIsMJdtfxycGcjo1euHwrFu3YWAmcDx0DnhPnZ
         asCOA7tayspFigq9loEIlTwtjjoQjqKA0p6xoeAhan/vgEIKVzlXINo4ABxbB0wO/Jq7
         neEDyeUJu7SuHP8o/V7+k4FXr/AAIUXk9JyGBOT9LxUVPwf1ahOgVap7K7UfyWPvY9Tw
         Gai0LQTxMfggif4ISdKyOSq4maCkRohVCMMBc4DPSE34hZv76fMRdtH2nyYYtwmOnMWY
         rDOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518586; x=1779123386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0CvEziVo2wtfpfqqcjJyEXvbgqMPtrtrISbGQRY7AY=;
        b=DpjiwuxS+ljDNpIaTdrC8/Qjr4gdOoikid0c6ZlHv9JEkMOd3JIJaNOHIw5B2Shv9R
         ZTqjUkHJubNAs71KM5sHUJ8mtXF5nLC6Am4vdMLPYEK5i0w0qUl7A+xzXxGhzM77XLG0
         Y7iMpG5OGIM8dJe30Ym2gKwEQTdWqDypEW6xdf1x6BGUnzHSBnwtWu/CwXASUS6shuwr
         H5Q/2f/BIdZekcC/Nk0YwWzcXLnKrXy+JfD6N72PzKzuEkESSHdFo/VtIDFGd+lOdsXv
         /ZtzCFwotn8A41g5vXhbnRDWS05p19J5jaDDF+ri1rWk3fD2J7GSHG+cT4ALndCBvuIa
         +omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518586; x=1779123386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/0CvEziVo2wtfpfqqcjJyEXvbgqMPtrtrISbGQRY7AY=;
        b=IRrMMDzP8NdNnhL7QKgWK/2VzTNK+KMl98XKFjEPVEGXxUoDv7w6KoekexFOx/BnKG
         oS4NP8cB9ECuhA1tOjQ/QRnhnIMat72EvCtzCA6E+rHCyGsdBLAZrk3AY/FEbuv44Nlr
         xXA6kZzcAxqDvQ3JJXGrNm825GJJ8Cv68KXdW1XkhKiTLf9JZO56cpCHMMDmJ+suO2Sv
         RO3hM5dt/bYOLukqdVIZRRbRLXlV7c9+QgYFTdTr0B6hkas8CtF4g6EjVoMjur7AcLfj
         M4n0a4g1yzK1vF+/ocMCh+7Tcbs7ScGz4zWhxNflVzjLF9WgfizMbr9oLFL2ZliX56aQ
         I6rA==
X-Forwarded-Encrypted: i=1; AFNElJ+8epQW9Fj8oUYalu7a/Nh3LKvXDAj4QA+4YYXq2DRCOrahr3bZZ2QNxciOPOmFwpGAeBKSyTT+QMV1HXaIzdoEIKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDoeBwgdPn1ZoaM11Z4ZYDfJcL00LNQGl5BqinCbFs0niVMs0J
	iOJdApYTEnaxK1g1KCCIigeN9xVgP1TN2O4BnBHeGQfxVxCe+JwieiC5oZ3UA8oU1/uHux7+OU2
	92cOYJM3pf+45X7GHBRkCFs+DwcT2IC0=
X-Gm-Gg: Acq92OE3nINhOblETxzsZJIPWaD3OMpwOxQG5AB/QDcy8f+X3gfKAWoiygspden7hHf
	ZHegEnZFN+jbbex83Neq5QzKyrBjzYbeqrnUj8bWAI9Qa23xuM99ZpVyAT/TV+yndApBduEqZvl
	fb1IS6sdneM3aaPxavwfX5urwsfMmOjrNUOURYtsVtsgqJkwZ8qkdQz+G/tqhcCCz+qAthUCld1
	SjS2N1lefY7bwnNHK59pFcifxTVGgX5QYfy79JMf2coq02ffzDjUvX8/JT4Q28RDaVAjaFVXB0n
	P9gqaczkQwpljkisnaKBHx4fayh8Izv5fg==
X-Received: by 2002:a17:902:e54d:b0:2b2:5857:583e with SMTP id
 d9443c01a7336-2bc7ac400d7mr112472675ad.31.1778518585881; Mon, 11 May 2026
 09:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509003146.976844-1-andrii@kernel.org> <agHreV1m7MRKUtbh@redhat.com>
In-Reply-To: <agHreV1m7MRKUtbh@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 May 2026 18:56:13 +0200
X-Gm-Features: AVHnY4IdO7unJN91UoR5H_CqGoMmaWgoA533Lznx8M5T4GehEiGBvA85JRGPrqQ
Message-ID: <CAEf4BzZSSsUKGje1mOTOxrRxGfw4sVfyVmKrono1rOdDq1iFHQ@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5 optimization
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, jolsa@kernel.org, peterz@infradead.org, 
	mingo@kernel.org, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 7:45=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 05/08, Andrii Nakryiko wrote:
> >
> > +static bool resolve_uprobe_addr(unsigned long ip, unsigned long *probe=
_addr)
> >  {
> > -     struct vm_area_struct *vma =3D vma_lookup(current->mm, ip);
> > +     struct uprobes_state *state =3D &current->mm->uprobes_state;
>
> it seems that there is a problem, with or without this change...
>
> Lets forget about this patch for the moment, I am still trying to underst=
and it.
>
> What if register_for_each_vma() calls install_breakpoint(vma) and
> vma->mm !=3D current->mm ?
>
> In this case install_breakpoint() path will call __is_optimized() and the=
n
> __in_uprobe_trampoline() which does vma_lookup(current->mm). This looks
> obviously wrong ?
>
> And unless I am totally confused, this patch "inherits" the problem...
>
> No?
>

Yes, sashiko called this out as well. I'm going to pass mm explicitly
into is_optimized and all the way to resolve_uprobe_addr(), easy fix.

But we should have a stand-alone easily backportable fix for this even
without my changes, yes. I can add it as pre-patch or send separately.

> Oleg.
>
