Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C91CEAB2;
	Fri,  4 Apr 2025 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743775055; cv=none; b=ZuIy0JEW1vBfqtUUviVQJYKa3OSRwHWUVrCutWFmd61kofSO3sXg2ql0oN7zrO9PvXni9v2U/79/4gojygKDfOJz2J/oQ6Sf3ZkQZ8WlBjmI66O9dTnL+5xxgRcxTAe/RdhoydgwN75kEd7dxrrKPKJQZZvWGpzpMjPL3Eyedsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743775055; c=relaxed/simple;
	bh=EueH0+geg0o8xfbZLaKXPspg9uCy9ptnxMntWR7/72g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hqtTJI4a2JXZzBORHdPVjrWVGOlV7wwAcFJeNnGBYmFPXClW+E0148/4Xgq0Rqup/n94Bz/k5wDgnD7SLylNsxjoNR+rwwFXeaSVE5PDz5hSoeZtWbFZzHWFqkHjBGulgHuvvEqgpKFKIk561nYW4nlVIjdSDbFSmCMQMKj+3eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D378C4CEDD;
	Fri,  4 Apr 2025 13:57:33 +0000 (UTC)
Date: Fri, 4 Apr 2025 09:58:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Move histogram trigger variables from stack to
 per CPU structure
Message-ID: <20250404095841.2cac7a47@gandalf.local.home>
In-Reply-To: <20250403204251.0164a4cf@gandalf.local.home>
References: <20250403204251.0164a4cf@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Apr 2025 20:42:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> +static struct hist_pad *get_hist_pad(void)
> +{
> +	struct hist_pad *hist_pad;
> +	int cnt;
> +
> +	preempt_disable();
> +	hist_pad = per_cpu_ptr(hist_pads, smp_processor_id());
> +	if (!hist_pad)
> +		goto out_fail;

Hmm, this is incorrect. hist_pads can be NULL or allocated, so the check
should be:

	if (!hist_pads)
		goto fail;
	hist_pad = per_cpu_ptr(hist_pads, smp_processor_id());

Will send v2.

-- Steve


> +
> +	if (this_cpu_read(hist_pad_cnt) == MAX_HIST_CNT)
> +		goto out_fail;
> +
> +	cnt = this_cpu_inc_return(hist_pad_cnt) - 1;
> +
> +	return &hist_pad[cnt];
> +
