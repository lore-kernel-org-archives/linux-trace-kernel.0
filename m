Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239EF26B2CE
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Sep 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978812; cv=none; b=MjnhSTPvgFbOmL5ESTlPjVAr5bE/0ncgGMggFG2nmuqRs8hrHV/ZetHhy1sWDLpFfkSKqc0TrVkdNRP2le7NjAA+eaC1BeyHEqiTnhciV4nbpZIs5He3TY4wnYKCmzWgiNZsucA59zhVtiMEFAxXM0enEq475ez4Q5MQ2goxwZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978812; c=relaxed/simple;
	bh=qiPAxPLNsHk954kmsc89B13q3EQZqdgliUn29iZKgKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Moooq2y3E8NsnUWzOyifvxx8yQfyfYCIwqd+/ofcsC3gVBZCkursK397SoWuVzVAtlLgs5+kvGUwaUCmvgSxgPi2ruAR+xSTSW+WtILzvkgOP1xdhRdqIYijkb0qUcmkPaR8cT1OMlJL03UKWhMR2arVMWqiEWR0ZZzhhvvQjng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zkv3yXlH; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zkv3yXlH"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61d14448c22so6611a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Sep 2025 02:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756978809; x=1757583609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeUX3NDgv06+NcrhTZI/Y6Tb5TiLTC+7+QLeL03CebI=;
        b=Zkv3yXlHEb1VWkFQ94GdbkhSi0ClB30t5y7VZCWt81p1cxHLl7zCXf4I32lPWd17jC
         CIiuwNWTlfieHUSzNCRSUz8Iv1HnKEw+/TBsBWYjsOsSV4Pgw6pMMrTMVGs1NYZBw6yP
         PrEnWFW266+1X965MG2OZ1HOElP5u49Ze8vFdSzvswwx4AR+A42daghpuh6RuX7EuC8Z
         lIHIDDaVuDoSCEjgNO7jfxVRR8uhn4qOzszxn8DagDGqUMeDg3d0vth4n6T28m0elOeb
         I04z9+ijxGsNgTQ5OWi1NK+EgyScKOZvsxP6ZwnIxwHZZ4dQ1YmtzJ7NtKDtpoluIk5O
         3u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756978809; x=1757583609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeUX3NDgv06+NcrhTZI/Y6Tb5TiLTC+7+QLeL03CebI=;
        b=lAQpYvslJOLWT04IQhqiV/robuysrtT5KZP0OuPaapa0zEKyLp9+ZJXUdedTmx213e
         q/cF8eQ7ylV7S+jTwaWWgoV15kNVJzfjGhnYvHGMIqIWHr39ltox06d6bgKPvr1KdM5N
         4o04UX+Awgl9jSJKqUuhUCU/H8iT+k7sc8tk65QcRRjQGy2RACc5hKc97Zo7YYNPLiym
         zqGDIj8vEqzqo9YoJmTrPgCSV211JwnNlWhsTt7w7WMpmS8qeCeAODuKvfc7QFiZ5s/W
         FG/Dz5Qb/yGklJ5/iervx1qpLtCUY9OMia2P71BsiRES8oRCRit2YQ/HnY6NuEON1yjf
         hpbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgVD/2DuJptqgjOFKxYzd5SzToaps7VfV4kgJN1rBhZ5RMyfWJN/vmCAJMB7GeHXZEcIFHTR0gZnU9F1BUwTzlXz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi2E3fpocOmxwprDR7dsT6gYDTuXA+Zl/9lbAruF4DuYE8qwqG
	/ZHoPRQdTCQ75GqTBtx0IoowB+bzvVUqVTPp1UkrB0NUDKBFaBAebUMrgq6WvBYbtmDJxDOLWie
	2Z/WTtLrhtvGXnIEPhk/CFuoEYq3qLtnTRSWVITsT
X-Gm-Gg: ASbGncutEZCpXR69lOvdqKwSG/0L3gUL/6b35j5xm5WrSd7xvf2Nn/uvTVeZQYzfgCW
	hOLHQrZiMyqCKW9sYGqqTT8XsXR74aQVYq1NoY8iXFVFT/jU5WmExRzVI6L7dC0q7+GLnnHEPDH
	pxHuVZI+KbW8aAVBzPv3ZTCwa9gwH1y8nFmFVb4czeq+YepbNfEgbJIXn57/8o+05PmDvQj/4Em
	M1/wIm096pzXMRBFa4HoNnB0BF+wB5gzUHTrhCQ8zKIt6iBA+Iv
