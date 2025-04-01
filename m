Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6921EBA08;
	Tue,  1 Apr 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501204; cv=none; b=YRznoK7tERr+Ndr++TN8BXhxO6hst12IGQxMqiUMxiIFMbqnO/D0Tjjefek/6ATr4C9/BwfWx0AwM8nf5XP8exPFymDBfd5YuhmD/0ptCgMqTsSOJZOPr5PEghl+JUgo5wsIcaN1bo5y1qhUn0mKiMfWV4il+L9qx7yO2UeP4tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501204; c=relaxed/simple;
	bh=1Mf8Ez5FaQfBpAnf7/eDGb1Tcc+xI9OJZdyzg+Hbl1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZEfHzyNQ6RrkYnyyRDRdjBbSXoYZpxG8PsXYYURDbiItnnL11JOZfieqPU1kMC5G4ukI2exeXE7tckma296gneoV3vjRyXALdWUnLzclhjaQzoU/P2zsvoVrTNjBxNskk9sQVG1pgWzMIDt0ZXUx48cCzTx7kffw3M7p5q/80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSnlA7RI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSnlA7RI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C09C4CEE5;
	Tue,  1 Apr 2025 09:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743501203;
	bh=1Mf8Ez5FaQfBpAnf7/eDGb1Tcc+xI9OJZdyzg+Hbl1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JSnlA7RI5TEP5P8l+VosiNEYu7slQ3LwqzMloU9PvYMJI3mJ9zvpXATb20MGSgWvM
	 aiWa8Mt51mMw1rnCA+kKpSYYKYdizUhEhi2OeJ2lxOVdAtu/5q6uILTeuWUwoCYlFg
	 tcZt23H6cAOCkl6aohn/hwz3/GZqMVCdF3fGygbnEyZZJ400QkhWvIoH4mlpu/xUbt
	 2rF/R+LrKf37z7yMxx012EHKjDtR8wv/1FXAG+ffCECdo5yIB9YsPSMjyx07b0qfdh
	 dpBTOTgHJBeZBaldvcjzUt9sKrVNEpJdrcLazV1FsXqgAPFH8i5c1fjXOY8FWstsna
	 AkA7i5xtZWaVw==
Date: Tue, 1 Apr 2025 11:53:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <Z-u3jW1zdqic9IKy@gmail.com>
References: <20250331133906.48e115f5@gandalf.local.home>
 <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home>
 <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
 <20250331194251.02a4c238@gandalf.local.home>
 <CAG48ez3w0my4Rwttbc5tEbNsme6tc0mrSN95thjXUFaJ3aQ6SA@mail.gmail.com>
 <20250331210245.585fff23@gandalf.local.home>
 <CAHk-=wi=GNaLzNt5zjee6m9OHNvr=Sc1S-xsnS0cNMfdVp15hg@mail.gmail.com>
 <20250331214132.49622459@gandalf.local.home>
 <CAHk-=wjijTKpotANjhqoKrEFh=B=RLrfGWa7OFB2WJ9RU8jaaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjijTKpotANjhqoKrEFh=B=RLrfGWa7OFB2WJ9RU8jaaA@mail.gmail.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 31 Mar 2025 at 18:40, Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > I think 'pfn' was introduced as a name ong long ago because it was
> > > what the alpha architecture used in the VM documentation. It probably
> > > predates that too, but it's where I got it from, iirc.
> > >
> >
> > It is old, as I remember using it when I first started Linux kernel
> > development back in 1998.
> 
> So I did the alpha port in '95, but I meant that the 'page frame
> number' as a name may well have roots that go much further back. I
> only know it from the alpha architecture docs.
> 
> Google only seems to find the modern Linux use, but I wouldn't be
> surprised if the alpha architects got it from some much older use (I
> would suspect VMS).

*Technically*, for those of us with a weakness for Git archeology, the 
'PFN' term was first introduced in Linux with the MIPS port, which went 
upstream via Linux 1.1.45, released on 1994/04/06, and had this in 
include/asm-mips/mipsregs.h:

  +/*
  + * Compute a vpn/pfn entry for EntryHi register
  + */
  +#define VPN(addr,pagesizeshift) ((addr) & ~((1 << (pagesizeshift))-1))
  +#define PFN(addr,pagesizeshift) (((addr) & ((1 << (pagesizeshift))-1)) << 6)

... while your Alpha port went upstream via 1.1.57, released on 
1994/10/24, and the first mention of 'PFN' was in arch/alpha/mm/init.c, 
introduced as part of 1.1.82, released 1995/01/16, almost a year later:

  +unsigned long paging_init(unsigned long start_mem, unsigned long end_mem)
  ..
  +               unsigned long pfn, nr;
  +               if (cluster->usage & 1)
  +                       continue;
  +               pfn = cluster->start_pfn;
  +               nr = cluster->numpages;

So you don't appear to have dibs on the PFN name within Linux, although 
I suspect MIPS and Alpha had it from a similar background. :-)

By the way, some quick review feedback on that patch: there should be 
extra newlines after variable declarations - clearly the author is not 
a good kernel programm... oh, never mind.

Thanks,

	Ingo
