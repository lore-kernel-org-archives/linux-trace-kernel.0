Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E87374E67;
	Thu, 21 May 2026 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331891; cv=none; b=cLFO7uDilHSFXsgJQqVbk9+ANPLW20lp29zZ3hKIxdbwS7PWexkT20DiX60FUxuf/nGqpqK5MbS3ws9LTdQu7YvX6WeTP2MfWVoZ15Nh3kEW5h9Wqp0T3NdkFcxNWks8matMsDWk5XokcsqrndUUPfKJuLinsLnniJwvAnkdYPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331891; c=relaxed/simple;
	bh=Dk7tKFqFR0bOJ0A2KWuN5Qks9i1ELzRqHA9E01VTj2I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KQWttRuVu+CZnEycTidYyfJ4AQw3zJOJg5qJlUXwxGufrjhXkiSrZ1hIonocS2Vw3HogGIEZRQBM1lG17BGkIYt0o+UF+I1YN8HW+3mR7uE3KeNABozqxT9BgUSVmxcXU5TdAZNMbV7qV6P5rhbpak8AdQSIFgzwWL+hfaHM/Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsD1BcIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsD1BcIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7F61F000E9;
	Thu, 21 May 2026 02:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779331889;
	bh=/Yr+j+Nu0sbcfnd1kwq6WhvoU5572MezfD5IaIMJcbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bsD1BcIOHQR7RULoKHwI9PLlNWuG1JCAfGvgYCy6+PEMc/eS18nRvnyTqpjWXFW8o
	 DYEYpgZHuH6wX0sDnl8C+QMNEHOWV3ZeS4YgY5c4b3wKVOdjSF+ODOGO+O00LqmKkg
	 xRPNHnA4cmutp4yn8+tG7gCjRUat2cjJuRZlh0lYzxuuxgoa+RT8jl0s3njuryjW3e
	 jyQT8dl34Dw+N1TKIgOcV4jL2wSXmK/v7u7vl6sTpQE3wFD0b0QOmr8qi0SFuSo6O+
	 sNgbVdUF5Fevtcg7y3MAxvLKgyuZPIKKxjgodUohU8UZz6HxLhWLHj4USyZIhWxpDh
	 NLwWsgnwEZMXw==
Date: Thu, 21 May 2026 11:51:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: Re: [PATCH v20 07/10] ring-buffer: Skip invalid sub-buffers for
 iterator
Message-Id: <20260521115125.a2a1d90c5913bd4d27cb9107@kernel.org>
In-Reply-To: <20260520185018.051228084@kernel.org>
References: <20260520184938.749337513@kernel.org>
	<20260520185018.051228084@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 14:49:45 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> On bootup if the persistent ring buffer finds an invalid sub-buffer, it
> only invalidates the invalid sub-buffer and continues. Several sub-buffers
> may be invalid and this can cause the iterator to loop more than 3 times
> looking for a new event. If that happens, then it returns NULL. Having a
> NULL return early can confuse the iterator looking for the next event, and
> may show events out of order.
> 
> Have the same logic for the consuming read for the iterator that will
> allow the loop to find the next event to happen the number of sub-buffers
> and not just 3.
> 
> Fixes: **TBD** ring-buffer: Skip invalid sub-buffers when validating persistent ring buffer
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Should we merge this into the original one?

Anyway, this looks good to me.

Thanks,

> ---
>  kernel/trace/ring_buffer.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c6c2f92bfc24..bda53a2d2159 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -6103,12 +6103,14 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	struct ring_buffer_event *event;
>  	int nr_loops = 0;
> +	int max_loops;
>  
>  	if (ts)
>  		*ts = 0;
>  
>  	cpu_buffer = iter->cpu_buffer;
>  	buffer = cpu_buffer->buffer;
> +	max_loops = cpu_buffer->ring_meta ? cpu_buffer->nr_pages : 3;
>  
>  	/*
>  	 * Check if someone performed a consuming read to the buffer
> @@ -6131,7 +6133,7 @@ rb_iter_peek(struct ring_buffer_iter *iter, u64 *ts)
>  	 * the ring buffer with an active write as the consumer is.
>  	 * Do not warn if the three failures is reached.
>  	 */
> -	if (++nr_loops > 3)
> +	if (++nr_loops > max_loops)
>  		return NULL;
>  
>  	if (rb_per_cpu_empty(cpu_buffer))
> -- 
> 2.53.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
