Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21915CD74;
	Wed,  8 Jan 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348849; cv=none; b=sa6fdHzn8btYe2lRYSz2lg3YRUfpDfVL58KKIg66qvZJ1Zh0XmhYNtj7N9MUOOyml2yimhO8RQ51D/7ji9xw8IxyfeK8pTXkUxdXYWnxHu/u73UX7v+RJAazcmke16cW6lEEIO1bYcEwA7fVD4Mi0/FRaNtg0Z/xTX2zjvUZIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348849; c=relaxed/simple;
	bh=CbGopdsTJxaL6kt5plvHZoT1beeDH+0x8ZHIXLMw3a0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVXmsGgx6tVqhHOhPCyWKasIBXo86ijB1AAY76FN7tbCA9lD4iEsngoVenKXZIo4crDj/nJO7TLLTCx9WakKv9mWoSbgmTgJCNh1z3Gm5xmlEgKXbX9dGvxGI5AXLbWt1DBbllg+Qwaox5Lka1GC09T34G3fGYtja/raHxngnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74712C4CED3;
	Wed,  8 Jan 2025 15:07:26 +0000 (UTC)
Date: Wed, 8 Jan 2025 10:08:57 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] tracing: Use __free() in trace_probe for cleanup
Message-ID: <20250108100857.0aec062e@gandalf.local.home>
In-Reply-To: <173630225708.1453474.16752527154293973755.stgit@devnote2>
References: <173630223453.1453474.6442447279377996686.stgit@devnote2>
	<173630225708.1453474.16752527154293973755.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jan 2025 11:10:57 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use __free() in trace_probe to cleanup some gotos.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v5:
>   - Fix to remove kfree() in for loop. Since I confirmed __free(kfree) is
>     called in each iteration.
> ---
>  kernel/trace/trace_probe.c |   51 +++++++++++++++-----------------------------
>  1 file changed, 17 insertions(+), 34 deletions(-)

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
