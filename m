Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD0E42AA3
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Apr 2025 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743470941; cv=none; b=In4bpQcsFfoXGQteafg8l+l69mWVLzcPDFAlynQZbDkkwd2nkAD77Ucjuz8saRgSTke8WCTskN6wWSlVprB7iD7mV6G3H2cH8AKBCrsiHWBggIsQwqDGJJD/7661H5nr+gZn4bYDsD3Po7T9YWfoSw3hWj8/CMsOMVusr/KO8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743470941; c=relaxed/simple;
	bh=GhPAaqOA3j3FYRbo3B5JHACvUs9UEP/cCHIrgKY6SZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JqmfR6K/oXlo3hdThEAeHcQgBOHG4JIcd6tuSOIXHnGUGS7fcXGqA5BaHyYzLotxHToVenGkfAZK9P+wZoj4eWYYLrOfSG1VMzhCcbjo/hK3Vnqbzfx2qN+BTmMEEuU7vso1EaKpednp15h0YfJGSRsPs7idPaJQZNssS22uaco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G//9xqmf; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G//9xqmf"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ee2e154a35so5211a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 18:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743470937; x=1744075737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhPAaqOA3j3FYRbo3B5JHACvUs9UEP/cCHIrgKY6SZU=;
        b=G//9xqmfZQOOGvzbsoGlwXElN8A52saeFQYQ4z15+GegKArgx+RFp5Qz/XoyodpEdw
         j1LpYY8zKrTrvOgt6T3ebbp5+NSZbkad/W/LrVfCQszzddDF0bfCTSgqD7XVTWOGGEAe
         kglMX+IM4rdYyO7bMtWPCu436FGpMfB8MIqLHQWnWw1HecG1h6MMeFC4IkJx9qTDzysZ
         bm/z/gQTxWgO39W+33W/HNmoE7nmeEUO6grD/QIoMISJmc0WIJpSOftkk4Nm7F7amvwJ
         T5yZnrsDDEYTz6kImKhAsaaRdt9aB8p8AwjAbJ9j2PNemtWRtrkIdNUSROCawCTlG3gE
         efXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743470937; x=1744075737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhPAaqOA3j3FYRbo3B5JHACvUs9UEP/cCHIrgKY6SZU=;
        b=HfRbm+C6aBRAOQXggruBQYbb5h4q4oNFvtT3FOFMe1PN8DCETAlqfFHng+W4LbkqaT
         nshyrODn3rLHCM5owYy93l8DORhqoctevF7E7EgIMFrHu35sevdNhHQZb31jJ1VtGF5B
         lNg0I5y7m4Ptv9aDoM72GaW+j5TJIsF3j0hCK2voPEUGsA3es/7duLd0EVTWT1JQnz5o
         iWprPiWv8iHu5b9dfEVwlJ7SavwkyvM6Py7CMcyKoBtzPsSRRE91jJ5xVZJ5leBvQfID
         kiu83O4uwGRhvXoE0+TrBw96prtioA5vKJTi2WJDH5942vGt+JRE5foaxmkveGqSvBTV
         tQDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0aykM18eDeSk3m5ErLXKS/Dm8piSEJNokaKyfp8p7LUNkEqsCpvFIUIYS3vtniVVJeAIFfEu7yCgdUe8AGO/JhW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvboablInnnaN1M1ieCHcxMc3tpE23gl4SfnTNDCK6c1OLoOg
	iNOs4o35WbhBoTVh/ZB7xuhLzJ4uYV+ADCdSF/HCkqtQhsOdIgzHyYlI0M1EtS/RxVMdk42wU6p
	qfqKDpWIC13Mmpq4HAG1DOR2EAJI07Nd0ue4/
X-Gm-Gg: ASbGncvdksl6mNTOikntO9KKOtp2gzACAddK4+241Mu/15JcesTUdmTbFARZTxS5suk
	XTESaF6e1N3tacsvF2KXy1RX4UOK1uvzeMT4WUKAwBplXwTj3seL4Va/XBx2O3h3F9pSptn/mMW
	LzxCyulnKSBPuQraJ9R8L5cAiEZr1OgEWzonLr+aw9ugDA/Bbxpqd0oQ==
