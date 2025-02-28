Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96FD1CAA64;
	Fri, 28 Feb 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783014; cv=none; b=Ftudo8kRZirb8kU4jZ/fBNNQ27aT87ieXKMhLGDlBv0tPO0508iSIJ7CTGG52YeHS/VM4FbMmUNoJQmKUtWCszi6RFwRYbJ0E6el0zTaZ+aESNE3zBnvV/UX7Se8MSLpB0mEXVP8xPvfktVn9gzMDGi9vdTGwpjlGcHqG+52zMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783014; c=relaxed/simple;
	bh=ePm1yQe3FdyuPAaqOsFRkNIMYJsY8PXaisJILwjs2pU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjP81VrHkPWnuID30inmdZ5BGTTKaGuR0eg2xnglVo9GTg1jGlX9Qe9IYi6V+OtvRxqe0/i7ErrfKZdYLJdEwtRkNVOuq1Z5F8c7sFaIyFJO2rZINZQ5UHxL0OqCGYvsLtaiRT1EbOqIdJE7iN7PE7oRjRj//aJv/818BT4j3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1873AC4CED6;
	Fri, 28 Feb 2025 22:50:13 +0000 (UTC)
Date: Fri, 28 Feb 2025 17:50:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Michael Petlan <mpetlan@redhat.com>, Veronika
  Molnarova <vmolnaro@redhat.com>, Suren Baghdasaryan <surenb@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RESEND][PATCH] tracing: gfp: Remove duplication of recording
 GFP flags
Message-ID: <20250228175058.28db2b08@gandalf.local.home>
In-Reply-To: <20250225135611.1942b65c@gandalf.local.home>
References: <20250225135611.1942b65c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Since I hear only crickets on this. I'm going to apply it and push it to
linux-next and see if anyone notices. It only affects the output of the
memory trace events.

-- Steve


On Tue, 25 Feb 2025 13:56:11 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The gfp_flags when recorded in the trace require being converted from
> their numbers to values. Various macros are used to help facilitate this,
> but there's two sets of macros that need to keep track of the same GFP
> flags to stay in sync.
> 
> Commit 60295b944ff68 ("tracing: gfp: Fix the GFP enum values shown for
> user space tracing tools") added a TRACE_GFP_FLAGS macro that holds the
> enum ___GFP_*_BIT defined bits, and creates the TRACE_DEFINE_ENUM()
> wrapper around them.
> 
> The __def_gfpflag_names() macro creates the mapping of various flags or
> multiple flags to give them human readable names via the __print_flags()
> tracing helper macro.
> 
> As the TRACE_GFP_FLAGS is a subset of the __def_gfpflags_names(), it can
> be used to cover the individual bit names, by redefining the internal
> macro TRACE_GFP_EM():
> 
>   #undef TRACE_GFP_EM
>   #define TRACE_GFP_EM(a) gfpflag_string(__GFP_##a),
> 
> This will remove the bits that are duplicate between the two macros. If a
> new bit is created, only the TRACE_GFP_FLAGS needs to be updated and that
> will also update the __def_gfpflags_names() macro.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
