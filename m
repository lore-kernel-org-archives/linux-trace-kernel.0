Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AA11CBA;
	Mon, 10 Mar 2025 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597190; cv=none; b=FZQ5nXA6aA6I8UuNIQ28qwIipqtVCgNH4t0DnqZVLMsHokRLtknSB+pBykNEqP8ZO9Z0YYkBfez4gwXc2ztz4xYBsnOjbBJt4y8sAqv2WgCq6/g2twZotSK2rmlX13oe+OzM6nSkW7R7TfnwcDYUl2o9mymnVRWpgvCsz19W0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597190; c=relaxed/simple;
	bh=GQQBIdIOKWJxe3LiUtKXXMYyWtF11k9WGbe7caGN000=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AC7044V+laWPpqY2fjFiScL3mXuihTjUEVcGUFGOk8UgSne007CnY2XRaSRZlgUw4Pg47oxXYSJLlXtwsSXEh+nlOXaxBfuMbv5ydMoQZO+Cn9zN5MvXKVEoqKgyHnSK1eF8DI8+GWfrDdOTKnniIE5W/xDXjTWI7E9VKgJA4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWoaYac+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWoaYac+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A678CC4CEE5;
	Mon, 10 Mar 2025 08:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741597190;
	bh=GQQBIdIOKWJxe3LiUtKXXMYyWtF11k9WGbe7caGN000=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cWoaYac+uJiF2IyNaXA2a2CSYqnDWmgRmWyjGLxr4jw3XtHHltce34kRf8jL0Z+ew
	 nG9eD3HVsiRpLX2EFe3SuY7s4JJEOdJg8i8add2Pl17TkDBT6Y2XGQOaEirGDidu6X
	 N+dn+oy75vklG3F+g13fO2U5IXqnf6FQ8x/fgKABTKpAZba6X10qE0qsFaasquMBJI
	 Kf1XlyyvGV5bWWOCrCDyio7JqcN6su3TuszPRSxUxJcnLbRmUfH40EuU9WX4fYLVm0
	 /BYUepK0Ta/n3FTTSYnoKBz8r07hZKxA26fFd3mX/8YmP7gfS2fHL6ZnrCD7mKW4vP
	 hWltLvTnqNnwA==
Date: Mon, 10 Mar 2025 17:59:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 1/3] tracing: Show last module text symbols in
 the stacktrace
Message-Id: <20250310175946.c317afa1ae89540cb1076940@kernel.org>
In-Reply-To: <20250306194627.59452513@gandalf.local.home>
References: <173920222697.826592.3726270716809214055.stgit@devnote2>
	<173920223724.826592.12665655620615313089.stgit@devnote2>
	<20250306194627.59452513@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 19:46:27 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 11 Feb 2025 00:43:57 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the previous boot trace buffer can include module text address in
> > the stacktrace. As same as the kernel text address, convert the module
> > text address using the module address information.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v2:
> >   - Add LRU based removed module information override.
> 
> I don't think we should bother supporting removal of modules yet.
> 
> It also makes this patch way too complex for what it should do.
> 
> >   - Fix to move module_delta initialization after tr->scratch check.
> 
> >   - Fix to make mod_delta on all loaded modules correctly.
> 
> Should be a separate patch.
> 
> >   - (Note, I don't add uname check yet)
> >   - Fix mod_addr_comp() overflow issue.
> >   - Add pr_info() when failed to allocate module_delta.
> 
> So basically this patch should just add the code to handle finding the
> module for stack traces. Not to mention, I have code that depends on that,
> but this patch currently does way to much.
> 
> Can you just send a patch that adds the trace_adjust_address() (although, I
> would shorten it to "trace_addr_adjust()").
> 
> And add what is needed to update the trace_stack_print().
> 
> You can base it off of the ring-buffer/for-next branch.

OK, BTW, if we always need tscratch, we can move module_delta in it.
Let's reimplement it.

Thanks,

> 
> Thanks,
> 
> -- Steve
> 
> 
> > ---
> >  kernel/trace/trace.c        |  173 ++++++++++++++++++++++++++++++++++++++++---
> >  kernel/trace/trace.h        |    4 +
> >  kernel/trace/trace_output.c |    3 -
> >  3 files changed, 167 insertions(+), 13 deletions(-)
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
