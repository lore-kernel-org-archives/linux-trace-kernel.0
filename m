Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823A24C676
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758574084; cv=none; b=OZehSDinU1Wjkp+3QqR9KQ2NyTMocwPCQ2cNBTQeOkX+PIT40YyRCjY1V5Ll07oHKUJ3v6rqgkOM3gQlbzBcFMpvJkHyOxDeEIi7qVGKGCBUMGqtiPpqsLHYoa3tJbxQMj+6GGmhmSDFNQBMLkIAGS6DoZJ7q+jmaoIA21s4bJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758574084; c=relaxed/simple;
	bh=pE10PShoxNlFwAuYiz+gEtT3x6OgXhVGNZoXiBF2uwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P30ORX57ISb0rPKDqPe6dEJ6nJ/RC9AcnlT5dne/ywxHC49626bqcJUJvy5v8LeeI8BtHdGLvQZFHVBqDXXdp87UPhAq3GhKO8lkPp3MnehVFXBvbD8vlQelOZxQxVmdgG2HjaVBilU/Vt37NQ8RpEf10nyiBPp60pfnvjT1mKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBirfv6j; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBirfv6j"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b54a588ad96so3650500a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758574082; x=1759178882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRupgu2oLIRJ4YbwydOEX0rzUmWrxjSy6aJdxKz3zYU=;
        b=cBirfv6jWy8u9WTREiNseQmsYvd1hKHw316OWDLFZrQIkhn5JVMyWeKBMUSmTv4Pn8
         G+glio0whtwBlMqLPteSE7XoiHPtfOI1haargHIpgmA7q/UlbdNvGXUR7bn5bXUm3Usg
         NQ3XE7Jpk0OE95rvfv8W8/s/vWtrSMWWxD5jAY/40o4ybM35QfnBFII3FWEXBwez3WHM
         HMJzSNQyMqPrp2Htmdh91hX9Q6bQC2OFeJS0g3sBKAZ3o1Nz5tWbfJISM9pN6RP2LMHH
         Fa97Ie8m2nbhxuxnFWdww2i4frkTBeW1ZTOfrTJE0Z14nqRJAJE9n6vXd4UVT/fM3K7N
         Of3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758574082; x=1759178882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRupgu2oLIRJ4YbwydOEX0rzUmWrxjSy6aJdxKz3zYU=;
        b=VhvJ0C3tO2/vhi8NUkNp43Za8LSUpbQuFpIgUvp1ICy4kWS/xnCCfqphhddEAGKBYV
         2vvbgtjZnWT7nSdjw36n9sZR5uOKulF1JhpeotuB1P+6NKkeNpSeqvSmp0KdX3kGu1m8
         HBefdrdwQDmrXVCtrec1RPf7qYOgGoPfr7hdjq+6xtykt6QNReMCaj/YcZ4dj06EoZJK
         g7es5PafdlNgIIHM9AiGbDEE+OdrUDM37q85kNiXR2FCmt5CwzJgx8G+CM8M+tkz+mXm
         ltikgtGLsAk0VSJKxLrkIMcMJix0yh6KRWmxBfZ3dE8fb67ooXpl9QgFgeqax8SzH+ar
         6UnA==
X-Forwarded-Encrypted: i=1; AJvYcCVTliw+8LXTLDLGx4DGv4YFlgSi9UMOBQN7NgtctJUNuuh80VcdkM2YnDUJ1x5w8hUM64BmV70HKoJt6HapCzykK5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu0FVC4vyRGmkPs2bqQJwZZqmqKRQ2XjjYb9A82BXrwRwM7YLW
	/5Qv0mTgl/9Adrg+paalDXkQVchg8Dwx0kPWToZZOCYxf1kpn5halzT44YtfHLkqKVGhNul6ScO
	i1Z5zFHRlgnoBGk2fYKtSeWcff/9vcFA=
X-Gm-Gg: ASbGnctnmCqrv8L8Ogh7fplVtq3HhMxsWZ56H9Xz1RDKYnF/89Z/yCXFff5CBXMM344
	IPy9EwjoGwaJkIU6BNYpE849NS51An8ouMbMyfHsfePJyAoJMptiQqkDsNYKT6TI9e1gsFxfEhM
	hummrZv1JTLfC2janV/1gpLz+wnkAoNpVcM6PnAmtr6k35fJsK0TRODQop4x5VGekHtbz8bOzsh
	WjUazUcBeDn+gZ1k6rLEvo=
X-Google-Smtp-Source: AGHT+IEUuRWAd6fG0rfybE+0nP/IJA4IiQhjz/jt+hdzGma+ca+nrEuDJjaAUdoxzJ1xY3vBRwKee/XUZdJVl1Lpshw=
X-Received: by 2002:a17:902:f64f:b0:274:823c:8642 with SMTP id
 d9443c01a7336-27cd7464367mr926955ad.10.1758574082268; Mon, 22 Sep 2025
 13:48:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916215301.664963-1-jolsa@kernel.org> <20250916215301.664963-3-jolsa@kernel.org>
 <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Sep 2025 13:47:47 -0700
X-Gm-Features: AS18NWDxAmgOz0mcGrQMXGNUADECY-kaOgTXybxwa3vFyGGUnDZr74-MswLax0s
Message-ID: <CAEf4BzYfh_oqMOCq8G1S48Ym3th4+wQS1=ZTgRE3OTQrAJnCMQ@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original
 instruction when ip is changed
To: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 3:28=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 16, 2025 at 2:53=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrot=
e:
> >
> > If uprobe handler changes instruction pointer we still execute single
> > step) or emulate the original instruction and increment the (new) ip
> > with its length.
> >
> > This makes the new instruction pointer bogus and application will
> > likely crash on illegal instruction execution.
> >
> > If user decided to take execution elsewhere, it makes little sense
> > to execute the original instruction, so let's skip it.
> >
> > Acked-by: Oleg Nesterov <oleg@redhat.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/events/uprobes.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 7ca1940607bd..2b32c32bcb77 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
> >
> >         handler_chain(uprobe, regs);
> >
> > +       /*
> > +        * If user decided to take execution elsewhere, it makes little=
 sense
> > +        * to execute the original instruction, so let's skip it.
> > +        */
> > +       if (instruction_pointer(regs) !=3D bp_vaddr)
> > +               goto out;
> > +
>
> Peter, Ingo,
>
> Are you guys ok with us routing this through the bpf-next tree? We'll
> have a tiny conflict because in perf/core branch there is
> arch_uprobe_optimize() call added after handler_chain(), so git merge
> will be a bit confused, probably. But it should be trivially
> resolvable.

Ping. Any objections for landing this patch in bpf-next?

>
> >         if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
> >                 goto out;
> >
> > --
> > 2.51.0
> >
