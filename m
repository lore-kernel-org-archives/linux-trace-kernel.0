Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3893D367;
	Sun, 16 Feb 2025 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739673348; cv=none; b=YFCoOSbm1QjuT3egZ6lAee/zmJ8lv6035Lo5HEpRcSDi6HJuc+PArwNfAObHHPDW2h0dMsg9/JwpTyWeKiBTKyHeO+Fkb6SOpQ9wfuPKc5LPQP4BbMDz2Y5UZLm2mCxCTd0E7ngHDjuhEaOezxuE+awGrzt1UcdywAiF7NZhXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739673348; c=relaxed/simple;
	bh=og7vRdotEbl970Mxh3tCgnLXuP+7n1w8WQ3zdtO/IFk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uDhVB6RkOe5f6X//+ZjQhSycssgFNrM2+YhqvKnF8gdgQVWfLlZ4jZiX4JENmaQJN+4ASoRymIuIk+O2g6oWEAjuQZZhMKjX3Z9MDM/eLXYoHRIPSK0fwwzxbc3zHXwVJDkmoTsJ+5SZHoioffBY9Cz8qcFAYhI6LhHx9dcwbTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STY1/6DV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STY1/6DV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA32C4CEDF;
	Sun, 16 Feb 2025 02:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739673347;
	bh=og7vRdotEbl970Mxh3tCgnLXuP+7n1w8WQ3zdtO/IFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=STY1/6DVx2ue+1I8wj8+diIba67bpb0LgomeJUcOPpN09fa/wxx/UNjL0c86cuFi5
	 xBYAnMqN6vcQ8aWpDULOnXALhhzzgid3RCPL/ouSZOgimew576pUwfpXrArMXsC37a
	 veJqHFOrQ0m1IwMa/OpDOMAChHQrXRlPeWGkQZZq27GKoQEHwEsY8utxIgC1dExoKz
	 tHj+4DhkQy+WyKPGOySRDYIiK0cCoC9Y/485oc4ILaQR/7/h1P7x9y/RkXiLr90xnP
	 OGPitbwK+frCwUAdEtZr49FeHjEUl1HnMUvUOAqLFdhdeL8mf4dxbYXG4gTY5fCmI0
	 XXqgK/JIuDfdw==
Date: Sun, 16 Feb 2025 11:35:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/8] ring-buffer/tracing: Save module information in
 persistent memory
Message-Id: <20250216113544.5abf06ed25203539a8c7d16c@kernel.org>
In-Reply-To: <20250215034301.624019422@goodmis.org>
References: <20250215034301.624019422@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 22:43:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> This updates the persistent instance to record what modules were
> loaded and what addresses they were loaded at.
> 
> First the KASLR offset is recorded in the persistent ring buffer instead of
> a text address. This can be used to calculated the address offset.
> 
> Next the persistent memory is divided up differently so that there's
> a single global meta data for the entire buffer that can hold the
> global data, and each per CPU meta data can just hold what it needs.
> 
> A scratch area can be created by the caller, in this case the tracing
> system, to store data in the persistent memory area.
> 
> As the KASLR offset is only needed by the tracer, that data is moved
> from the ring buffer meta data into this new storage.
> 
> Next the modules that are loaded and where they are loaded is stored in this
> new persistent storage.
> 
> The module list along with the KASLR offset is now exposed in the
> last_boot_info if the buffer is from a previous boot. If it is from the
> current boot, the file will only contain:
> 
>    # Current
> 
> in order to not leak the KASLR offset.
> 
> Finally, when new modules are loaded while the trace is active, they too
> will be added to this persistent memory. Note, if tracing is stopped, and
> then restarted, it clears the module list and will reload all the modules
> again so that it doesn't need to keep track of what is loaded or unloaded
> while no tracing is going on.

The series looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org> for this series.

Thanks,

> 
> Changes since v1: https://lore.kernel.org/all/20250205225031.799739376@goodmis.org/
> 
> - Rebased on top of the urgent branch
> 
> - Allow the size of the scratch area in the persistent ring buffer to be
>   defined by the caller.
> 
> - Change the output of the last_boot_info to show the kaslr instead of:
>   "Offset: <offset>" to "<offset>\t[kernel]" to make it consistent with
>   the module output.
> 
> 
> Steven Rostedt (8):
>       ring-buffer: Use kaslr address instead of text delta
>       ring-buffer: Add buffer meta data for persistent ring buffer
>       ring-buffer: Add ring_buffer_meta_scratch()
>       tracing: Have persistent trace instances save KASLR offset
>       module: Add module_for_each_mod() function
>       tracing: Have persistent trace instances save module addresses
>       tracing: Show module names and addresses of last boot
>       tracing: Update modules to persistent instances when loaded
> 
> ----
>  include/linux/module.h      |   6 +
>  include/linux/ring_buffer.h |   8 +-
>  kernel/module/main.c        |  14 +++
>  kernel/trace/ring_buffer.c  | 245 ++++++++++++++++++++++++-----------------
>  kernel/trace/trace.c        | 263 ++++++++++++++++++++++++++++++++++++++++----
>  kernel/trace/trace.h        |  15 ++-
>  kernel/trace/trace_events.c |  40 +++++--
>  7 files changed, 448 insertions(+), 143 deletions(-)


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
