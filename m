Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558D148FF6;
	Tue, 14 Jan 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869637; cv=none; b=hbhgPM9OE1DbUs+MwuTq9zq1RgshKZOhu1GPGmVWSqAloBFQ4nBk5xtegVxTuRopxeU6pGuO+etkITmFMF/W7zlBA2C1yFyUPtEr73Q+ID79cszvVik840xqA60Cq9Rh+BaHScl1aT082sPMfRKX9R8y3RXNpSjFiKYPkvHYoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869637; c=relaxed/simple;
	bh=DUgEniUCLzYjxKtAeNYaEMv06S8XFpMMTAZ/TbTXGjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXw2MUWmpgBy0ty4bSAWAiXz/JWyeFfRBdujOl4etuovRzKAFgsYrHW/fN2dsoPUmHpMwqU9vas7X2yzqGPh5joR1/9N/WsnV9pqvTekj9o9H8B37O6F1p8TTjavJVCyBrw0dFAaVqOTFGBeBd9IJtF73yXncWohYYQWnpNGfIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AB9C4CEDD;
	Tue, 14 Jan 2025 15:47:16 +0000 (UTC)
Date: Tue, 14 Jan 2025 10:47:16 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ftrace: Document that multiple function_graph tracing
 may have different times
Message-ID: <20250114104716.74c9b389@gandalf.local.home>
In-Reply-To: <20250114101202.02e7bc68@gandalf.local.home>
References: <20250114101202.02e7bc68@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 10:12:02 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The function graph tracer now calculates the calltime internally and for
> each instance. If there are two instances that are running function graph
> tracer and are tracing the same functions, the timings of the length of
> those functions may be slightly different:
> 
>  # trace-cmd record -B foo -p function_graph -B bar -p function_graph sleep 5
>  # trace-cmd report
> [..]
> bar:            sleep-981   [000] ...1.  1101.109027: funcgraph_entry:        0.764 us   |          mutex_unlock(); (ret=0xffff8abcc256c300)
> foo:            sleep-981   [000] ...1.  1101.109028: funcgraph_entry:        0.748 us   |          mutex_unlock(); (ret=0xffff8abcc256c300)
> bar:            sleep-981   [000] .....  1101.109029: funcgraph_exit:         2.456 us   |        } (ret=0xffff8abcc256c300)
> foo:            sleep-981   [000] .....  1101.109029: funcgraph_exit:         2.403 us   |        } (ret=0xffff8abcc256c300)
> bar:            sleep-981   [000] d..1.  1101.109031: funcgraph_entry:        0.844 us   |  fpregs_assert_state_consistent(); (ret=0x0)
> foo:            sleep-981   [000] d..1.  1101.109032: funcgraph_entry:        0.803 us   |  fpregs_assert_state_consistent(); (ret=0x0)
> 

I added:

  Link: https://lore.kernel.org/all/20250114101806.b2778cb01f34f5be9d23ad98@kernel.org/
 
  Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>

To this as well.

-- Steve

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/trace/ftrace.rst | 6 ++++++
>  1 file changed, 6 insertions(+)

