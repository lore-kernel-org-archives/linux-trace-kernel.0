Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEEF30BB89
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417634; cv=none; b=hczg+OODvC11v1g3D8RFsNMRFQU6h2a7KgKP0F/R8tUo28cuJKFgW0RggGcwgiTBvrM3eXF0ftOMf3dv0WBy7GGPPw0sLDBRR5pcshBZHD4YbJn3678o5mU56iX1y+T8fE6OUBeH6/yej6681Q81jai9+vpxKlv8cw6EvSp7vPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417634; c=relaxed/simple;
	bh=a4xoUFMwYk684k5JYg2VpNN7CFXbHuQ0VdyeOTINjuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnnrHxNOeKMdx2z525yH2UQCGkPgcBOrWQ1/aNy4v2WH+jfqzlka0rwN7+H+CoVLsNafXQL/hn0aJPvZmOSQog2xI4877+CbzfTSBLSf3OrzAGEonIaW8BuFafzheljfMBVeLhAq0JgeK8x0KcYaLaSbuGlGn5MTv4bkcZV2hR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aznXbLcg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aznXbLcg"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6399706fd3cso7186129a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760417631; x=1761022431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfQyCyE+XPfPYrrByTwKDtcCs6GmIeb9aW4FmXsJ1IU=;
        b=aznXbLcgXjHxPtXEW5ecJk+ZyMPLyVdCJoBMWGzWXF+AJO0LGO96KOWl9mM/ok2sbT
         bgxldsiqlSyJmSLIxYvBhzbsWxeqvyZ/nqZtHl/cOCgpwIMJzz4G5jlFv6cRaV/nIrGS
         Xmf2WL4PcetmZcLtNSgnF2T0TkJhmnsVVITrOrpeNk0BQUHomytLzTPE/eO4VG4/7gr2
         R6HTScfgjjstN2R4/tc0gEjE1r3MII0ab5XJg5rhB8/JJdOiWUyvl4Uqbj7D44JGJHYm
         6Xs7bYWkHqigveaGGr/jQMX9VF4967cf1nW9DkNc18ZgnBARtjAqd8uyA5v3MNhvycCN
         7SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760417631; x=1761022431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfQyCyE+XPfPYrrByTwKDtcCs6GmIeb9aW4FmXsJ1IU=;
        b=p4sqq0mneq8f3vMFdxp9TpnBJCRQcwhg2wUtgfOGrPTM/1+QHlb+NMHiD8X6SnKfy6
         9IZlEttcNN0ICbKvbyLByKGUHar9hcfuRxPcD3PfMJQt47cNSVc4jLqtRK38SjJ9RYuM
         9Z0+MuPUNlFrS+Isb33SCrYfrcN8okWvP83kTY1wEDotfobpGnGg+GnUVC9r5NhjRtIz
         q7agGQGTzFyG79V9dvNKGncAW2mwQFY7c/Do7rwAlyH5y8SBupmC3bRJ2Go1a11kH0Rg
         moMYWS+WTe4OBC1tIibKf20/t/7RaglEDSN6Hv8mcKJ+cgj+pVpC5JPRtnWicpbNzqCi
         LMAA==
X-Forwarded-Encrypted: i=1; AJvYcCU9R3kCVVDab43q0+TK4eauMrHfJQ8IKaEVYS7ApFPfG3bUIRDuiifSvDex7Rd3E3zavQEfNiaW4YdE2u7A02EMYK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuMWxUStWfgzV/ixzIduXljurxPnuXCAffyRe9b/RxfuXfHJ6N
	k/bjNTr3FmCKgaf8XGQ1Z0rWEBteG6O6AmnOdjtKee8f+autXnPI/FqORbF13yFKVf+qgOKkXTC
	3xcZbPPQwdAIai843Eh53YmnH3evJN/w=
