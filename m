Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194C61A275;
	Tue, 15 Jul 2025 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752558965; cv=none; b=O7/o7slaFxEHS5yyN+12lAvcA0qo74yefb+E5EIIJaWNuN5FvsMZfRzRDZME6aJ12b11eg3aJ7/VJZuRs8yJjpVoxIRmjRqIMTBotvufs+g2V0AKWkQP16bTUZCSTYXK3l7YhFiqSmYLsBWUEaRF+5QN3XOvMo2kFSLJ5FQJbBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752558965; c=relaxed/simple;
	bh=mPp5m962w7+T4m+gDAx42wEIz4cnOFM/Y1tsCvI4gDY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bthtM/Hh4/1ehTOG+R7MphxRjs7XqPU1CJXFw6aJQWA0hWLYRBt+9YuanIqCdAQOoBra0CHYxSBZw7k3m4tQ41o29PwMMFVsrUOC8FR3kL0ZMIMHTm98uQ2zhw/gZ3bNpIwtBcqu3nZNTn4bRsu7YF8NXbxMrlMWUWfE0Dv8bhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+bBDCGV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+bBDCGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E2EC4CEE3;
	Tue, 15 Jul 2025 05:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752558964;
	bh=mPp5m962w7+T4m+gDAx42wEIz4cnOFM/Y1tsCvI4gDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a+bBDCGVbBZ6B7bv6CwFNw72PO5iuYxDulrsT5Y+dCwDNZrftGnGtDRJf3T9gGhFN
	 Vz36QEj1/yRYBHOdB16KV1pVdTYXoL9kzKD1ttGaIZSxT2FCnYbv6CYtVduOZTGs0y
	 KHM4W2GB6uSpH7n5vnjoFAJJjVVCYaHrwTlN3Tnf133yyIcZtA37iDM3QrAWOzgdff
	 IwVX29I5uPpxXVv96snhADdJ0BuLhDmuO2b04sPgIvShzBcYXz0VtIHOQkcFnYMntR
	 gUjmHHlf5y/Iu1vvC8S946qlIjBmUqIqrbdSpw0C5ZJF1yCdGXvd3aJlUQ1l1rVwY9
	 wdwwnUl2g42LQ==
Date: Tue, 15 Jul 2025 14:56:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 2/2] panic: Fix up description of vpanic()
Message-Id: <20250715145601.2489a701c86ae48a75d1995f@kernel.org>
In-Reply-To: <23a7e8add6546b155371b7e0fbb37bb1def13d6e.1752232374.git.namcao@linutronix.de>
References: <cover.1752232374.git.namcao@linutronix.de>
	<23a7e8add6546b155371b7e0fbb37bb1def13d6e.1752232374.git.namcao@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 13:20:43 +0200
Nam Cao <namcao@linutronix.de> wrote:

> The description above vpanic() has the wrong function name. Fix it up.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20250711183802.2d8c124d@canb.auug.org.au/
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  kernel/panic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 6a1823c383d0..2a499facde13 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -307,7 +307,7 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>  }
>  
>  /**
> - * panic - halt the system
> + * vpanic - halt the system

Shouldn't we make a copy the doc for the panic() (keep the text as it is)
and change the short explanation?

panic - halt the system
@fmt: ...

vpanic - halt the system with va_list
@fmt: ...
@args: ...

 From the newbie's viewpoint, as far as we keep providing the same
function, it is better to keep the same document to avoid confusion.

Thanks,


>   * @fmt: The text string to print
>   * @args: Arguments for the format string
>   *
> -- 
> 2.39.5
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
