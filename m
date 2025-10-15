Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A92F6176
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760490782; cv=none; b=Wdpdqxa5g0LahWOjsm9o9XhGyqtTegxcUjXvWlGy51TyLr43WpoqzBJ5e7QITLhksotwbgDKK0RtCp1Seoax/CPoQ7Yu8OJxoo6e2kk4HeC1umtARV49+bFN892jskZvPm7x6y4jhIkZU/gsfKjsvP6rZ/zPejAUMPs82BgS4/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760490782; c=relaxed/simple;
	bh=5W2+85pd06ZV1M+prtFXZf89M0U1ODNJHDrAbYVfZbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KalsxMaqrqdNg5fEF9o6ckM3QkYxFTpA8UpP5OVVv0nXZu/cQoKGzGGhz1j2WkTXwkK3g4m+xGs4noU+WBanIojKzdx7S8OHbULYVTDHLgOKzW21Mk3tPEqpjm3bYgY0PU/HBSqKW5X3lkud0BDdwh8tdPpYlAm6Bdty+kTKd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FSbdghoN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSbdghoN"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-639102bba31so3361857a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760490779; x=1761095579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIFg9Y651C6jYHMRNt/SIA9hUcF2F84+cqC9exRdD80=;
        b=FSbdghoNHTUpCFOAMeJqrcZqqJDgr9P1/ErK4bPUmj01c9dLJPOWedDg8DQQnsqpwd
         Kz8riTAL5TbjEWkDHmsqw9CL922KYh4POKILk3Laraycb9/+0Cf/sg3IbhypxKXorpmb
         vJ9Lo8QwghHDO0j/vy9nzAO8WvPpwi8BcMLcj4fa60FP8enUP3RgDaN+azHSRTddS3nl
         Y+coSrkz7GpE+oQl+MIOOtebmgH7Vvpn/FdWjRdlJogrZ+bo+Pt7iWqvSMjfuVU5rzMf
         +7M2K82tngIJLbhNO3/32pevBDfwO9tfuf9stJhHc/M5R8yresTwewLaiA6aFmNe7sS5
         li8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760490779; x=1761095579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIFg9Y651C6jYHMRNt/SIA9hUcF2F84+cqC9exRdD80=;
        b=ZmjwNZIryfJbbYzCFlAbfaHf7CtNr7sLy9jofNKmTyJ1niBvWoHiLAcESSx11Oi/iI
         Pqdop1tsrs6BUvYm+L970z7TgUlVzLunP9QitjkW4VioGhftbJZqk1W+N8rVuCHTWFRw
         KnoytDhHk4vGDADaodbGfdLhr+j4tQNLsVmRlzwcjt+7GwBwj1s0shDnCmJqYl2RyjIv
         F7rd0srp7gbUqp3kZvWJJuPnVABKzPTOfi40N0XdkYL2RDh0hJB54CWhqgYYkk9j6IXG
         pJQkNhdwZdSvszguFNRSUpILsMlizTh4FMugv9oAq1amnpok2xXDkIjLSngEy3lkdFCr
         WjOw==
X-Forwarded-Encrypted: i=1; AJvYcCWS7rYy8rMkyNrdNjGlJ46jKaXIY8zgYisTtiAs6reIKc91sG30faD7EjzPc7vNPSoMYEgnWhEpaf5CKqoRffHHZAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMMjlDYFyZYGCWZ0jhmngsAPCTzD3prG3zqQLYOoXl5PfJ6EMM
	Ef8VREZG+++D+JUuM0UUmuw+vNsT5776h+sXyE3xgkpfNCDYPJqf6bPtVICtcR3x3op84mAVRIy
	HkNyZouMtGWVgnNvJfz/Th4AcHxp/UZs=
X-Gm-Gg: ASbGncumxJEBCGVKbofNc88hhRM8RCRcRguY4j78PSUbGg1KFaLltUkbulsoqtYH831
	4gPYdIPCSh/TVnJ4tQNG9IrWrenS6a/avCMNW+lorAy/ZRzWQ0S2yhGtrf4S8akl4+FEvooeGvL
	VRqwRzMxUR9BIEqhnJMgHRuSDq0gtCD/E16ZCQBhJF6Mdm/VweJ1Km4bgBgGkbCgi5iJwOipvdd
	4dC5DOstdGOSzl1a1vYjEZS4Kw+QijQ8u2RlWWPr8tg3yjr
X-Google-Smtp-Source: AGHT+IEMqjPapD9eRQP/uxVQXUUIw7oKODkqd8+sXPMIUZbAd8hTgbXCVRklJtg/rXMz7OFgPnLe7Y2s5OJF7DIXxLc=
X-Received: by 2002:a05:6402:13d1:b0:626:4774:2420 with SMTP id
 4fb4d7f45d1cf-639d5c320c0mr24548232a12.20.1760490778582; Tue, 14 Oct 2025
 18:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
 <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
 <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com>
 <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com>
 <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com> <7f770a27-6ca6-463f-9145-5c795e0b3f40@oracle.com>
