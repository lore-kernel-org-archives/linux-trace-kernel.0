Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC42F361B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 21 Jun 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782062203; cv=none; b=HV2ATCgURj34+9lnmKlM+zdFeo37b4HhBART+uTDRhqtQQpdl92m0kyrx2FaJWpGZDJ0ddtwvrM+qvVSege01ArGs4A0WZ2L2Pt1bEhGoiFihOj7fDIIwvsuE2OFreNLhVe85IEGCXEbHcRrobi05UsAoQLGGMaIP5lRHXDWJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782062203; c=relaxed/simple;
	bh=PYIMUPD3AKX4CJIC+IT5NFVlBmhjj2gGWN3cHcV/ny8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qJpUD9sdwELJOG6yNUQkSVth8mJSZE7sgOOFsWob6M4adqZzX7xBWYSy7JUPju4W9nWo+m/CWGwCg2YSZciIvKfnkE7fn6V7V/aGGEwHcQ13ms1edlzmojuLQDNDyPI75yTDENO36Id5vxJdFH0jRxl36oNOPyr7B3JtdHxfV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=hIlEOycc; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="hIlEOycc"
X-KPN-MessageId: f1a9766b-6d94-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f1a9766b-6d94-11f1-9e8e-005056999439;
	Sun, 21 Jun 2026 19:16:30 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id f1a82abf-6d94-11f1-91a1-00505699891e;
	Sun, 21 Jun 2026 19:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=AgwUlvkvdVPsfsg7AKOcX+bnU/0pIR65cfU+vu3313k=;
	b=hIlEOyccXgbbsnumur7UImx7rxa2RiVjw14vUxr44wSwaKgm/WhUsf8/hAHXxadq1ZgW0uR1Gfup6
	 zcbMf26c9Lqdac4Gzkul9HfVsIdwfJ2nG6alFjSb+ZUbeonj+dD+GhMS056+2iaXpC0asLdmfoPje6
	 uyTli+D12wBaqjD1fNXbCnV98mSJTkvqzuNOhX2Jm4KfIU/I7i9oShAw1XDVmchRbqAUcbcKqfJ38c
	 5InEDqu6Z6rUM8iLmIG6ezqVYAsmZOzcjzAv2CwQStD9U7CIrO1jIFnzpj+CqT3Ozrc/ZLwyh6F0q8
	 MT0FDYpGOejmA2C5IzNW1iH6Hekr6Mg==
X-KPN-MID: 33|zV4dEls6C4crfDir2+UZIpGFiLqTMyiyl6bIU5JQdDoQtxSg5hq593U0k2PA2Mb
 ZSRTRTzura5jEIsrBS68NK/WjQeSu8Y7BeJcvn+6iOdg=
X-CMASSUN: 33|eS54b1dhrtIOizHOqjVgpqCmrVIMyIa7gQmI+mqdc9DL2gA4+DX2LD2WeJQkrde
 ZkYMZVQb6QjfOLkDtgeFDLg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id f19a84bb-6d94-11f1-8edb-00505699eff2;
	Sun, 21 Jun 2026 19:16:30 +0200 (CEST)
Date: Sun, 21 Jun 2026 19:16:30 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>, rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, shuah@kernel.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com
Message-ID: <70408559.2499685.1782062190117@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260620175441.223342-1-woradorn.laon@gmail.com>
References: <20260620175441.223342-1-woradorn.laon@gmail.com>
Subject: Re: [PATCH] tracing: Use seq_buf for string concatenation
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 20-06-2026 19:54 CEST schreef Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>:
> 
>  
> In preparation for removing the strlcat API[1],
> replace the string concatenation logic with a struct seq_buf,
> which tracks the current position and the remaining space internally.
> 
> The backing buffer bootup_event_buf allocation is unchanged.
> Use seq_buf_str() to NUL-terminate before passing to early_enable_events().
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> 
> Signed-off-by: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
> ---
>  kernel/trace/trace_events.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index c46e623e7e0d..15164723e028 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -22,6 +22,7 @@
>  #include <linux/sort.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/seq_buf.h>
>  
>  #include <trace/events/sched.h>
>  #include <trace/syscall.h>
> @@ -4501,13 +4502,23 @@ extern struct trace_event_call *__start_ftrace_events[];
>  extern struct trace_event_call *__stop_ftrace_events[];
>  
>  static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;

Isn't this now unused?

> +static struct seq_buf bootup_event_seq;
> +static bool bootup_event_seq_initialized;
>  

I think this can be refactored to avoid the bool. And should bootup_event_seq not be
__initdata?

>  static __init int setup_trace_event(char *str)
>  {
> -	if (bootup_event_buf[0] != '\0')
> -		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
> +	if (!bootup_event_seq_initialized) {
> +		seq_buf_init(&bootup_event_seq, bootup_event_buf, COMMAND_LINE_SIZE);
> +		bootup_event_seq_initialized = true;
> +	}
> +
> +	if (seq_buf_used(&bootup_event_seq) > 0)
> +		seq_buf_puts(&bootup_event_seq, ",");
>  
> -	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
> +	seq_buf_puts(&bootup_event_seq, str);
> +
> +	if (seq_buf_has_overflowed(&bootup_event_seq))
> +		return -ENOMEM;
>  
>  	trace_set_ring_buffer_expanded(NULL);
>  	disable_tracing_selftest("running event tracing");
> @@ -4766,7 +4777,7 @@ static __init int event_trace_enable(void)
>  	 */
>  	__trace_early_add_events(tr);
>  
> -	early_enable_events(tr, bootup_event_buf, false);
> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), false);

What if trace_event is empty? Then setup_trace_event does not run AFAIK. See the
WARN_ON in seq_buf_str too. Have you tested this?

>  
>  	trace_printk_start_comm();
>  
> @@ -4794,7 +4805,7 @@ static __init int event_trace_enable_again(void)
>  	if (!tr)
>  		return -ENODEV;
>  
> -	early_enable_events(tr, bootup_event_buf, true);
> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), true);
>  
>  	return 0;
>  }
> -- 
> 2.43.0

Thanks,
Jori.
