Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2C863B8;
	Mon,  6 May 2024 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714991926; cv=none; b=l6VGqmoAbiNK8lR1Y+DRBG0AnYt2DOj7t2hN25BgQNf+YulWT+NLK6aMkyu6KyW3KB2Z6JoFbrA7S0Ss9CZRHm+TgxzO2MeW/a8fDFavUmWhZ1nZdGopD+jxJjoC7nK10Lz7dRBX3FIwbWYIfQNpRa+NbrlOfp0AQ0a5MPiH/t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714991926; c=relaxed/simple;
	bh=+sMre+0s8XuSqhviOvxYhM1E9EHHXARPAYeKH8OPY78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqLlgiBjPiRi3KLd0iVjvFUS5/XnOt+gynd9bG4m+jXPidHcz1w22O2VKQ3iwr14EqGadcY0M6IAjzqDx6lMP8b2mOgEK/ifO4OVzgkUwyHUVtyWhm9MfAYIneDeyd6/BMorQOGRTqBVs2dyTJLv2nr3vnQoksHyCi2f4H0oMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5chX6W+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5chX6W+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FEDC4DDE3;
	Mon,  6 May 2024 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714991925;
	bh=+sMre+0s8XuSqhviOvxYhM1E9EHHXARPAYeKH8OPY78=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p5chX6W+7I2fDJkE1QqM9wRxsSH/i/mgVUsH3W5V8yEUMBAthAeB0+rRqPoEY3JCr
	 vpo80Tf8X8DlxxksbetRo+ksekpb00QRchH8UT8aa9L99POHSKNMbkzkx9BJXribmZ
	 6qAU9u5zE9mhdIwL+BVu7hWwGzUQs8Xxl6rr41WErC51eyPSjn2Gvi3TZDdimZwxYP
	 a7SrGaLFiuBJvmFMPQ8saRtckD+3jNPkdU1QasHUnXKomBZVFzTAKnOMa+59hjkVC3
	 5AV9Mvyxy64NPjOzCu9cqaoc+ivkUdY4feLk15FDsZrT5aBJ9+QDooMekmIkYSNLzZ
	 ozqdCoso0VJ9A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52006fbae67so2316604e87.0;
        Mon, 06 May 2024 03:38:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUv9sMl3MyDiEbQBABnkseJoXn3ogwBJ/1nu/QQ3jQoO/kbl06pMGkQPx1XsJa6TuYs8ilVRP44zApo4krW10iS+IUNznj/HWUHLHoFtObdrsiKPmpFAtJRrnV9vFX77xKWQd/xPkLCNcDnG0sEiU2rpULyeF8/Lz8tET4/uUZNE+xZiBp9e8Z3Uuvh6XiCKa89
X-Gm-Message-State: AOJu0YxABy7MhtxHdxB25LqXWo9ytHNJiPRL4HES1I8DP4b9qz8WrfCl
	GotV5QgL2ZwR8ZHpUYWmMns8hbz3TNHWMHghJCgshSGYvTTvJGcy1qKQTGEhuJkoJSJUhd3lKG5
	T6512xHYUCBViPptcJ2Sx27FendM=
X-Google-Smtp-Source: AGHT+IGrmdoDC9OU2KevduoZC6ArmZA6QOhPgQmvYxG1IrrYVOP27uC3VgBT/7g9DgqcivO0pnNgMPGrMBtlEAKwxG0=
X-Received: by 2002:a05:6512:33c5:b0:51e:1bed:13a8 with SMTP id
 d5-20020a05651233c500b0051e1bed13a8mr6619509lfg.29.1714991924016; Mon, 06 May
 2024 03:38:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409210254.660888920@goodmis.org> <20240409211351.075320273@goodmis.org>
 <202404091521.B63E85D@keescook> <20240409191156.5f92a15c@gandalf.local.home>
 <202404091638.2F98764A41@keescook> <Zhmgm86tzpanoweB@kernel.org>
 <20240412181940.3e1d99f7@gandalf.local.home> <202404151017.FC002AA5@keescook> <ZjJYV7ak5ApgNTBx@kernel.org>
