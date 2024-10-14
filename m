Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0F29CA;
	Mon, 14 Oct 2024 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728924402; cv=none; b=HToCQ7g2dEs5g25g76Cd+DgNmxsmC95XohLDd/hSbyom1rH2AIK6jMbAjEsuwntn6wi0m1kt8XejJQzBo5PIDpnOpZ4IfIK/NoG9/VBFgx4KRYb8pUd14/UyMWu60IaMPWqWq3O3r7zBb7QPPFFooED/0578UHPvIDCVM5vTkJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728924402; c=relaxed/simple;
	bh=fXkOLcbnT4wM2Gtr/c3Az9IUoMUm8bVs0H1pKhSN1q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3XGDVZ4eO/hu0d5bzq47pZEE+dIiNrKAdRItJ6UzWo6hvgmwZ6HYDDkBsqNmTULzhwNoXzsYY+pjDbFPLxqtSYTkh+o4bypDH3DN3hCgO1y+XYYB8klnKGyjD7AuE6jgiqdQJAGrlqyEEb+Npu//hO0DpTcLGx3+k2wXZ6mpfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2E1C4CEC3;
	Mon, 14 Oct 2024 16:46:40 +0000 (UTC)
Date: Mon, 14 Oct 2024 12:46:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 18/57] trace: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <20241014124656.3ffb0f65@gandalf.local.home>
In-Reply-To: <20241014105912.3207374-18-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241014105912.3207374-1-ryan.roberts@arm.com>
	<20241014105912.3207374-18-ryan.roberts@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 11:58:25 +0100
Ryan Roberts <ryan.roberts@arm.com> wrote:

> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> Convert BUILD_BUG_ON() BUG_ON() since the argument depends on PAGE_SIZE
> and its not trivial to test against a page size limit.
> 
> Redefine FTRACE_KSTACK_ENTRIES so that "struct ftrace_stacks" is always
> sized at 32K for 64-bit and 16K for 32-bit. It was previously defined in
> terms of PAGE_SIZE (and worked out at the quoted sizes for a 4K page
> size). But for 64K pages, the size expanded to 512K. Given the ftrace
> stacks should be invariant to page size, this seemed like a waste. As a
> side effect, it removes the PAGE_SIZE compile-time constant assumption
> from this code.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  kernel/trace/fgraph.c | 2 +-
>  kernel/trace/trace.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index d7d4fb403f6f0..47aa5c8d8090e 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -534,7 +534,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
>  	if (!current->ret_stack)
>  		return -EBUSY;
>  
> -	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
> +	BUG_ON(SHADOW_STACK_SIZE % sizeof(long));

Absolutely not!

BUG_ON() is in no way a substitution of any BUILD_BUG_ON(). BUILD_BUG_ON()
is a non intrusive way to see if something isn't lined up correctly, and
can fix it before you execute any code. BUG_ON() is the most intrusive way
to say something is wrong and you crash the system.

Not to mention, when function graph tracing is enabled, this gets triggered
for *every* function call! So I do not want any runtime test done. Every
nanosecond counts in this code path.

If anything, this needs to be moved to initialization and checked once, if
it fails, gives a WARN_ON() and disables function graph tracing.

-- Steve


>  
>  	/* Set val to "reserved" with the delta to the new fgraph frame */
>  	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index c3b2c7dfadef1..0f2ec3d30579f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2887,7 +2887,7 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
>  /* Allow 4 levels of nesting: normal, softirq, irq, NMI */
>  #define FTRACE_KSTACK_NESTING	4
>  
> -#define FTRACE_KSTACK_ENTRIES	(PAGE_SIZE / FTRACE_KSTACK_NESTING)
> +#define FTRACE_KSTACK_ENTRIES	(SZ_4K / FTRACE_KSTACK_NESTING)
>  
>  struct ftrace_stack {
>  	unsigned long		calls[FTRACE_KSTACK_ENTRIES];

