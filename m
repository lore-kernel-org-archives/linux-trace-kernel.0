Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA8A26B777;
	Wed, 18 Feb 2026 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771402427; cv=none; b=vCybJiaqsRN57mM7p9XS4Ri8QBSV8GIk4PTkUm7WGKBz5aWpN8blZ9j5dMBsVumxdA/TNfXjkpdex8AzPcCAE0vz92/n8jGNBvYNrNEOCSfPhk0Is9F5BAvwQq0tjmFDBn84VuI6C2jhvkTfJRx6kdc1/ccmng4a9qu385tVSaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771402427; c=relaxed/simple;
	bh=CZAjJSnAhnZ0NIcbulITgJS+qmIYTno1laQEW2qBDm4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P+YEE7uRIyfxfHRdi0Dt7//M4OcOEcdSRhxr85zb3a1cxbHViQbk9F8rcZY239+gbYAQiko5KNKa7nipa776CkwMjejwHzFxrboaVNKTfwx1DguFK7Pso0Cwm5e/tMIsr+OfiVyMx90jlH+P/G7Wh2CkZDHYV9ygvZF8sL7lWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkcBQ1YY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkcBQ1YY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F72C19421;
	Wed, 18 Feb 2026 08:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771402426;
	bh=CZAjJSnAhnZ0NIcbulITgJS+qmIYTno1laQEW2qBDm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HkcBQ1YYFgjyD74bn1XIQix3nMeAxbTzmLru/jGCWp53wWumB2uEQhs1QFNxocvzd
	 4qRXMj5AInJrMHWh/jtSlbu1T573/jIcZ0/kBvpI/WSoldmg8M3bBmlHoJCjZQKide
	 6PDfRGMG2OYFajyLPdMUEt3wwbCCQJrk0XbiFUVas/YqNDew7wPFq91IynYc+QPga4
	 310LAMx7vXjYdKupCYGSrt1AXqYFBAJeqtI0Oc1eIJIWy6C/cV9foojogKkGZjo+Z5
	 /JUDcHlmsMbb9oHwmkHu0E8jpgkLa62RKpQC0S2Nm9DKPM8NbG9704Y+VKA2K1l+ky
	 eK1mqK6mAnh9g==
Date: Wed, 18 Feb 2026 17:13:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: ring-buffer: Fix to check event length before
 using
Message-Id: <20260218171344.85677f1bd5494a3a728acfdd@kernel.org>
In-Reply-To: <177123421541.142205.9414352170164678966.stgit@devnote2>
References: <177123421541.142205.9414352170164678966.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I found another problem. Let me make a series for fixing issues.

Thanks,

On Mon, 16 Feb 2026 18:30:15 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Check the event length before adding it for accessing next index in
> rb_read_data_buffer(). Since this function is used for validating
> possibly broken ring buffers, the length of the event could be broken.
> In that case, the new event (e + len) can point a wrong address.
> To avoid invalid memory access at boot, check whether the length of
> each event is in the possible range before using it.
> 
> Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/ring_buffer.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 630221b00838..1ef17d6fd824 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1848,6 +1848,7 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
>  	struct ring_buffer_event *event;
>  	u64 ts, delta;
>  	int events = 0;
> +	int len;
>  	int e;
>  
>  	*delta_ptr = 0;
> @@ -1855,9 +1856,12 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
>  
>  	ts = dpage->time_stamp;
>  
> -	for (e = 0; e < tail; e += rb_event_length(event)) {
> +	for (e = 0; e < tail; e += len) {
>  
>  		event = (struct ring_buffer_event *)(dpage->data + e);
> +		len = rb_event_length(event);
> +		if (len <= 0 || len > tail - e)
> +			return -1;
>  
>  		switch (event->type_len) {
>  
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
