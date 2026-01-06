Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E125FA10;
	Tue,  6 Jan 2026 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767742872; cv=none; b=i8AD7qpuS4Mu6Bycsn/kY64biR3eN1WyzpljPyD3tkZSFFtPcjmKrKW3+0ADDCZHKOM8DMKhMsIL2NY7Wtc88VvGEg+kAIK7DCVuBCFbCpto/JbxdH8f/J0lBlRb2X0sfjNcIoC3BIqLb26Xvyy7wENPWgIKn1/vpDz6+LmTGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767742872; c=relaxed/simple;
	bh=bq9O43pH0l347A80OPXrPoMh9DHD+pF0xB3+faFQ3wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQvug30Cywzm65oXef2ovhHLnpJmHbIbNquneg4CkmGDim0YcCdeo3Am3aGONVQi0qkx7X9/niGkafuzTrulzAQWGvzS1RHK2SOnTkL85qbaAC/MTh8GUK6gRE/EPcc/gFNpaQbaEKzmvTaItTenKaSlQjpAS3+symYwsCPdfrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 160B91AD62F;
	Tue,  6 Jan 2026 23:41:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 5A1FE2002D;
	Tue,  6 Jan 2026 23:41:07 +0000 (UTC)
Date: Tue, 6 Jan 2026 18:41:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH] trace: ftrace_dump_on_oops[] is not exported, make it
 static
Message-ID: <20260106184132.23a73aca@gandalf.local.home>
In-Reply-To: <20260106231054.84270-1-ben.dooks@codethink.co.uk>
References: <20260106231054.84270-1-ben.dooks@codethink.co.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4in3nuujfpf58hz69dr9wnz5zdet4qqg
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 5A1FE2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Tf/H/JtAzBxDKBBhqwd9qAS7fQ8fYmIA=
X-HE-Tag: 1767742867-617401
X-HE-Meta: U2FsdGVkX1/gF3aRFKaztAfWxv/V2eygF/iV2tW86ZVc97D6+qu6BPpMidFE7/oOuUzsijdcM+Jb1o5mM46zis4zgyDl6WU+EJm4g702YRbeNTnUGOzybeXGMXBMlyY1t3eqFWzc1D/1SblIC3EuNVrtsVQWITmXFOgCb6KrtaGyvolEx8W7QuZ8BrVIPPNxUZlYJMn/jnPH1QngUAwT9/0ftAihwtJb9EAoCr5tQglaefqvYsczgX8Ftcs3fa5e/9ZUkwPhWnZLH3pI9oFZ5MO7kvcmz6QznF+77v/j2ZeaRD5H8+urnnuh/oA+YXpQHCSGUXHEtPbLyXbytQR9gzNfIMnsn07WQu5iIPqYJMYa+cHgp+wThDW5D9fqeXgo

On Tue,  6 Jan 2026 23:10:54 +0000
Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The ftrace_dump_on_oops string is not used outside of trace.c so
> make it static to avoid the export warning from sparse:
> 
> kernel/trace/trace.c:141:6: warning: symbol 'ftrace_dump_on_oops' was not declared. Should it be static?
> 

This could probably have:

Fixes: dd293df6395a2 ("tracing: Move trace sysctls into trace.c")

as that was the commit to move the usage of that variable back into the
defining file.

-- Steve


> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6f2148df14d9..5c196ea93768 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -138,7 +138,7 @@ cpumask_var_t __read_mostly	tracing_buffer_mask;
>   * by commas.
>   */
>  /* Set to string format zero to disable by default */
> -char ftrace_dump_on_oops[MAX_TRACER_SIZE] = "0";
> +static char ftrace_dump_on_oops[MAX_TRACER_SIZE] = "0";
>  
>  /* When set, tracing will stop when a WARN*() is hit */
>  static int __disable_trace_on_warning;

