Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408142BF3F4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709428; cv=none; b=Omr3aYsIVpLSeg7hye2I8niu2t9SHqvbrKOiQwwthJvkC7LD6EHZ3SWDIwddIyrfcyekFTlrMMs+z233q8U75BGGFpwbjyByMT/9nuuz15oGN60UK3FkJc/q+PWOPA2PI6rL1OwfTTTedKY/RV4eTFZmMZBTAI7xmcJTQDaazIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709428; c=relaxed/simple;
	bh=wljaEKuWWL3DhQrslfw2HXA2fIH2n1hotCcZnEdFrzU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCnbk7G2RQJJBHuq+opKIHRvAypen8oLe5HcBtD7IeNGN5WbIgtxy4GXxD9fYW+3ZexWcG3u3WQxs1YJgXG+pkgsGT0+flnHaCpQ3UtyLpkMo70XTxlXmQxSq5bZ/j/s4tTyl0LwmKAI/U8U5/tqywpBedZE35jcw776CIYJjjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQuB7Hba; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQuB7Hba"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3fa528f127fso614207f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709420; x=1759314220; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Jip6AA5ytMsKDtIMaGcXPfdygTtTlFWoiPJyBddqbQ=;
        b=YQuB7Hba1g6UkZhvQnqX7kG7/kA0iPVq6hRiQcYuppzIMdnuMyHDsN5XinBxktwfSw
         XwiYbrvWChyRNHLFoFPbl1vugxgssp8iXUv8vMdnAl40qa+ydiM7vsMy2qRNNpcz3WPg
         ohVJmEwuk007AlbzhB1gCBt2gqXYIFJIeoWww8t/Q2bbVhFzFgFRQX2G+xzbibp8hDOa
         io6I5pyRHN1MjmLjE9Vzx4OSXKLnxEwTWYmEUSOlpYOItGi3vL2zaK5OUu0koeK4HVJW
         KuhcUdawj9VbRi8osPa71h/FlG7dK90C52hS8zpMDsll3ucu8tb+h0Fv20S8OGJUXugX
         MbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709420; x=1759314220;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Jip6AA5ytMsKDtIMaGcXPfdygTtTlFWoiPJyBddqbQ=;
        b=KQ51OY8zPb0AkUSlnFR9X87MuyFfma8Gv2keNyvC98U99PzlPD6snvISUBXYlS+bHk
         /dwSDDUD+GQtKUmkrTEWKc5IcL1bt7sAqdgy6C2ZYLK2YUp0Zx26D7gTWPUtzFLWoqmQ
         8s+VKWd3icBkrD/hb+upEuTZXyNHJwOCw8zQu7OEKbZwOb86l6CKzISkJijPBO801JU4
         r1K2VZceyxJmUZRfDDqbcibGUF/lNRv96zc/GtoxKDrWITJgk9g5pdrT7o/dp4CFD9zA
         tTfsGzWCT9amN241FSLTFhlzHtxjIuHduZgLCJWWIugDVuyPBNjG3hAO6Lz6eQNJpTHW
         m+bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhvDpRCiOF311nlKkN4ul5rbacCGioBmYhzkdj4RpP86KfuIqw1JGYDdnArekbC7CX+PuEWMdSHoo9vr8cO/7XaPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWri1LyOn3PX9e4IzLQ3fZZhANmDAnoqatcqF4vY8cYvGmozP6
	eO4Sre7ruEIkBLoMFFeZA9ZQbHI8HxEUPScV/jRlDIjN9UE30NmMxC2c
