Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41D198850;
	Mon, 30 Sep 2024 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722503; cv=none; b=Q76TH0vmXgV/c4xSXF8Y45+a83S+6cN2We+4oxIvQyvfOA24yqYo9XwCwGExAJ/C8Ad2bE9LVv/rNaVzygcA139r/xZXjayaKaejTUGt5OXRhCJKVXSD75xiiukha+AmRAfyLLbTJlbJ1LCu5m+sQzjJom7NxL0dO0O6Adcn/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722503; c=relaxed/simple;
	bh=4aB31/RYsCM09NmQTOG8aPje7R95QbV3PufbzORUXx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjfmggEdpQxnHqZASbdbbPVOr7pIGtVbchrKxgivl73pA8O8iHBmW6Cxm0ocQ0z4TjRKsnMjRcWALqFbLwvmo4SvgV5sY0JfmifB+0xO7edxL0p/QJ1DQAAvtxRF4i7o+mb1GeAe0xt1icQxCaIy5BudeitYDKiNbRfpRFdBDBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4F0C4CEC7;
	Mon, 30 Sep 2024 18:55:01 +0000 (UTC)
Date: Mon, 30 Sep 2024 14:55:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v14 04/19] function_graph: Replace fgraph_ret_regs with
 ftrace_regs
Message-ID: <20240930145548.08c8f666@gandalf.local.home>
In-Reply-To: <20240917095538.GA27384@willie-the-truck>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615373091.133222.1812791604518973124.stgit@devnote2>
	<20240915051144.445681c2@rorschach.local.home>
	<20240917095538.GA27384@willie-the-truck>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Sep 2024 10:55:39 +0100
Will Deacon <will@kernel.org> wrote:

> The arm64 part looks good to me, although passing a partially-populated
> struct out of asm feels like it's going to cause us hard-to-debug
> problems down the line if any of those extra fields get used. How hard
> would it be to poison the unpopulated members of 'ftrace_regs'?

The purpose of creating ftrace_regs was to allow a partially populated
pt_regs to be sent around, as Thomas Gleixner and Peter Zijlstra were
against using pt_regs that were not fully populated. Hence, I created
"ftrace_regs" for this purpose.

ftrace_regs should never be accessed via its internal elements but only with
its accessor functions, as depending on the arch or functionality used, the
content of the structure should never be trusted. The accessor functions
will do all the verification needed.

I may add some compiler hacks to enforce this. Something like:

struct ftrace_regs {
	void *nothing_to_see_here;
};

And then change the arch code to be something like:

// in arch/arm64/include/asm/ftrace.h:

struct arch_ftrace_regs {
        /* x0 - x8 */
        unsigned long regs[9];

#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
        unsigned long direct_tramp;
#else
        unsigned long __unused;
#endif

        unsigned long fp;
        unsigned long lr;

        unsigned long sp;
        unsigned long pc;
};

#define get_arch_ftrace_regs(fregs) ((struct arch_ftrace_regs *)(fregs))

static __always_inline void
ftrace_regs_set_instruction_pointer(struct ftrace_regs *fregs,
                                    unsigned long pc)
{
	struct arch_ftrace_regs *afregs = get_ftrace_regs(fregs);
        afregs->pc = pc;
}


-- Steve
