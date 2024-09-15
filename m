Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA401B85C6;
	Sun, 15 Sep 2024 05:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726377757; cv=none; b=OjE41G67tcC0zZ7JqIiajrgzXHyB8Ghd77RYNF72LHNfvRVDMvNIQV/sxi3H998JwnZmWKrxz/PlA3RUomKhFh8UFQyPG607d6Dm9db4w5kfkNHLFuedNHPWp5gbCGgLpJqzbJ89k0/v12btwBaGe0Sr+2BrS3hgfN4CHXGcJXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726377757; c=relaxed/simple;
	bh=1CqsCyV6zjXceSWEZum34kBlQu5zVb957vGfVYBBrwM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l2Jth7Kah2BtP3hdcSk6TX6Ow1bNhMLFtei9sfZ1tituavDZH4ePmKLLEv0Ri9zmXffVy3qSgcZa1vVWAhc/WEOewMQX08Zc3bdNJuCC8zGgw/eZmUGvb3zefgTAyDaPOGRAJgoLxKBKL9epnKokdLYWwvo9FrZdRXi6U1j2TDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQvLwS0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQvLwS0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC4DC4CEC3;
	Sun, 15 Sep 2024 05:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726377756;
	bh=1CqsCyV6zjXceSWEZum34kBlQu5zVb957vGfVYBBrwM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oQvLwS0v3fv/8IZzzHbMtEkGcrSq9ZZk1+q9zbgD15HKHf8iG4xZ3L9/55Ph9dOtj
	 Zju/zAlWeGkNFvWKbpf17pWYTzAGVEdolQDWglJMwnE7ETiGCyJvskZrWrBfPmiNCr
	 nMQ6Eqh2kjmdD2pYvL6oQn+WwsKm4Ty+EVR/D0CZoxqgZ66RPGaApxDnnAwQDK+AQi
	 Se4YFKCrRMPMr3T1oMuhgdE/2OgEZT4o+8iTnTZJapcvIo7Z6CDJ90nnA7T5N0+cUg
	 qpCWhBQHCDvDh9FFvqDbKWdSAADpyQn27onsn0JPDl+ZlqpDgmRHJtJIKKlz9qQDtc
	 SbPJwyhfGObRw==
Date: Sun, 15 Sep 2024 14:22:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH 0/3] fgraph: Do not save calltime in shadow stack
Message-Id: <20240915142233.168da2dcd06000dc86a34a1e@kernel.org>
In-Reply-To: <20240914214805.779822616@goodmis.org>
References: <20240914214805.779822616@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Sep 2024 17:48:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Now that there's more users of the function graph infrastructure, the
> calltime field on the shadow stack wastes space and also getting the
> timestamp is a waste of time for those that do not use it.
> 
> Instead, have the only two users of it (function graph tracer and the
> profiler) store it in its own shadow stack variable.

This series looks good to me. Instead of adding add-hoc flag, this
solves call-time clearer.

For this series,

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Steven Rostedt (3):
>       fgraph: Use fgraph data to store subtime for profiler
>       ftrace: Use a running sleeptime instead of saving in shadow stack
>       ftrace: Have calltime be saved in the fgraph storage
> 
> ----
>  include/linux/ftrace.h               |  5 +--
>  include/linux/sched.h                |  1 +
>  kernel/trace/fgraph.c                | 85 +++++++++++++++++++++---------------
>  kernel/trace/ftrace.c                | 45 +++++++++++++------
>  kernel/trace/trace.h                 |  1 +
>  kernel/trace/trace_functions_graph.c | 52 +++++++++++++++++++++-
>  6 files changed, 137 insertions(+), 52 deletions(-)


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
