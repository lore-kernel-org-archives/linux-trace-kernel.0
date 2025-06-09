Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C85D1FDE22;
	Mon,  9 Jun 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483522; cv=none; b=kDJEfsGceGFnX0tCiygUskdnczStpiPDCUVTfHWjJwwkezpQ8TWBAG7UfwEkjalyohzt8FBczLnbKFVDSdrQoodyFn1+/cppYcjJ2KRVmMLAbomItCqEmVliAbpzfWjIAIh/EeKS5PN/u4O1IXlw0LFk9AFY5EfsTMi9V8ur0rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483522; c=relaxed/simple;
	bh=vjumWbI1nLmJofNVoMmsXIpj4QnYwD0P0T1Q8ZvROOw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YT9G0rMXR4ZoQL/7XMk/w69R1dinppkYQCEXeShRzFIk4UcO24A99r7x65H4aH5JmDfAx8JgTUY2zmOATT8NJBgLgnPg8Gqjesueed0pQWDH57Jg5Wz/7FMZkHHBQreD7UQjkzVwpE/jfDQ1ZddBYLKYRrwAe4D8Oyzgt97iJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id D7EF4120695;
	Mon,  9 Jun 2025 15:38:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id C0B8918;
	Mon,  9 Jun 2025 15:38:27 +0000 (UTC)
Date: Mon, 9 Jun 2025 11:39:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Andreas Ziegler
 <ziegler.andreas@siemens.com>, Felix MOESSBAUER
 <felix.moessbauer@siemens.com>, Julien Flot <julien.flot@siemens.com>
Subject: Re: [PATCH v2] tracing: Fix regression of filter waiting a long
 time on RCU synchronization
Message-ID: <20250609113955.47a2f44c@gandalf.local.home>
In-Reply-To: <9a2f0cd0-1561-4206-8966-f93ccd25927f@paulmck-laptop>
References: <20250606201936.1e3d09a9@batman.local.home>
	<9a2f0cd0-1561-4206-8966-f93ccd25927f@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: C0B8918
X-Stat-Signature: k77cudh6kkko738ufnaaa5w1gbb47hnq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19olcQrNIITw9reBrW2zFmvrSR4FMpmzqA=
X-HE-Tag: 1749483507-534997
X-HE-Meta: U2FsdGVkX18WltvNoZqDQyslFZ+ayUtqvpED8YUCRFGbu+nDsw5JPVdzsfCqzaF7wGi8JigYzLF5hlblisjz2TfNLGSOvDCq9C5SDtG37DXSPQuo0crEtWnLAIZhV4n4rqP7Q5BhpOz4K2T/jMMqmFARqAS1RpLY334H39hGuEHkFltKL8qmpQRvatdXEPG59hW9etCcpH9yImlWGwhNrM7tQDsM535YPzcSlkktDTUg3NF3nEXjEWnTmEFWEhnDpSXrlxdJ0UL6i1wOXGz89uaGxaNoUdjdjlExjSTEawbqbEosqDxudpK22WXlFaLxYd9HzaG2BR2wdXdP+eNgEVkFsR2FJL/v

On Mon, 9 Jun 2025 05:21:19 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > +static void free_filter_list(struct rcu_head *rhp)
> > +{
> > +	struct filter_head *filter_list = container_of(rhp, struct filter_head, rcu);
> > +	struct filter_list *filter_item, *tmp;
> > +
> > +	list_for_each_entry_safe(filter_item, tmp, &filter_list->list, list) {
> > +		__free_filter(filter_item->filter);
> > +		list_del(&filter_item->list);
> > +		kfree(filter_item);
> > +	}  
> 
> If the series of synchronize_rcu() calls was taking 99 seconds,
> we might well be going through the above loop quite a few times, all
> within a bh-disabled region of code.  For example, the calls from both
> filter_free_subsystem_filters() and process_system_preds() look like
> they can queue a very large number of entries.

The iteration is for each event in a subsystem.

Seeing what that is:

~# for sys in /sys/kernel/tracing/events/* ; do cnt=`ls -F $sys |grep '/$' | wc -l`; echo $cnt $sys; done | sort -n | tail
24 /sys/kernel/tracing/events/tcp
26 /sys/kernel/tracing/events/xen
28 /sys/kernel/tracing/events/sched
32 /sys/kernel/tracing/events/writeback
33 /sys/kernel/tracing/events/libata
34 /sys/kernel/tracing/events/irq_vectors
55 /sys/kernel/tracing/events/xhci-hcd
92 /sys/kernel/tracing/events/kvm
113 /sys/kernel/tracing/events/ext4
724 /sys/kernel/tracing/events/syscalls

So the most loops that can happen is 724 on the syscalls plus the system
filter. And adding in printks to count the loops, I verified that:

[..]
[  100.019209] LOOPED 4 times
[  100.020033] LOOPED 5 times
[  100.020791] LOOPED 8 times
[  100.021583] LOOPED 10 times
[  100.022239] LOOPED 2 times
[  100.110515] LOOPED 725 times
[  100.111520] LOOPED 4 times
[  100.112889] LOOPED 25 times
[  100.114416] LOOPED 6 times
[  100.115950] LOOPED 4 times
[  100.117557] LOOPED 7 times
[..]

(724 event filters and one system event filter = 725 filters).

If you feel that's too big, we could move it to a work queue.

As more system calls get added, that number will grow. But it is limited to
the number of system calls.

All the event systems are way fewer than that.

> 
> So...
> 
> > +	kfree(filter_list);
> > +}
> > +
> > +static void free_filter_list_tasks(struct rcu_head *rhp)
> > +{
> > +	call_rcu(rhp, free_filter_list);  
> 
> ...why not use queue_rcu_work() in place of call_rcu() here, thus avoiding
> possible response-time issues?
> 
> Or is there something that I am missing that limits the length of the
> list passed to free_filter_list()?

Just the number of events in a system.

I could switch to a work queue but I don't think it needs to go as a fix,
do you? That is, it can wait till the next merge window. Or is this going
to affect things now?

-- Steve
