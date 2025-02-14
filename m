Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96180B;
	Fri, 14 Feb 2025 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739491835; cv=none; b=hT+12uoH1OoJG3LzjLNCB8Wpf6VgcdedPq0wlf+Ddt6ZzfZiCfx6Pd2/GqrUUqXeK9SQxNoRUXp1YQfzy0i/zflXKMZbiHkqSYmDf7HNYkKe8kZ6rI59K+rux4JsdP7G710B0vnnp1N01pJiXMwNkx/8xbKjqSaZz6MugMsjFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739491835; c=relaxed/simple;
	bh=3xrjQC4vivjWCLqH94r/JVqPR6YJTXdfJtrCe9XTMKc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Pp4oVBzxocushWYQYQKmR8b/e3gmXP3X36NI6sYX1mSNWdN4QJwlHl/RItovtdac6tN4tyJBg7XW4+chzRwN18FzPJtDDKg9+IhKzgr1IwDKqnN+g6j/dglrVS/bv+rQIVy14eXZi6bR9ZCXHTNDjio+H76MDHlrKiRtboVssHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHmIX2ub; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHmIX2ub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29614C4CED1;
	Fri, 14 Feb 2025 00:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739491835;
	bh=3xrjQC4vivjWCLqH94r/JVqPR6YJTXdfJtrCe9XTMKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MHmIX2ubYN87rsggIK/s1pbWVFEFf8quxjxjOKNvTaPI5kbf3vJa7fxkaKHRu6hKD
	 I8GFGiUfCHyZYRQFcZZnmEiLrqJYVULAMhKtdA6zomIN2slXWb7Ry9aTnL5y9Ero91
	 GM2uKmTu4+5HizDjFbHSym9iWfSNoNbJCcySGOG2UbJkxiP0nZtUSpgj+DuWxEex8o
	 Mgf1tKr380BNF/zGaWw2A8CKQ1rEW9Y17aAkzeyNqND1Afu/vYE++vfUg+YVgtzm+o
	 bGJZJxX/I3uy/BOzyg5oXN/0w+ItMp90MxSjFBmoMvDYj7XYJ31WGuT7cwra94wnZQ
	 c99tAXQrrnWSw==
Date: Fri, 14 Feb 2025 09:10:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH] ring-buffer: Unlock resize on mmap error
Message-Id: <20250214091031.fc31a81a5e86148655998e4a@kernel.org>
In-Reply-To: <20250213131957.530ec3c5@gandalf.local.home>
References: <20250213131957.530ec3c5@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 13:19:57 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Memory mapping the tracing ring buffer will disable resizing the buffer.
> But if there's an error in the memory mapping like an invalid parameter,
> the function exits out without re-enabling the resizing of the ring
> buffer, preventing the ring buffer from being resized after that.
> 

Looks good to me.

Reveiewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Cc: stable@vger.kernel.org
> Fixes: 117c39200d9d7 ("ring-buffer: Introducing ring-buffer mapping functions")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index b8e0ae15ca5b..07b421115692 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7126,6 +7126,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>  		kfree(cpu_buffer->subbuf_ids);
>  		cpu_buffer->subbuf_ids = NULL;
>  		rb_free_meta_page(cpu_buffer);
> +		atomic_dec(&cpu_buffer->resize_disabled);
>  	}
>  
>  unlock:
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