X-Google-Smtp-Source: AGHT+IFvQ09ItdiF9IKa8AKCXWGo8iaQfkCiShjvgTToiej2wu3bQUANg3c8mPRCdKj+Oeo97Rq34yk08Eqg6vMF2/s=
X-Received: by 2002:a05:6402:20d9:b0:61c:c08d:359d with SMTP id
 4fb4d7f45d1cf-61eeeb9e286mr58503a12.4.1756978809259; Thu, 04 Sep 2025
 02:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720112133.244369-1-jolsa@kernel.org> <20250720112133.244369-10-jolsa@kernel.org>
 <CAEf4BzaxtW_W1M94e3q0Qw4vM_heHqU7zFeH-fFHOQBwy5+7LQ@mail.gmail.com>
 <aLirakTXlr4p2Z7K@krava> <20250903210112.GS4067720@noisy.programming.kicks-ass.net>
 <CAEf4Bza-5u1j75YjvMdfgsEexv2W8nwikMaOUYpScie6ZWDOsg@mail.gmail.com> <aLlGHSgTR5T17dma@krava>
In-Reply-To: <aLlGHSgTR5T17dma@krava>
From: Jann Horn <jannh@google.com>
Date: Thu, 4 Sep 2025 11:39:33 +0200
X-Gm-Features: Ac12FXxsZGDsNFJ-OLi5fgKFV75dsXqfESDrRxdzmAMV29gomXnQnvt7nYNZ2rU
Message-ID: <CAG48ez2BBTiDGT1NNK2dfZLiYMF-C75EAcufcVKWtP+Y4v-Utw@mail.gmail.com>
Subject: Re: [PATCHv6 perf/core 09/22] uprobes/x86: Add uprobe syscall to
 speed up uprobe
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:56=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
> On Wed, Sep 03, 2025 at 04:12:37PM -0700, Andrii Nakryiko wrote:
> > On Wed, Sep 3, 2025 at 2:01=E2=80=AFPM Peter Zijlstra <peterz@infradead=
.org> wrote:
> > >
> > > On Wed, Sep 03, 2025 at 10:56:10PM +0200, Jiri Olsa wrote:
> > >
> > > > > > +SYSCALL_DEFINE0(uprobe)
> > > > > > +{
> > > > > > +       struct pt_regs *regs =3D task_pt_regs(current);
> > > > > > +       struct uprobe_syscall_args args;
> > > > > > +       unsigned long ip, sp;
> > > > > > +       int err;
> > > > > > +
> > > > > > +       /* Allow execution only from uprobe trampolines. */
> > > > > > +       if (!in_uprobe_trampoline(regs->ip))
> > > > > > +               goto sigill;
> > > > >
> > > > > Hey Jiri,
> > > > >
> > > > > So I've been thinking what's the simplest and most reliable way t=
o
> > > > > feature-detect support for this sys_uprobe (e.g., for libbpf to k=
now
> > > > > whether we should attach at nop5 vs nop1), and clearly that would=
 be
> > > > > to try to call uprobe() syscall not from trampoline, and expect s=
ome
> > > > > error code.
> > > > >
> > > > > How bad would it be to change this part to return some unique-eno=
ugh
> > > > > error code (-ENXIO, -EDOM, whatever).
> > > > >
> > > > > Is there any reason not to do this? Security-wise it will be just=
 fine, right?
> > > >
> > > > good question.. maybe :) the sys_uprobe sigill error path followed =
the
> > > > uprobe logic when things go bad, seem like good idea to be strict
> > > >
> > > > I understand it'd make the detection code simpler, but it could jus=
t
> > > > just fork and check for sigill, right?
> > >
> > > Can't you simply uprobe your own nop5 and read back the text to see w=
hat
> > > it turns into?
> >
> > Sure, but none of that is neither fast, nor cheap, nor that simple...
> > (and requires elevated permissions just to detect)
> >
> > Forking is also resource-intensive. (think from libbpf's perspective,
> > it's not cool for library to fork some application just to check such
> > a seemingly simple thing as whether to
> >
> > The question is why all that? That SIGILL when !in_uprobe_trampoline()
> > is just paranoid. I understand killing an application if it tries to
> > screw up "protocol" in all the subsequent checks. But here it's
> > equally secure to just fail that syscall with normal error, instead of
> > punishing by death.
>
> adding Jann to the loop, any thoughts on this ^^^ ?

If I understand correctly, the main reason for the SIGILL is that if
you hit an error in here when coming from an actual uprobe, and if the
syscall were to just return an error, then you'd end up not restoring
registers as expected which would probably end up crashing the process
in a pretty ugly way?

I guess as long as in_uprobe_trampoline() is reliable (which it should
be), it would be fine to return an error when in_uprobe_trampoline()
fails, though it would be nice to have a short comment describing that
calls from uprobe trampolines must never fail with an error.
