Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D51BD4FB;
	Wed, 31 Jul 2024 17:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445980; cv=none; b=DgTBfW8iTXtYmnBG3qDmNUOgBZmwIOxVuX6wpCWzD/NVA1Ch4AmtKcJN8CwzOcU/FCjzjjzUzYFNflGNTuWw3JM67JAWe/UNOnelLcHGmJUrffGliELon87nO1PeRjBT+SJ/1rMOAbwF5nuyOM7rxoElyEw9+v94LQwBskzt4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445980; c=relaxed/simple;
	bh=r65fSjPQ8O9ACzXWIzjVq2aULtuRMZ7QPY0CSn2vRDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZugg53ltuj3atkqMLSUsG3jjempRVBWGV+rnt2EKGaia+xL1wdq0H0ZNrORf2f8m7poOrbqZuQ4oMZgSUggpb9nfYlgVNrIqkr1wd0lxGg8lXjPKX3Wcwo7qews9M+4bQoyFIH+NOftQV22/u45/sG3C7r5YzQRAP8g2mGvc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bc+bQCH7; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bc+bQCH7"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cf11b91813so3999011a91.1;
        Wed, 31 Jul 2024 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445978; x=1723050778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDSCWhELRBdtlc7/5+Htsyc9brjO2KaQhGoF8NY2ITg=;
        b=Bc+bQCH7ze4x5IOkLN3h6iLJ8OG2Jc78wwan6Ob2x5XmiK/WfUDWMlVPsF16mjCuwq
         +Qi2ZeSqszeb/FX9J+lfwG7oR1Am+fAsaYlSRxkAmGGJrxaJLYUd3g0wUmYmiRvSTaNm
         2TRwD+6n3OXQH0yOoJMXS+o6Bz9+y7aGu/j5sp3e/TqlQih3Xqeg7OUB+dREpAQTOU9A
         FsNW920f4hRIK8zles57+C/5qlY5EK6lVunSeQJj7Mr6N7Ne13CGp6ONHGummPFQTZ6L
         fSuLzGg4M51p8Dcuo3yY7rYgMs7+8dUe7joMSDzti6SPt5zcOdjeJl/Ob+3IMQ37qOzm
         BPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445978; x=1723050778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDSCWhELRBdtlc7/5+Htsyc9brjO2KaQhGoF8NY2ITg=;
        b=sUrD2F5yk+Ck47J8SbL6a5aSiw6QZsDL9SbikeTiyTLn91EDmUWQo07cJuPRy0am21
         CSSKByRqmUhnUZBmrxKFFffIqgvFLbaBqCqYacn78iyVuJJHESJ9suvtumtOKZrCpSVL
         vkgtplNGH/kH/Sevx6GL9/RsN10E5Bjg4YmMRBgzPBBsSyPdTPT3GzzYsrabmOzwcuDi
         iiX0wVbEVYwZto78QSaimc9kM6dYofEWCzk+Nx7JqoboYG0l0r6b04FyNjvoLw29Izc2
         YUWXXahFj+mW5GayvbfYEJcfsFIl7BH0w9y24/aIH6x6AD9Hv8IRB5CXwlZop/TqJXk2
         YoJw==
X-Forwarded-Encrypted: i=1; AJvYcCVY8Y1iVLd1c8FORNW6byWSujCRWJe8FmAPr4owoIvys0Jnaez4blK/fJbK78xDjMOk3t6XlRfK0zwcWcY6CsQUqXG9qCSNlXOgg1LwZtaEfXFg4fehQxqV08s2xnHgEKMborOQ+t3U3HgTxzH/YtKb
X-Gm-Message-State: AOJu0YwsFmg1uMQ9bB/fVztARqt8BTvmB5SxB5elHeo6QEVyxfaghzQM
	Pyrr/BMTxao6x8h7gltT1wqhw4HuuPtBDnl74VwUBlNpv730jlF9sXSrXGQB4MvaBRNPolB4/LD
	GHI7Qt8jAqKoYqYQbZJdVRna3Duc=
X-Google-Smtp-Source: AGHT+IGaonZcBJspp25j6c3POADFGz9J5x0DFcX1Z2PPjOvRj/EFikdZvqegcHo9A2jVLebbB+ZtZHEoCwulXyiU2ZY=
X-Received: by 2002:a17:90a:bb83:b0:2c9:888a:7a7b with SMTP id
 98e67ed59e1d1-2cf7e1ffa35mr14141634a91.25.1722445978002; Wed, 31 Jul 2024
 10:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729134444.GA12293@redhat.com> <20240729134535.GA12332@redhat.com>
 <CAEf4Bza1_njsVUad8so9EFxy8VmJsTfzaaAahBYFtOqdF1HAjA@mail.gmail.com>
 <20240731165614.GI33588@noisy.programming.kicks-ass.net> <CAEf4BzZXze8wRQwEJSy5nFzH=uk4wZPHY-gWw6j7iZfeBEiO0g@mail.gmail.com>
 <20240731170551.GK33588@noisy.programming.kicks-ass.net>
In-Reply-To: <20240731170551.GK33588@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 31 Jul 2024 10:12:45 -0700
Message-ID: <CAEf4BzYTMTNoGbL6keMhj4hRty-tw5XDeiLHOXMJxRyxZv6Efg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] uprobes: make uprobe_register() return struct
 uprobe *
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, andrii@kernel.org, mhiramat@kernel.org, 
	jolsa@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:05=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Wed, Jul 31, 2024 at 10:01:47AM -0700, Andrii Nakryiko wrote:
> > On Wed, Jul 31, 2024 at 9:56=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 09:18:00AM -0700, Andrii Nakryiko wrote:
> > > > On Mon, Jul 29, 2024 at 6:45=E2=80=AFAM Oleg Nesterov <oleg@redhat.=
com> wrote:
> > > > >
> > > > > This way uprobe_unregister() and uprobe_apply() can use "struct u=
probe *"
> > > > > rather than inode + offset. This simplifies the code and allows t=
o avoid
> > > > > the unnecessary find_uprobe() + put_uprobe() in these functions.
> > > > >
> > > > > TODO: uprobe_unregister() still needs get_uprobe/put_uprobe to en=
sure that
> > > > > this uprobe can't be freed before up_write(&uprobe->register_rwse=
m).
> > > > >
> > > > > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> > > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > > >  include/linux/uprobes.h     | 15 +++++-----
> > > > >  kernel/events/uprobes.c     | 56 +++++++++++++++----------------=
------
> > > > >  kernel/trace/bpf_trace.c    | 25 ++++++++---------
> > > > >  kernel/trace/trace_uprobe.c | 26 ++++++++---------
> > > > >  4 files changed, 55 insertions(+), 67 deletions(-)
> > > > >
> > > >
> > > > You'll need something like below to not break our bpf_testmod. And
> > > > please send pull patch sets, not individually updated patches, it's=
 a
> > > > PITA to deal with. Thanks!
> > >
> > > Do I stuff this on top of Oleg's patch or do you want me to fold it i=
n
> > > one of them?
> >
> > Please fold so we have better (potential) bisectability of BPF
> > selftests, thanks!
>
> Fold where, patch 5?

Yep, this one, where Oleg changed uprobe_register/uprobe_unregister API.

But note, I did the lazy thing and just copy/pasted `git show` output
into Gmail. So all the whitespaces are butchered and unlikely you'll
be able to apply that patch as is. My expectation was that Oleg will
just incorporate that by hand and will send the final v4 patch set.
