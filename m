Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70F3279DCE;
	Fri, 21 Nov 2025 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754688; cv=none; b=cC+30M1vpEGiE6H74GvQtWk+5/2GUUu4nplKggl5QUnFapxh7CPhKkBMUM5gJkSFg80jZXH9D+L4mEickXEwOV/yjNIrtsaXc4iDbP9aogurr4jlx4AYldz2xDT4AFOMfhrZ9T4/hT6OMWHqPUv1tP+4VvRglVFggwSFWr/PD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754688; c=relaxed/simple;
	bh=QoV63hAxhv0Ff2tqjkfuMDcRoIUEUUYw1z0w3BvCBVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPbHX85HvknZfc6+QfY5jJaQsVRTNAXWsQD9bqSb/t5oH7Z7+JVT4JdD72ia2DzFV3dVBs/IRf0wqviNo1i880oB6reW0dujc2syTfE0Q3TmahO230MIvKP4w0aY5kY42Mxu0bWYUDT1bk15h31HxYKkPiqh60tvXRnh+BOzmhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 9D122BA6FA;
	Fri, 21 Nov 2025 19:51:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 8F4282000E;
	Fri, 21 Nov 2025 19:51:16 +0000 (UTC)
Date: Fri, 21 Nov 2025 14:51:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/3] tracing: Add bulk garbage collection of freeing
 event_trigger_data
Message-ID: <20251121145150.3716a1a1@gandalf.local.home>
In-Reply-To: <20251122001206.57ad6d77b96726421503da41@kernel.org>
References: <20251120205600.570673392@kernel.org>
	<20251120205710.151041470@kernel.org>
	<20251122001206.57ad6d77b96726421503da41@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8F4282000E
X-Stat-Signature: 3wu63ixi4pcw5zi983s19psrueunfq8c
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JRuO451PsZQqSv0Zj7MPwwEEiSyyWJYk=
X-HE-Tag: 1763754676-323947
X-HE-Meta: U2FsdGVkX18ATMNZYn3WNQoGKcyDAk55mNXPoyMFsD4ip+xFV6mQTRStaSCbKEpnnTQh7Hdf1U2yHrNPnzNazQyBoLNeH4ehIuo7bIqaK/f5iLA1W5v6Pt4zzm3BSotyg70VlzNGeyfxjMiaIvkQhNodH4Vt9WQRkWXcP5uZ9W8PSuXva7hsLQRd5Yfpfm4AdBEtHBeb5ZzITqKdknSf/b7fSFt4gn5rbTrV1tGbDRQRoYp9MF1hlM+lym4u429IWR7lAaz3j0sab8mlkVB2OwG70TXmoFl3HJBkuQT7yPSHCuSABcLsvNADoYgx9EM2IMjN9UlgWv4RnV4zGOpy7YVV6kbus3R5sL9s31i+9ae8nnF9m1UHBk8o3XW8WvAt

On Sat, 22 Nov 2025 00:12:06 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> >  /* Avoid typos */
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> > index e5dcfcbb2cd5..16e3449f3cfe 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -6,26 +6,76 @@
> >   */
> >  
> >  #include <linux/security.h>
> > +#include <linux/kthread.h>
> >  #include <linux/module.h>
> >  #include <linux/ctype.h>
> >  #include <linux/mutex.h>
> >  #include <linux/slab.h>
> >  #include <linux/rculist.h>
> > +#include <linux/llist.h>  
> 
> nit: Shouldn't we include this in "trace.h" too, because llist_node is used?

You mean to move it to trace.h instead of here?

> 
> >  
> >  #include "trace.h"
> >  
> >  static LIST_HEAD(trigger_commands);
> >  static DEFINE_MUTEX(trigger_cmd_mutex);
> >  
> > +static struct task_struct *trigger_kthread;
> > +static struct llist_head trigger_data_free_list;
> > +static DEFINE_MUTEX(trigger_data_kthread_mutex);
> > +
> > +/* Bulk garbage collection of event_trigger_data elements */
> > +static int trigger_kthread_fn(void *ignore)
> > +{
> > +	struct event_trigger_data *data, *tmp;
> > +	struct llist_node *llnodes;
> > +
> > +	/* Once this task starts, it lives forever */
> > +	for (;;) {
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		if (llist_empty(&trigger_data_free_list))
> > +			schedule();
> > +
> > +		__set_current_state(TASK_RUNNING);
> > +
> > +		llnodes = llist_del_all(&trigger_data_free_list);
> > +
> > +		/* make sure current triggers exit before free */
> > +		tracepoint_synchronize_unregister();
> > +
> > +		llist_for_each_entry_safe(data, tmp, llnodes, llist)
> > +			kfree(data);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  void trigger_data_free(struct event_trigger_data *data)
> >  {
> >  	if (data->cmd_ops->set_filter)
> >  		data->cmd_ops->set_filter(NULL, data, NULL);
> >  
> > -	/* make sure current triggers exit before free */
> > -	tracepoint_synchronize_unregister();
> > +	if (unlikely(!trigger_kthread)) {
> > +		guard(mutex)(&trigger_data_kthread_mutex);
> > +		/* Check again after taking mutex */
> > +		if (!trigger_kthread) {
> > +			struct task_struct *kthread;
> > +
> > +			kthread = kthread_create(trigger_kthread_fn, NULL,
> > +						 "trigger_data_free");
> > +			if (!IS_ERR(kthread))
> > +				WRITE_ONCE(trigger_kthread, kthread);
> > +		}
> > +	}
> > +  
> 
> Hmm,
> 	/* This continues above error case, but we should do it without lock. */
> ?

Does this really need a comment? The lock is only needed to make sure we
only create one kthread. If that fails, then we do it the slow way. The
code below is unrelated to the lock. The lock is for kthread creation, not
the trigger_kthread variable itself.

-- Steve

> 
> > +	if (!trigger_kthread) {
> > +		/* Do it the slow way */
> > +		tracepoint_synchronize_unregister();
> > +		kfree(data);
> > +		return;
> > +	}
> >  
> > -	kfree(data);
> > +	llist_add(&data->llist, &trigger_data_free_list);
> > +	wake_up_process(trigger_kthread);
> >  }
> >  
> >  static inline void data_ops_trigger(struct event_trigger_data *data,
> > -- 
> > 2.51.0
> > 
> >   
> 
> 

