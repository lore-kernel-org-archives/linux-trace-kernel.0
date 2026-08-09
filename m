Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301512E737D;
	Sun,  9 Aug 2026 02:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786241582; cv=none; b=Js+vSNPnl5T/hgRDzSHrhyjUOenoDpQazf/2SaycniH2de6kRP6MBFvn6tROuges7GiXgBZwWppMXFSD/50br09MfZClCNiwbXSoFpNgMQ+GgwVZlo9i6Tn0cZgw578hOSiF3zk/mxwU+tUQnka99Q/3+OFVo5SM68tF/Ro7+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786241582; c=relaxed/simple;
	bh=GNq1CsWQTqMBwpjicJa5abOJJFzq/MauLvvYK/u4r+c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5rioV9P9J11FwZNsbDJa8nSbUUxuvVgwwNNEgEt9Lqso/zJN2ihKdq820aaw/iSTH6xEaWMNSR0qKOtuFu33eilrbLxvkUR1GZHwXW4LDl/bdPqjfod1mgWdOKP3Q9RFcVwC2o8mpWF2WrmxpnqHHzGcViVMH2jbdADTNmWWvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 548A61A048F;
	Sun,  9 Aug 2026 02:03:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 9B8B520029;
	Sun,  9 Aug 2026 02:03:50 +0000 (UTC)
Date: Sat, 8 Aug 2026 22:03:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Wu <michael@allwinnertech.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4] tracing: Fix race between update_event_fields and,
 event_define_fields
Message-ID: <20260808220349.0a326dd1@robin>
In-Reply-To: <6c515e5f-66f4-0dc7-00f2-69f319c8ad87@allwinnertech.com>
References: <6c515e5f-66f4-0dc7-00f2-69f319c8ad87@allwinnertech.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 9B8B520029
X-Stat-Signature: ehszqt6ru1qikdmkohxfpq7s69igykyy
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ld07N37GEstt4PkLfrkPUZcZVDSBWVwU=
X-HE-Tag: 1786241030-56778
X-HE-Meta: U2FsdGVkX1+dDIgqGCGg+f2K1BbbdqI/I2Q5mI3iBk136Koj770tGKZYsn6eN1BZs4NVXHfxIUaFfcZKbE6pPrj6P7aX5Mq9Y+HcmSjmRwxpednhD6PiOdN34kzNcHkZRz/ICb4hXesVJArcsJFd7kNsib/xfezvMWQpSXFI16qYb8zUKzU2caYFsjS2uvLlm+Qnu1ZHTv06nE2ypgB7TPlYptwXNgx/CF3G2V/TDj+rmhdIdjjfyaFQU2IshdQhMFPITo9DORICsMf/RCdrXsAPtADXyq4k/21tZ1T+v+uMg0KRyxIycxvQbbvwjefS1DIIcn9Xcpik/KfINBMjdZEe8wgu16AUnbRXhU9frRitm1/hmgljfaSGS52RKhH8

On Mon, 3 Aug 2026 17:40:55 +0800
Michael Wu <michael@allwinnertech.com> wrote:

> event_define_fields() (pri=1 MODULE_STATE_COMING notifier, locked by
> event_mutex) populates class->fields via list_add(), while
> update_event_fields() (called from the pri=0 notifier path via
> trace_event_update_all) traverses class->fields protected only by
> trace_event_sem.  These are two different locks guarding the same
> data structure, so during cross-module loading a reader on one CPU can
> observe partially initialized list nodes being concurrently added by a
> writer on another CPU.
> 
> On arm64 with weak memory ordering, __list_add() writes to two
> different cache lines:
> 
>         next->prev = new;                // (1) ordinary store
>         new->next = next;                // (2) ordinary store
>         new->prev = prev;                // (3) ordinary store
>         WRITE_ONCE(prev->next, new);    // (4) release store
> 
> The store buffer can drain (2) and (4) independently since they target
> different cache lines.  A remote CPU may observe (4) before (2): it
> sees prev->next pointing to the new node, but the new node's link.next
> is still zero (kmem_cache_alloc zero-initialized via KMEM_CACHE with
> SLAB_PANIC).  Since offsetof(struct ftrace_event_field, link) == 0,
> list_for_each_entry() derives field == NULL from link.next == 0 and
> crashes at field->type (offset 0x18):

The above description is way too verbose. What exactly is the race?

Was the above written by AI? It looks like it .

I already tested it but when I went to write the log for Linus, I
realized this description isn't acceptable for the commit itself.

-- Steve
