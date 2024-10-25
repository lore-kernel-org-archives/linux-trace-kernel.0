Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E310A19;
	Fri, 25 Oct 2024 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729818321; cv=none; b=IXt7MKNgUZY9oESlEmgMdx1XY5nnrhbVCmY8qC+Mhz7JTRx2z9jZOo8ujpVYwdFUwsaX2uEGf+EfLyYNEQoLd/6CmK4xdIp9TWVegemMtV8uqhIrFuJm2WcuZCrGk+G+hP75nxkehX5Zi0koVropcwHg2WxIjj3aM0h5mryfy/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729818321; c=relaxed/simple;
	bh=xYOYJxh6xMZHF0NJHDVigkIS5hoayHXk4j1TF7X8HBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3t2uwKtMiMkgEHitd3F58NU+/yl3rcV+M8poFRdSQg90b7+pKz5CYEuS0yL7eTXTkIO+inrJ2rdokSKiSJu+fSCg3PQYbuYcYspRh3ZVzGPyrw6sH+qc5J4UnYOd4PGzl+cyQpBMjScrTEyVaWcEHxyYd2Z0UC8Bj+Kkpb6bwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6357FC4CEC7;
	Fri, 25 Oct 2024 01:05:19 +0000 (UTC)
Date: Thu, 24 Oct 2024 21:05:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] fgraph: Free ret_stack when task is done with it
Message-ID: <20241024210515.53943bdf@rorschach.local.home>
In-Reply-To: <20241025002121.ef5dc8be87e1b6baa2dd544c@kernel.org>
References: <20241024092723.817582319@goodmis.org>
	<20241024092952.709200360@goodmis.org>
	<20241025002121.ef5dc8be87e1b6baa2dd544c@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 00:21:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > +static void fgraph_ret_stack_work_func(struct work_struct *work)
> > +{
> > +	mutex_lock(&ftrace_lock);
> > +	if (!ftrace_graph_active)
> > +		free_ret_stacks();
> > +	mutex_unlock(&ftrace_lock);
> > +}  
> 
> Hmm, will you scan all tasks everytime? Shouldn't we have another global
> list of skipped tasks in remove_ret_stack(), like below?
> 
> static void remove_ret_stack(struct task_struct *t, struct list_head *freelist, struct list_head *skiplist, int list_index)
> {
> 	struct ret_stack_free_data *free_data;
> 	struct list_head *head;
> 
> 	/* If the ret_stack is still in use, skip this */
> 	if (t->curr_ret_depth >= 0)
> 		head = skiplist;
> 	else
> 		head = freelist;
> 
> 	free_data = (struct ret_stack_free_data*)(t->ret_stack + list_index);
> 	list_add(&free_data->list, head);
> 	free_data->task = t;
> }
> 
> Then we can scan only skiplist in free_ret_stacks() in fgraph_ret_stack_work_func().
> 
> Of course this will need to decouple preparing freelist/skiplist and
> actual free function.

I thought about doing it this way, but I felt that it made the code
more complex with little benefit. Yeah, we scan all tasks, but it only
happens in a work queue that is grabbing the ftrace_lock mutex. If
anything, I rather keep it this way and if it ends up being an issue we
can change it later.

One thing Thomas always says is "correctness first, optimize later".
This is much easier to get correct. Adding a skip list will add
complexity. Like I said, nothing prevents us from adding that feature
later, and if it ends up buggy, we can know which change caused the bug.

-- Steve
