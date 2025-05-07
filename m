Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D77289E33;
	Wed,  7 May 2025 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625927; cv=none; b=Fevmm0zx+WLjQ6bnWc3PrOcgZy3Ae3ZA2XPLatbISJhbTsL+sTyAVK6MCaSBaWeegMxsm+H/fqHFsNpF6Rej9wVefeNJBYCKFuM2tgH038VBE5VuMe0ASRQkyhCMGZZ/zOIWh/38TXsYw2p8G6OZ9ncZzHAaAyMU9MDt5m14pOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625927; c=relaxed/simple;
	bh=CbDm41Tf/oUefKTycomGEUjeLYQT4F4RYLJYctJWcN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gVSz/I8MzJ4TpfZJ4AwbyGFKyCe2L4lssRYQrf1HZkvO/3doXhy4jpAZgbLy8ZABg0Zn76cgOdpCkwJbwqj2w6v/j7wsmr8Y4aH66knFSxDUg2Uf7ntslX/lJt8MPJYSlJVWf7uNRsE0GgbHlCmW9p2w4gRR/sXywael7pdH4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38002C4CEE2;
	Wed,  7 May 2025 13:52:06 +0000 (UTC)
Date: Wed, 7 May 2025 09:52:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Miaoqian Lin
 <linmq006@gmail.com>, Mathieu Desnoyers  <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix error handling in event_trigger_parse
Message-ID: <20250507095215.26493050@gandalf.local.home>
In-Reply-To: <02549e50e26565ffb54ea943af87c19f40692576.camel@kernel.org>
References: <20250318112737.4174-1-linmq006@gmail.com>
	<20250319090650.fe63164eac3ac32bb559ffc8@kernel.org>
	<02549e50e26565ffb54ea943af87c19f40692576.camel@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

I was trying to get this patch in, and realized that the code is all messed
up.

event_trigger_alloc() creates a event_trigger_data which needs to be freed
by trigger_data_free() NOT event_trigger_free()!

I'm renaming event_tigger_alloc() to trigger_data_alloc(), and changing
this patch to just call trigger_data_free() on error.

One day, if I get time, I need to rewrite the event trigger code, as it's
really confusing to deal with! Trying to follow the function pointers that
get called via init, reg, unreg, etc between struct event_command and
struct event_trigger_ops is just a nightmare!

-- Steve
