Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4003FC5BE;
	Mon, 10 Aug 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373121; cv=none; b=jCQ9yqZ71kCGjYnuedZaPmHDaC2sy/EZwDoJJPuRu1SznHn8gt21pFGc45tdff+lKyVeSG2UEOhSF3F//RzhYhCcfffspGvZWfVfkiAtfjtCP6p8LUmFn4OfT67D38dG01dOdFelWPSAdOcnUzIWlb53JwQBrgdQzfvovr6Kldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373121; c=relaxed/simple;
	bh=i+sXm5+EZv031KmZpzatKjfv+kA4xl/1/NkR1Ma3ba8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uqOuQYNvhki6DxrEwqnmCc73VLBvEafPPJamugI/ZCcmDtfQu29Inahi5arh5FAPScnCNSg3UtVnUXsF0Ad0J5nQB+o6UH/Qu31ILWc+QpNj6Q31AtJe57rzubQkmiGZGBRWj7Knf8/j0B6BDJi+i3TnobYGygs4zQYMzqegtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 0BFEF1A018E;
	Mon, 10 Aug 2026 14:45:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 3E54920026;
	Mon, 10 Aug 2026 14:45:16 +0000 (UTC)
Date: Mon, 10 Aug 2026 10:45:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Wu <michael@allwinnertech.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5] tracing: Fix race between update_event_fields and,
 event_define_fields
Message-ID: <20260810104525.6a3a2e6c@gandalf.local.home>
In-Reply-To: <2e5730d2-c631-da41-3a3a-ae35bb4895f3@allwinnertech.com>
References: <2e5730d2-c631-da41-3a3a-ae35bb4895f3@allwinnertech.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nkq38s7jf7tgedn1h4b3ka9fxoq9mj5e
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 3E54920026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JkqIB3X6n5MSWGtnF1Iwjw07dFJ2QE+o=
X-HE-Tag: 1786373116-184958
X-HE-Meta: U2FsdGVkX1+fgnBRCyy1YTccF6lMNKny+Mav7AvICLlX9Re++NbUYBPIgy8n4u9xrdIwhQn7KJMzmeBRtBw8h8aUmtHctRDXHZ1RrHON+vnY0KMhOdas5TK3M5v+PI7UOQPg+Ua4t6VPG6xLDSdUL3lhzdOC/eUFi/84CncU7A2nda/mLe2jKxY8IUZvZd6h7bKkNCVIwSDfWqCBXCc8HygHjWaESTw2XqwG9GWpCVZcsUZU8I8dSad4xjDwkIqtGjdIEjX9/l4alLVlZC8V5B8THVQXwCVfR5g2y6ju4JkSdXvuT2AYI1EqvPgNE3IOP+MbHU4sqewr2ZiZzxrp71hCi/BgtpyX2LxahezQZh/aW/decstEphpiyfGUtSoirZCSlAP1Sns3iK/kEp5KXg==

On Mon, 10 Aug 2026 14:32:30 +0800
Michael Wu <michael@allwinnertech.com> wrote:

> The following sequence may leads race between event_define_fields()
> and update_event_fields():

>   CPU0 (module A, pri=1 notifier)        CPU1 (module B, pri=0 notifier)

What does the above mean? Are you loading two modules at the same time?
What does "pri=X notifier" mean? What function calls are these coming from?

-- Steve

>   ===============================        ===============================
>   event_define_fields(call_A)            trace_event_update_all()
>     for each f:                            list_for_each_entry(...,
>       list_add(&f->link,                                &ftrace_events)
>                &class->fields)               -> finds call_A
>         f->link.next = next;        (2)
>                                            update_event_fields(call_A)
>         WRITE_ONCE(class->fields->next,
>                    &f->link);       (4)
>                                              list_for_each_entry(field,
>                                                &class->fields, link)
>                                              -> field = class->fields->next  
>                                                   = &f->link
>                                                   = f (offset 0)
>                                              -> arm64 weak ordering:  
>                                                 (4) visible before (2)
>                                                 field->link.next == 0
>                                              -> next iteration:  
>                                                 field = (void *)0 = NULL
>                                              -> crash at NULL->type (0x18)  
> 
> This produces the following panic:
>    Unable to handle kernel access ... at virtual address 0000000000000018
>    pc : update_event_fields+0xf8/0x368
>    Call trace:
>     update_event_fields+0xf8/0x368
>     trace_event_update_all+0x7c/0x2b4
>     trace_module_notify+0x4c/0x1dc
>     notifier_call_chain+0x84/0x168
>     blocking_notifier_call_chain_robust+0x64/0xd4
>     load_module+0x10c8/0x123c
>     __arm64_sys_finit_module+0x230/0x31c
> 
> Fix by taking event_mutex in trace_event_update_all() before
> trace_event_sem.
> 
> Fixes: b3bc8547d3be ("tracing: Have TRACE_DEFINE_ENUM affect trace event types as well")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
