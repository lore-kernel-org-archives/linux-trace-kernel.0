Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C813B8409;
	Tue, 23 Jun 2026 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207531; cv=none; b=Y3PpaNWmBLo8OiT3TQhN/bvz1dMWXJFGV6CsBre5s4YZ0uA8McjEcN578WKHMMVIsgOAIRai3NCAXSJTmcilryfleWZkLNWKWBSRAl5eRwwKIHxpCW9L5ETYGKx3X+mJax6oWoWPVvrtdS9KAyKK/aHRxXmDv3ZY9jGGmLFHj7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207531; c=relaxed/simple;
	bh=rp8fQIf0v3VeLp559/vGbo7pCos9nfdd5qX6cEWwNDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hzgiu+HYcN7ChELklJFccPkCa16akBiWK5ajahZaUnLgfjKYeGq1XKltraHw8uSZ6szQJAj9Wb7LmP9/dgY8guUpwvFdBSyQWItO1jJhTfKP7z4EPjFExOVHBRlIhIJlm7VA8qJc3x6tZzlhQ4QpHMl6qET5n5RGV6bu1p18nQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hoY17NyQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PJ68GUXY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hoY17NyQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PJ68GUXY"
Date: Tue, 23 Jun 2026 11:38:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782207528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/kePziIcU5+vEDkGgb/hmvnq0AGaFGGKDzR4twtrO4=;
	b=hoY17NyQVqJzG/CeQh7ewGECS4oiaq11gsNkxPV0tscvdwggM0GHGXHCUFgRbZ1juDTTdg
	J57CbtqIq5JZehtMEfqPlFostRXeIGtzwd4qJOhSsMbd8aJjDNyNannWHpIivyrYAvqNIj
	EfxXldCWiMcJguG+CLP3+jaQQEgIsTOA5WDS5hs4e/utx1xk6c4LwoTCcKf+ueJWbGsR+3
	ZKbGdAivILaDROpozWmT8JInhXuVVsEiZjl0uX9aGD2/EauTTDUPqAAkFORiNgwQPMqY7z
	1+bSnnNpCxnOqIWUnWJlqqvtgJt+BkgpluoPf6taziXiOYCnhgCSxoLt9+9iIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782207528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b/kePziIcU5+vEDkGgb/hmvnq0AGaFGGKDzR4twtrO4=;
	b=PJ68GUXYXemoCTh4fwLlH8xW5PRRfYS+EeNA+ghCy57x+tu318Zsi1nzmOeGrdsUWWF2du
	6D2A8K1IFtRwZZDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: wen.yang@linux.dev
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rv/reactors: fix lockdep "Invalid wait context" in
 rv_react()
Message-ID: <20260623112942-4943fc6a-c1d5-4eed-a91f-66b3a034caa7@linutronix.de>
References: <cover.1781541556.git.wen.yang@linux.dev>
 <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>

On Tue, Jun 16, 2026 at 12:44:48AM +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
> 
> The DEFINE_WAIT_OVERRIDE_MAP() macro creates a lockdep map with
> wait_type_inner = LD_WAIT_CONFIG, which inherits the outer context's
> wait type.  When rv_react() is called from a LD_WAIT_FREE context
> (e.g., a KUnit test with busy-wait), and the reactor callback triggers
> a timer interrupt during the busy-loop, the interrupt exit path attempts
> to schedule (preempt_schedule_irq -> __schedule -> rq->__lock), which is
> LD_WAIT_SPIN.  Lockdep then reports:
> 
>     [ BUG: Invalid wait context ]
>     context-{5:5}
>     1 lock held by kunit_try_catch/209:
>      #0: rv_react_map-wait-type-override at rv_react+0x9d/0xf0

It would be nice to have the full trace here from your real-world example.

> The wait_type_override map allowed the outer LD_WAIT_FREE to propagate
> inward, but scheduling from an interrupt is LD_WAIT_SPIN, violating the
> constraint.
> 
> Fix by explicitly setting wait_type_inner = LD_WAIT_SPIN, which is the
> tightest constraint rv_react() callbacks must satisfy: they may not
> sleep (LD_WAIT_SLEEP) or use mutexes, but can use spinlocks and be
> interrupted. This matches the documented LD_WAIT_FREE constraint.

So this is not a pure fix but a change in behavior. This should be
reflected in the subject.

> Fixes: 69d8895cb9a9 ("rv: Add explicit lockdep context for reactors")
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> Cc: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  kernel/trace/rv/rv_reactors.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
> index 460af07f7aba..423f843bbd68 100644
> --- a/kernel/trace/rv/rv_reactors.c
> +++ b/kernel/trace/rv/rv_reactors.c
> @@ -465,7 +465,13 @@ int init_rv_reactors(struct dentry *root_dir)
>  
>  void rv_react(struct rv_monitor *monitor, const char *msg, ...)
>  {
> -	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
> +#ifdef CONFIG_LOCKDEP
> +	static struct lockdep_map rv_react_map = {
> +		.name = "rv_react",
> +		.wait_type_outer = LD_WAIT_FREE,
> +		.wait_type_inner = LD_WAIT_SPIN,
> +	};
> +#endif

This now allows reactors to take (raw) spinlocks. The original idea was
to not allow that as a reactor can be called from LD_WAIT_FREE context.
So I am not sure this is the right fix. Not that I have a better one
available right now.

>  	va_list args;
>  
>  	if (!rv_reacting_on() || !monitor->react)
> -- 
> 2.25.1
> 
