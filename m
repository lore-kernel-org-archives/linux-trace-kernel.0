Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E032F37;
	Thu,  1 May 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746113228; cv=none; b=fjIEqoFqwxA2edNFPlOlFGTPxoaoa8SZpPzkzogbrLF29taAKlatU9DHqlS6wl4s0IEBB9wI2QESJ0x8hybiQSkNlgK0vCb5oJA4JXi+am8DPshV37hFY4EZUAVv7nxUrddQQ329j9SGQw+qEELsprHGXBROoSK679CswKmrzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746113228; c=relaxed/simple;
	bh=FhCOcFW51U3Cz+yfsL36R2ZMXe8ZfZrgt+QFOMcJ4kY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8AiCsOihqmfgrV3gE2HLiH/9047w+aWbGZLkrO7B1csDQX2YAHwFcDaTSAMMVSidYPWTKvWOtzrzFOHpjNXUDlEGUrRuy3uYDiSwKi/rCkcgIIS75BjSbteSjGC6aA05GzUnC4twdj6/C5mypY7tMnLLFNnwMm+EsSQOq4u7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6590FC4CEE3;
	Thu,  1 May 2025 15:27:07 +0000 (UTC)
Date: Thu, 1 May 2025 11:27:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing: tprobe-events: Register tracepoint when
 enable tprobe event
Message-ID: <20250501112712.755d238c@gandalf.local.home>
In-Reply-To: <174219859655.549159.12584048778295152488.stgit@devnote2>
References: <174212767109.348872.18231451508464729427.stgit@devnote2>
	<174219859655.549159.12584048778295152488.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 17:03:16 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> As same as fprobe, register tracepoint stub function only when enabling
> tprobe events. The major changes are introducing a list of
> tracepoint_user and its lock, and tprobe_event_module_nb, which is
> another module notifier for module loading/unloading.  By spliting the
> lock from event_mutex and a module notifier for trace_fprobe, it
> solved AB-BA lock dependency issue between event_mutex and
> tracepoint_module_list_mutex.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_fprobe.c |  382 +++++++++++++++++++++++++------------------
>  1 file changed, 218 insertions(+), 164 deletions(-)

Is this patch still needed? It doesn't apply cleanly.

-- Steve
