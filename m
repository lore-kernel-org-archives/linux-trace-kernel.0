Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48196202990;
	Wed, 14 May 2025 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747226997; cv=none; b=Y2MTVEvZmjpFMCw6XSP4/XiIu94V7B6zyChmNSz1fZRB3I6U0dWx1W3FH/KY8Xt18W1dwJTbBpz+UXcYz83Hz9zpmsBlNjXASMJFDB5BFyNiRlpnX/v62PlTvT4jEzS4npMbnx7InmIhGxjXgKLd6cCg36vycYRDlxH9oxCbTo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747226997; c=relaxed/simple;
	bh=991Gcq7ITMJefXFXrMRPa7mwgVGZpj5Z3vbGCI3ftIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMnJ7hcVtwbvstaRLPglpKWuaeuyRn4GH7f4JBzETNhkUyu69FeOlJs2hutKNpE7TNVebTbLj1B3EchqI9ru51LE6BQXUfcpsAQafSky/Uj36mZAq0PqliWQQX8L27ABZh8MpQimk8JIvH1d011lYRWpFk6VtBYnGgv1uQ4d6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A72BC4CEE9;
	Wed, 14 May 2025 12:49:55 +0000 (UTC)
Date: Wed, 14 May 2025 08:49:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: Record trace_clock and recover when reboot
Message-ID: <20250514084946.17c3ffd7@batman.local.home>
In-Reply-To: <20250514101431.e1363d1a60ed2548feb4cef0@kernel.org>
References: <174709628747.1945884.11884057542151507891.stgit@mhiramat.tok.corp.google.com>
	<20250513135652.7cb970cf@gandalf.local.home>
	<20250514101431.e1363d1a60ed2548feb4cef0@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 May 2025 10:14:31 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > In case the tscratch->clock_id gets corrupted, we better make sure it
> > doesn't overflow:
> > 
> > 		if (tscratch->clock_id >= ARRAY_SIZE(trace_clocks) ||
> > 		    tracing_set_clock(tr, trace_clocks[tscratch->clock_id].name) < 0) {  
> 
> Good catch! BTW, don't we have any check about scratch area?
> (e.g. adding a checksum)

We could, but it would require updating every time we update the
scratch area.

Currently, the scratch area is only considered valid if the ring buffer
is proven to be valid. But if this becomes a problem, we probably
should add a checksum or something.

-- Steve
