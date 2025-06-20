Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5C4685;
	Fri, 20 Jun 2025 00:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750379439; cv=none; b=heqf7q/Gjd1cfHy0HYOBCnB2xZ/JNUKCp5hoXC1HoaaMI5xnnzNpximYxg7kP5Lxd5pMDf7sGXnGQ0LgZ2I8lGyiUgH1TfH93mTsXs2WwzCTQFgNUM+CsEEI+OH8LuoslBXetdMXja4LVRxW+Kupjz96hGGS7zjlUPeouMoJYuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750379439; c=relaxed/simple;
	bh=PhUQJujY6I6sVBSqIbFXKN242JF/UeWEaGrQxM3Pno8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jJ94jtiI0QvyTBpGBX3zTIrOkdP8oBtVMnB3ctByH7P8oaRqv3Wdratf64fQwrsMUvy9j4fWl1woC13SFSTHWidUdP1nfESSvrCccjRUQhkwmj4V8/UFE7qkslNh4WdarUoCaCrRXrnhQCxXHa/2aC0hYM8sNkR56g+EgEVvIrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVN3GPla; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVN3GPla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D464C4CEEA;
	Fri, 20 Jun 2025 00:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750379439;
	bh=PhUQJujY6I6sVBSqIbFXKN242JF/UeWEaGrQxM3Pno8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WVN3GPlagMQWxf+TWxsS4PQbsNn9FyC6kCn/D0h2G+dnP9Z2rlnUrOS3a35GaOX6I
	 s8O7BBt0oXebqBmRQSnEwb+9sOCxp23k1YSkGFcEPpmz83xlZ8HlKyJA5f/dnyVGqQ
	 zJeyw75cllPmdYGS7C2AQrS9f+ERudaL+n9OHpcawmupO5Mn1X0ZY+teMhHDSVBQz2
	 C+mLyUYCbGRiH9p4IiBW3syyeA4ivrHgnHU8KohA9WPmviv2mHyRI9uc7pLD15mSGk
	 6F8mhGDDD4n91B3fILJMGrRyxTUteA3LNdoBpWw/QWZJcbSifsO0x7vn9U+8qN/UvD
	 97dnFVe35FM4A==
Date: Fri, 20 Jun 2025 09:30:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Artem Sadovnikov <a.sadovnikov@ispras.ru>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH] fgraph: Make pid_str size match the comment
Message-Id: <20250620093030.3d2d11edf2c4c54c263eddd5@kernel.org>
In-Reply-To: <20250617152110.2530-1-a.sadovnikov@ispras.ru>
References: <20250617152110.2530-1-a.sadovnikov@ispras.ru>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 15:21:09 +0000
Artem Sadovnikov <a.sadovnikov@ispras.ru> wrote:

> The comment above buffer mentions sign, 10 bytes width for number and null
> terminator, but buffer itself isn't large enough to hold that much data.
> 
> This is a cosmetic change, since PID cannot be negative, other than -1.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Signed-off-by: Artem Sadovnikov <a.sadovnikov@ispras.ru>
> ---
>  kernel/trace/trace_functions_graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index a8c1f56340680..d789d308ab1de 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -344,7 +344,7 @@ static void print_graph_proc(struct trace_seq *s, pid_t pid)
>  {
>  	char comm[TASK_COMM_LEN];
>  	/* sign + log10(MAX_INT) + '\0' */
> -	char pid_str[11];
> +	char pid_str[12];
>  	int spaces = 0;
>  	int len;
>  	int i;
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
