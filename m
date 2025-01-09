Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685A621B1BF;
	Thu,  9 Jan 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434476; cv=none; b=Yx32XzUx2v2FITOlQ0aRdi++RG6qkQbg9syMLrgjq0ngfTtuUyaZWnlR7WfljKNwCL80hgGTQB2A5Soi8n/wITI1Q9r++tjsotGahDd6GBlvOzpqHtznRPHawmcy0JPjOeyRnGQYUvgcXHj8gJLkf3PtXkP98iBO1HcvvIlgOTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434476; c=relaxed/simple;
	bh=sDuqwztHozr5x42lXPU5OPKJkwldFz/PRkzHrrmKF2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wk+cs2lWzgvVQuc3dnixBgibLgD42SOKUleYMyBAIovXj1HcQOGePfzaGmKgThmCrIXGFhNJxynlG+dzln14pYJpEUS1ckKwsjtBBP3G8qkdGxrtXsTRt0z79IbFaTOKdsu7ktWO3437GTMY3c//X6sH9c0Sv2GeTCKSq5fiQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF82C4CED2;
	Thu,  9 Jan 2025 14:54:34 +0000 (UTC)
Date: Thu, 9 Jan 2025 09:56:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] tracing: Adopt __free() and guard() for
 trace_fprobe.c
Message-ID: <20250109095607.15bfb6aa@gandalf.local.home>
In-Reply-To: <173643302228.1514810.2053430844068447947.stgit@devnote2>
References: <173643296599.1514810.1580554610685712071.stgit@devnote2>
	<173643302228.1514810.2053430844068447947.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 23:30:22 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Adopt __free() and guard() for trace_fprobe.c to remove gotos.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v6:
>   - Rename trace_fprobe_create* functions.
>   - Rename __free label for trace_fprobe.
>   - Simplify the last part of trace_fprobe_create_internal().
> ---
>  kernel/trace/trace_fprobe.c |  130 ++++++++++++++++++++-----------------------
>  1 file changed, 61 insertions(+), 69 deletions(-)

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