X-Google-Smtp-Source: AGHT+IFdpNIM74DMCYlSQZGDg0V5ofJ9VTljm7g6xclq3VUdZ5+XmVgPyYoA5Gbye57wb0GhpZdA2Nga3kXNHdUDLRo=
X-Received: by 2002:aa7:c31a:0:b0:5e5:c024:ec29 with SMTP id
 4fb4d7f45d1cf-5f029198a48mr66087a12.0.1743470937193; Mon, 31 Mar 2025
 18:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home> <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home> <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
 <20250331194251.02a4c238@gandalf.local.home> <CAG48ez3w0my4Rwttbc5tEbNsme6tc0mrSN95thjXUFaJ3aQ6SA@mail.gmail.com>
 <20250331210245.585fff23@gandalf.local.home>
In-Reply-To: <20250331210245.585fff23@gandalf.local.home>
From: Jann Horn <jannh@google.com>
Date: Tue, 1 Apr 2025 03:28:20 +0200
X-Gm-Features: AQ5f1JokqTzRkKiXuPKditTAiXHP1I8Yb_LJd1w5FZamGO9Sa0X64-0iuZtZY8I
Message-ID: <CAG48ez1mZ4nq-_DXHqiHe8_tSX37DdcngnULqXQ71fFt0oQPyA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 3:01=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
> On Tue, 1 Apr 2025 02:09:10 +0200
> Jann Horn <jannh@google.com> wrote:
>
> > On Tue, Apr 1, 2025 at 1:41=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > > On Mon, 31 Mar 2025 14:42:38 -0700
> > > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > >
> > > > .. and *after* you've given it back to the memory allocator, and it
> > > > gets allocated using the page allocators, at that point ahead and u=
se
> > > > 'struct page' as much as you want.
> > > >
> > > > Before that, don't. Even if it might work. Because you didn't alloc=
ate
> > > > it as a struct page, and for all you know it might be treated as a
> > > > different hotplug memory zone or whatever when given back.
> > >
> > > Hmm, so if we need to map this memory to user space memory, then I ca=
n't
> > > use the method from this patch series, if I have to avoid struct page=
.
> > >
> > > Should I then be using vm_iomap_memory() passing in the physical addr=
ess?
> >
> > For mapping random physical memory ranges into userspace, we have
> > helpers like remap_pfn_range() (the easy option, for use in an mmap
> > handler, in case you want to want to map one contiguous physical
> > region into userspace) and vmf_insert_pfn() (for use in a page fault
> > handler, in case you want to map random physical pages into userspace
> > on demand).
>
> Note, I believe that Linus brought up the issue that because this physica=
l
> memory is not currently part of the memory allocator (it's not aware of i=
t
> yet), that the getting struct page or a "pfn" for it may not be reliable.

PFN mappings are specifically designed to work with memory that does
not have "struct page":

#define VM_PFNMAP 0x00000400 /* Page-ranges managed without "struct
page", just pure PFN */

> > > As for architectures that do not have user/kernel data cache coherenc=
y, how
> > > does one flush the page when there's an update on the kernel side so =
that
> > > the user side doesn't see stale data?
> >
> > flush_kernel_vmap_range() (and invalidate_kernel_vmap_range() for the
> > other direction) might be what you want... I found those by going
> > backwards from an arch-specific cache-flushing implementation.
> >
> > > As the code currently uses flush_dcache_folio(), I'm guessing there's=
 an
> > > easy way to create a folio that points to physical memory that's not =
part
> > > of the memory allocator?
> >
> > Creating your own folio structs sounds like a bad idea; folio structs
> > are supposed to be in specific kernel memory regions. For example,
> > conversions from folio* to physical address can involve pointer
> > arithmetic on the folio*, or they can involve reading members of the
> > pointed-to folio.
>
> Linus already mentioned flush_cache_range() which looks to be the thing t=
o
> use.

It looks like flush_kernel_vmap_range() is used for flushing dcache
for the kernel mapping, while flush_cache_range() is for flushing
dcache/icache for the userspace mapping?

For example, on 32-bit arm, you might go down these paths, ending up
in arch-specific functions that make it clear whether they're for the
user side or the kernel side:

flush_cache_range -> __cpuc_flush_user_range

flush_kernel_vmap_range -> __cpuc_flush_dcache_area ->
cpu_cache.flush_kern_dcache_area

I think you probably need flushes on both sides, since you might have
to first flush out the dirty cacheline you wrote through the kernel
mapping, then discard the stale clean cacheline for the user mapping,
or something like that? (Unless these VIVT cache architectures provide
stronger guarantees on cache state than I thought.) But when you're
adding data to the tracing buffers, I guess maybe you only want to
flush the kernel mapping from the kernel, and leave flushing of the
user mapping to userspace? I think if you're running in some random
kernel context, you probably can't even reliably flush the right
userspace context - see how for example vivt_flush_cache_range() does
nothing if the MM being flushed is not running on the current CPU.