In-Reply-To: <7f770a27-6ca6-463f-9145-5c795e0b3f40@oracle.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 15 Oct 2025 09:12:47 +0800
X-Gm-Features: AS18NWC2l2vIG6SIpnIJhDffpTLpm2QvUXu3kXYxlJNoEm_ngJOG4oOMkQlG3Ic
Message-ID: <CAErzpmvKtM5Abb9jKUg4KV0zwOpJL5Yy4nWEnxUpjRFUeeci3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 4:06=E2=80=AFPM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 14/10/2025 05:53, Donglin Peng wrote:
> > On Tue, Oct 14, 2025 at 10:48=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Mon, Oct 13, 2025 at 6:54=E2=80=AFPM Donglin Peng <dolinux.peng@gma=
il.com> wrote:
> >>>
> >>> On Tue, Oct 14, 2025 at 8:22=E2=80=AFAM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>>
> >>>> On Mon, Oct 13, 2025 at 5:15=E2=80=AFPM Andrii Nakryiko
> >>>> <andrii.nakryiko@gmail.com> wrote:
> >>>>>
> >>>>> On Mon, Oct 13, 2025 at 4:53=E2=80=AFPM Alexei Starovoitov
> >>>>> <alexei.starovoitov@gmail.com> wrote:
> >>>>>>
> >>>>>> On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> >>>>>> <andrii.nakryiko@gmail.com> wrote:
> >>>>>>>
> >>>>>>> Just a few observations (if we decide to do the sorting of BTF by=
 name
> >>>>>>> in the kernel):
> >>>>>>
> >>>>>> iirc we discussed it in the past and decided to do sorting in paho=
le
> >>>>>> and let the kernel verify whether it's sorted or not.
> >>>>>> Then no extra memory is needed.
> >>>>>> Or was that idea discarded for some reason?
> >>>>>
> >>>>> Don't really remember at this point, tbh. Pre-sorting should work
> >>>>> (though I'd argue that then we should only sort by name to make thi=
s
> >>>>> sorting universally useful, doing linear search over kinds is fast,
> >>>>> IMO). Pre-sorting won't work for program BTFs, don't know how
> >>>>> important that is. This indexing on demand approach would be
> >>>>> universal. =C2=AF\_(=E3=83=84)_/=C2=AF
> >>>>>
> >>>>> Overall, paying 300KB for sorted index for vmlinux BTF for cases wh=
ere
> >>>>> we repeatedly need this seems ok to me, tbh.
> >>>>
> >>>> If pahole sorting works I don't see why consuming even 300k is ok.
> >>>> kallsyms are sorted during the build too.
> >>>
> >>> Thanks. We did discuss pre-sorting in pahole in the threads:
> >>>
> >>> https://lore.kernel.org/all/CAADnVQLMHUNE95eBXdy6=3D+gHoFHRsihmQ75GZv=
Gy-hSuHoaT5A@mail.gmail.com/
> >>> https://lore.kernel.org/all/CAEf4BzaXHrjoEWmEcvK62bqKuT3de__+juvGctR3=
=3De8avRWpMQ@mail.gmail.com/
> >>>
> >>> However, since that approach depends on newer pahole features and
> >>> btf_find_by_name_kind is already being called quite frequently, I sug=
gest
> >>> we first implement sorting within the kernel, and subsequently add pr=
e-sorting
> >>> support in pahole.
> >>
> >> and then what? Remove it from the kernel when pahole is newer?
> >> I'd rather not do this churn in the first place.
> >
> > Apologies for the formatting issues in my previous email=E2=80=94sendin=
g this again
> >  for clarity.
> >
> > Thank you for your feedback. Your concerns are completely valid.
> >
> > I=E2=80=99d like to suggest a dual-mechanism approach:
> > 1. If BTF is generated by a newer pahole (with pre-sorting support), th=
e
> >     kernel would use the pre-sorted data directly.
> > 2. For BTF from older pahole versions, the kernel would handle sorting
> >     at load time or later.
> >
> > This would provide performance benefits immediately while preserving
> >  backward compatibility. The kernel-side sorting would remain intact
> > moving forward, avoiding future churn.
> >
>
> If you're taking the approach of doing both - which is best I think -
> I'd suggest it might be helpful to look at the bpf_relocate.c code; it's
> shared between libbpf and kernel, so you could potentially add shared
> code to do sorting in libbpf (which pahole would use) and the kernel
> would use too; this would help ensure the behaviour is identical.
>
> Maybe for pahole/libbpf sorting could be done via a new BTF dedup()
> option, since dedup is the time we finalize the BTF representation?

Thanks for the suggestion. I'll look into that.
>
> Alan
