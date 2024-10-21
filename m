Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895B41E103F;
	Mon, 21 Oct 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497691; cv=none; b=qJHy+POa7uh2V4LWXgwS6jOZ5FYV3Rt1B86ZCjr+PXI+jqnkD6t3DsAG+qIFA5idczKg9eq98eJLIUSfi0gUK2u/oNoo6drC9vl9BkBynJAR6sGj7gQIZ82Opm2TQSD4tbXkKTG5VYd6vwe/S3biZYAW7Ute40Pj6hAppS6sbFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497691; c=relaxed/simple;
	bh=qYaluKYeXjK/vxavp1QyHP7JhfNcOYobyCl7MtCijIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQe5pWVMvi+f2+IL1auu6jHdVsjB7fzrETNjGiETAZa9qzllsRlioDcaRuYSiK/BpWXmJuLhTW/0nhcIwxkz+PZP8HXzYYc6+dfU61fosrwfbFOBDtV5BFCJxGT6TjaWk1BvhtEBqdaD0hhNV8WXbbGPRdygGhPj4CMg025OX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EB09DA7;
	Mon, 21 Oct 2024 01:01:58 -0700 (PDT)
Received: from [10.57.87.148] (unknown [10.57.87.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB05C3F71E;
	Mon, 21 Oct 2024 01:01:27 -0700 (PDT)
Message-ID: <218a79b3-8bf1-4a2a-a137-092920830b91@arm.com>
Date: Mon, 21 Oct 2024 09:01:25 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fgraph: Separate size of ret_stack from PAGE_SIZE
Content-Language: en-GB
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux trace kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
References: <20241019152951.053f9646@rorschach.local.home>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241019152951.053f9646@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/10/2024 20:29, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The ret_stack (shadow stack used by function graph infrastructure) is
> currently defined as PAGE_SIZE. But some architectures which have 64K
> PAGE_SIZE, this is way overkill. Also there's an effort to allow the
> PAGE_SIZE to be defined at boot up.
> 
> Hard code it for now to 4096. In the future, this size may change and even
> be dependent on specific architectures.
> 
> Link: https://lore.kernel.org/all/e5067bb8-0fcd-4739-9bca-0e872037d5a1@arm.com/
> 
> Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

LGTM!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

> ---
>  kernel/trace/fgraph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ee829d65f301..51e81b299a0d 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -153,7 +153,7 @@ enum {
>   * SHADOW_STACK_OFFSET:	The size in long words of the shadow stack
>   * SHADOW_STACK_MAX_OFFSET: The max offset of the stack for a new frame to be added
>   */
> -#define SHADOW_STACK_SIZE	(PAGE_SIZE)
> +#define SHADOW_STACK_SIZE	(4096)
>  #define SHADOW_STACK_OFFSET	(SHADOW_STACK_SIZE / sizeof(long))
>  /* Leave on a buffer at the end */
>  #define SHADOW_STACK_MAX_OFFSET				\

