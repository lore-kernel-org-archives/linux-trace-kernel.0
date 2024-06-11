Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD53111A1;
	Tue, 11 Jun 2024 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127246; cv=none; b=KKbKacsaufVzivC1fAbtpoFrkMagx8xHkyCV8qJja1ElyNYSIa7hpty9cWp+6zzlr6IBDMTzZ/Ej6oEAUpooey+s7RtPiHGgqYz8soevXIxt2FPCSiQjPwk8P1SFqUVDA0spQb+djzLOYGgwefGPuEZ9VqlXWT2fYMP3zbAJsIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127246; c=relaxed/simple;
	bh=mw2bHrfXC91A3Z41Lk93bFgLF0h96ckW52DG3RINQfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jW7qVtqnri6Z/54sBrHPlSpDWeiAsCpXjFuLP2orkf/efyeLYacSIqEt0LaC5jyO3ae4o7+gI+kkSIOGG3RTKczphFJDwmswh3xa0yBFy7MLeg07rD8ajhYOmYpe0Ib9NLCCRDT4zxf5oU/PGhwkPUJq8pZunhVwa7R2KSrwVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBDEC2BD10;
	Tue, 11 Jun 2024 17:34:02 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:34:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
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
Subject: Re: [PATCH v2 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240611133418.4a32086b@gandalf.local.home>
In-Reply-To: <Zmh7t8kupN2pbCF0@kernel.org>
References: <20240606150143.876469296@goodmis.org>
	<20240606150316.751642266@goodmis.org>
	<20240611144029.h7egl4aif5mjlrwf@master>
	<20240611111218.71e57e0f@gandalf.local.home>
	<Zmh7t8kupN2pbCF0@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 19:30:47 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> > I don't know if we care what the align is. Zero is valid.  
> 
> memblock won't like zero align, it should be SMP_CACHE_BYTES at least.
> No point requiring it from user, just update the alignment if the user passed
> zero.

Thanks, will do in v4.

-- Steve
