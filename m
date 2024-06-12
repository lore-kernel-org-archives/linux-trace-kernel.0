Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5F4F1EE;
	Wed, 12 Jun 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218354; cv=none; b=dFw+gQQk0r5gGedfWFHPmBseGq2q+tCQR/Xo0BgpKSmEtIuN9+KRfKumliGsLyCW+LwGgpPz03CIxG3/yYmYm641m/ew+7eo3QD1QjBhfsEE7/jSckda5kZegqEnLsHN5FAxGKe9uB7XyJaHXGdyE8LYaH9U+JWO9lyyZitN9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218354; c=relaxed/simple;
	bh=AFNQEyQz8NyIoVuU/XMy7q/Q54NFWdA/wuxRXPywRUs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P40He/iEgyvZ2DTUP3+nNTDHcrf1QhFkFycbdJuogUwdT4TmMdpmJ2jutVsvlj/9J73PlYtMVyJYzZcsEvq8rJIeooBVj297jFnM2GuIRelbIsAYx4Z8CaGBODqoFpnQ9YBeeqe9aoO+TP5Y6zK6jRsDxtsgI8DOuUJ00vKqkh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7ADC4AF50;
	Wed, 12 Jun 2024 18:52:29 +0000 (UTC)
Date: Wed, 12 Jun 2024 14:52:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, wklin@google.com, Vineeth Remanan Pillai
 <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mike
 Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v3 2/2] pstore/ramoops: Add ramoops.mem_name= command
 line option
Message-ID: <20240612145228.5bf426e0@rorschach.local.home>
In-Reply-To: <202406121145.8860502D7@keescook>
References: <20240611144911.327227285@goodmis.org>
	<20240611144949.703297941@goodmis.org>
	<202406121145.8860502D7@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 11:45:57 -0700
Kees Cook <kees@kernel.org> wrote:

> On Tue, Jun 11, 2024 at 10:49:13AM -0400, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Add a method to find a region specified by reserve_mem=nn:align:name for
> > ramoops. Adding a kernel command line parameter:
> > 
> >   reserve_mem=12M:4096:oops ramoops.mem_name=oops
> > 
> > Will use the size and location defined by the memmap parameter where it
> > finds the memory and labels it "oops". The "oops" in the ramoops option
> > is used to search for it.
> > 
> > This allows for arbitrary RAM to be used for ramoops if it is known that
> > the memory is not cleared on kernel crashes or soft reboots.
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Acked-by: Kees Cook <kees@kernel.org>
> 
> Let me know if this should go via the pstore tree, if you'd rather carry
> it?
> 

I'm going to send out another version to cover some more comments that
were made, and perhaps it's best if Mike Rapoport takes it through his
tree.

Thanks!

-- Steve
