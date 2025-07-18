Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6B215F42;
	Fri, 18 Jul 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752861537; cv=none; b=bizN+WPrpHwXzYaouRD5ZHkLsIIyR1+F8gvmDWimb142g7sX2xJ6bYqNabqQe8tHwp7QNOWTC6WxR8Tgx1byVFF+vM2C+ISMAnC5eWuy9fgk606j3//1EZkjuxpAx9nm0C1OLYfpzpFda7FhE7VSUWuJIX6KfYTkLvoh2I5uyvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752861537; c=relaxed/simple;
	bh=Zy90RLKwiHKaLLNWHDYAoDxn58xyklq6A+QkZtN0F30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkFawN+nxFLfVTS2iPYKewgv51mVuJKkUFtZ9XuXV13K2b2HJRCHVY0Zbirg0OI3gIq9q8aztAoeNE5wy3vll6k59la0B+fHqJR+4VB1S+K4SVN+qxAbvM3HEzXug4/CqtiWrI5SyYD04VSNWD9ZqCEX41HvEiuquREZAY40gm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B118955F5A;
	Fri, 18 Jul 2025 17:58:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 101232000D;
	Fri, 18 Jul 2025 17:58:46 +0000 (UTC)
Date: Fri, 18 Jul 2025 13:58:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] tracing: uprobe-event: Allocate string buffers from
 heap
Message-ID: <20250718135846.6dd841e7@batman.local.home>
In-Reply-To: <175283849142.343578.11299469553352925660.stgit@devnote2>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
	<175283849142.343578.11299469553352925660.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 101232000D
X-Stat-Signature: f7ct7khhykke5nespobwssgiha6tr1fq
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+JWvHt2whzU1z8n6w9EjAyRETLKMiUpYg=
X-HE-Tag: 1752861526-576959
X-HE-Meta: U2FsdGVkX19ScH/NsbXhWunHJfawwiflmeG5QcwJOnAvoKCOuxrlzeuEkf6nbGQRwEjwvU3bkbnJ1haS2h+tDBkQjP5kln3mOE/AfUVxirgRmF44FxUomBAbQB99xLIzsG3Jw8qeRjXFLOrJyqQ13szpjahBfwGpEAgW7F1g4oxTIIdGHqcbDcCextWhTRV2vEOCm2ueAFBLDWQWh1UYbgIc7dnGCLVGF2zoKDc6JGRe3YuSLmfklpvu6faF41XB49EBC7Wn05GakCR3w/Jl8qukDyvSHpzN2zkPI1xIHtWHTQBDLb+DhR32UhXhEwiGVxK8Cjk1v3kd7ZrUPntcxjPrNx+NmHP+flY+N1vZn0hrlxGMaaPHfvnra+oLVQNh

On Fri, 18 Jul 2025 20:34:51 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Allocate temporary string buffers for parsing uprobe-events
> from heap instead of stack.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_uprobe.c |   22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 1fd479718d03..17124769e254 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -7,6 +7,7 @@
>   */
>  #define pr_fmt(fmt)	"trace_uprobe: " fmt
>  
> +#include <linux/cleanup.h>
>  #include <linux/bpf-cgroup.h>
>  #include <linux/security.h>
>  #include <linux/ctype.h>
> @@ -19,6 +20,7 @@
>  #include <linux/filter.h>
>  #include <linux/percpu.h>
>  
> +#include "trace.h"
>  #include "trace_dynevent.h"
>  #include "trace_probe.h"
>  #include "trace_probe_tmpl.h"
> @@ -538,15 +540,15 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>  static int __trace_uprobe_create(int argc, const char **argv)
>  {
>  	struct traceprobe_parse_context *ctx __free(traceprobe_parse_context) = NULL;
> -	struct trace_uprobe *tu;
>  	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
>  	char *arg, *filename, *rctr, *rctr_end, *tmp;
> -	char buf[MAX_EVENT_NAME_LEN];
> -	char gbuf[MAX_EVENT_NAME_LEN];
> -	enum probe_print_type ptype;
> -	struct path path;
>  	unsigned long offset, ref_ctr_offset;
> +	char *gbuf __free(kfree) = NULL;
> +	char *buf __free(kfree) = NULL;
> +	enum probe_print_type ptype;
> +	struct trace_uprobe *tu;
>  	bool is_return = false;
> +	struct path path;
>  	int i, ret;
>  
>  	ref_ctr_offset = 0;
> @@ -654,6 +656,11 @@ static int __trace_uprobe_create(int argc, const char **argv)
>  	/* setup a probe */
>  	trace_probe_log_set_index(0);
>  	if (event) {
> +		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> +		if (!gbuf) {
> +			ret = -ENOMEM;
> +			goto fail_address_parse;
> +		}
>  		ret = traceprobe_parse_event_name(&event, &group, gbuf,
>  						  event - argv[0]);
>  		if (ret)
> @@ -674,6 +681,11 @@ static int __trace_uprobe_create(int argc, const char **argv)
>  		if (ptr)
>  			*ptr = '\0';
>  
> +		buf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
> +		if (!buf) {
> +			ret = -ENOMEM;
> +			goto fail_address_parse;
> +		}
>  		snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_0x%lx", 'p', tail, offset);
>  		event = buf;
>  		kfree(tail);

You could easily do the same thing as I mentioned in my reply to patch 4:

		if (!buf)
			goto fail_mem;

error:
	free_trace_uprobe(tu);
out:
	trace_probe_log_clear();
	return ret;

fail_mem:
	ret = -ENOMEM;
fail_address_parse:
	trace_probe_log_clear();
	path_put(&path);
	kfree(filename);

	return ret;
}

-- Steve
