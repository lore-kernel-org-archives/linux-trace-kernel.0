Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A31235341;
	Wed, 19 Feb 2025 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003861; cv=none; b=W9hwMqKePgw7rb28719KHehb3XnJuCSMIDRv7j/+eo+e7/Dez81r7EK9/wMb0IouacAj6UbaMw/F/P4mT8CAQMAB7/K0LRoxnD9/OFyvF/KFF+fxIt+lwZ3h81zTsfSbNHEZxD5QnSaWlmzuHRx/v6XrEjwbhOenQvCj/z7o4EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003861; c=relaxed/simple;
	bh=F7cQj/S2Jx2LKjsunoVGqTWLq7Q+BonMp+jOTEJgYM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKV+qiRHVTZ9jjQVmncCxb/L6oYm1/PvRHTAIY3cCiv2KNpRExIqkIsK/aiiodap2KImii8Yg3lBz5VtW3vjG2Lb/nhmT5enJ1h6+KXyM7LWwRG7z2aXrCMbbvPTuuuXVPym9IJex+FrAb0A2LoM6JxWn3erlDN9CQpxKV7gIFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0919C4CED1;
	Wed, 19 Feb 2025 22:24:19 +0000 (UTC)
Date: Wed, 19 Feb 2025 17:24:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jemmy Wong <jemmywong512@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] sched: Refine scheduler naming for clarity and
 specificity
Message-ID: <20250219172443.5a78401d@gandalf.local.home>
In-Reply-To: <20250219182020.393006-1-jemmywong512@gmail.com>
References: <20250219182020.393006-1-jemmywong512@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 02:20:18 +0800
Jemmy Wong <jemmywong512@gmail.com> wrote:

> Hi, I'm relatively new to Linux and eager to contribute to the community
> with some foundational work.

Welcome to the community.

> 
> I aim to help improve code readability and maintainability.
> While reading the scheduler code, I found some naming inconsistencies
> that made understanding the code more difficult.

I do plan on updating the scheduler comments soon, so that every function
has a purpose. But there's a lot of history to the scheduler code that you
really can't just go and rename items. It causes a lot of churn which also
causes noise in the git history, where git blame is used a lot to find why
things were done. Adding renames causes one more level of indirection that
makes it harder on the maintainers to do git forensics.

> 
> Specifically:
> 1. Some function names do not accurately reflect their purpose.
> 2. Certain names are too general, making it unclear what they represent.
> 3. Some concepts are ambiguous, leading to potential confusion.
> 
> - Rename ttwu_do_wakeup to ttwu_set_running:
>     - This function only sets task state to TASK_RUNNING,
>         not performing the actual wakeup.
> 
> - Rename update_cfs_group to update_cfs_group_shares:
>     - The name was too generic; specifying "shares" clarifies its purpose.
> 
> - Rename place_entity to update_entity_sched:
>     - The function does not handle entity placement but updates
>         sched info: vruntime, slice, and deadline.
> 
> - Rename update_load_<set, add, sub> to load_weight_<set, add, sub>:
>     - "load" can refer to either PELT load or load weight, causing ambiguity;
>         "load_weight" specifies it's dealing with weight.
> 
> - Rename struct sched_avg to struct sched_pelt:
>     - This structure includes not just average statistics
>         but also sums like <load, runnable, util>_sum, last_updae_time,
>         all of which are PELT (Per-Entity Load Tracking) metrics.
> 
> - Rename init_entity_runnable_average to init_entity_pelt
> 
> This patch aims to improve code readability and reduce confusion by
> ensuring names are more descriptive of their actual functionality or purpose.

I personally am not against these updates. But as I mentioned, there's a
lot of history here and it's really Peter Zijlstra's call (and he's been
against changes like this in the past).

So please do not be discourage if this doesn't get much traction.

-- Steve
