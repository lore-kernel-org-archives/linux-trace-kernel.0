Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D632861E;
	Thu,  2 Jul 2026 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032424; cv=none; b=KoEKqPNw7d2XuQ0fJ4c8qlzQTBBa87EgmzNwcqJwhx/I01qLE6CUO736UN6UNaJvM0E6QCuouxALrx16qCOEcxTIoXCuiSnYLT6FEDAqES+S3D6dHsLVuT006t+HYYlOraDlA/u/rpf5cqedBiUbzGHlssg0rDsjEyGdzlYjT7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032424; c=relaxed/simple;
	bh=N0sj7AeL0BuFG6J+SIQbYSvESu0c4t2itFHQZpxvKqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEjegT5L1q5gnx1Y+XgavazGysniiLB4ca23RxhP/18cJWTtgBLyawbvgqEeJUVC9Ibv2J75elLkvHA0LQU3UIvCUUp//ye1cVuNdxpSEYTuQQS1ae6eZ6WD4En+ixpHl7AJl9kwv5FYdtjSEwNexJju4ML1zgqkdCn1b/bn9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 10F128D174;
	Thu,  2 Jul 2026 22:46:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 50F0E20029;
	Thu,  2 Jul 2026 22:46:54 +0000 (UTC)
Date: Thu, 2 Jul 2026 18:46:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: make tracepoint_printk static as not exported
Message-ID: <20260702184658.0e0ffb02@gandalf.local.home>
In-Reply-To: <20260617105822.904164-1-ben.dooks@codethink.co.uk>
References: <20260617105822.904164-1-ben.dooks@codethink.co.uk>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout02
X-Stat-Signature: nscpuo6oip61oo5ax4h4sbzxw9eejpox
X-Rspamd-Queue-Id: 50F0E20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/FbZrv9YHeod7PkS4xjmRvrtl2CMhEf7s=
X-HE-Tag: 1783032414-108661
X-HE-Meta: U2FsdGVkX18LU6gxY41W61IfD1RLK98HWcj2ucVh3YJOpBu1vyzOKd/FPFX93bWe+SoGu0lsJCyCuZEOa61FIuEABazLvhQpWtG6DWuYrpHtF1AKv+HkgdxZcPFAR6ASqia+ExzdYjT29z7OqvLvB3fEzr0X/HkypemYFWI2POOllMujqX8ByFhUGXp9iEeeFv/bUp8O3L2E0VbNxJPJEihf3e9TqigH53Bk2eDZTWXdqBWqYJdBPX3bP8X6Hqse95+96in59S165iDIASlN+hHaQ1C6D/9aZUy+VFZphvytADVJ+nINpC/PF27yfe1f6B5qljYByPs+L5qgxODMadqkYwtQX50h8bcM9zvErj8koJBGfRcftNPKDqrcHsm4

On Wed, 17 Jun 2026 11:58:22 +0100
Ben Dooks <ben.dooks@codethink.co.uk> wrote:

> The tracepoint_printk symbol is not exported, so make it
> static to remove the following sparse warning:
> 
> kernel/trace/trace.c:90:5: warning: symbol 'tracepoint_printk' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Thanks, this became only used by this file via commit dd293df6395a2
("tracing: Move trace sysctls into trace.c")

I may add a Fixes tag to that commit.

-- Steve


> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 6eb4d3097a4d..4c3729c8d5e2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -87,7 +87,7 @@ void __init disable_tracing_selftest(const char *reason)
>  
>  /* Pipe tracepoints to printk */
>  static struct trace_iterator *tracepoint_print_iter;
> -int tracepoint_printk;
> +static int tracepoint_printk;
>  static bool tracepoint_printk_stop_on_boot __initdata;
>  static bool traceoff_after_boot __initdata;
>  static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);

