Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4950913635C;
	Tue, 14 Apr 2026 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157817; cv=none; b=KtTMRkCqIe32SyjapUQXCLv4sL1TqAcNO+UaQasOztQHb+VDg0INomBIqKb7H28t7kUcIMEaNKjx12IakU1IVgB6NjS8ljANGKlBPD9RsM14e3fHOd/AxrtjxMqOPojPmRC3I9/ZV/98VctUG8PHiV8HGBawo0cLMPcqmMtsqqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157817; c=relaxed/simple;
	bh=l5950Y1fLVwL/RbEHDN4aOqJkRB/TiXnYRkkxZ4hSBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=my/7HPirA7NIpRNWOTsjxggoHz7U2YJGgn78swaXq88EacllLgwMWKKtaUQasbqS8J1T707vxywFoST/A+E0pMeLYv7zwojJfhVyuAvAuQB4C1Jpkmy/QZpWmGpBwm7kR9H+arWztxqw/k8kJRFZdFJHsvtLM7Q6CWBFTPnzn94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 1AC8EB994F;
	Tue, 14 Apr 2026 09:10:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 0075334;
	Tue, 14 Apr 2026 09:10:12 +0000 (UTC)
Date: Tue, 14 Apr 2026 05:10:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/hist: bound expression strings with seq_buf
Message-ID: <20260414051010.200075d8@robin>
In-Reply-To: <20260409123001.1-tracing-hist-expr-v2-pengpeng@iscas.ac.cn>
References: <20260407153001.1-tracing-hist-expr-pengpeng@iscas.ac.cn>
	<20260409123001.1-tracing-hist-expr-v2-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xfr8pjtxo6wkmimgj7eizd19qq7aynpf
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 0075334
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX186NpDt74eEdFgmsicjtZ/cpl6ElvPDlMo=
X-HE-Tag: 1776157812-678636
X-HE-Meta: U2FsdGVkX1/1QERJXK5AuwR10WUT6ye2M8oykD9clkaONbK/glNWgRHrKYW1czoFGle6NGFI8Elb7HZGO+PSd1TrsSL/Niyn5uPjQuFBmTnWANpzoqOOnj9JLzz4Tue9B+eyi/Fq7SwzqRugNsRc/90Z4n0Fb2a692E7ZfaDWA0rh1/OLcKpgRCoOAch57VwqyQzmB+Rj1MGCAC8LTHxC0g6+r5eOx4Y26fpOMn6XgMjmpk28EchpkCuDP+ualshmQHScZjfA1De42uwhdfq4XKp+rb2Eq7f2CKPY8QExMeIlaRikDUaP8E/6xBGyW7g

On Thu, 9 Apr 2026 10:56:28 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

Hi Pengpeng,

Again, subject should be:

  tracing: Bound histogram expression strings with seq_buf

> expr_str() allocates a fixed MAX_FILTER_STR_VAL buffer and then builds
> expression names with a series of raw strcat() appends. Nested operands,
> constants and field flags can push the rendered string past that fixed
> limit before the name is attached to the hist field.
> 
> Build the expression strings with seq_buf and propagate failures back to
> the expression parser when the rendered name would exceed
> MAX_FILTER_STR_VAL.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v1:
> - replace the previous bounded append helper and manual length tracking
>   with seq_buf as suggested by Steven Rostedt
> - keep the -E2BIG propagation back into parse_unary() and parse_expr()
> 
>  kernel/trace/trace_events_hist.c | 93 ++++++++++++++++++++++----------
>  1 file changed, 64 insertions(+), 29 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 73ea180cad55..09aaedb92993 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/kallsyms.h>
>  #include <linux/security.h>
> +#include <linux/seq_buf.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/stacktrace.h>
> @@ -1738,85 +1739,104 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
>  	return flags_str;
>  }
>  
> -static void expr_field_str(struct hist_field *field, char *expr)
> +static bool expr_field_str(struct hist_field *field, struct seq_buf *s)
>  {
> +	const char *field_name;
> +
>  	if (field->flags & HIST_FIELD_FL_VAR_REF)
> -		strcat(expr, "$");
> -	else if (field->flags & HIST_FIELD_FL_CONST) {
> -		char str[HIST_CONST_DIGITS_MAX];
> +		seq_buf_putc(s, '$');
> +	else if (field->flags & HIST_FIELD_FL_CONST)
> +		seq_buf_printf(s, "%llu", field->constant);
>  
> -		snprintf(str, HIST_CONST_DIGITS_MAX, "%llu", field->constant);
> -		strcat(expr, str);
> -	}
> +	field_name = hist_field_name(field, 0);
> +	if (!field_name)
> +		return false;
>  
> -	strcat(expr, hist_field_name(field, 0));
> +	seq_buf_puts(s, field_name);
>  
>  	if (field->flags && !(field->flags & HIST_FIELD_FL_VAR_REF)) {
>  		const char *flags_str = get_hist_field_flags(field);
>  
> -		if (flags_str) {
> -			strcat(expr, ".");
> -			strcat(expr, flags_str);
> -		}
> +		if (flags_str)
> +			seq_buf_printf(s, ".%s", flags_str);
>  	}
> +
> +	return !seq_buf_has_overflowed(s);
>  }
>  
>  static char *expr_str(struct hist_field *field, unsigned int level)
>  {
>  	char *expr;
> +	struct seq_buf s;
> +	int ret = -E2BIG;
>  
>  	if (level > 1)
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  
>  	expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
>  	if (!expr)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);

A patch should do one thing at a time. This patch appears to be doing
two things: fixing the bound strings, returning errors instead of NULL.

Please split this up into two patches. One that changes the return
values from NULL to ERR_PTR() and the other to use seq_buf.

Thanks,

-- Steve

