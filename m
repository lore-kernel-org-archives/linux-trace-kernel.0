Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6F52F50;
	Wed,  8 Jan 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348865; cv=none; b=PwRQEeUbdpur2F+RVujjGjUGjPOpT0xoFVrWz7ThmZ9xCfi9TW97s2i9u/7OwVIMEi0pHkAxzjs77F3rpJh8fFGGtp6Sc4nIW+scaAUYGWTPu5FyLvVF1C5sja2tSY+I8r5GAvcFSND/A9H5cpKWfUjY98ZeKFNN3AjzboU+mCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348865; c=relaxed/simple;
	bh=XZnk2JgWlHhPi8Xm2niVrdNTb5w+3ywMPe/SfGYA/dc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRhpRfb8/5mOcUHQ1m0wWBUNDBXtIILYT0EsJEqEr6Om4nsCi8yYqim4uL1+1ci6Rn3O4ygb+vx7VDyu5ADFQEb1ydk+YRlvNuGXVYsrCSc87YjjTYI1fQQZwGM0ujdUUZovwjWt47iI2kc3LtQnrgPeeLTxnp0vE4YInCsCbuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1A8C4CED3;
	Wed,  8 Jan 2025 15:07:43 +0000 (UTC)
Date: Wed, 8 Jan 2025 10:09:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] tracing: Use __free() for kprobe events to
 cleanup
Message-ID: <20250108100914.6a6e4ed5@gandalf.local.home>
In-Reply-To: <173630226782.1453474.10077691519522198018.stgit@devnote2>
References: <173630223453.1453474.6442447279377996686.stgit@devnote2>
	<173630226782.1453474.10077691519522198018.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jan 2025 11:11:07 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Use __free() in trace_kprobe.c to cleanup code.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v4:
>   - Use no_free_ptr(tk)->tp instead of assiging NULL to tk.
>  Changes in v3:
>   - Rename to __free(free_trace_kprobe) to clarify what function will be called.
>   - Add !IS_ERR_OR_NULL() check because alloc_trace_kprobe() returns an error code.
>   - Prevent freeing 'tk' in create_local_trace_kprobe() when succeeded to register.
>  Changes in v2:
>   - Instead of using no_free_ptr(), just assign NULL to the registered pointer.
> ---
>  kernel/trace/trace_kprobe.c |   62 ++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 33 deletions(-)

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
