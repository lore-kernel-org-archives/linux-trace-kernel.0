Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4663233711;
	Fri, 21 Nov 2025 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763714843; cv=none; b=ncZjiM0jsEkidPk10VtgmcESCB+0gVMIUes4pk/7BcIdzauTlP2NAf0ufrR9m1JdVq53ByQVwoZ8xli3T27WLA3ykapwIJsrlYXkUSZpK9x1MrDJihWhKIqVR94UTdYsexXFzwtkbRxXl5dtulRVXanUQijnkuY5PlV06YEj4xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763714843; c=relaxed/simple;
	bh=sqGXtgGmLCX5OAuI4+23gfhEPyobSpNl8KpPJoX4IjU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f+OcTbQZG4WfA+OhDynGCwnxmzLf2ko7n5+E8EvobGItrlHzy891Wy1VYSEsqS97VbdHbjexD/4V7Wa6WaFqsHd6Uu60hH0qj/v+K2R7EXOlSeSfbp7c0NdjkQfn6mKs3VOMcIM0t8G+0rp5rl6XV8jAJ0LWGy270X8xao/Ef+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odavzBDq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odavzBDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FE4C4CEF1;
	Fri, 21 Nov 2025 08:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763714842;
	bh=sqGXtgGmLCX5OAuI4+23gfhEPyobSpNl8KpPJoX4IjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=odavzBDqbJ1UMDYOaOKENoL2yZXbzdECDWyHUq+SkYYt9aN/00/9Ox8ItaxPRv9on
	 9ENruziEf2Spqf5xSGWhIDLb/kpwpH1YcFfYqfMMUVd9yy7rlHTnzGxLRRKnpLnEzD
	 hGR+McJnhnAIV8b/3qU7g/n4Nca7jsDJ20lQ5bHd/9MzGbGt7kwqbBgL6Zmf5IrpwC
	 uuZOq831wsjEMfMcihRl4cNZYJkVXDIl0rad2EgkH4CIJPeySLbDKBAWQpLhU9+WsT
	 rOsQaIPe5RmWCWQ2dgYhkqPC4XFcMymqXecV0a4XlS/HciqC191YSj7EJMs5C3amBK
	 4bWUG3OCZsEbw==
Date: Fri, 21 Nov 2025 17:47:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 1/3] tracing: Remove unneeded event_mutex lock in
 event_trigger_regex_release()
Message-Id: <20251121174718.fc27769642daee97dc020c6f@kernel.org>
In-Reply-To: <20251120205709.984522508@kernel.org>
References: <20251120205600.570673392@kernel.org>
	<20251120205709.984522508@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 15:56:01 -0500
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> In event_trigger_regex_release(), the only code is:
> 
> 	mutex_lock(&event_mutex);
> 	if (file->f_mode & FMODE_READ)
> 		seq_release(inode, file);
> 	mutex_unlock(&event_mutex);
> 
> 	return 0;
> 
> There's nothing special about the file->f_mode or the seq_release() that
> requires any locking. Remove the unnecessary locks.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_trigger.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 7795af600466..e5dcfcbb2cd5 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -314,13 +314,9 @@ static ssize_t event_trigger_regex_write(struct file *file,
>  
>  static int event_trigger_regex_release(struct inode *inode, struct file *file)
>  {
> -	mutex_lock(&event_mutex);
> -
>  	if (file->f_mode & FMODE_READ)
>  		seq_release(inode, file);
>  
> -	mutex_unlock(&event_mutex);
> -
>  	return 0;
>  }
>  
> -- 
> 2.51.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
