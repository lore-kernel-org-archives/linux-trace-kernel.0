Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ADC41C6A;
	Fri, 20 Dec 2024 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734701868; cv=none; b=L6GI7rJvWVaNJlZ2S9pfJ7hGiP25E4GTIf1aqnGjtV7yTMDdCyE/y8o2g+hFF6ASQZbgb4CCvm1LPKqw/RWOSswHT0x+OmaiJhlLDcuDmVDpXD6idaUVjpy8IMuouGLhCcHD2VnKxtT/v+VIWBwK2K9uDGmDDa85/g5XULeBk/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734701868; c=relaxed/simple;
	bh=mbPQvlFQnvZSBnGj0hcRSgD7psVglKprnhvdqSyLHp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLl7MMC/ZfoLgpiFjhwy9uDGSIvKkJMKCjRjJUNPA9ls9FwLeAOWvq/IuTpDEzMyJnVtIJQSwfCu/QjlBFa4oOjNKogRxNVqwf4ovKxGr0x/QV6mxCrikZX4KcYdI0H8c1TdBBhVHMqPvMuRezDnW7RbFVro3rscylPoAEEXPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5727FC4CECD;
	Fri, 20 Dec 2024 13:37:47 +0000 (UTC)
Date: Fri, 20 Dec 2024 08:38:29 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [PATCH 08/14] tracing: Switch trace_events_trigger.c code over
 to use guard()
Message-ID: <20241220083829.1e1aa9d3@gandalf.local.home>
In-Reply-To: <20241219201345.860391310@goodmis.org>
References: <20241219201158.193821672@goodmis.org>
	<20241219201345.860391310@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 15:12:06 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> @@ -288,28 +280,22 @@ static ssize_t event_trigger_regex_write(struct file *file,
>  
>  	buf = memdup_user_nul(ubuf, cnt);
>  	if (IS_ERR(buf))
> -		return PTR_ERR(buf);
> +		return PTR_ERR(no_free_ptr(buf));
>  

I just realized that __free(kfree) is defined as:

  DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))

where it can handle IS_ERR(), so the above doesn't need that no_free_ptr(buf).

-- Steve
