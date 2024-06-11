Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E0D1DDF4;
	Tue, 11 Jun 2024 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718115284; cv=none; b=HXPHxtGhUkO+CL8Gxhqn666diltWjCMOvmJDYQN+/QJt+Qnob90h7BFl8HrUX7BC0mp+WCWn/0KkQCviV8LpeSrxEfYNNwcs5ZgvmVvbJ1IerWWJo/FOj4P4ALZ3JusDVuXROH18PTcYQ1EntZJMNqNlF1vUFquR+GjrGlL1AwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718115284; c=relaxed/simple;
	bh=S/j3+QxdEt9IjCO3OfwR4LKCMbcrl3GvC8e/rIHpyMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWdHzLxSg0SuYbkLV8MR89iAe3cB+urnBs8k265oxSH0clIN3xRMc2KFrIepDsBpXvxNbElUvXwE23RX4njiWlFKbZUL7Id3eenFRSC7Odxpv0Oh8NqxvwadQ3C4C2Mv5rKFZ9I9F/vYUQF0L1He30PJXxbc3AypYSbv03J0Y2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8AEEC2BD10;
	Tue, 11 Jun 2024 14:14:42 +0000 (UTC)
Date: Tue, 11 Jun 2024 10:14:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
 kernel-janitors@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>, Thorsten Leemhuis
 <linux@leemhuis.info>
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <20240611101458.7fa78da8@gandalf.local.home>
In-Reply-To: <05ec743a-c4e9-4c66-b2cd-4e89c858d7d4@suse.cz>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
	<20240609082726.32742-6-Julia.Lawall@inria.fr>
	<20240610112223.151faf65@rorschach.local.home>
	<b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
	<20240610163606.069d552a@gandalf.local.home>
	<70c093a5-df9c-4665-b9c9-90345c7f2139@suse.cz>
	<2024061143-transfer-jalapeno-afa0@gregkh>
	<05ec743a-c4e9-4c66-b2cd-4e89c858d7d4@suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 10:42:28 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> AFAICS that documented way is for a different situation? I assume you mean
> this part:
> 
> * Specify any additional patch prerequisites for cherry picking::
> 
>     Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
> 
> But that would assume we actively want to backport this cleanup patch in the
> first place. But as I understand Steven's intention, we want just to make
> sure that if in the future this patch is backported (i.e. as a dependency of
> something else) it won't be forgotten to also backport c9929f0e344a
> ("mm/slob: remove CONFIG_SLOB"). How to express that without actively
> marking this patch for backport at the same time?

Exactly! This isn't to be tagged as stable. It's just a way to say "if you
need this patch for any reason, you also need patch X".

I think "Depends-on" is the way to go, as it is *not* a stable thing, and
what is in stable rules is only about stable patches.

-- Steve
