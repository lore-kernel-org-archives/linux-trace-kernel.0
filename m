Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E041321CC47
	for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967050; cv=none; b=ds197fFYweYJ69JKbD5UkfiLXMrtSv4zanS3FPY8iCCZa1Fh9i3OtJIA1q+HJK65qal3bB3UeRxA2R2JrC/p36yJxcvFzZ4JphE6KDprcb4v74jBVqVVNKz8wiqF6r6b9m1Q4xCk6N776H2BuzJ99jcpedcTu345BSR9E+uInLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967050; c=relaxed/simple;
	bh=gombhexvDzLLf/Y1V8p7ZE99vClFYXdoUSu+SwK/MLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gfdd5gxqogzdclsD6yUZqb/jZXgDgnkybAOZwMjnsoWAh2iOvGL9Pzx0q0ZEHCvUEITuDVEwuYSISx+5NQ3mwQZtyonvuA6td3DLLH9F2lA3gtByRZxW/jFjNLqeLIaCBjiU/XzeFc6/3zAqYTLIWq9VBRuQeQwUOvJYoHvaqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ktctbOBv; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktctbOBv"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso3267958a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967048; x=1758571848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9i+RyIAhaSG8LwT953hbKzYwwFHtyc1hiplWTlRZi0=;
        b=ktctbOBvAEVO4SPE8nyhR111KWcgyYTYrNozOrCBv2D0Dgpgqjoe3AjHa0ep0J5NUu
         4u4krCZ2iBW5SJsGNrs3OyQ+p3toVSCvp9sg2+UkQiQhKjIaUq6YwDurngElbc4uZsyK
         kBiyj6jQ9dXrxr4D3NAMBXnhEOaEA2GbTyWf7zwb0ssWG8qOPWQ/XK/ygn1xmShUM98p
         q+YLqkLCvmXcyv19xvnKMnwEYhMQrBDrWdCKuWOXhqdLUqorkTLBHx8VdkMzHiX/vozQ
         oMeofnkLFcV41L42bi7jPrnYwP4/oGvd+uxUtrGkfAqI7Z/QKCDpVPU5FBQ0wWjq/FS/
         g4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967048; x=1758571848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9i+RyIAhaSG8LwT953hbKzYwwFHtyc1hiplWTlRZi0=;
        b=ERZazns9G6VW8yKUq5HJt0y4yp81xFfEo0SuOLz8DvArUUBU46Ja9XFHGNpFYFazse
         pjjDovQ1+QqjLpVrK5ob4vkgU38/3juX13xBMp+tokFzXwVr6BQo2uhTAOC0R48kpgqv
         tGnTYmPYWshQa0/o3Pmtv4XJ6Gy2KGMj1kr0WLO2Regatkdh9AYerRpuOMbZ2GNt40gH
         dcurVH8z7yoN4/JzspyFzkZuvOCeuETlDkA5LRMfrG5k5SquUVxago6OI7WSKI9pnlOm
         WqVpTh+ojyd36p7IHZMNAQreXYNaOkSsJk2Wf3WdIwVH5qY+OWNAiBKJ29vQIqz964sF
         8J3Q==
X-Forwarded-Encrypted: i=1; AJvYcCX3DjMym2IyQ1ee418GDhMZ0dGMs2NaV9/bzI5D14pbER8BwZtimJQEv4RxJ7Y7xD0wvHZp/QOc9/czz1E63LLTGrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1p11WPSBzEotNpmBesEQYmv/DmzhtJGwv+vjJQApZP312ReVC
	OUYv+aSVIXxisN2JAdRzJjC+wuLzoHoZdkrdNabGfcMeFxFnrc4H54l/lBsuDc+UaapFvtoRI3X
	7/6HUGW+sGEy8fiiBsY2FxjiBA/wJrm4=
X-Gm-Gg: ASbGncub/8CF925dyrbEsErLLzTyPgpfrrFhPj/JC0XXm8/5oQfbDAp0vuqQR7KDe72
	M8TJgCe4yPok3pIwBiSWrLfCHPMAQ6WWZytX3cS8aOubLSPoVjalgdveM1nE8QmJCqILyC72aqc
	Zi+7tVpWZCKLjrejOlmXrxOJWIogLK6YA7TlKHXrG5J+iQA8QzRCTlmIZ76wHBq++EHhMdzp0U+
	BjI0M8E3r7XokvtdG51VRo=
X-Google-Smtp-Source: AGHT+IEOvj5/CbVtdXgge48j2eyDX0bRe3AITikVbTf+5sf4C05xN7/hPcAtOwcav6nlH8gwC7+q671/Jhu5CBu7bvc=
X-Received: by 2002:a17:90b:2dc7:b0:32b:4c71:f423 with SMTP id
 98e67ed59e1d1-32de5144b01mr13659135a91.32.1757967048096; Mon, 15 Sep 2025
 13:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909123857.315599-1-jolsa@kernel.org> <CAEf4Bzb4ErWn=2SajBcyJxqGEYy0DXmtWuXKLskPGLG-Y9POFA@mail.gmail.com>
 <7f591ac9-d3e0-4404-987c-40eceaf51fbb@linux.dev> <aMSIr1oItIfWQd5R@krava>
