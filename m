Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAEB1487F6;
	Wed, 14 May 2025 20:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747254511; cv=none; b=IEgveac6JBE1NVmIzeWMKc2UVClC16rvHYbB4K9QsRx9N68ur6HUF0kFTs0oj5x5VdEJAR8tmFUQZZrfG8WIxsu/+WCYszOCk/9VXDOSytPNxZQ9TdKS3sNyfZR4zqPqZ8xSpj8DnZ40Es5FRTf9Dd1OqxX51WKekgBn8h5mrxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747254511; c=relaxed/simple;
	bh=p4O3d8Z4/Z4owD/WPv6OUNS8/hMMidt47hnYPaQYdn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szT985F+Ru6vBkMM8gW3ICpFM63Iuj8S8I+doTD3jCDUSZUNlQVpJKh2jgsF+1Lo1SeYrN7tAcvnXKrNni4j1qs+d9uLoDwXeHrM18+0Lp6dhwgBSEyMyioU8kOxLclrVof2SX118ahTQUwjVtjtcDq6TF1j09mFGO3c2ycUJAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7051AC4CEE3;
	Wed, 14 May 2025 20:28:30 +0000 (UTC)
Date: Wed, 14 May 2025 16:28:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Devaansh Kumar <devaanshk840@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] tracing: Replace deprecated strncpy() with strscpy()
 for string keys in hist triggers
Message-ID: <20250514162857.4a3f846a@gandalf.local.home>
In-Reply-To: <20250514201956.1447439-1-devaanshk840@gmail.com>
References: <20250514201956.1447439-1-devaanshk840@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 01:49:55 +0530
Devaansh Kumar <devaanshk840@gmail.com> wrote:

> strncpy() is deprecated for NUL-terminated destination buffers and must
> be replaced by strscpy().
> 
> See issue: https://github.com/KSPP/linux/issues/90
> 
> Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 1260c23cfa5f..90a4e486fba8 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5225,7 +5225,7 @@ static inline void add_to_key(char *compound_key, void *key,
>  		if (size > key_field->size - 1)
>  			size = key_field->size - 1;
>  
> -		strncpy(compound_key + key_field->offset, (char *)key, size);
> +		strscpy(compound_key + key_field->offset, (char *)key, size);
>  	} else
>  		memcpy(compound_key + key_field->offset, key, size);
>  }

Incorrect, and this is already fixed in next (at least it's in my ftrace/for-next branch).

  https://lore.kernel.org/20250403210637.1c477d4a@gandalf.local.home

-- Steve
