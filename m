Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CA615624D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707280; cv=none; b=IBIcgC/7uPpsRFdgrD9YKPHXQwqAfaYV2Td+QnyuXTZSW4ds3rrte3kODFbqD7XpZ2ljGVte5iCdZnf5Wntyl5W2+RgNetgd+ZvcDPF7iHOxYbHKJeAMfY5bLVZiV3T3AaIqlu2NWVeqy+tvVX4WhHoPxRPP8e4Ly3je19EKHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707280; c=relaxed/simple;
	bh=clfk60SyfYqZmt5Z+z2CI7XpK9tr1yr5nZ4/ERZNp8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMFA2QaZn6gHWVthAI9uM379mGNVib8RRQKMMMA5DwMIcZE5G8nwie7mWwFEZ0FMasS2c6qj26Tl5jGMTXlh2d5Oin8zVqfK6jeqgDDaZdf7FR8TSVK1MdkeAYFzplDWOTKf65XOQ+gB15i6EQjzdWNSFCbs5cdN0pwLfhDAF28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBmDAu54; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBmDAu54"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so441923f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758707273; x=1759312073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+/yAQIJHy6zgxStgmA8+woCe8XjoAU5txYeFqYzfH0=;
        b=TBmDAu54boe1929wX6EsDoCVrvE/jUZZAnve83MwzzbSDage2TOPdDqeiu57zquv89
         MsQ2vmzbzwFb6EtVKBxHdmYCX7iR7tztLSaV9vdcpOAc4OmXNtxxgZlPXxHzKd5bo2Yv
         2AifCbs0RUr8mfArXWqlLsN+yYOYF8SNZh1b/d4/3vAcrYsUCT9mNUGywXjkKJQmmxpl
         phRRS/PM5vSb3P93bJ9Z8URbPvnX1ibRokI6wn0haVwhsgc7raTD5xT7snLrTGbLYgQz
         tJUuorK+PJl7YBvkNhSwdU1h/gHx9baE8/+7Aurprb7nsx8coYfuBzdfN6YklgJ1Oe7f
         Tosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707273; x=1759312073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+/yAQIJHy6zgxStgmA8+woCe8XjoAU5txYeFqYzfH0=;
        b=EromGopWqL1wLvWU/9Fgq8oJGkBZhx9kVvv87ibliWTRTYayR5iOatotsdxnbs9QpC
         8hzD8hUjRPF1WXFEJ1paAKX5k4h3BCcbgsSZLdSjDNFGmCTbFXqEWhmjfo1YWdlYcQVB
         WxCteWCp3Wh4h5lG0A/l1xz+B1AGvOrZOAgUv9s272WGkBG85Ya7r4G8ivY05AEMVhiR
         uVPlsIbmHPB6xdY4idl4bSljkfW2zyKK7JUuKuREqBdrBiqIoN5ZjqB4BzGZ4jww7DTH
         ijVtSBQLU7beYcQbugF/vN7FmthpYdKN86EDsNrElLwHFrp3g5HxESeM+iEdTZfxRfVL
         3ogw==
X-Forwarded-Encrypted: i=1; AJvYcCUdOx4zy0p7hCFAeR/NpsQgN4oKFEGF+Ln0O0J3H0fTgVvdfNtYpAsnXIbwWYQZPZA3Ee1BZL9QmxdWmrpd8vhl788=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1aR889QoLpJccvZwE1bQ8oz9s87TTb+FrzoWLX9CDZCDu1YIL
	WFUsBmLMBZo0S0gSD6aLw9lbqjlr2GGGl6achkdLv1y3bDhAqe4mZkiqU2VQhhssqHU2YjnebB0
	oOO8MV75M7E8RGx1mTAaGNJ3XRmqR0kk=
X-Gm-Gg: ASbGncumh9uyprydM8YpElHGJ87ZPY2tSw4J1FEJ2EcX0Fd0Kum2zVqHC+/JAbxz/zB
	7tGF+7nS9biTD3JkC/n3CGENRyn1I4yp7R6E3uL3+l4cjRiHg/9lax9psea2/buUXMD0BGk2N/H
	KPBfGrmq4Ubo+LojnRoTPyhMqMATHVYJIZ542mwjCHRa81YWw3/JqLODb9G8UGX+jhtnj7VvJPE
	/dOgeMVoYBvpW/FMDg=
X-Google-Smtp-Source: AGHT+IGNEyOFTkhhfZ+ODCUH/TtmGTf98EryrfgpvlPOBPzYZ9gdhhQMDlm+uYotpfaf5G/L0rt+YloNfDg3NmGpD8g=
X-Received: by 2002:a5d:5d84:0:b0:3fc:54ff:edbb with SMTP id
 ffacd0b85a97d-40abe09400fmr1871286f8f.9.1758707273143; Wed, 24 Sep 2025
 02:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916215301.664963-1-jolsa@kernel.org> <20250916215301.664963-3-jolsa@kernel.org>
 <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com> <20250924084956.GW3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20250924084956.GW3245006@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Sep 2025 11:47:42 +0200
X-Gm-Features: AS18NWAjVTpnvN9YoNCHY8qLaBt16TRzfs-v53h1ST40PSwW1aqo1PKnsvSDwoI
Message-ID: <CAADnVQJ6CFD6D9gDb5R=ZnAiXVVJxMe+V3Mv+qniwD13-28MTQ@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original
 instruction when ip is changed
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 11:15=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Tue, Sep 16, 2025 at 03:28:52PM -0700, Andrii Nakryiko wrote:
> > On Tue, Sep 16, 2025 at 2:53=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > If uprobe handler changes instruction pointer we still execute single
> > > step) or emulate the original instruction and increment the (new) ip
> > > with its length.
> > >
> > > This makes the new instruction pointer bogus and application will
> > > likely crash on illegal instruction execution.
> > >
> > > If user decided to take execution elsewhere, it makes little sense
> > > to execute the original instruction, so let's skip it.
> > >
> > > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  kernel/events/uprobes.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > > index 7ca1940607bd..2b32c32bcb77 100644
> > > --- a/kernel/events/uprobes.c
> > > +++ b/kernel/events/uprobes.c
> > > @@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
> > >
> > >         handler_chain(uprobe, regs);
> > >
> > > +       /*
> > > +        * If user decided to take execution elsewhere, it makes litt=
le sense
> > > +        * to execute the original instruction, so let's skip it.
> > > +        */
> > > +       if (instruction_pointer(regs) !=3D bp_vaddr)
> > > +               goto out;
> > > +
> >
> > Peter, Ingo,
> >
> > Are you guys ok with us routing this through the bpf-next tree? We'll
> > have a tiny conflict because in perf/core branch there is
> > arch_uprobe_optimize() call added after handler_chain(), so git merge
> > will be a bit confused, probably. But it should be trivially
> > resolvable.
>
> Nah, I suppose that'll be fine. Thanks!

Thanks! Applied.

Jiri,
in the future, please keep the whole history in the cover letter.
v1->v2, v2->v3. Just v4 changes are nice, but pls copy paste
previous cover letters and expand them.
Also please always include links to previous versions in the cover.
Search on lore sucks. Links in the cover are a much better
way to preserve the history.
