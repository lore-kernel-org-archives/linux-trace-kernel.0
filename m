Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347342BDC0F;
	Mon,  6 Jul 2026 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344845; cv=none; b=e8+t7UA+x1kkjcPKFnxNjnXns+x+GfHoKJQCYhAgrvrtQGMIXu21RJ0IXvaQLREor/fysgNJP7c8dnYGX93suhayDuWFya8V7r0JX1ilmV901oaVwd50WvLQYhy5UHsvFVHD/z6z8OrRqPNePFflWCIqBXLDDbiJaWBbIANl/OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344845; c=relaxed/simple;
	bh=WY22pQhYBAZK7JB7HgwClXJb0Jf7F0D3iKKHcsLIPRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKrmGTw5611zlAT+CwdMIZ/ImIswtDJ35oVPL7i+g61jIdMnqmKGLBmr4du9DLaKp6Aj2BmNwi4B1VuJkQuL7+oj8Ji8PNX4m5vfPFNigY1yMlYvzPVRWwDzO63PCi6XPyWJ6oyPKvYz42a4v1zTEhq8w8FnE74Gk8Yk/JRP8Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id D89C340306;
	Mon,  6 Jul 2026 13:33:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id AE0AC6000B;
	Mon,  6 Jul 2026 13:33:51 +0000 (UTC)
Date: Mon, 6 Jul 2026 09:33:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Eugene Mavick <m@mavick.dev>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Gary
 Guo <gary@garyguo.net>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH 1/4] tracing: add ref_trace_final_put tracepoint
Message-ID: <20260706093352.02bd08c0@gandalf.local.home>
In-Reply-To: <20260705-refcount-final-put-trace-v1-1-cdd0014626a9@mavick.dev>
References: <20260705-refcount-final-put-trace-v1-0-cdd0014626a9@mavick.dev>
	<20260705-refcount-final-put-trace-v1-1-cdd0014626a9@mavick.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: AE0AC6000B
X-Stat-Signature: 74n7nyetqp76efpmpoitcun1b7f3dydt
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/NhqJtYjnkM7IHOrlFdiTHVk2lDmEUh20=
X-HE-Tag: 1783344831-930887
X-HE-Meta: U2FsdGVkX1+2clslqU1OwznXkTDevv7qXlbJtfY4KlGfdEb7QptnmTpeFWuCHtOPBTrStmj0VnGLcxq1pK+heA/i94/tcxiFMu00LCktHex6zrsBHlFBafommHpHadV4wQ8DNvl1SQyH4HXp8XRxjf1bPsMtE37aP73hbCUJVoUumi7MjSkv78bR1fWm7y84AwhZNCeBm5U31Zv4rjO6YMIGjMDgmcL2z6vBgbUYf4a6wiNF0PvvfCbUS70CvYxneatoS9T1TUucGwm3XMH4qzWXTyAp1dHzrj8/qTwQQt4+Zpqc2ehb9Kg5PodJ5FHR

On Sun, 05 Jul 2026 07:19:20 +0800
Eugene Mavick <m@mavick.dev> wrote:

> +++ b/lib/ref_trace.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/ref_trace.h>
> +
> +//Wrapper function for functions defined entirely in header files
> +void do_ref_trace_final_put(unsigned long caller, const char *fn, const void *obj)
> +{
> +	trace_ref_trace_final_put(caller, fn, obj);
> +}
> +EXPORT_SYMBOL_GPL(do_ref_trace_final_put);

Since this is only called when ref_trace_final_put tracepoint is enabled,
you can use the direct call that doesn't use the static_branch(). The above
should be:


//Wrapper function for functions defined entirely in header files
void do_ref_trace_final_put(unsigned long caller, const char *fn, const void *obj)
{
	trace_call__ref_trace_final_put(caller, fn, obj);
}


-- Steve
