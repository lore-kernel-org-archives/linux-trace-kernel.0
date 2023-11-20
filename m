Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B310E7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap4gfEVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05502C433C7;
	Mon, 20 Nov 2023 04:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700456266;
	bh=D8GkFkadiMvyfeHxVlRTuBngO0W+nbZFP1V6zF4gWgY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ap4gfEVJl+R+eIh1mutUrAjpACp5P0jiwpxn/rx78T/sultv9oQKN/7Da6gpCcusv
	 037av/hc14u38aufL6LrpScArXelj8mceylftyLmIlYfBu9bD1y9OHR6TnG320DooP
	 dFOZrgzVGRmYh6/j4UCu2mgfyElARiKd9UvsnL8bP/rWoiogK5tSngLLZ8hg8iiQ1t
	 V+ygjmbszOjGa+qvtEEgtT0yec1c5TNAYr6H9jF0lSBj+UpheeqtLEKMTsxnEO41jG
	 9Cj6UpuJVeoFqa5HQpp8kyr0G7GOEDKMUa2EFhwkEYto150rFFDFSgFqWbxAjKOg8n
	 SuxGIQYEf86FA==
Date: Mon, 20 Nov 2023 13:57:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yuran Pereira <yuran.pereira@hotmail.com>
Cc: linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
 rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] ftrace: Replaces simple_strtoul in ftrace
Message-Id: <20231120135742.0abfc6bb7ccdd985990c68a4@kernel.org>
In-Reply-To: <GV1PR10MB656333529A8D7B8AFB28D238E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB656333529A8D7B8AFB28D238E8B4A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 05:46:13 +0530
Yuran Pereira <yuran.pereira@hotmail.com> wrote:

> The function simple_strtoul performs no error checking in scenarios
> where the input value overflows the intended output variable.
> This results in this function successfully returning, even when the
> output does not match the input string (aka the function returns
> successfully even when the result is wrong).
> 
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
> 
> This patch replaces all uses of the simple_strtoul with the safer
> alternatives kstrtoul and kstruint.
> 
> Callers affected:
> - add_rec_by_index
> - set_graph_max_depth_function
> 
> Side effects of this patch:
> - Since `fgraph_max_depth` is an `unsigned int`, this patch uses
>   kstrtouint instead of kstrtoul to avoid any compiler warnings
>   that could originate from calling the latter.
> - This patch ensures that the callers of kstrtou* return accordingly
>   when kstrtoul and kstruint fail for some reason.
>   In this case, both callers this patch is addressing return 0 on error.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
> 

This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!

> Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
> ---
>  kernel/trace/ftrace.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8de8bec5f366..70217ee97322 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -4233,12 +4233,12 @@ static int
>  add_rec_by_index(struct ftrace_hash *hash, struct ftrace_glob *func_g,
>  		 int clear_filter)
>  {
> -	long index = simple_strtoul(func_g->search, NULL, 0);
> +	long index;
>  	struct ftrace_page *pg;
>  	struct dyn_ftrace *rec;
>  
>  	/* The index starts at 1 */
> -	if (--index < 0)
> +	if (kstrtoul(func_g->search, 0, &index) || --index < 0)
>  		return 0;
>  
>  	do_for_each_ftrace_rec(pg, rec) {
> @@ -5810,9 +5810,8 @@ __setup("ftrace_graph_notrace=", set_graph_notrace_function);
>  
>  static int __init set_graph_max_depth_function(char *str)
>  {
> -	if (!str)
> +	if (!str || kstrtouint(str, 0, &fgraph_max_depth))
>  		return 0;
> -	fgraph_max_depth = simple_strtoul(str, NULL, 0);
>  	return 1;
>  }
>  __setup("ftrace_graph_max_depth=", set_graph_max_depth_function);
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
