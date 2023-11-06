Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C52E648
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Nov 2023 22:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8908C433C7;
	Mon,  6 Nov 2023 22:28:10 +0000 (UTC)
Date: Mon, 6 Nov 2023 17:28:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe-event: Fix to check tracepoint event
 and return
Message-ID: <20231106172811.25066d33@gandalf.local.home>
In-Reply-To: <169902753361.313086.6662802092416198593.stgit@devnote2>
References: <169902753361.313086.6662802092416198593.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  4 Nov 2023 01:05:34 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to check the tracepoint event is not valid with $retval.
> The commit 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is
> a return event by $retval") introduced automatic return probe
> conversion with $retval. But since tracepoint event does not
> support return probe, $retval is not acceptable.

Can you add the command that causes this to fail.

-- Steve

> 
> Fixes: 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is a return event by $retval")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_fprobe.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 8bfe23af9c73..7d2ddbcfa377 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -927,11 +927,12 @@ static int parse_symbol_and_return(int argc, const char *argv[],
>  	for (i = 2; i < argc; i++) {
>  		tmp = strstr(argv[i], "$retval");
>  		if (tmp && !isalnum(tmp[7]) && tmp[7] != '_') {
> +			if (is_tracepoint) {
> +				trace_probe_log_set_index(i);
> +				trace_probe_log_err(tmp - argv[i], RETVAL_ON_PROBE);
> +				return -EINVAL;
> +			}
>  			*is_return = true;
> -			/*
> -			 * NOTE: Don't check is_tracepoint here, because it will
> -			 * be checked when the argument is parsed.
> -			 */
>  			break;
>  		}
>  	}

