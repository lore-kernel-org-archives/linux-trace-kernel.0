Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D556834DCFC;
	Wed,  7 Jan 2026 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798958; cv=none; b=mtIpVfueO7puUXa4wgUmzJlD1VOXq9IYeLk+5j1edemoWqFsgR1IEJupNCzaV5LbaNmE8OLc9IuZYRMZeuqsbkPtDEJVlYXAqCU1cc86EDKgozAvRlcFQF7q1f3R/nMX/i7SujXVljNPAT70/hTjwrQa2Rws9Z8JCX6rFcMs5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798958; c=relaxed/simple;
	bh=lWG8b96u1UevFVESCbPPRPuEvioBvJTEalwm/TgiIqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBAw8xVpVQYKLy2U7NGb6rCLUQSz5UMWjDD/AfEAZkHNlJAlfM7Iu4C+pEh2z0SzUio3XE0fZ5MSOFWIrnHzeJ8jX+NYkY3k1dEMZbXKK0rWqDgCyjd/TrFtsY0GeFKA88lju+gWWh1bUp2VsO1R2FYTpJFZ/PLZ1EAwIvVwU/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 1264B14014C;
	Wed,  7 Jan 2026 15:15:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id D4BA52000E;
	Wed,  7 Jan 2026 15:15:44 +0000 (UTC)
Date: Wed, 7 Jan 2026 10:16:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sunliming@linux.dev
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, sunliming <sunliming@kylinos.cn>,
 kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] fgraph: Make sure fregs is non-null when accessing
Message-ID: <20260107101611.527f0772@gandalf.local.home>
In-Reply-To: <20260107015125.27659-1-sunliming@linux.dev>
References: <20260107015125.27659-1-sunliming@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: o8nkq4fmqseusi81un7bnt3ifdmzt4wj
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D4BA52000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/dwHeHZ7pQz0J5KLumUlHl0DSoZ1aibOU=
X-HE-Tag: 1767798944-414159
X-HE-Meta: U2FsdGVkX1+4NeHzvs8GceHUuV4CTJNyjLw0AzhXHmkyvHW9XbFuQ1dg4ujTVCRwLv/DHXPRqHyXDEOYMJjfNMPfDpEWcGuPNH1ljkCC0EufG1NRYhtpjFzGfUZCvrXvvosjovMTtOKIaLejlF99EIrllvTXNu1y+Wkxq3UJ6BEqmnJ1Z8rotz/cqSCeMSMjdcLn4zgeSJTkXAaF5MjYI7WXV1MaF10kH06j3MFRgilZ4llhWnTa78hfw1cLXpWzs5FJJp/4gGwNXCxsgRJUZwr3LgjibpRb3rmpFGQYSkBjVC1JXInDSVKyWVde9gyoC0mJDuBLWLXsQOxvIBui2gdN4hueU7OLMVhUXNjZ7UCAhdiOioB9o8pfTditq7Fy/aEkQwvy55o=

On Wed,  7 Jan 2026 09:51:25 +0800
sunliming@linux.dev wrote:

> From: sunliming <sunliming@kylinos.cn>
> 
> Fix below smatch warnings:
> kernel/trace/fgraph.c:834 __ftrace_return_to_handler() error: we previously
> assumed 'fregs' could be null (see line 830)
> 

NACK!

> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202512131657.JQUt5fXQ-lkp@intel.com/

Really? Did you not read this thread you are "closing"?

-- Steve

> Signed-off-by: sunliming <sunliming@kylinos.cn>
> ---
>  kernel/trace/fgraph.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index cc48d16be43e..0f50a55032c5 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -837,7 +837,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
>  		goto out;
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
> -	trace.retval = ftrace_regs_get_return_value(fregs);
> +	if (fregs)
> +		trace.retval = ftrace_regs_get_return_value(fregs);
>  #endif
>  
>  	bitmap = get_bitmap_bits(current, offset);

