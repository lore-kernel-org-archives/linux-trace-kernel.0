Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680CF86353;
	Tue,  1 Apr 2025 01:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743469308; cv=none; b=OUvod/Yhp/utHDW8APJ4ARSH9Zt87rEnxRUQQnWous2rozL6sXL+LvqZ8/Vuf9VbR/Kntlw6+P5vuS8nAwE0srtA+/pqzA2Gitxc81EL2YRQerMIUkFVZ5F4B1UpO3UDWkhGMfYidRxrWDQhVp+7leVU4FWqBhLWEQP9b35dSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743469308; c=relaxed/simple;
	bh=kFndhdL1+Fi31s7M82lXfVwQLCJS7fRhq/+SXk7OKa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/PHJ9baBizLpQ5wIvbjdFdx0gFu8BVSew78u+a5aOsrKK/ONtzHiLD9Mz1VWU8M1CleHYfyOUho2DSYDJ8LBhh9iM2eYCEt4jmoBCKNvc9OJd6RXkauheTulGIIY6fkBChJ9NnY1F0zkE7N1UQXVT9iQP8eKb96Z33L7HMQvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F526C4CEE3;
	Tue,  1 Apr 2025 01:01:46 +0000 (UTC)
Date: Mon, 31 Mar 2025 21:02:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees
 Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <20250331210245.585fff23@gandalf.local.home>
In-Reply-To: <CAG48ez3w0my4Rwttbc5tEbNsme6tc0mrSN95thjXUFaJ3aQ6SA@mail.gmail.com>
References: <20250331143426.947281958@goodmis.org>
	<20250331143532.459810712@goodmis.org>
	<CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
	<20250331133906.48e115f5@gandalf.local.home>
	<CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
	<20250331165801.715aba48@gandalf.local.home>
	<CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
	<20250331194251.02a4c238@gandalf.local.home>
	<CAG48ez3w0my4Rwttbc5tEbNsme6tc0mrSN95thjXUFaJ3aQ6SA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Apr 2025 02:09:10 +0200
Jann Horn <jannh@google.com> wrote:

> On Tue, Apr 1, 2025 at 1:41=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> > On Mon, 31 Mar 2025 14:42:38 -0700
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > =20
> > > .. and *after* you've given it back to the memory allocator, and it
> > > gets allocated using the page allocators, at that point ahead and use
> > > 'struct page' as much as you want.
> > >
> > > Before that, don't. Even if it might work. Because you didn't allocate
> > > it as a struct page, and for all you know it might be treated as a
> > > different hotplug memory zone or whatever when given back. =20
> >
> > Hmm, so if we need to map this memory to user space memory, then I can't
> > use the method from this patch series, if I have to avoid struct page.
> >
> > Should I then be using vm_iomap_memory() passing in the physical addres=
s? =20
>=20
> For mapping random physical memory ranges into userspace, we have
> helpers like remap_pfn_range() (the easy option, for use in an mmap
> handler, in case you want to want to map one contiguous physical
> region into userspace) and vmf_insert_pfn() (for use in a page fault
> handler, in case you want to map random physical pages into userspace
> on demand).

Note, I believe that Linus brought up the issue that because this physical
memory is not currently part of the memory allocator (it's not aware of it
yet), that the getting struct page or a "pfn" for it may not be reliable.

>=20
> > As for architectures that do not have user/kernel data cache coherency,=
 how
> > does one flush the page when there's an update on the kernel side so th=
at
> > the user side doesn't see stale data? =20
>=20
> flush_kernel_vmap_range() (and invalidate_kernel_vmap_range() for the
> other direction) might be what you want... I found those by going
> backwards from an arch-specific cache-flushing implementation.
>=20
> > As the code currently uses flush_dcache_folio(), I'm guessing there's an
> > easy way to create a folio that points to physical memory that's not pa=
rt
> > of the memory allocator? =20
>=20
> Creating your own folio structs sounds like a bad idea; folio structs
> are supposed to be in specific kernel memory regions. For example,
> conversions from folio* to physical address can involve pointer
> arithmetic on the folio*, or they can involve reading members of the
> pointed-to folio.

Linus already mentioned flush_cache_range() which looks to be the thing to
use.

-- Steve

