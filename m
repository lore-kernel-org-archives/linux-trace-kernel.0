Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Aepfzeil"
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4BD99;
	Tue, 12 Dec 2023 06:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1702391035;
	bh=USEuixjU2fIwlYaRovUecQIYEQq4YyOBnS594yyopqg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Aepfzeilvp/gNBYsgSBllAS2dR4H7lS0IsyIBuPRbqfGK0o8o6GXQIlxVuecPRHAb
	 GcWH0w7cWxDQYb7UYhLodUFssnGMVTDF1i3TZEfRd7CInFC71BROE0Jy+JzU1AY7Vq
	 OM1cIn3tztCpi6NE+veTJj8HpeWmN8kL5vdF/Pp7PYaGBWVoOBJKmoWbohAiGlx+Be
	 ErUZPOQr9erPjyafiIv/DYC4phNjrfAUTKYyVeGsYzHRjtPMv0Edj+ZzheqL7lrm92
	 YwYPgw82jVimjyQusDBGSFO4E7zRuFh794i8xsxJDRdfRAJW1pB1v+dzjNp3oNFjeY
	 JRosiQg5/UBaA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SqLT70XlKzGGr;
	Tue, 12 Dec 2023 09:23:55 -0500 (EST)
Message-ID: <148974c2-df17-4c71-a59a-6e056e10910e@efficios.com>
Date: Tue, 12 Dec 2023 09:23:54 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add size check when printing trace_marker output
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <20231212084444.4619b8ce@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231212084444.4619b8ce@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-12 08:44, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> If for some reason the trace_marker write does not have a nul byte for the
> string, it will overflow the print:

Does this result in leaking kernel memory to userspace ? If so, it
should state "Fixes..." and CC stable.

Thanks,

Mathieu

> 
>    trace_seq_printf(s, ": %s", field->buf);
> 
> The field->buf could be missing the nul byte. To prevent overflow, add the
> max size that the buf can be by using the event size and the field
> location.
> 
>    int max = iter->ent_size - offsetof(struct print_entry, buf);
> 
>    trace_seq_printf(s, ": %*s", max, field->buf);
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   kernel/trace/trace_output.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index d8b302d01083..e11fb8996286 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -1587,11 +1587,12 @@ static enum print_line_t trace_print_print(struct trace_iterator *iter,
>   {
>   	struct print_entry *field;
>   	struct trace_seq *s = &iter->seq;
> +	int max = iter->ent_size - offsetof(struct print_entry, buf);
>   
>   	trace_assign_type(field, iter->ent);
>   
>   	seq_print_ip_sym(s, field->ip, flags);
> -	trace_seq_printf(s, ": %s", field->buf);
> +	trace_seq_printf(s, ": %*s", max, field->buf);
>   
>   	return trace_handle_return(s);
>   }
> @@ -1600,10 +1601,11 @@ static enum print_line_t trace_print_raw(struct trace_iterator *iter, int flags,
>   					 struct trace_event *event)
>   {
>   	struct print_entry *field;
> +	int max = iter->ent_size - offsetof(struct print_entry, buf);
>   
>   	trace_assign_type(field, iter->ent);
>   
> -	trace_seq_printf(&iter->seq, "# %lx %s", field->ip, field->buf);
> +	trace_seq_printf(&iter->seq, "# %lx %*s", field->ip, max, field->buf);
>   
>   	return trace_handle_return(&iter->seq);
>   }

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

