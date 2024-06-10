Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502D1EA6F;
	Mon, 10 Jun 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718038926; cv=none; b=D13GHqW+hqVBrxmgP87LogMWHuwVKCNrsJOEXpU2q/fpuulY0SZ1D48eXVBapQ2aPSLaEJ1lpbWeEMj/txE+f/zoqwmHZVlU1nhNQvNxWZqhIb9jvXL22PZ9ykYgMtupb84KtawluHjR6s0YXGwvlxUcaLOq+lS5hHrOW/jwt7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718038926; c=relaxed/simple;
	bh=WFeffItMXMcz+XG1+wQHxMIyeQdKyjz6JLP3Gz+RuNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWU4H/iXSNHiZmjRBFCh7p7sjVWaoVlANLr07adgarlHfFA/FZGdF9T9i/0l97RGZJFmYNlv6nvLzvPQ4hDAjDoSebjCDFYc3EYEWOBHCuM22OsWbj8DnEbWcjcL8IgJPqCePbU0hu6T3GvRYULyoHFZzZa0VzNHbL4+i5Cc/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti3YrOvh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti3YrOvh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F37C2BBFC;
	Mon, 10 Jun 2024 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718038926;
	bh=WFeffItMXMcz+XG1+wQHxMIyeQdKyjz6JLP3Gz+RuNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ti3YrOvh6kr5L5/NEmkjAc5sZJGS2uB9eaN9LfnQmvR7CYr1QvL70SPO1fFt+U3b+
	 doxRofUpDLlm82KDuIFhpGfxLe1vkjZjOSUgNJ0+fLX2LXO7StMGCMkXufzn8drQN0
	 6OiNHM6Uf/ryvFLlmDbEEHSfOU8ryT/2wjZqzX6aV4iZP3D7Gd78TistJY9yFMMTF4
	 UEcLNDRf5z0B0KLJWltETSvBp/o3kbaYzMNKlw8C8TXulzA6FAytCGJHVjUX+b1oWu
	 UeSi5LdyRoEd5kDGRZlhTAcaT5HWBWlYEdD+5IdM7uZStDBCz/CJGdxOi9VuvbLqOD
	 9AOlEQ2ImzyDw==
Date: Mon, 10 Jun 2024 10:02:05 -0700
From: Kees Cook <kees@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
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
	Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <202406101001.D469C9A@keescook>
References: <20240606150143.876469296@goodmis.org>
 <aa8c49d5-1a51-9256-6327-d47036b343fe@igalia.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa8c49d5-1a51-9256-6327-d47036b343fe@igalia.com>

On Fri, Jun 07, 2024 at 04:54:41PM -0300, Guilherme G. Piccoli wrote:
> On 06/06/2024 12:01, Steven Rostedt wrote:
> > Reserve unspecified location of physical memory from kernel command line
> > [...]
> > Solution:
> > 
> > The solution I have come up with is to introduce a new "reserve_mem=" kernel
> > command line. This parameter takes the following format:
> > 
> >   reserve_mem=nn:align:label
> > 
> > Where nn is the size of memory to reserve, the align is the alignment of
> > that memory, and label is the way for other sub-systems to find that memory.
> > This way the kernel command line could have:
> > 
> >   reserve_mem=12M:4096:oops   ramoops.mem_name=oops
> > 
> > At boot up, the kernel will search for 12 megabytes in usable memory regions
> > with an alignment of 4096. It will start at the highest regions and work its
> > way down (for those old devices that want access to lower address DMA). When
> > it finds a region, it will save it off in a small table and mark it with the
> > "oops" label. Then the pstore ramoops sub-system could ask for that memory
> > and location, and it will map itself there.
> > 
> > This prototype allows for 8 different mappings (which may be overkill, 4 is
> > probably plenty) with 16 byte size to store the label.
> > 
> > I have tested this and it works for us to solve the above problem. We can
> > update the kernel and command line and increase the size of pstore without
> > needing to update the firmware, or knowing every memory layout of each
> > board. I only tested this locally, it has not been tested in the field.
> > 
> 
> Hi Steve, first of all, thanks for this work! This is much appreciated.
> The kdumpst tooling (Arch Linux) makes use of pstore when available, and
> the recommendation so far was to reserve memory somehow, like "mem=" or
> use kdump instead, if no free RAM area was available.
> 
> With your solution, things get way more "elegant". Also, I think we all
> know pstore is not 100% reliable, specially the RAM backend due to
> already mentioned reasons (like FW memory retraining, ECC memory, etc),
> but it's great we have a mechanism to **try it**. If it works, awesome -
> for statistical analysis, this is very useful; pstore has been used with
> success in the Steam Deck, for example.
> 
> With all that said, I've tested your patches on top of 6.10-rc2 in 2
> qemu VMs (one running legacy BIOS - seabios - and the other UEFI - using
> ovmf) and on Steam Deck, and it's working flawlessly. I've tested only
> using ramoops as module.
> 
> Some code review in the patches themselves (like a missing
> EXPORT_SYMBOL_GPL), but all in all, that's a great addition! Feel free
> to add my:
> 
> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Yeah, I think this looks good as long as it's understood to be a "best
effort", and will radically simplify doing qemu testing, etc. I expect I
can take v3 into -next with the fixes Guilherme noted.

-Kees

-- 
Kees Cook
