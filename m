Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7061921B8FE;
	Thu,  9 Jan 2025 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434314; cv=none; b=IneA/+oEaazR3qNT6h/iIzudivmpRUY/J0MwMsEA6k/cr8A/tdgJesjK0COVmW9ZNWNV2IaKul05BBguqEWforKoRp64gW4+6tA3PmoRWgCasCK/1M4vcyxhH9y1fQqzzaqmCdQ46G/QYR/xUtAM9prnIWAZ/Tr8RR2kaFMJUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434314; c=relaxed/simple;
	bh=ponN+B62d9IIgYsIG4N9sql6FIYxl0Ij8LkP3EUKfTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f98egwLMIui45eLLId5+9FjmFbfGA7B2HsgiFL/ZFFpWB74uXO3wC8lspoHUUJbf6Xo8UjM6XYFfzICA9y7zm8r7grxiCt9jiT3zQ2VGa994x9CVIoM6qaEZ0wz9kbqzuqHFHyY9ghEdhCmsYtq4ArLrdv4NSYvEz0dn3ZXewlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B06C4CED3;
	Thu,  9 Jan 2025 14:51:52 +0000 (UTC)
Date: Thu, 9 Jan 2025 09:53:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] tracing/kprobes: Simplify
 __trace_kprobe_create() by removing gotos
Message-ID: <20250109095325.2f2d2f3a@gandalf.local.home>
In-Reply-To: <173643301102.1514810.6149004416601259466.stgit@devnote2>
References: <173643296599.1514810.1580554610685712071.stgit@devnote2>
	<173643301102.1514810.6149004416601259466.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 23:30:11 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Simplify __trace_kprobe_create() by removing gotos.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v6:
>   - Rename trace_kprobe_create* functions.
>   - Simplify the end of trace_kprobe_create_internal() a bit.
> ---
>  kernel/trace/trace_kprobe.c |   97 ++++++++++++++++++++++---------------------
>  1 file changed, 49 insertions(+), 48 deletions(-)

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
