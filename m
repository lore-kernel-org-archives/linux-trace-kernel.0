Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514321798F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQoT7kHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E35C433C7;
	Tue, 12 Dec 2023 22:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702421270;
	bh=fTzQszjJZI1SU83F2DPicXFge7TTPi0j6QJoBbVl1TI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UQoT7kHuV6vYeIp2c9J97rMAU/aseRE7+I8zj2u86LxOKPQN1l4BJR9RdO27xHGKh
	 bAMyPCc/73mlXUi9IKA+ZnB9OzETYfDcVhTlammymBEyJHwM15dEhUzojsa5nolcjr
	 yWtWXwtFNhy5mzf7KKrLDLZ2KkOWER5le/4pWK0RCxipo+VHPi0UGCKgcp0wyHR1uo
	 xbNi7X8Ugo4Opw8qTpYwfLVUrUslrclsAr0xLXyNOWR05u+TO9w5++hx59S5vO8Y2T
	 +eFu5FGg/fyWaT4J5LYjd0FpZ72mODhtnIubXfkRVjFLSnnZfwXpH9bg/jpNp9jinI
	 yPVerbXa1ysiw==
Date: Wed, 13 Dec 2023 07:47:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: Add size check when printing trace_marker
 output
Message-Id: <20231213074746.cd2dbd703bd19fe791c5d44a@kernel.org>
In-Reply-To: <20231212084444.4619b8ce@gandalf.local.home>
References: <20231212084444.4619b8ce@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 08:44:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If for some reason the trace_marker write does not have a nul byte for the
> string, it will overflow the print:
> 
>   trace_seq_printf(s, ": %s", field->buf);
> 
> The field->buf could be missing the nul byte. To prevent overflow, add the
> max size that the buf can be by using the event size and the field
> location.
> 
>   int max = iter->ent_size - offsetof(struct print_entry, buf);
> 
>   trace_seq_printf(s, ": %*s", max, field->buf);
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_output.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index d8b302d01083..e11fb8996286 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1587,11 +1587,12 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
>  {
>  	struct print_entry *field;
>  	struct trace_seq *s = &iter->seq;
> +	int max = iter->ent_size - offsetof(struct print_entry, buf);
>  
>  	trace_assign_type(field, iter->ent);
>  
>  	seq_print_ip_sym(s, field->ip, flags);
> -	trace_seq_printf(s, ": %s", field->buf);
> +	trace_seq_printf(s, ": %*s", max, field->buf);
>  
>  	return trace_handle_return(s);
>  }
> @@ -1600,10 +1601,11 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
>  					 struct trace_event *event)
>  {
>  	struct print_entry *field;
> +	int max = iter->ent_size - offsetof(struct print_entry, buf);
>  
>  	trace_assign_type(field, iter->ent);
>  
> -	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
> +	trace_seq_printf(&iter->seq, "# %lx %*s", field->ip, max, field->buf);
>  
>  	return trace_handle_return(&iter->seq);
>  }
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