X-Gm-Gg: ASbGncuVmsJReJmvXxzKzNS5YhVlp48UhuuJzI4Ql3zkR9oISbGvtQ/bW+xSddweftQ
	dtUJqpu7JC7wNRuvdXV197ayyUpn77aOd6UAXteHTPZvouv4omJOuqqZLOQhzxeWP8jtf8hG4bA
	3+qbOWAVM5RxdBAw3NLU+bXPtznt+vRbBarnS7USGBfWYZaBKYAFSd+9vWPR3AlqlTDnGOpF5Dd
	Bd2GAJRwJIloZSfS8ysQ4oSRGd89QaX1K4XjA==
X-Google-Smtp-Source: AGHT+IHycdhxq/9uyp9yKAAL3r9oERFUtH+HAFOLwQI4pevZSkF66rxnEvWd1Bw49lAHp9HOueRaVLiXkkjNr0qGtHc=
X-Received: by 2002:a05:6402:2744:b0:637:dfb1:33a8 with SMTP id
 4fb4d7f45d1cf-639d5b64901mr22616488a12.3.1760417630759; Mon, 13 Oct 2025
 21:53:50 -0700 (PDT)
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
 <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com> <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com>
In-Reply-To: <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 14 Oct 2025 12:53:39 +0800
X-Gm-Features: AS18NWBzhlnxQ9UDKq0PMeKLqmLwp_jZVc21fUyToJv8XAqRPenRlWCmVKYbt5s
Message-ID: <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:48=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 6:54=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Tue, Oct 14, 2025 at 8:22=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Oct 13, 2025 at 5:15=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Oct 13, 2025 at 4:53=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > Just a few observations (if we decide to do the sorting of BTF =
by name
> > > > > > in the kernel):
> > > > >
> > > > > iirc we discussed it in the past and decided to do sorting in pah=
ole
> > > > > and let the kernel verify whether it's sorted or not.
> > > > > Then no extra memory is needed.
> > > > > Or was that idea discarded for some reason?
> > > >
> > > > Don't really remember at this point, tbh. Pre-sorting should work
> > > > (though I'd argue that then we should only sort by name to make thi=
s
> > > > sorting universally useful, doing linear search over kinds is fast,
> > > > IMO). Pre-sorting won't work for program BTFs, don't know how
> > > > important that is. This indexing on demand approach would be
> > > > universal. =C2=AF\_(=E3=83=84)_/=C2=AF
> > > >
> > > > Overall, paying 300KB for sorted index for vmlinux BTF for cases wh=
ere
> > > > we repeatedly need this seems ok to me, tbh.
> > >
> > > If pahole sorting works I don't see why consuming even 300k is ok.
> > > kallsyms are sorted during the build too.
> >
> > Thanks. We did discuss pre-sorting in pahole in the threads:
> >
> > https://lore.kernel.org/all/CAADnVQLMHUNE95eBXdy6=3D+gHoFHRsihmQ75GZvGy=
-hSuHoaT5A@mail.gmail.com/
> > https://lore.kernel.org/all/CAEf4BzaXHrjoEWmEcvK62bqKuT3de__+juvGctR3=
=3De8avRWpMQ@mail.gmail.com/
> >
> > However, since that approach depends on newer pahole features and
> > btf_find_by_name_kind is already being called quite frequently, I sugge=
st
> > we first implement sorting within the kernel, and subsequently add pre-=
sorting
> > support in pahole.
>
> and then what? Remove it from the kernel when pahole is newer?
> I'd rather not do this churn in the first place.

Apologies for the formatting issues in my previous email=E2=80=94sending th=
is again
 for clarity.

Thank you for your feedback. Your concerns are completely valid.

I=E2=80=99d like to suggest a dual-mechanism approach:
1. If BTF is generated by a newer pahole (with pre-sorting support), the
    kernel would use the pre-sorted data directly.
2. For BTF from older pahole versions, the kernel would handle sorting
    at load time or later.

This would provide performance benefits immediately while preserving
 backward compatibility. The kernel-side sorting would remain intact
moving forward, avoiding future churn.

>
> Since you revived that thread from 2024 and did not
> follow up with pahole changes since then, I don't believe that
> you will do them if we land kernel changes first.

Regarding the pahole changes: this is now my highest priority. I=E2=80=99ve
already incorporated it into my development plan and will begin
working on the patches shortly.

What do you think about this approach? Would this be acceptable?
