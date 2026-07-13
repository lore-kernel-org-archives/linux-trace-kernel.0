Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4E7262B;
	Mon, 13 Jul 2026 02:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783908989; cv=none; b=jWSxvvr7p2MIkFBo3AmyRSsxkOhn/9s/zJVJrmKS4JzXEfrqvSvIByPuXjgCvA+6M3o0CLkNrWTkGnwajSAJsgRZsgjhkZzskhoraO7MttyVqm5hB6jsYbt2mssV487GpwHB+bzsheulnGMue38L5DcBLDloer+fXodN/PEqnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783908989; c=relaxed/simple;
	bh=dGF7xPfKvWbgXDdOai1l5M80C/P3hvIHfMKdaVHUE6c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NNQjgslskxFOKFzRQwB5iQ1WNp1JyueAdVAsgmnfTif16yIi+u65Unkvj4ldmAqPC0IhkNaHyXFqEpmbrtQch4ktrPm77zKrRbCP2wFENE/9H/ZRz/Wp0xs6aH5bVxNObCR2+gR+ng2CUA0oEAQZynQ/odfO3tZ+R2DK/odImbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR3FcJwl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR3FcJwl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F3D1F000E9;
	Mon, 13 Jul 2026 02:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783908987;
	bh=br9FhVYJuPRVoM9lVCAAChWOr0wLAcBU1znUuGfC0yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jR3FcJwlDRti3QVIqRaiPv4Zm+2+TGc1dcjjVxG/8zGXzm0KoYX90rnA4ZmX2GyEn
	 adYWCj22e+XxSrBbiZlHg+V38A5Zbj3u3MW8oPoR7uXoO57O1UxHdc8j+y8a1/NCbP
	 RzqvCKk7nyX3XMBMnjc8rrd9+YXJxju7a0C/HP4yYBSYOPxg5gI1BdfDONQsLvTplu
	 +1hIfghtwvt7gpOMqS1RVUknFeYTcVKOJfxXasS9iC/lrFhKL0jqxIB4ikSatdxpuT
	 QaGjuZAEQVwpOWv0EeqLd32dl6VKTHAtkdbV+vFpXLgPM5mhd4eMpc3KZkou5GTwGC
	 QDIoT+tjgUDfA==
Date: Mon, 13 Jul 2026 11:16:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 4/5] tracing/probes: Extend max length of argument
 string
Message-Id: <20260713111623.bae8f26476740a0467b03521@kernel.org>
In-Reply-To: <178386880215.3174487.982264935084717241.stgit@devnote2>
References: <178386876526.3174487.5142283230157728964.stgit@devnote2>
	<178386880215.3174487.982264935084717241.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 00:06:42 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> To support BTF argument parsing (such as accessing fields within nested
> structures via typecasting), the maximum argument string length needs
> to be extended. Extend MAX_ARGSTR_LEN from 63 to 256.
> 
> Since MAX_ARGSTR_LEN was previously reused to format command heads in
> trace_*probe_match_command_head() functions, introduce a dedicated
> MAX_COMMON_HEAD_LEN (63) macro for matching command heads and switch
> these functions to use the new macro.
> 
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko asked to extend other macros, 
> Does this code also need to increase MAX_BTF_ARGS_LEN and MAX_DENTRY_ARGS_LEN?

I don't agree this. MAX_BTF_ARGS_LEN is only for expanding "$args" into
each parameter names. The other arguments are kept on the same memory.

MAX_DENTRY_ARGS_LEN is already 256, so I think if that is too long,
it should be rejected.
(But MAX_ARGSTR_LEN should be 255.)

BTW, both macro names are a bit complicated because those are just
buffer size, not max length of something.

Thank you,

