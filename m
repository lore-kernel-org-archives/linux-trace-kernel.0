Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A2F142623;
	Thu, 13 Jun 2024 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284816; cv=none; b=CaN66/Fx1aCNq6W7ua7sexHRNmqiu30vVP15OeQ6zaSk5Q/Q4e8KJz8oFsCJDpxiK/JLjSJpxTyQSzMt9gqREunbErG+368kYxRkibSIwY5NRoKPm9+8PA01mkpF2+nOVFI1Bf673FJL+S6nJd0cXXYLib8ANiGwKIqeHFR2zwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284816; c=relaxed/simple;
	bh=j+ZRgUOzIDJat4u1tQYC1sCLBDeq6cEI5sb5AQpJBjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9flraEfpXtPV8FeTr8/Ho9U7fUN8phTzQEqtVtImC/IMPkiJtVwcQoXWe+dg69hPQA8226s/P3X/oEiCcKzxmLhO5uvJV+P87ulk8B5JSN3LZOJKkP1FS+FaYsvo5lOfUmbyyqdt+c634ShSewVMAmfCyO+kli5U6pyeaBvyPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD09C2BBFC;
	Thu, 13 Jun 2024 13:20:11 +0000 (UTC)
Date: Thu, 13 Jun 2024 09:20:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Kees Cook
 <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Guenter
 Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
 wklin@google.com, Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Joel
 Fernandes <joel@joelfernandes.org>, Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel
 <ardb@kernel.org>
Subject: Re: [PATCH v5 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240613092009.5fffa4f3@rorschach.local.home>
In-Reply-To: <ZmqK_zeGus_VxAHN@kernel.org>
References: <20240613003435.401549779@goodmis.org>
	<20240613003508.752963299@goodmis.org>
	<ZmqK_zeGus_VxAHN@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 09:00:31 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> > +	/* Make sure the name is not already used (size is only updated if found) */
> > +	if (reserve_mem_find_by_name(name, &start, &size))
> > +		return -EBUSY;  
> 
> I'd prefer another variable here rather than size. Will be more robust IMO.

It's a damn habit of mine to be frugal on the stack variables. I'll
update in v6.

-- Steve
