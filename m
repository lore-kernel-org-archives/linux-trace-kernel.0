Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94265371CFF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308883; cv=none; b=a0Zup9EhlaRDMsJicYqiqs9OLzAhXYkV2RANgsCpmX35GH3tNgrFYfkngbqDKUS9yejqOw1d1h3khJOr60y8OZx69aMrIFLkdBFc4RRu+ozZh35zHhu20wwOJWO08sxUOEErQnD2T+zpgMfXl5uLBn23Pk9oU7gyP3GhQ/Wr5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308883; c=relaxed/simple;
	bh=m83fV44PE5AQzrXp1fABP39gZAo6a+ut5rx0vItetZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qA0aCysgNtwMuy/2bx6z+5x43j2BU0PctQ5NKZO9nGqbcAPf8XMtQ4imzDxx9Cp0tGpgEdmOtW2GXZEJr9VJUVzIKb82qIQz/FthNlQqQN/1GbOl9aWJZ7HAdfnSzbmtoAc4Z1lPYeMbOestAE0O+/lZbdZt0U4UGAPZ+qL8zd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 727AE1C1251;
	Wed, 20 May 2026 20:27:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 7E08520025;
	Wed, 20 May 2026 20:27:51 +0000 (UTC)
Date: Wed, 20 May 2026 16:28:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Crystal Wood <crwood@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa <wander@redhat.com>, sashiko-bot@kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] tracing/osnoise: Array printk init and cleanup
Message-ID: <20260520162810.3112a9d6@gandalf.local.home>
In-Reply-To: <20260511223035.1475676-1-crwood@redhat.com>
References: <20260511223035.1475676-1-crwood@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: pj8fyrwg5tntqjrf78cb5c91u6mmtpy4
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7E08520025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/ZEJSX/ozQlAg+w+NVgjJB/34YL8FPzk0=
X-HE-Tag: 1779308871-93409
X-HE-Meta: U2FsdGVkX1+KONntJ3OhdvTFfviCO09iljXKPwPtjnINQCWU0Jt/9uChU9JK8hnoNgHiYgpATkEC7/BZGuwZFwnPO1sA7VfpbC73IbNf14CN8LbTWOalYJgWYkoxTKKxwXa/Sivl/4yw1J/lTiOblHXdTTP02zoOsjxOFBKX6dxioAmzjLgZpygplub8fSQRFFle98F0nLqtE/LfR2zq1ycd0R+CJDutGcgn8pXccNjf3OgMi2Aqyh2pnN/hF4Hjql7frxV3HAhSrSfkwbvI+QrvguHYKdjXQU6coSLeDSxFoLj9rEG7fn97jbob0+h5I7NkDbrAVk5MvMt7ch72CG9dMOeU51pjC0nBPVUFZFoAXeeEiRMVAqyyAHh6KcEqgcW91OhcMvkUe/I9tQYG7Q==


