Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750C1E25E6;
	Mon, 21 Oct 2024 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729499864; cv=none; b=iRqC8iCh/SJhhvOC3arGlKWvh7cUf4onBF4VFO/oPePN+S0fBGYpr0QiyTrs6zwGSiwew5h6/99T5h7BowK9SDl27jXjwoyLYNJnYaNBrWPPt9EAFTxjfa9dZITCd7SDUSypRFLHTN3JwcAiu+oMMqidzL2MGR6kWgikW0Si42E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729499864; c=relaxed/simple;
	bh=7uOEf8AmYvhNU4JKXwXKMyFdmwr1fZehRFdtIpHEDaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAAiK1e3n6wYwaezAJ7ZtCZpZcqKkN33QqyAB/aefnU9OG1B4ThSACjklf6DLkP0iMdgVgVcsAJ0ftrHFxDoq1sZnqJzub5lpu4NY7OjxuzKvLgrzZveAT0f5IXgu6CCo+oJB1XmPPgqtfPxZRHJc3Ek+LO0DFnxkrxvRHT/890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93430C4CEC3;
	Mon, 21 Oct 2024 08:37:42 +0000 (UTC)
Date: Mon, 21 Oct 2024 04:37:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] fgraph: Give ret_stack its own kmem cache
Message-ID: <20241021043738.4d55a6a1@rorschach.local.home>
In-Reply-To: <bf425884-b355-4da9-8e2b-6da693f2760b@arm.com>
References: <20241019152719.321772eb@rorschach.local.home>
	<bf425884-b355-4da9-8e2b-6da693f2760b@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Oct 2024 08:58:11 +0100
Ryan Roberts <ryan.roberts@arm.com> wrote:

> > @@ -1290,6 +1305,16 @@ int register_ftrace_graph(struct fgraph_ops *gops)
> >  
> >  	mutex_lock(&ftrace_lock);
> >  
> > +	if (!fgraph_stack_cachep)
> > +		fgraph_stack_cachep = kmem_cache_create("fgraph_stack",
> > +							SHADOW_STACK_SIZE,
> > +							SHADOW_STACK_SIZE, 0, NULL);  
> 
> (I don't have any experience with this code, but...) is there any value/need to
> destroy the cache in unregister_ftrace_graph()? I guess you would need to
> refcount it, so its created on the first call to register and destroyed on the
> last call to unregister?

No, we can't destroy it. In fact, we can't destroy the stacks
themselves until the task exits. This is because a function could have
been traced and its return address gets replaced by the fgraph return
code. Then it goes to sleep. For example, say you were tracing poll,
and systemd did a poll and you traced it. Now it may be sleeping
forever, waiting for some input. When it finally wakes up and exits the
function, it will need to get its original return address back.

The ret_stack holds the original return address that is needed when the
function finishes. Thus, its not safe to free it even when tracing is
finished. The callbacks may not be called when tracing is done, but the
ret_stack used to do the tracing will be called long after tracing is
over.

Now I'm looking at being able to free stacks by scanning all the tasks
after tracing is over and if the stack isn't being used (it's easy to
know if it is or not) then we can free it. But for those cases where
they are still being used, then we just have to give up and leave it be.

-- Steve
