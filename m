Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF4E567;
	Wed,  5 Jun 2024 21:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717624391; cv=none; b=jjWC4HlDR0q3XDdeJYInwjI8IwllUnGW0rH95o3ZxcAfK8U2QwFg0TwopInhQasLbwPti2aD5fuUT6LnGyjnaFydv90nIqkw2OomFgLp176dcBqCQlOvFxlPpjf0JW2reuid8TUgf+Mi4z4Pkl0h0BWQjQ+QkIW74DwzTUx3Ql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717624391; c=relaxed/simple;
	bh=uFoqx4EWB80J+V8A2fZpMH7sF3p50Dxm9OodeJrXLJ0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TSNaaXloakhuS7E7BbaGMPxoTCpGIz7HFQHJpqcaFnNMzqjg1omD/8qDHWiSvt5HLcfKIguUirBCYDlUeFE2AJZyzCM0AJIiCSeqTB4tSp6c0JjUT/JQ5hQDBIQi/VQZKibJn89CfLLLO21plGu9ZvlZor3Xr4i2/TQMiax64+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlyjfB5l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlyjfB5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3090C2BD11;
	Wed,  5 Jun 2024 21:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717624389;
	bh=uFoqx4EWB80J+V8A2fZpMH7sF3p50Dxm9OodeJrXLJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UlyjfB5lAWgmkVP405prTTWBC6j4hGQX5NgqGbnSBshloHLrVWb24iiRt5yj6qkLi
	 4ew6guQGWus/EAff8SFjYd6PLdfnlRAS+QPEt9o5iFp5GJnQsNwZmFoPXP4kd3QVt1
	 olYMC6q18YSIykxihjirbH6GocuWF6Fb5tjZeHNnOaVQlLGe0pnz/Fq+rNm+F+fFgJ
	 P8T97bBlLgDwpucbdnIUOq6ajqAwBSG40LWGPGQYIiczAI8lFwNjBTjNwGXptwDxih
	 Dp/CjeeR+SstfRXR3Oip4KeJNyH/g/37ULrSyPjQ9muTxJsBMI7JbaZO7UjU0DZ3p3
	 LaOzNAQMlHJig==
Date: Thu, 6 Jun 2024 06:53:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/6] ftrace: Minor fixes for sparse and kernel test
 robot
Message-Id: <20240606065306.abba1a2def44185fe1dd2200@kernel.org>
In-Reply-To: <20240605202644.293295925@goodmis.org>
References: <20240605202644.293295925@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Jun 2024 16:26:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Recieved some minor bug reports from the kernel test robot. First I started
> cleaning up some of the sparse warnings. There's many more, but most changes
> are not really helping anything, but just quieting the warnings.
> 
> But the reports from kernel test robot need to be fixed.

All looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> 
> Steven Rostedt (Google) (6):
>       ftrace: Declare function_trace_op in header to quiet sparse warning
>       ftrace: Assign ftrace_list_end to ftrace_ops_list type cast to RCU
>       ftrace: Assign RCU list variable with rcu_assign_ptr()
>       ftrace: Fix prototypes for ftrace_startup/shutdown_subops()
>       function_graph: Make fgraph_do_direct static key static
>       function_graph: Do not update pid func if CONFIG_DYNAMIC_FTRACE not enabled
> 
> ----
>  include/linux/ftrace.h         | 3 +++
>  kernel/trace/fgraph.c          | 4 +++-
>  kernel/trace/ftrace.c          | 4 ++--
>  kernel/trace/ftrace_internal.h | 9 +++++++++
>  kernel/trace/trace.h           | 1 -
>  5 files changed, 17 insertions(+), 4 deletions(-)


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