In-Reply-To: <aMSIr1oItIfWQd5R@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Sep 2025 13:10:33 -0700
X-Gm-Features: Ac12FXzQ_QY2pjcnJxbRCflvqVRVDb7gMXI27nmWWJqXnfRJav7AB0LAEj67VqU
Message-ID: <CAEf4BzZ21xFq25Vs0xSmCfb1MSbdz_GLs8B6s+h0Q3kCTmnzSw@mail.gmail.com>
Subject: Re: [PATCHv3 perf/core 0/6] uprobe,bpf: Allow to change app registers
 from uprobe registers
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Oleg Nesterov <oleg@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 1:55=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Sep 12, 2025 at 01:28:55PM -0700, Ihor Solodrai wrote:
> > On 9/9/25 9:41 AM, Andrii Nakryiko wrote:
> > > On Tue, Sep 9, 2025 at 8:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> w=
rote:
> > > >
> > > > hi,
> > > > we recently had several requests for tetragon to be able to change
> > > > user application function return value or divert its execution thro=
ugh
> > > > instruction pointer change.
> > > >
> > > > This patchset adds support for uprobe program to change app's regis=
ters
> > > > including instruction pointer.
> > > >
> > > > v3 changes:
> > > > - deny attach of kprobe,multi with kprobe_write_ctx set [Alexei]
> > > > - added more tests for denied kprobe attachment
> > > >
> > > > thanks,
> > > > jirka
> > > >
> > > >
> > > > ---
> > > > Jiri Olsa (6):
> > > >        bpf: Allow uprobe program to change context registers
> > > >        uprobe: Do not emulate/sstep original instruction when ip is=
 changed
> > > >        selftests/bpf: Add uprobe context registers changes test
> > > >        selftests/bpf: Add uprobe context ip register change test
> > > >        selftests/bpf: Add kprobe write ctx attach test
> > > >        selftests/bpf: Add kprobe multi write ctx attach test
> > > >
> > >
> > > For the series:
> > >
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > >
> > > Question is which tree will this go through? Most changes are in BPF,
> > > so probably bpf-next, right?
> >
> > Hi Jiri.
> >
> > This series does not apply to current bpf-next, see below.
> >
> > Could you please respin it with bpf-next tag?
> > E.g. "[PATCH v4 bpf-next 0/6] ..."
> >
>
> hi,
> the uprobe change it needs to be on top of the optimized uprobes (tip/per=
f/core)

Is this what you happened to base it on (and thus diff context has
that arch_uprobe_optimize), or those changes are needed for correct
functioning?

It seems like some conflict is inevitable, but on uprobe side it's two
lines of code that would need to be put after arch_uprobe_optimize
(instead of handler_chain), while on BPF side it's a bit more
invasive.

So unless tip/perf/core changes are mandatory for correct functioning,
I'd say let's rebase on top of bpf-next and handle that trivial merge
conflict during merge window?

> but the bpf selftests patches could be applied on bpf-next/master and dis=
abled
> in CI until tip/perf/core changes are merged in?
>
> thanks,
> jirka
>
>
> > Thanks!
> >
> > $ git log -1 --oneline
> > a578b54a8ad2 (HEAD -> master, origin/master, origin/HEAD,
> > kernel-patches/bpf-next) Merge branch
> > 'bpf-report-arena-faults-to-bpf-streams'
> > $ b4 am 20250909123857.315599-1-jolsa@kernel.org
> > [...]
> > $ git am ./v3_20250909_jolsa_uprobe_bpf_allow_to_change_app_registers_f=
rom_uprobe_registers.mbx
> > Applying: bpf: Allow uprobe program to change context registers
> > Applying: uprobe: Do not emulate/sstep original instruction when ip is
> > changed
> > error: patch failed: kernel/events/uprobes.c:2768
> > error: kernel/events/uprobes.c: patch does not apply
> > Patch failed at 0002 uprobe: Do not emulate/sstep original instruction =
when
> > ip is changed
> > [...]
> >
> > >
> > > >   include/linux/bpf.h                                        |   1 =
+
> > > >   kernel/events/core.c                                       |   4 =
+++
> > > >   kernel/events/uprobes.c                                    |   7 =
+++++
> > > >   kernel/trace/bpf_trace.c                                   |   7 =
+++--
> > > >   tools/testing/selftests/bpf/prog_tests/attach_probe.c      |  28 =
+++++++++++++++++
> > > >   tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c |  27 =
++++++++++++++++
> > > >   tools/testing/selftests/bpf/prog_tests/uprobe.c            | 156 =
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++-
> > > >   tools/testing/selftests/bpf/progs/kprobe_write_ctx.c       |  22 =
+++++++++++++
> > > >   tools/testing/selftests/bpf/progs/test_uprobe.c            |  38 =
+++++++++++++++++++++++
> > > >   9 files changed, 287 insertions(+), 3 deletions(-)
> > > >   create mode 100644 tools/testing/selftests/bpf/progs/kprobe_write=
_ctx.c
> >