[ Replying to Sashiko: https://sashiko.dev/?list=org.kernel.vger.linux-trace-kernel#/patchset/20260511223035.1475676-1-crwood%40redhat.com ]

> commit 859dc1eded9e36304f27e72643f28f30f327f078
> Author: Crystal Wood <crwood@redhat.com>
> tracing/osnoise: Array printk init and cleanup
> This commit initializes the trace array buffer for osnoise instances on
> creation. It also introduces the osnoise_print() helper function and switches
> the tracer to use trace_array_printk() instead of trace_array_printk_buf().
> > Use trace_array_printk() instead of trace_array_printk_buf(), as we're
> > only writing to the main buffer (of a non-main instance) anyway -- and

> Is this description accurate? Can the osnoise tracer also be enabled on the
> global trace array, for example by writing to current_tracer?
> If it is used on the global instance, trace_array_init_printk() explicitly
> returns -EINVAL and refuses to allocate a buffer, and trace_array_printk()
> will return 0 without printing.

Hmm, I guess it would drop any of these prints if it's using the top level
trace array. But I believe this is for use with RTLA which always creates a
trace instance.

> > diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> > index 75678053b21c5..2be188768ab42 100644
> > --- a/kernel/trace/trace_osnoise.c
> > +++ b/kernel/trace/trace_osnoise.c
> > @@ -83,6 +83,22 @@ struct osnoise_instance {
> >  
> >  static struct list_head osnoise_instances;
> >  
> > +static void osnoise_print(const char *fmt, ...)
> > +{
> > +	struct osnoise_instance *inst;
> > +	struct trace_array *tr;
> > +	va_list ap;
> > +
> > +	rcu_read_lock();
> > +	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
> > +		tr = inst->tr;
> > +		va_start(ap, fmt);
> > +		trace_array_vprintk(tr, _RET_IP_, fmt, ap);

> Does this code create a use-after-free on the trace array if an instance is
> removed concurrently?
> When a user deletes a trace instance via rmdir, the unregister function
> removes the instance from the list using list_del_rcu(). However, the removal
> routine does not appear to wait for an RCU grace period before freeing the
> trace array itself.
> Could a concurrent execution of this loop inside the rcu_read_lock() section
> still access the unlinked instance, read the freed inst->tr, and pass it to
> trace_array_vprintk()? This appears to be an existing issue, but it still
> affects the loop here.

Hmm, this is interesting. osnoise keeps track of its own instances via a
osnoise_instances list. But it only use kfree_rcu() to free the list
descriptor but doesn't take care of the tr being freed before hand!

Something like this could work [not even compiled]

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 75678053b21c..bda1e0e0d2e1 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -476,8 +476,11 @@ static void print_osnoise_headers(struct seq_file *s)
 										\
 	rcu_read_lock();							\
 	list_for_each_entry_rcu(inst, &osnoise_instances, list) {		\
+		if (trace_array_get(inst->tr) < 0)				\
+			continue;						\
 		buffer = inst->tr->array_buffer.buffer;				\
 		trace_array_printk_buf(buffer, _THIS_IP_, msg);			\
+		trace_array_put(inst->tr);					\
 	}									\
 	rcu_read_unlock();							\
 	osnoise_data.tainted = true;						\


> > +		va_end(ap);
> > +	}
> > +	rcu_read_unlock();
> > +}
> [ ... ]
> > @@ -123,6 +139,7 @@ static int osnoise_register_instance(struct trace_array *tr)
> >  	 * trace_types_lock.
> >  	 */
> >  	lockdep_assert_held(&trace_types_lock);
> > +	trace_array_init_printk(tr);

> Could this leave the per-CPU buffer unallocated when running on the global
> instance?
> If the tracer is used on the global trace array, trace_array_init_printk()
> returns -EINVAL. Because this return value is ignored here, the buffer
> remains unallocated, causing trace_array_vprintk() to fail internally.

Well, it will fail anyway because it is the top level trace buffer.

> [ ... ]

> > @@ -1189,10 +1198,10 @@ static __always_inline void osnoise_stop_exception(char *msg, int cpu)
> >  	rcu_read_lock();
> >  	list_for_each_entry_rcu(inst, &osnoise_instances, list) {
> >  		tr = inst->tr;
> > -		trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
> > -				       "stop tracing hit on cpu %d due to exception: %s\n",
> > -				       smp_processor_id(),
> > -				       msg);
> > +		trace_array_printk(tr, _THIS_IP_,
> > +				   "stop tracing hit on cpu %d due to exception: %s\n",
> > +				   smp_processor_id(),
> > +				   msg);

> Does this switch to trace_array_printk() silently drop messages when tracing
> on the global instance?
> Looking at trace_array_printk(), it explicitly returns 0 if the
> TRACE_ARRAY_FL_GLOBAL flag is set on the trace array:
> kernel/trace/trace_printk.c:trace_array_printk() {
>     ...
> 	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
> 		return 0;
>     ...
> }
> This means stop and exception logs would be discarded if the tracer is
> running on the global instance.

Yep. But maybe that's not an issue?

-- Steve

