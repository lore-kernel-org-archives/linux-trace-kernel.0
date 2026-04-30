Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A43CFF56
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Apr 2026 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534418; cv=none; b=fCRjhsIN7MzOyNsPQ8T6eqZCXzwUUpkyxPE1k00d5w6qzc2MrtI1kl1hhsU2vJ7U8nFd69IImSawgpB8jNXBP2s8hs+Qo5NMHRwir0Aw2AW/S0jHb6rROUjyTYoyb/paFlbJatQfNv2c1SbOD8JWIhzAOcvutMOUyhed+AJBmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534418; c=relaxed/simple;
	bh=OflwiH1nIJfdNUHLelUOys+vm0D17s6KIYEkzzBHKIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7+VfnqbD5fZb9qdmEeupfd1lFoK8sao+9SK6fNp+QG9hLakoH+myPKTw0wjGpmbV6HauNgJuuX1Nt+AZccw9gfyjI66iLyUDjNMXje3B6eUeiJYfSGWuVtkRhLPsY9yqWbfsj3VgbFtQyw7ukZx8sld30SvsBnAAxG/Klm6O5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4645dde00a7so1198976b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Apr 2026 00:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534405; x=1778139205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBgEVUdU4L4wfRMqvP//YZN+cC+kUQHoSVaa4kQ4JnA=;
        b=TcAnubltIIFSScGYTKxCcR22aTxHqozVt5JgbuPctCdhUfYGrI491izrVs4SeXaGmF
         +qEDJCmssW4bgAWrnrb4UsNuUG7oFjfrQwB1WnfDwyyrdEubw2HSFm8zXd9d5MWR5bck
         Q3DWSrItM6aSHa7AOgWqd72U4WcXw8gCTkDpAKhZvwO4j4/yn9B3jC1Ux3B/wQTbMUym
         M+VNiFCQyZmv6rFdi8cRGsyNp8jii53oZVLoOrrnmD9Xhnws0QWqrNhAZNfnr6CjyIAN
         upOKtIRPLAMv8lfAZHMniMZTh5trEzT37mbLnz4Gztgm33xRBgcoF+aO/m37SlIL8tt2
         P2lg==
X-Forwarded-Encrypted: i=1; AFNElJ+SC4mh9dSmuPMIOOOtIRpsKrNes8++5H+2UR8vpR452u4thWtjPKsGF73GDRmUJPlFmYMNcm2xrGylJX2oKGKeaDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzszCHOLL8v+R95C+Owc9wncmya0KVJvLSkLB+WX6gbUjLz4Uj
	n4F0q/LTZsHRSyx8C50Eh+tk7yPsxlqXOUYoyo1ZIq57OrG6M5ytStpZJYL4S7GEcvs=
X-Gm-Gg: AeBDieujDhpxIJODLtG6eipPYLFTm46p/uG/6DO2C0AgaNwJRZiLbhp5Zq/FHSyb8d3
	otKqcxnynD32Xb2jggYLZCKAnc0PEndh9uegp9gGvAtLdvBs2/j5S8ZBVa5nDufA4O8xOS3ihvf
	VbTpflpceeL2B9DpH4xr4RABDpBtBK+UMw0QNaP/5u7eMqivK5beJIIjij1M3iBKC6fsMOobq4n
	OKOrtEXzXaiP+JIAUzzrTLB8Iu4QRa6cGEnZf3A1afaQbRC7rV9Dl1WFjl5kKFP5QiIpvgTNqHI
	igpL38O5zQBQVnLkTogLujsmUM9vdb7EHAR+9nfDxPyqjRh3Epm15OgelrGl7NHiBpYx5CoVBYr
	U/XzgUQLbuznwykWooWFHeZS9sZ39xOqAQSD1NT4P54+MTNnQNqb2ILCiG3QiBCuY9ito/hdqsp
	e9YtUTLPZmpbVweoXfCp8h349r/brcpyOuafSSo5w6L49n1lUjkS08S/GiBh4dx92H/2YoWXFhe
	i/FDKRH2A==
X-Received: by 2002:a05:6808:1791:b0:467:2f58:dff3 with SMTP id 5614622812f47-47c620b29ebmr493763b6e.18.1777534404898;
        Thu, 30 Apr 2026 00:33:24 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c43e6aec9sm2332066b6e.2.2026.04.30.00.33.24
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 00:33:24 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dcdd1b492eso699714a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Apr 2026 00:33:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/WXsvM75JipvckrD47AmggA1ijF1z24UFnX/FoOKcTVSRYZyPnvA1Uf6gnenysErcYOp9+nKgZRgeQtxG0BC0rZks=@vger.kernel.org
X-Received: by 2002:a05:6102:14a9:b0:600:ac0:ce33 with SMTP id
 ada2fe7eead31-62afc5062bbmr347701137.5.1777534020660; Thu, 30 Apr 2026
 00:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429114355.6c712e6a@gandalf.local.home> <20260429114747.4cf74d04@gandalf.local.home>
 <b743d575-0842-4718-8dc9-23c3c97b4a92@efficios.com>
In-Reply-To: <b743d575-0842-4718-8dc9-23c3c97b4a92@efficios.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Apr 2026 09:26:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZojwb_oc1O7io5gXDYSXos1FN1wFymp-UzgAtGTjO6g@mail.gmail.com>
X-Gm-Features: AVHnY4JGT2_BT-KASFaK_HQ4YttKP1fcj-B1OQssyz9iS1fAt2Ncyqnc8Ads_GE
Message-ID: <CAMuHMdUZojwb_oc1O7io5gXDYSXos1FN1wFymp-UzgAtGTjO6g@mail.gmail.com>
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, 
	Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 20:35, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> On 2026-04-29 11:47, Steven Rostedt wrote:
> > On Wed, 29 Apr 2026 11:43:55 -0400
> > Steven Rostedt <rostedt@kernel.org> wrote:
> >
> >> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> >> index 4fcc7c58a105..005441233932 100644
> >> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> >> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> >> @@ -562,3 +562,4 @@
> >>   469        common  file_setattr                    sys_file_setattr
> >>   470        common  listns                          sys_listns
> >>   471        nospu   rseq_slice_yield                sys_rseq_slice_yield
> >> +472 nospu   stacktrace_setup                sys_stacktrace_setup
> >
> > BTW, I have no idea what "nospu" is. I did some searches for PowerPC and
> > spu vs nospu and the only thing I found was a stackoverflow asking about
> > it, and the response was "don't worry about it".
> >
> > I only picked nospu because I noticed that rseq_slice_yield used it, but
> > that doesn't give me a good feeling that it's correct.
>
> AFAIR PowerPC SPUs are the Cell "Synergistic Processing Units", e.g.
> for Playstation 3.

Exactly. System call numbers are the same for normal (PPU = PowerPC)
CPUs and SPUs, but SPUs don't need all syscalls.  Hence the option to
exclude a syscall for the SPUs by marking it "nospu".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
