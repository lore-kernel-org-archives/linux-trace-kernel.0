Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284582D98;
	Tue, 18 Jun 2024 10:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706093; cv=none; b=C8YDK+TtiaYZCKEwXytBb30mRw01vXg6WmI7GXVoh3Xk1SmlOA2koEMmaW7ZqhZEIuBh4UQ5XKPth++qhqb3KgVC+XLUd69W+lOvOslsutZ+DBjDoYSZROn2TtOmavBAZt98QUf4D7s0vTBdhJOMTFvaBzxBDGW6RSc7tfaJKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706093; c=relaxed/simple;
	bh=N7eOxHp2WbWwLt0YRrTk1o+SIsaJnwdVhP4S5VDFwEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkhFrhlET482tcW+9wT3QmIZRhprjgUQz1WnsrGfyeAONJ2WSrvU7oaiPRctdJRId1u3H6SWGiT/sXoRLnFY4sW/iCWFYWtcDUFc9vPRwrmPxYdfu6m3AwCuZPPTWDGQaH4foBVoOzFdEwCuDdNSKNU/61Blh+i6b5WgkIUhxBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTxtR7Sl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTxtR7Sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB237C4AF55;
	Tue, 18 Jun 2024 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718706092;
	bh=N7eOxHp2WbWwLt0YRrTk1o+SIsaJnwdVhP4S5VDFwEw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kTxtR7SlN0EhVtmUeut5MWOZA05CKSkmwDRc4Zt+i7CAusx/mmy1hJKMgoK6grpjl
	 Mu/o0Nez7NujK90Wrc6Vnnoa6Yc1WsB8XrsVK6gdsQmQsQv6KbFiENwWcD6LN/WaY+
	 etsH2vVebwV4DeNFQ0J6CgoN4yho63aGwVG1nh/Z9sk7MjcYaSGWsGNYR50Nh9GTL4
	 FLI+N0fHEp8UHrMMVC3fnXvqXUg0RTwUnIrCPR1Osdg9zjbDX28VXu0gijwsMle6qB
	 K0BvaPZ1N5ch4ulPPGZ3zqNf6pn7IQRsuLUuRxTqllHuKzQIbnjnWSyZOGdEQUeTFW
	 6e+BuWsgyLRuA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ebe3bac675so47382211fa.1;
        Tue, 18 Jun 2024 03:21:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1l5J8m5z79nfsvOKsZMAUdfUHfvWp4ganRZFcWZQmdKV8fXiEMxjkrQRQZIv8aJUGYCIAtWF9Yt43ck3E9MjKrkMqbP6piQJHQhAVl3edaxYkpkl+9bGfVMdb7IbEkTieJbxNIb5wPOTL7MdDAWpX
X-Gm-Message-State: AOJu0YyxznfSNd6KhEzdFSfDuiuganyKw9vX/UocaidjsTkhMh2ROspu
	nUtHw8uNxQGkRhZgA7xblE6MyHc5l/PhN2JkQZdsgNmaioNcDPfqXYYfzxdjD64g4roNgg1wOck
	WBKhSydFAGalGl6oU8sgKLBrVVr0=
X-Google-Smtp-Source: AGHT+IFuvWaoKBQenRCtc9r/vp/7EgwSDRST9GJCUelo+dCGXvyD4rIWiz64mttYriWu4xBfPOTN5yaGNKYJrrOXS68=
X-Received: by 2002:a2e:9157:0:b0:2ea:ab3b:fd89 with SMTP id
 38308e7fff4ca-2ec3465230emr5779411fa.10.1718706090736; Tue, 18 Jun 2024
 03:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613155506.811013916@goodmis.org> <b0ed328f-c4e5-4e9b-ae4e-5c60703ab376@amazon.com>
 <20240613131212.7d1a7ffa@rorschach.local.home> <7c90c574-5cfa-40cf-bd4c-1188136cd886@amazon.com>
 <20240617164006.198b9ba3@rorschach.local.home> <049b2e0f-00b2-4704-8868-1569a006a134@amazon.com>
In-Reply-To: <049b2e0f-00b2-4704-8868-1569a006a134@amazon.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 18 Jun 2024 12:21:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF3AetyuLh-QU8yaE-wTLcgyzwuAwe-uo_3EqSDsAYhuQ@mail.gmail.com>
Message-ID: <CAMj1kXF3AetyuLh-QU8yaE-wTLcgyzwuAwe-uo_3EqSDsAYhuQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
To: Alexander Graf <graf@amazon.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, suleiman@google.com, 
	Thomas Gleixner <tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, 
	Youssef Esmat <youssefesmat@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, 
	David Howells <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Jun 2024 at 23:01, Alexander Graf <graf@amazon.com> wrote:
>
> On 17.06.24 22:40, Steven Rostedt wrote:
> > On Mon, 17 Jun 2024 09:07:29 +0200
> > Alexander Graf<graf@amazon.com>  wrote:
> >
> >> Hey Steve,
> >>
> >>
> >> I believe we're talking about 2 different things :). Let me rephrase a
> >> bit and make a concrete example.
> >>
> >> Imagine you have passed the "reserve_mem=12M:4096:trace" kernel command
> >> line option. The kernel now comes up and allocates a random chunk of
> >> memory that - by (admittedly good) chance - may be at the same physical
> >> location as before. Let's assume it deemed 0x1000000 as a good offset.
> > Note, it's not random. It picks from the top of available memory every
> > time. But things can mess with it (see below).
> >
> >> Let's now assume you're running on a UEFI system. There, you always have
> >> non-volatile storage available to you even in the pre-boot phase. That
> >> means the kernel could create a UEFI variable that says "12M:4096:trace
> >> -> 0x1000000". The pre-boot phase takes all these UEFI variables and
> >> marks them as reserved. When you finally reach your command line parsing
> >> logic for reserve_mem=, you can flip all reservations that were not on
> >> the command line back to normal memory.
> >>
> >> That way you have pretty much guaranteed persistent memory regions, even
> >> with KASLR changing your memory layout across boots.
> >>
> >> The nice thing is that the above is an extension of what you've already
> >> built: Systems with UEFI simply get better guarantees that their regions
> >> persist.
> > This could be an added feature, but it is very architecture specific,
> > and would likely need architecture specific updates.
>
>
> It definitely would be an added feature, yes. But one that allows you to
> ensure persistence a lot more safely :).
>
>
> >>>>> Requirement:
> >>>>>
> >>>>> Need a way to reserve memory that will be at a consistent location for
> >>>>> every boot, if the kernel and system are the same. Does not need to work
> >>>>> if rebooting to a different kernel, or if the system can change the
> >>>>> memory layout between boots.
> >>>>>
> >>>>> The reserved memory can not be an hard coded address, as the same kernel /
> >>>>> command line needs to run on several different machines. The picked memory
> >>>>> reservation just needs to be the same for a given machine, but may be
> >>>> With KASLR is enabled, doesn't this approach break too often to be
> >>>> reliable enough for the data you want to extract?
> >>>>
> >>>> Picking up the idea above, with a persistent variable we could even make
> >>>> KASLR avoid that reserved pstore region in its search for a viable KASLR
> >>>> offset.
> >>> I think I was hit by it once in all my testing. For our use case, the
> >>> few times it fails to map is not going to affect what we need this for
> >>> at all.
> >> Once is pretty good. Do you know why? Also once out of how many runs? Is
> >> the randomness source not as random as it should be or are the number of
> >> bits for KASLR maybe so few on your target architecture that the odds of
> >> hitting anything become low? Do these same constraints hold true outside
> >> of your testing environment?
> > So I just ran it a hundred times in a loop. I added a patch to print
> > the location of "_text". The loop was this:
> >
> >    for i in `seq 100`; do
> >          ssh root@debiantesting-x86-64 "dmesg | grep -e 'text starts' -e 'mapped boot'  >> text; grub-reboot '1>0'; sleep 0.5; reboot"
> >          sleep 25
> >    done
> >
> > It searches dmesg for my added printk as well as the print of were the
> > ring buffer was loaded in physical memory.
> >
> > It takes about 15 seconds to reboot, so I waited 25. The results are
> > attached. I found that it was consistent 76 times, which means 1 out of
> > 4 it's not. Funny enough, it broke whenever it loaded the kernel below
> > 0x100000000. And then it would be off by a little.
> >
> > It was consistently at:
> >
> >    0x27d000000
> >
> > And when it failed, it was at 0x27ce00000.
> >
> > Note, when I used the e820 tables to do this, I never saw a failure. My
> > assumption is that when it is below 0x100000000, something else gets
> > allocated causing this to get pushed down.
>
>
> Thinking about it again: What if you run the allocation super early (see
> arch/x86/boot/compressed/kaslr.c:handle_mem_options())?

That code is not used by EFI boot anymore.

In general, I would recommend (and have recommended) against these
kinds of hacks in mainline, because -especially on x86- there is
always someone that turns up with some kind of convoluted use case
that gets broken if we try to change anything in the boot code.

I spent considerable time over the past year making the EFI/x86 boot
code compatible with the new MS imposed requirements on PC boot
firmware (related to secure boot and NX restrictions on memory
mappings). This involved some radical refactoring of the boot
sequence, including the KASLR logic. Adding fragile code there that
will result in regressions observable to end users when it gets broken
is really not what I'd like to see.

So I would personally prefer for this code not to go in at all. But if
it does go in (and Steven has already agreed to this), it needs a
giant disclaimer that it is best effort and may get broken
inadvertently by changes that may seem unrelated.

> If you stick to
> allocating only from top, you're effectively kernel version independent
> for your allocations because none of the kernel code ran yet and
> definitely KASLR independent because you're running deterministically
> before KASLR even gets allocated.
>

Allocating top down under EFI is almost guaranteed to result in
problems, because that is how the EFI page allocator works as well.
This means that allocations will move around depending on, e.g.,
whether some USB stick was inserted on the first boot and removed on
the second, or whether your external display was on or off.

> > As this code relies on memblock_phys_alloc() being consistent, if
> > something gets allocated before it differently depending on where the
> > kernel is, it can also move the location. A plugin to UEFI would mean
> > that it would need to reserve the memory, and the code here will need
> > to know where it is. We could always make the function reserve_mem()
> > global and weak so that architectures can override it.
>
>
> Yes, the in-kernel UEFI loader (efi-stub) could simply populate a new
> type of memblock with the respective reservations and you later call
> memblock_find_in_range_node() instead of memblock_phys_alloc() to pass
> in flags that you want to allocate only from the new
> MEMBLOCK_RESERVE_MEM type.

This would require the introduction of a new kind of memory map for
the handover between EFI stub and core kernel. Currently, x86 relies
on E820 and other architectures pass the EFI memory map unmodified.
