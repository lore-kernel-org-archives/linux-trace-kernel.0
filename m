Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E331E868;
	Fri,  7 Mar 2025 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308390; cv=none; b=UDsylow9Vr3aQyST7nLLB9xQKZZkur+LG7/Ztlqf+wmz8DfFrCzO3WQJV4FIUU5zVBP00Jo1MdBJ2sxNOF1A2J0oSu/WWXexIRv5GKIoRHMTkXsYeCnA8NRy+m6+vwkbA4OGKbzNyGK3Z1O5xL1NptyZMhrdohFIPh07O/m6vns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308390; c=relaxed/simple;
	bh=1/L9emtK9hucruSg20/zRBRrihTT01klByixgO9Yj14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7ph0LKcc+txsSTcJNhAyqHbzVGW/5KqT/hUmXTz0WaAm0v2j3uz4QJpeI7QrMZ21TVMgmPwivk5SZZKeSugiVSyc1gW9aV83isaK4fcEOcXT4F9U66YbxdCFHpm14+lDRX3uKJ7t/bkRJxpT3X5a9/BYTHd3O8OFCRJwZnvSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EAFC4CEE0;
	Fri,  7 Mar 2025 00:46:28 +0000 (UTC)
Date: Thu, 6 Mar 2025 19:46:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v2 1/3] tracing: Show last module text symbols in
 the stacktrace
Message-ID: <20250306194627.59452513@gandalf.local.home>
In-Reply-To: <173920223724.826592.12665655620615313089.stgit@devnote2>
References: <173920222697.826592.3726270716809214055.stgit@devnote2>
	<173920223724.826592.12665655620615313089.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 00:43:57 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the previous boot trace buffer can include module text address in
> the stacktrace. As same as the kernel text address, convert the module
> text address using the module address information.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Add LRU based removed module information override.

I don't think we should bother supporting removal of modules yet.

It also makes this patch way too complex for what it should do.

>   - Fix to move module_delta initialization after tr->scratch check.

>   - Fix to make mod_delta on all loaded modules correctly.

Should be a separate patch.

>   - (Note, I don't add uname check yet)
>   - Fix mod_addr_comp() overflow issue.
>   - Add pr_info() when failed to allocate module_delta.

So basically this patch should just add the code to handle finding the
module for stack traces. Not to mention, I have code that depends on that,
but this patch currently does way to much.

Can you just send a patch that adds the trace_adjust_address() (although, I
would shorten it to "trace_addr_adjust()").

And add what is needed to update the trace_stack_print().

You can base it off of the ring-buffer/for-next branch.

Thanks,

-- Steve


> ---
>  kernel/trace/trace.c        |  173 ++++++++++++++++++++++++++++++++++++++++---
>  kernel/trace/trace.h        |    4 +
>  kernel/trace/trace_output.c |    3 -
>  3 files changed, 167 insertions(+), 13 deletions(-)
> 
