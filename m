Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C064A125B2;
	Fri,  6 Feb 2026 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336735; cv=none; b=CwJ6KkpJWeaoOQfhhPXrCuz3H47BByLD2RtoXs0Nu5kJqpMIpn95MkSqdTg+bjBstxlIGfLb9e6Fut7T7acTCOO/ocjOla33c/Aq3AbcCtTMDkHufWR9ookPvMKNM/VWNO/4s4z/bhxbdQ+MiCw/jZWPrf2ebM4A9aw8jFtTTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336735; c=relaxed/simple;
	bh=JllQdjHjyArfBWo53SAT9kxvFdKiGTs+1It88NS9Glw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=T8Hezt8/hApXHhsjaEyGDhUUBTG9HM9EaKvryAqGV5Q5jggJ37e14sgJTwAqzOwhW8SKUjwRfyI3FB3fI6eOgMn6NVIzb3UUtd/w84JfNi73gmHpeOINqMGotuLifS3TffQnvm0sdJ4M2Za+ORlVNbkAzAnjhFnvUzGg2qy/Ddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fx3aq1cu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fx3aq1cu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ECA2C4CEF7;
	Fri,  6 Feb 2026 00:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770336735;
	bh=JllQdjHjyArfBWo53SAT9kxvFdKiGTs+1It88NS9Glw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fx3aq1cuJKUizarAgqah9r0dAchKI0wf3VSkmvB68Sm3fZyOfhQdJT+oR5d56m/7G
	 WdPoZ6djcNpj1igldn95iSbVH3RP4ii9pYJOwlqzcsju8Fet8CVK9ojFKHSdmd5f4/
	 OG6Lir2qw9eb45tM4tnk7EwOTx80HRM6ezhyyaCUYwwaUYl+OXnTEHH5IjpGE61LMU
	 bcFq/MNPMdz4Gl89wjUyQ4c3XHM/EqSYYIEzhLs5BpCHdrnaDc4l662Q2nPZEqWuu1
	 gM6qcQAD+VOfUJHccDu+9qyT1jBQakfTg/q8BY9PYK0X/6uWolRrvAcdJ+SLO8UaMC
	 x0nfntPaTWJ6w==
Date: Fri, 6 Feb 2026 09:12:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: rostedt@goodmis.org, ast@kernel.org, mhiramat@kernel.org,
 andrii.nakryiko@gmail.com, linux-kernel@vger.kernel.org, Donglin Peng
 <pengdonglin@xiaomi.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing: resolve enum names for function arguments
 via BTF
Message-Id: <20260206091210.923917c8ff1f52fbdb3907ed@kernel.org>
In-Reply-To: <20260202111548.3555306-3-dolinux.peng@gmail.com>
References: <20260202111548.3555306-1-dolinux.peng@gmail.com>
	<20260202111548.3555306-3-dolinux.peng@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Feb 2026 19:15:48 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: Donglin Peng <pengdonglin@xiaomi.com>
> 
> Use BTF to print symbolic names for enum-type function arguments,
> improving trace readability.
> 
> Before:
> count_memcg_events(memcg=0xffff..., idx=20, count=0x1) {
> 
> After:
> count_memcg_events(memcg=0xffff..., idx=20 [PGFAULT], count=0x1) {

Hmm, it is interesting idea. Maybe I can also introduce the same
feature to fetcharg for fprobe/kprobes as a new type.
Since the enum type should be solved in parsing the event definition,
for fprobe/kprobes the performance will not be a performance problem.

Thanks,

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> ---
>  kernel/trace/trace_output.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index cc2d3306bb60..c395f768c3b8 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -695,12 +695,13 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>  {
>  	const struct btf_param *param;
>  	const struct btf_type *t;
> +	const struct btf_enum *enump;
>  	const char *param_name;
>  	char name[KSYM_NAME_LEN];
>  	unsigned long arg;
>  	struct btf *btf;
>  	s32 tid, nr = 0;
> -	int a, p, x;
> +	int a, p, x, i;
>  	u16 encode;
>  
>  	trace_seq_printf(s, "(");
> @@ -754,6 +755,14 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
>  			break;
>  		case BTF_KIND_ENUM:
>  			trace_seq_printf(s, "%ld", arg);
> +			for_each_enum(i, t, enump) {
> +				if (arg == enump->val) {
> +					trace_seq_printf(s, " [%s]",
> +							 btf_name_by_offset(btf,
> +							 enump->name_off));
> +					break;
> +				}
> +			}
>  			break;
>  		default:
>  			/* This does not handle complex arguments */
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
