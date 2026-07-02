Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06F37A851;
	Thu,  2 Jul 2026 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006629; cv=none; b=rinaytmVBlecg7Q+iYZDm2Ll0AHqkVWofmhWkVjdOd3mJcN13A+MUiDjWnqwWHi7d1VSEhxN5ADtIcRDn6l2vDMLz4N69gA77hVCHa/VFq31KuzL9NhWVVvSB9p17DMKkeJMzJsNsfYD150wsyPTBJxFb3HyTVfKZVrN4ktViXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006629; c=relaxed/simple;
	bh=xsM2iJ3cC73anEWLYBBSbxWc1tdo+81VgHLU71NVf8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGLwlGwUEZGaiwK1BzEEHJWkPmgGl74EGrBVOnJ1cNAQx9TQxCLyElYggdQZyC4d100drDPWUBhCgzw4+51JPsOkTBJsx7AyAbrV9Ohz9iknm/jTU6LeZCVNJUNJkH9Ea+avkG9AVXNv0GTTJ4PfqkahXLgnV7HPlEkP0YIPvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRsYFVjY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRsYFVjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892041F000E9;
	Thu,  2 Jul 2026 15:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006628;
	bh=reVx5nwe/lP7xXFQOJgzFt4bhhYA1gPD8KqUxCYvNIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZRsYFVjYFaFY+nLdNaoEzi7ULZlKPuWjlhRE9w20P+3VR9mc60K4Mp7wNjUlzxU9C
	 R83pQitbErEagI82rOqER1vSN/z6l5JmOrYqbxY4lMnJP81An61mupkpEH6mapuo4/
	 DqYNm8sLiAvNL8af/M8Wffoc5uiuLLMtw7LlFqL4KWvYWIQoZB5hQ08cf/7MET+ZAP
	 Eky6HLeAkkmDdprCVEALDYQWIi//TJXrJ6FqxJafXrmuCh/Dk1PgZlatjdQcJdlaky
	 FJTSUYf87zxhTKTiO2SYRmZHof4kFmdrdeROUD4u5aejSlXr9doLWxFKtc3nLUYx2z
	 ocF6qYw1oLvHQ==
Date: Thu, 2 Jul 2026 21:07:04 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Martin Kaiser <martin@kaiser.cx>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] tracing: Warn when an event dereferences a pointer in
 TP_printk()
Message-ID: <akaFoBxskad7fCTd@vaman>
References: <20260630184836.74d477b6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630184836.74d477b6@gandalf.local.home>

On 30-06-26, 18:48, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Currently on boot up and when modules are loaded, the trace event
> infrastructure will examine the TP_printk's of every event looking to see
> if it dereferences pointers on the ring buffer via printk formats like
> "%pB" and such. What it doesn't do is check if the arguments themselves
> do a dereference from a pointer.
> 
> This was brought with a fix[1] to the fsl_edma event that had in the
> arguments of the TP_printk(): "__entry->edma->membase"
> 
> The __entry->edma is a pointer saved in the ring buffer. The dereference
> from TP_printk() happens when the user reads the "trace" file which can be
> seconds, minutes, hours, days, weeks, or even months later! There is no
> guarantee that the __entry->edma pointer will still be pointing to what it
> was when it was recorded, and could crash the kernel when a user reads the
> event.
> 
> Add logic to the test_event_printk() that also checks for this case and
> warn if the event dereferences a pointer from the ring buffer.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