X-Gm-Gg: ASbGnctIyD1d09CaR26O0uXV8QYoKeIZH3aGqotDIccPQUHU04B8b/kkP7uEZ/wWqfj
	g2vy3JYgu9OvNwUc0XgIF1pxqtszo5nSZSTCKKEWenAAD3gnCODMQnERf+eu9kN7hHXHc18uLew
	z09yBdFXfg/HuKjixnkLfSUPXgOIZdAGiZlaNexM5nS3ry9+/ct06x6Q+z8pEfIhCE4TXLGyh+6
	5axbYhQ8C8k0cO0AueS9tDPB2wODSxTe46VGcE56yViF9L23WDBnBMzfIxl3MrQEJGRBAs/UQPk
	+8vGsgZgvKx5h2w+Yzl6wwiy/Q+hK3u90C/iLbDWOPJGLDIOTgT4B37Z2d2Ypgws+rcYnkzjzHi
	ji7Elq03Z/fA=
X-Google-Smtp-Source: AGHT+IH7SKx2kJx45gtSN77AKvZD/WsXiJFVRScKsTn2qfd7bVys7yigp6x5cK3vK2f1JlYGEcK1Pg==
X-Received: by 2002:a5d:5d89:0:b0:3fd:271d:e2a5 with SMTP id ffacd0b85a97d-40abe093fccmr1803842f8f.11.1758709420375;
        Wed, 24 Sep 2025 03:23:40 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407aebsm28637355f8f.14.2025.09.24.03.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 03:23:39 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Sep 2025 12:23:37 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	X86 ML <x86@kernel.org>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original
 instruction when ip is changed
Message-ID: <aNPGqZfbViOaX82C@krava>
References: <20250916215301.664963-1-jolsa@kernel.org>
 <20250916215301.664963-3-jolsa@kernel.org>
 <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
 <20250924084956.GW3245006@noisy.programming.kicks-ass.net>
 <CAADnVQJ6CFD6D9gDb5R=ZnAiXVVJxMe+V3Mv+qniwD13-28MTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ6CFD6D9gDb5R=ZnAiXVVJxMe+V3Mv+qniwD13-28MTQ@mail.gmail.com>

On Wed, Sep 24, 2025 at 11:47:42AM +0200, Alexei Starovoitov wrote:
> On Wed, Sep 24, 2025 at 11:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Sep 16, 2025 at 03:28:52PM -0700, Andrii Nakryiko wrote:
> > > On Tue, Sep 16, 2025 at 2:53 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > If uprobe handler changes instruction pointer we still execute single
> > > > step) or emulate the original instruction and increment the (new) ip
> > > > with its length.
> > > >
> > > > This makes the new instruction pointer bogus and application will
> > > > likely crash on illegal instruction execution.
> > > >
> > > > If user decided to take execution elsewhere, it makes little sense
> > > > to execute the original instruction, so let's skip it.
> > > >
> > > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  kernel/events/uprobes.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > > index 7ca1940607bd..2b32c32bcb77 100644
> > > > --- a/kernel/events/uprobes.c
> > > > +++ b/kernel/events/uprobes.c
> > > > @@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
> > > >
> > > >         handler_chain(uprobe, regs);
> > > >
> > > > +       /*
> > > > +        * If user decided to take execution elsewhere, it makes little sense
> > > > +        * to execute the original instruction, so let's skip it.
> > > > +        */
> > > > +       if (instruction_pointer(regs) != bp_vaddr)
> > > > +               goto out;
> > > > +
> > >
> > > Peter, Ingo,
> > >
> > > Are you guys ok with us routing this through the bpf-next tree? We'll
> > > have a tiny conflict because in perf/core branch there is
> > > arch_uprobe_optimize() call added after handler_chain(), so git merge
> > > will be a bit confused, probably. But it should be trivially
> > > resolvable.
> >
> > Nah, I suppose that'll be fine. Thanks!
> 
> Thanks! Applied.
> 
> Jiri,
> in the future, please keep the whole history in the cover letter.
> v1->v2, v2->v3. Just v4 changes are nice, but pls copy paste
> previous cover letters and expand them.

ok

> Also please always include links to previous versions in the cover.
> Search on lore sucks. Links in the cover are a much better
> way to preserve the history.

will add them in future, thanks

jirka
