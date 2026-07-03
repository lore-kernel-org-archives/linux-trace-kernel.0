Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D73D25BC;
	Fri,  3 Jul 2026 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093358; cv=none; b=Z+OTqQ7ewOxzPs8rGLlEehFl5KefNoThZXGc43kojaC9CYYh0uGNjtYFxV2Fcy3xnPTFH/KaBJWmA4/LvtKQeMOpgRGF06eNcF4OrR61EsP465RafxVfvFUCzk8YYJLvxyS9IeJevBasZuNYo9y6pSoIWcfP9LNOPO6inyyPN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093358; c=relaxed/simple;
	bh=6mCPrTzW4noYwbsuzcBJ+qFltknqmygPCX0r6S+AIqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXauIoWAwir+9Kg7G1g9l6Z7fDtZ7iUCZLXaT2ija4EKSkmoe9Wk4BH7cZGbrKAeXhNghPqObVe08gfZGBa0isUYDuFn2xp89awYnuuBm7CRcW0qjdnnX6MCGvrNeAyofUuayvy3EcRchmwoY3md/vbd0O9+gSGkyBtdnBtTAQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6BE83401BC;
	Fri,  3 Jul 2026 15:42:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 81C312002A;
	Fri,  3 Jul 2026 15:42:27 +0000 (UTC)
Date: Fri, 3 Jul 2026 11:42:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
Message-ID: <20260703114233.56f0c864@gandalf.local.home>
In-Reply-To: <d8f33e0a-b378-4dad-92b1-9ce2098c04f3@web.de>
References: <20260701174829.67ab8a33@gandalf.local.home>
	<79106214-b341-46ab-8810-a206ce8fad29@web.de>
	<20260702165346.035f8eef@gandalf.local.home>
	<d8f33e0a-b378-4dad-92b1-9ce2098c04f3@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9mdngkfuw669i9xtkm146e3t3z5iihit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 81C312002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+hofvhNtSKWTT3a7AajmSaw2AZDqwn6BY=
X-HE-Tag: 1783093347-77130
X-HE-Meta: U2FsdGVkX1+1fvlwKGxzxhiRD1allVvTvi4hD/9hFo7K4810BVHKAwkGSmMFcjPyCDK12ZcRas/xQOi76uI7901U894kv5mpvGtKjD3odSA1zzLU23c/1auGVBN0N6UcHXARtyZZLuLJEK6dMJ5hJXm15F0r/gl7l+jjwJMioci9gQUFOzCqp03/TWmoi9AwuisArfpuct7axWMPuugrRoqDGpKNKqCJxzhAwgSE4gxdePYAVfLYF2IMxiqHmk/wxVN/kJPYOqT5pgs3cVkJU7mmwVs58fnx2ZUMvlhN5tNpYjqtqxi8Tqi0Vrr/nZ005NdWwogjKQ4B2lDZLGk4W/hkQs1asPkBRvOLZm6asIzt8edfB6mUEDQVDU76aS8G

On Fri, 3 Jul 2026 07:00:10 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> > No, it's fine as is.  
> Does this feedback mean that you disagree to an essential development requirement
> according to such a programming interface?
> https://elixir.bootlin.com/linux/v7.1.2/source/include/linux/cleanup.h#L142-L153

>  * Given that the "__free(...) = NULL" pattern for variables defined at
>  * the top of the function poses this potential interdependency problem
>  * the recommendation is to always define and assign variables in one
>  * statement and not group variable definitions at the top of the
>  * function when __free() is used.

This is really just a guideline.

>  *
>  * Lastly, given that the benefit of cleanup helpers is removal of
>  * "goto", and that the "goto" statement can jump between scopes, the
>  * expectation is that usage of "goto" and cleanup helpers is never
>  * mixed in the same function. I.e. for a given routine, convert all
>  * resources that need a "goto" cleanup to scope-based cleanup, or
>  * convert none of them.

The above has more to do with guard()s and not so much with a __free() at
the top of the function. The reason is because things get broken if a goto
jumps over a guard().

In other words, if you don't know what you are doing, don't mix them.

-- Steve
