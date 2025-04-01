Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA7D79FE;
	Tue,  1 Apr 2025 17:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743530332; cv=none; b=YSmYef53D8x/M9ehAr+02cmbfUHAj4ZOSFMfxB2/GQwRn558j79DOgM8rnOZOXpXWd9qXxKE0JOPplXgAx8beoRTuXGXRsMtOM56rLEdmeul88KZgvEuW+TxriDuwu6YPrsAePSYShO94T0qUAupOm5NnvkZ51NHFzkHNeaCvfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743530332; c=relaxed/simple;
	bh=wiGocuCPvltfWWje9XoaBmB3Bty+R3cKGynKNs7ru6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGy60X+37DNounJG7mG6nJwXw0Xz5egudQ8pLbCmOIXsnmJO8GK7/tNRId5USuZ9Ck+Es8oxi2I+oJwLF3IGfYIDV72HqokSxhaXAXe5AjSjPYP5MWwDRgIR7UIvaX6XpsYfSV7l7R9m6ZetArYYy8nxlNEBDOiOkBoEqbeUT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOtMo4dh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOtMo4dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B847C4CEE4;
	Tue,  1 Apr 2025 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743530331;
	bh=wiGocuCPvltfWWje9XoaBmB3Bty+R3cKGynKNs7ru6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OOtMo4dhzFu0UvTT47V/tlPt5W8cfdYm5/embeWyUCu1HaA6a2kSi5ThOvHBljjRm
	 bkBw+2mIDvULCHj/BwF58PBcs4dT3WyJCVMYpbn0u1k9wkYyZoHtLUzEMmFzJrWeaR
	 qJQAEYLw1tl5Y536VjSqvyLC2TfGXUusJDXZtFE+JhD0YlIfLTSS07po2r8xib9i5h
	 rDUhOUqIV04EmDSOM75nnnT/KPY7Y2vjU72lDmhL73doeH6H/qqBziRRK4OCHMf9Z4
	 KuG6COmbw9YZb715l0YWi9HJMY+I44yVf9UhuJPLERuadLEjk/05QKRxBPAr6MGZOo
	 5TDsSfyFGoBEQ==
Date: Tue, 1 Apr 2025 20:58:43 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <Z-wpU6649BjlHZFU@kernel.org>
References: <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home>
 <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home>
 <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
 <Z-u4Tzz9J8hSk6G7@kernel.org>
 <20250401111159.7632a0fa@gandalf.local.home>
 <Z-wFszhJ_9o4dc8O@kernel.org>
 <20250401115423.3b6a926d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401115423.3b6a926d@gandalf.local.home>

On Tue, Apr 01, 2025 at 11:54:23AM -0400, Steven Rostedt wrote:
> On Tue, 1 Apr 2025 18:26:43 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > > But if I use vmap_page_range(), how do I give that back to the memory allocator?  
> > 
> > But you don't need neither vmap() nor vmap_page_range() to have kernel page
> > tables for memory that you get from reserve_mem. It's already mapped and
> > plain phys_to_virt() gives you the virtual address you can use.
> 
> Oh! That makes things so much easier! Especially since that means it should
> work like the normal buffer where virt_to_page() should also work. Right?

Right.
 
> Now I do support mapping the persistent ring buffer via memmap, but I can
> just give up on allowing that to be memory mapped to user space, or even
> freed.

It can't be freed without jumping through some hoops, and mapping it to
user space is hassle as well. 
  
-- 
Sincerely yours,
Mike.
