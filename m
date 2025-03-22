Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CB31D88D0;
	Sat, 22 Mar 2025 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742635611; cv=none; b=M2Us/guJ+/iwh8ZUQtGNSXfarujpzQBqR6X+oKTfUkUOVB1KuS1cz1/HEMmXdmtRK6lyO7tqzr5Xx1TOqpVoow+011Q/vw3U0fLp3B3atg9gBf6MdYCTwchqM15C7ebSs95tFcJo4c6vbaa/FlTP3yQC6bpSgRuYU3TGBxzmA1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742635611; c=relaxed/simple;
	bh=EbYza1EQ2HevAdP0EnZ2Q4xLrFO7aBmZ2gVXSGioVFo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nDW5iy3ptolLTOe/SWZLGCo7xb6i1lBmMZjyivEIWpE0OifkGfdPFVG3FNEIPqGl3lz0YiUvXmgdyvX7RYW6npXOo0J6nvb4a5zH9oHeqc5OmEXZIgrpGhGsBdclTYMX0URuPs/f7T7l2qdiaGC22zzg9tuBqL28QyyX5R+MJUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553E0C4CEDD;
	Sat, 22 Mar 2025 09:26:49 +0000 (UTC)
Date: Sat, 22 Mar 2025 05:26:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Miaoqian Lin
 <linmq006@gmail.com>, Mathieu Desnoyers  <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix error handling in event_trigger_parse
Message-ID: <20250322052645.66a0393a@batman.local.home>
In-Reply-To: <02549e50e26565ffb54ea943af87c19f40692576.camel@kernel.org>
References: <20250318112737.4174-1-linmq006@gmail.com>
	<20250319090650.fe63164eac3ac32bb559ffc8@kernel.org>
	<02549e50e26565ffb54ea943af87c19f40692576.camel@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 14:03:03 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> In both these cases, the code calls kfree() directly in order to avoid
> the WARN_ON_ONCE(data->ref) check.
> 
> In the first case (remove), trigger_data is only being used as a test
> object and will never have data->ref incremented.
> 
> The second case is the failure case, which is also dealing with a
> trigger_data object that hasn't been successfully registered and
> therefore has a 0 data->ref.
> 
> So perhaps the event_trigger_alloc doc should be changed to something
> like:
> 
> "Use event_trigger_free() to free a successfully registered
> event_trigger_data object."

Honestly, I think event_trigger_alloc() should set the data->ref to 1,
and remove the event_trigger_init() from those that use
event_trigger_alloc(). Then it's a lot easier to map
event_trigger_free() to event_trigger_alloc() and the users don't need
to keep track of the internals of event_triggers.

Then we don't need to have special cases of error conditions after
event_trigger_alloc(), we can simply use this patch.

So, this patch should stay as is, but another patch is needed before
this to make event_trigger_alloc() set data->ref to 1, and remove the
event_trigger_init() from the callers of event_trigger_alloc().

-- Steve