> ---
>  kernel/trace/trace_fprobe.c                        |    2 +-
>  kernel/trace/trace_kprobe.c                        |    2 +-
>  kernel/trace/trace_probe.h                         |    3 ++-
>  kernel/trace/trace_uprobe.c                        |    2 +-
>  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    2 +-
>  .../ftrace/test.d/dynevent/tprobe_syntax_errors.tc |    2 +-
>  .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    2 +-
>  7 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 536781cd4c47..5638a90e61cc 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -238,7 +238,7 @@ static bool trace_fprobe_is_busy(struct dyn_event *ev)
>  static bool trace_fprobe_match_command_head(struct trace_fprobe *tf,
>  					    int argc, const char **argv)
>  {
> -	char buf[MAX_ARGSTR_LEN + 1];
> +	char buf[MAX_COMMON_HEAD_LEN + 1];
>  
>  	if (!argc)
>  		return true;
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index cfa807d8e760..cc24e992732c 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -149,7 +149,7 @@ static bool trace_kprobe_is_busy(struct dyn_event *ev)
>  static bool trace_kprobe_match_command_head(struct trace_kprobe *tk,
>  					    int argc, const char **argv)
>  {
> -	char buf[MAX_ARGSTR_LEN + 1];
> +	char buf[MAX_COMMON_HEAD_LEN + 1];
>  
>  	if (!argc)
>  		return true;
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index e64e323244a5..e6aee800a7d9 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -32,7 +32,8 @@
>  #include "trace_output.h"
>  
>  #define MAX_TRACE_ARGS		128
> -#define MAX_ARGSTR_LEN		63
> +#define MAX_ARGSTR_LEN		256
> +#define MAX_COMMON_HEAD_LEN	63
>  #define MAX_ARRAY_LEN		64
>  #define MAX_ARG_NAME_LEN	32
>  #define MAX_BTF_ARGS_LEN	128
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index b2e264a4b96c..67bd8fd91e3e 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -281,7 +281,7 @@ static bool trace_uprobe_is_busy(struct dyn_event *ev)
>  static bool trace_uprobe_match_command_head(struct trace_uprobe *tu,
>  					    int argc, const char **argv)
>  {
> -	char buf[MAX_ARGSTR_LEN + 1];
> +	char buf[MAX_COMMON_HEAD_LEN + 1];
>  	int len;
>  
>  	if (!argc)
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
> index e9d7e6919c7f..984ab94df213 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
> @@ -75,7 +75,7 @@ check_error 'f vfs_read ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_L
>  check_error 'f vfs_read ^=@11'			# NO_ARG_NAME
>  check_error 'f vfs_read ^var.1=@11'		# BAD_ARG_NAME
>  check_error 'f vfs_read var1=@11 ^var1=@12'	# USED_ARG_NAME
> -check_error 'f vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
> +check_error 'f vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))))))))))))))))))))))'	# ARG_TOO_LONG
>  check_error 'f vfs_read arg1=^'			# NO_ARG_BODY
>  
>  
> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
> index ffe8ffef4027..2d0905b2c8b7 100644
> --- a/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/tprobe_syntax_errors.tc
> @@ -61,7 +61,7 @@ check_error 't kfree ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_LOG
>  check_error 't kfree ^=@11'			# NO_ARG_NAME
>  check_error 't kfree ^var.1=@11'		# BAD_ARG_NAME
>  check_error 't kfree var1=@11 ^var1=@12'	# USED_ARG_NAME
> -check_error 't kfree ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
> +check_error 't kfree ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))))))))))))))))))))))'	# ARG_TOO_LONG
>  check_error 't kfree arg1=^'			# NO_ARG_BODY
>  
>  
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index 21ce8414459f..d28f63b7e8a9 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -71,7 +71,7 @@ check_error 'p vfs_read ^arg123456789012345678901234567890=@11'	# ARG_NAME_TOO_L
>  check_error 'p vfs_read ^=@11'			# NO_ARG_NAME
>  check_error 'p vfs_read ^var.1=@11'		# BAD_ARG_NAME
>  check_error 'p vfs_read var1=@11 ^var1=@12'	# USED_ARG_NAME
> -check_error 'p vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))'	# ARG_TOO_LONG
> +check_error 'p vfs_read ^+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(+1234567(@1234))))))))))))))))))))))))))'	# ARG_TOO_LONG
>  check_error 'p vfs_read arg1=^'			# NO_ARG_BODY
>  
>  # instruction boundary check is valid on x86 (at this moment)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
