Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012261EA7C0;
	Thu,  6 Feb 2025 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848976; cv=none; b=YlE6VcB5XgnYqOhWArc6TW9gr5lVhrxmZ9qngh7S5AYiT4VaTdW0js4BaryanrxGcFfZkhvPv3HvGktHAT7JPV2RZAAw2YPCh28iqc2L5+fDYbHR4P6RrY5cYX/bYk0VEWCkgoTSUvkMr+dFzkntDNZ7qFu2Wp7VqIQixDXFAYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848976; c=relaxed/simple;
	bh=X1X/47qLoyQJnJUNGHCpNtuoq2dYcD2wrDCVemNAsAw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHfHVUFDJy8VwKlndACTWU1cFDCNdKFxFymQn5JDhcHjevBOTF2X5b4w2tvdLasLsLIY4NQEBBfVTU0eAmtMUsL/dZkI9aXiiWYoTnuHPuyoJ2FlfPrH2OZwuPfdCsyGTXknXepGLhvVkdnj9H0buw8BKJvVdwyasdoQ6si21VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CE0C4CEDD;
	Thu,  6 Feb 2025 13:36:13 +0000 (UTC)
Date: Thu, 6 Feb 2025 08:36:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/11] sched: Add sched tracepoints for RV task
 model
Message-ID: <20250206083654.6ea1d3f9@gandalf.local.home>
In-Reply-To: <1818165c4cbaedfb7314f4a200a273454ce49b63.camel@redhat.com>
References: <20250206080952.98478-1-gmonaco@redhat.com>
	<20250206080952.98478-4-gmonaco@redhat.com>
	<20250206081942.GJ7145@noisy.programming.kicks-ass.net>
	<d8187fcd53c62272d7e1a8dad327c4f2a5f07188.camel@redhat.com>
	<20250206085738.GL7145@noisy.programming.kicks-ass.net>
	<1818165c4cbaedfb7314f4a200a273454ce49b63.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 06 Feb 2025 12:47:17 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> > > What do you think would be better?  
> > 
> > So I would think having the tracepoint in-line would be better.
> > Because
> > as is, everything gets to have this pointless CALL to an empty
> > function.
> > 
> > If this were x86_64 only, I would suggest using static_call(), but
> > barring that, the static_branch() already in the tracepoint is the
> > best
> > we can do.
> >   
> 
> Ok, I see your point now..
> 
> Adding the trace_ call inline seems far from trivial to me, but we
> could indeed do what's suggested in tracepoint-defs.h and practically
> use a static branch to call this trace_set_current_state, not sure if
> this is already what you were suggesting, though.

Right, due to the macro magic of how tracepoints are created, you can't
have them in header files. It causes too many side effects that can easily
break the build.

-- Steve
