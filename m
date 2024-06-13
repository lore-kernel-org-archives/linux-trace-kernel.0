Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEA537C;
	Thu, 13 Jun 2024 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718258690; cv=none; b=fLK/FaVsjZ5AASP9xGSLHBCrF52mJjwWCe3S65HCnxywsPdI8GF/obtiFhzjwzNl4ejFzKJqvGwncud+ocwf1oTGZleqylgZrtcSGJGSB96N8kZhMI3tzmhbEIdBY/bzf3AHMq7HySJGRypyc8NB/n0/2HxjiEr4cFuQoojPgno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718258690; c=relaxed/simple;
	bh=7LdEa2cXZ92dCOV0tvIy2du3N9yfvC7ip0HcqkAwNEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WC+T/aIK0cZExL9LyWc2gNRtPdB9HwADQoud1F8/wGk7XzCchg13vF/4ObfzIBHUwcfMDPpraOwIXjmTT3Yvw2Gv2sxzRhu6ke+raXLoGQ0Aafw/HDVgjJ0VD6MZWrbR0iXTX7MDpB3li+pBVqBKKmES0Ek5+ZfYGL2uKGs9LaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxcenJJR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxcenJJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B256AC2BBFC;
	Thu, 13 Jun 2024 06:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718258690;
	bh=7LdEa2cXZ92dCOV0tvIy2du3N9yfvC7ip0HcqkAwNEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxcenJJRa56E3C/mgOBon5mdRqu/s2dglNrbBslIgsKqZQPnSv42myJqNdUwbwS86
	 ZnTchHadTKKdC/FsOKWRlJY8omawHNlOKkPziXgC9DmDiAkupXVVOQsQ+ubwLizPI6
	 Xh6ETy2wifOBbI0rjnd/lDv9abcX7hG+qotJOSiv56gj30hJvBW5uBRCj67ST8B8rx
	 ozL4oegTH5D4RyqBIJEV512FvBfIYw7aiekKt73/D6257eVpL9t5t3JtnpHRwzBb9n
	 XPtR7VKWr7LKbamwS2COeMJPpI3dqc/YsGCBjNqvKoLT0eCi1L/lptXVP0PFwDqf1i
	 WKxkzWrcXAJ+Q==
Date: Thu, 13 Jun 2024 09:02:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 2/2] pstore/ramoops: Add ramoops.mem_name= command
 line option
Message-ID: <ZmqLejL1mblOikLp@kernel.org>
References: <20240611144911.327227285@goodmis.org>
 <20240611144949.703297941@goodmis.org>
 <202406121145.8860502D7@keescook>
 <20240612145228.5bf426e0@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612145228.5bf426e0@rorschach.local.home>

On Wed, Jun 12, 2024 at 02:52:28PM -0400, Steven Rostedt wrote:
> On Wed, 12 Jun 2024 11:45:57 -0700
> Kees Cook <kees@kernel.org> wrote:
> 
> > On Tue, Jun 11, 2024 at 10:49:13AM -0400, Steven Rostedt wrote:
> > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > 
> > > Add a method to find a region specified by reserve_mem=nn:align:name for
> > > ramoops. Adding a kernel command line parameter:
> > > 
> > >   reserve_mem=12M:4096:oops ramoops.mem_name=oops
> > > 
> > > Will use the size and location defined by the memmap parameter where it
> > > finds the memory and labels it "oops". The "oops" in the ramoops option
> > > is used to search for it.
> > > 
> > > This allows for arbitrary RAM to be used for ramoops if it is known that
> > > the memory is not cleared on kernel crashes or soft reboots.
> > > 
> > > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> > 
> > Acked-by: Kees Cook <kees@kernel.org>
> > 
> > Let me know if this should go via the pstore tree, if you'd rather carry
> > it?
> > 
> 
> I'm going to send out another version to cover some more comments that
> were made, and perhaps it's best if Mike Rapoport takes it through his
> tree.

I've added one more comment to v5, with that fixed I can take this.
 
> Thanks!
> 
> -- Steve

-- 
Sincerely yours,
Mike.
