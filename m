Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0DB209698;
	Tue, 12 Nov 2024 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731445951; cv=none; b=FqkvrQr1fY60IN23GHz7o+TFfbDcZkT0cDwSUPYQHB0cI58DIodFgWOQ21pA9YUncF/f0Bm3TNYI9SXTfEpuhSkDlK6RixSqC60miqSAVp0snsGhPSEyvX2sjRRNr5X/AxMNnzevTp0Lb2JfvFe54/L77nBmLeXtbHs4HVlZB5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731445951; c=relaxed/simple;
	bh=7rOV68yhx3dvrMEB5tATmto7afNkLWcDEhR60GGt3ec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fd1Ltg5Ez3twaeXJrOjND04C0TvmLY4E8KvKxOy+hPDTwK3aQXToLKu/UzXuRJueX4PRPEteMIEiK2HPeR6lm1Zt0dtE/Xr2dsr3/ic3h/JH0kXVmupHXxp61Z9sBneuJitQq40PqIlfWoR5mSF6AQqqAN7bKKBuYx6nznru4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B18C4CECD;
	Tue, 12 Nov 2024 21:12:30 +0000 (UTC)
Date: Tue, 12 Nov 2024 16:12:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Yang <danielyangkang@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org (open
 list:TRACING), linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: Re: [PATCH] set_cmdline: replace fragile/deprecated strncpy with
 strscpy
Message-ID: <20241112161248.0fbdc802@gandalf.local.home>
In-Reply-To: <20241105072007.426782-1-danielyangkang@gmail.com>
References: <20241105072007.426782-1-danielyangkang@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 23:20:07 -0800
Daniel Yang <danielyangkang@gmail.com> wrote:

> Kernel docs identify strncpy as being fragile and ambiguous. Replaced
> strncpy with strscpy so dest str is null terminated and not padded.
> 

Already been updated:

https://lore.kernel.org/linux-trace-kernel/20241031120139.1343025-1-ruanjinjie@huawei.com/

-- Steve

> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> ---
>  kernel/trace/trace_sched_switch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
> index 8a407adb0..573b5d8e8 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -187,7 +187,7 @@ static inline char *get_saved_cmdlines(int idx)
>  
>  static inline void set_cmdline(int idx, const char *cmdline)
>  {
> -	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
> +	strscpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
>  }
>  
>  static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)

