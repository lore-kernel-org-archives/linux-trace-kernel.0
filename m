Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160D61F5617;
	Tue,  9 Dec 2025 00:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765241296; cv=none; b=ERw940xq6mcUOt1BVWZpo130h52tkCfnU51GhPsHIs1y9BtxbwU3NVcJ8m0A8H49p0x/FgBTyTDsVkHLC+VkJnJCFlHfrYdv+CCZ076hJexfpSseiH/EStqF9fea2Mzhs3vN7O6TBP1cjrr43vgd6De6sRlC7imtHYqpiLadUbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765241296; c=relaxed/simple;
	bh=qDhDv1XQHa7eVcohZXcOpO01GX4um01PZKAkFySD+zw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VYVFbdcdyJ8MluSRYHQTyztXJJkZAiBut6mFwcKncjNGsS7EX7X96v27JQLgazy0CqhC49IMgonGFNGeid3eYyM19vaTsic1YpLtN4iJFBDKHl4C3PFoV+Wasf4SWOxN6dLG4OYm+iNNCXEQslcEqJg4m28/2NzsBihOO6YUM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2KYVm0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2KYVm0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A94C4CEF1;
	Tue,  9 Dec 2025 00:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765241295;
	bh=qDhDv1XQHa7eVcohZXcOpO01GX4um01PZKAkFySD+zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o2KYVm0vHGeGP8v+TYeph4+qyXcAtm7tW0doXZlm5bXvSFTAfox4x9IDxTiNgl9AS
	 qI/4+UVuNOyx76PD9u7H1f/QEcVPkfoWcEZeWAnFHCNHRig5YSXUuPUUaVfzumCULh
	 mwEbyrwdTG/rhAeP0G00flwGsauEXG0BnjNpXrNH+pNULJ3Y4DBpUvsv6Mxablgi7x
	 rFlU3xWDJztt1oZlK7P18SytLqb+D4s4wxkDVGoXG5g+1bX56SYkyPJG7TPIt4Mpdx
	 tf474fjd92lFfNv3yAJ67X8fGLrQcgjw/Z45t/tu4dcSPzyO48ILq+xN7ugT6wAr7u
	 R9cxYwgHaqA+g==
Date: Tue, 9 Dec 2025 09:48:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: Re: [PATCH v2 1/2] fgraph: Use BTF to trim and filter return values
Message-Id: <20251209094810.fb53ac6296656d361754d593@kernel.org>
In-Reply-To: <20251208131917.2444620-2-dolinux.peng@gmail.com>
References: <20251208131917.2444620-1-dolinux.peng@gmail.com>
	<20251208131917.2444620-2-dolinux.peng@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Dec 2025 21:19:16 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> The current funcgraph-retval implementation has two limitations:
> 
> 1. It prints a return value even when the traced function returns void.
> 2. When the return type is narrower than a register, the printed value may
>    be incorrect because high bits can contain undefined data.
> 
> Both issues are addressed by using BTF to obtain the precise return type
> of each traced function:
> 
> - Return values are now printed only for functions whose return type is
>   not void.
> - The value is truncated to the actual width of the return type, ensuring
>   correct representation.
> 
> These changes make the funcgraph-retval output more accurate and remove
> noise from void functions.
> 
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  kernel/trace/trace_functions_graph.c | 64 +++++++++++++++++++++++-----
>  1 file changed, 54 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 17c75cf2348e..9e63665c81e2 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -15,6 +15,7 @@
>  
>  #include "trace.h"
>  #include "trace_output.h"
> +#include "trace_btf.h"
>  
>  /* When set, irq functions might be ignored */
>  static int ftrace_graph_skip_irqs;
> @@ -865,6 +866,46 @@ static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_e
>  
>  #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_GRAPH_RETADDR)
>  
> +static void trim_retval(unsigned long func, unsigned long *retval, bool *print_retval)
> +{
> +	const struct btf_type *t;
> +	char name[KSYM_NAME_LEN];
> +	struct btf *btf;
> +	u32 v, msb;
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
> +		return;
> +
> +	if (lookup_symbol_name(func, name))
> +		return;
> +
> +	t = btf_find_func_proto(name, &btf);
> +	if (IS_ERR_OR_NULL(t))
> +		return;
> +
> +	t = btf_type_skip_modifiers(btf, t->type, NULL);
> +	switch (t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN) {
> +	case BTF_KIND_UNKN:
> +		*print_retval = false;
> +		break;
> +	case BTF_KIND_ENUM:
> +	case BTF_KIND_ENUM64:
> +		msb = BITS_PER_BYTE * t->size - 1;
> +		*retval &= GENMASK(msb, 0);
> +		break;
> +	case BTF_KIND_INT:
> +		v = *(u32 *)(t + 1);
> +		if (BTF_INT_ENCODING(v) == BTF_INT_BOOL)
> +			msb = 0;
> +		else
> +			msb = BTF_INT_BITS(v) - 1;
> +		*retval &= GENMASK(msb, 0);
> +		break;
> +	default:
> +		break;
> +	}
> +}

Hmm, I think we should have another flag which directly tells the print
format of retval from BTF.

> +
>  static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entry *entry,
>  				struct ftrace_graph_ret *graph_ret, void *func,
>  				u32 opt_flags, u32 trace_flags, int args_size)
> @@ -884,17 +925,20 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
>  	print_retaddr = !!(opt_flags & TRACE_GRAPH_PRINT_RETADDR);
>  #endif
>  
> -	if (print_retval && retval && !hex_format) {
> -		/* Check if the return value matches the negative format */
> -		if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
> -			(((u64)retval) >> 32) == 0) {
> -			err_code = sign_extend64(retval, 31);
> -		} else {
> -			err_code = retval;

The original code just guesses the type (signed/unsigned) from
the retval, but we don't need to do that with BTF.

Thank you,

> +	if (print_retval) {
> +		trim_retval((unsigned long)func, &retval, &print_retval);
> +		if (print_retval && retval && !hex_format) {
> +			/* Check if the return value matches the negative format */
> +			if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
> +				(((u64)retval) >> 32) == 0) {
> +				err_code = sign_extend64(retval, 31);
> +			} else {
> +				err_code = retval;
> +			}
> +
> +			if (!IS_ERR_VALUE(err_code))
> +				err_code = 0;
>  		}
> -
> -		if (!IS_ERR_VALUE(err_code))
> -			err_code = 0;
>  	}
>  
>  	if (entry) {
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