In-Reply-To: <ZjJYV7ak5ApgNTBx@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 6 May 2024 12:38:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG3jiLahONhPkKD0VSngDnMQoUCkDmoCsWEzOHDZmhTiA@mail.gmail.com>
Message-ID: <CAMj1kXG3jiLahONhPkKD0VSngDnMQoUCkDmoCsWEzOHDZmhTiA@mail.gmail.com>
Subject: Re: [POC][RFC][PATCH 1/2] mm/x86: Add wildcard * option as memmap=nn*align:name
To: Mike Rapoport <rppt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>, wklin@google.com, 
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Suleiman Souhlal <suleiman@google.com>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 1 May 2024 at 16:59, Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Apr 15, 2024 at 10:22:53AM -0700, Kees Cook wrote:
> > On Fri, Apr 12, 2024 at 06:19:40PM -0400, Steven Rostedt wrote:
> > > On Fri, 12 Apr 2024 23:59:07 +0300
> > > Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > > On Tue, Apr 09, 2024 at 04:41:24PM -0700, Kees Cook wrote:
> > > > > On Tue, Apr 09, 2024 at 07:11:56PM -0400, Steven Rostedt wrote:
> > > > > > On Tue, 9 Apr 2024 15:23:07 -0700
> > > > > > Kees Cook <keescook@chromium.org> wrote:
> > > > > >
> > > > > > > Do we need to involve e820 at all? I think it might be possible to just
> > > > > > > have pstore call request_mem_region() very early? Or does KASLR make
> > > > > > > that unstable?
> > > > > >
> > > > > > Yeah, would that give the same physical memory each boot, and can we
> > > > > > guarantee that KASLR will not map the kernel over the previous location?
> > > > >
> > > > > Hm, no, for physical memory it needs to get excluded very early, which
> > > > > means e820.
> > > >
> > > > Whatever memory is reserved in arch/x86/kernel/e820.c, that happens after
> > > > kaslr, so to begin with, a new memmap parameter should be also added to
> > > > parse_memmap in arch/x86/boot/compressed/kaslr.c to ensure the same
> > > > physical address will be available after KASLR.
> > >
> > > But doesn't KASLR only affect virtual memory not physical memory?
> >
> > KASLR for x86 (and other archs, like arm64) do both physical and virtual
> > base randomization.
> >
> > > This just makes sure the physical memory it finds will not be used by the
> > > system. Then ramoops does the mapping via vmap() I believe, to get a
> > > virtual address to access the physical address.
> >
> > I was assuming, since you were in the e820 code, that it was
> > manipulating that before KASLR chose a location. But if not, yeah, Mike
> > is right -- you need to make sure this is getting done before
> > decompress_kernel().
>
> Right now kaslr can handle up to 4 memmap regions and parse_memmap() in
> arch/x86/boot/compressed/kaslr.c should be updated for a new memmap type.
>
> But I think it's better to add a new kernel parameter as I suggested in
> another email and teach mem_avoid_memmap() in kaslr.c to deal with it, as
> well as with crashkernel=size@offset, btw.
>

The logic in arch/x86/boot/compressed/kaslr.c is now only used by non-EFI boot.

In general, I am highly skeptical that hopes and prayers are enough to
prevent the firmware from stepping on such a region, unless this is
only a best effort thing, and failures are acceptable. For instance,
booting an EFI system with/without an external display attached, or
with a USB device inserted (without even using it during boot) will
impact the memory map, to the extent that the E820 table derived from
it may look different. (EFI tries to keep the runtime regions in the
same place but the boot-time regions are allocated/freed on demand)

So I would strongly urge to address this properly, and work with
firmware folks to define some kind of protocol for this.
