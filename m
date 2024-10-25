Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55DC18B49F;
	Fri, 25 Oct 2024 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729827114; cv=none; b=BGpTKn146qdHDW/SuL8picoyLTZeQmw72/31XAuQJMel4x+Xodng1fPv6j4L+HkloMJOfyzcN/UjwzISbKELklaw2Rt23ytSSjxhrjOcdvx0lw/oKQccr1+0AfPsrSClWhTlglvWOioc8GaP92ENaH/VB6IvIl9tAVc7+6qX9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729827114; c=relaxed/simple;
	bh=VvI5nlL1Zkhzl2+jnG/7eOzLTF3I65OOjLSF3OzjUq4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=axOaFoRqaoX7/wlW5DzEGAE4lbt4+dTQnERsUi2xiE/j6I54o75jTQoIC6W6uO448Un/UeV0bQWBL11EiRjkmy2ZWWMc/+P+eKViw+mwn4OmTHLOA1tBVwCSEnfqisnEhq5Bhkx8IHB/mMCSFhLqZKdtj2OWFNHhvoyfkRuPIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3Ij4PSX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3Ij4PSX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D990C4CEC3;
	Fri, 25 Oct 2024 03:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729827114;
	bh=VvI5nlL1Zkhzl2+jnG/7eOzLTF3I65OOjLSF3OzjUq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b3Ij4PSXg+t+LzT499jHm8ksfzru+IcxzAfHkpgAjE7mxNRzkXvUD8kWdhPN7waqu
	 oPmnXclKxHUZQqUNzUGijD1Z8jlp5K/RjlOiqNbdpoxKPJ3VdJjjL3KBvNgoWKxMAB
	 UHgxsiVjRt39ijXYswjaof26UtNuc2Ur1/5vHpAOEXGvAkKIeMBU3SheMuKmxstxMt
	 s5xD1qPjhcdN9Z3aaRvwnLtSntYcg65sNoZI+Eeg464t4BzSXtg4C0D2byT7CVm+am
	 tFu/xUy7/2jDOZauhl71J3IjmeTco5aYYOxu0ps43jGMnvZePd+c5Yv8njxVnOkI3B
	 WzvHZtVgPchaQ==
Date: Fri, 25 Oct 2024 12:31:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] fgraph: Free ret_stack when task is done with it
Message-Id: <20241025123149.30347839a4701de276638187@kernel.org>
In-Reply-To: <20241024210515.53943bdf@rorschach.local.home>
References: <20241024092723.817582319@goodmis.org>
	<20241024092952.709200360@goodmis.org>
	<20241025002121.ef5dc8be87e1b6baa2dd544c@kernel.org>
	<20241024210515.53943bdf@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 21:05:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 25 Oct 2024 00:21:21 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > +static void fgraph_ret_stack_work_func(struct work_struct *work)
> > > +{
> > > +	mutex_lock(&ftrace_lock);
> > > +	if (!ftrace_graph_active)
> > > +		free_ret_stacks();
> > > +	mutex_unlock(&ftrace_lock);
> > > +}  
> > 
> > Hmm, will you scan all tasks everytime? Shouldn't we have another global
> > list of skipped tasks in remove_ret_stack(), like below?
> > 
> > static void remove_ret_stack(struct task_struct *t, struct list_head *freelist, struct list_head *skiplist, int list_index)
> > {
> > 	struct ret_stack_free_data *free_data;
> > 	struct list_head *head;
> > 
> > 	/* If the ret_stack is still in use, skip this */
> > 	if (t->curr_ret_depth >= 0)
> > 		head = skiplist;
> > 	else
> > 		head = freelist;
> > 
> > 	free_data = (struct ret_stack_free_data*)(t->ret_stack + list_index);
> > 	list_add(&free_data->list, head);
> > 	free_data->task = t;
> > }
> > 
> > Then we can scan only skiplist in free_ret_stacks() in fgraph_ret_stack_work_func().
> > 
> > Of course this will need to decouple preparing freelist/skiplist and
> > actual free function.
> 
> I thought about doing it this way, but I felt that it made the code
> more complex with little benefit. Yeah, we scan all tasks, but it only
> happens in a work queue that is grabbing the ftrace_lock mutex. If
> anything, I rather keep it this way and if it ends up being an issue we
> can change it later.

OK, then let it goes with this in this version.

> 
> One thing Thomas always says is "correctness first, optimize later".
> This is much easier to get correct. Adding a skip list will add
> complexity. Like I said, nothing prevents us from adding that feature
> later, and if it ends up buggy, we can know which change caused the bug.

It is not buggy as far as I reviewed, just concerned about the
performance overhead. So,

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
