Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794915065;
	b=TYP+r64OE0R1W9+X/+pWHGwrOhK0OSAkRrXGQUwyqYrqmOtwRNugCPfVqEsau/XgBzDw
	 9tgLIC1pdKelf+e7jhXXJHiBNjiXjyZ68DNos1l2qJSpo/sh6rsa4Taer6mQtw1NEPYW5
	 NS2gr0xjNd3QoJKSGEVQvVkPwIsfyCVCZD8SoreqwSmv+RPP3YWREeBS6DAt6Xkg6loKs
	 oBbD6/WpBgwgk+oOOXyCEmNbkDkKZP2wIdzgbgBRcCM3sI+3nWl+X1hu4DBwR9n/anuti
	 +iIQSybR0hT3X2QHxnq6f7VD93OlIg1fX1VrZf54hNYMGTNs7bpy0d6tGDnTsT8i34g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794915065;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cFiwaMcyT2NhQzY/X19yZaN2QhIktNOCHXJgqiZSLPs=;
	b=Z8H7Hs0Yy3PJ1zR3Q6v6JJdFXX8OMOxcgNzNpB3+W9zan9m5z09v3nO8g9CMgg9vD896
	 N9xxIqEnIQ/IXVD8QaR1is+kAamd+M+XqLy3UtbX0QmRVAO+f3JnXNRl4u9kHBzmZQN0x
	 WDlbyI89zt1KIsi3JqIkkYRNl6jAyfuOO6MAUEwuHwHrU86mCAUX3WuWuUVI7cD892za/
	 OLPbLwu3Vn9K0A4K0q9oKxVyiK1L6SmnGGs+GyeV5JALHxwxi0iMNVWquCrK6GyqSeDhB
	 bvJfXgY6W9aMRP9jEvUwSXkZnaZFZNmuEanResf+66TWkDb105Qvkk0tX+6gnW93Ssw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arrvKc5f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A7D606A32C;
	Tue, 17 Nov 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=arrvKc5f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D594F1F000C4;
	Tue, 17 Nov 2026 11:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794915065;
	bh=cFiwaMcyT2NhQzY/X19yZaN2QhIktNOCHXJgqiZSLPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=arrvKc5fGlsoWXWZpVbh3ZHSqdAXR/Mri4YTI4YbmiEJXdkhylgA7WNqWcMr5NPBv
	 daG6GHfKtO63wI79zpSW+RZuF9dP57uYKdE4COg4X3Uj1v/VAzO27PUZrRYkDGGLsW
	 V1YuXULqKZR1xGUtBcXKECMMH2yCtcwYZZHbd0yPvmr7s912ySkN/5JUejv1f175VF
	 tVJyqUOwlZ+ZwC2DJ9w4ofmYle4rNRD4So7yKto3tGWcEPN2P86sskgs6WlvWzH2d9
	 XYMA2AEJ9/lTve1ydLI3CSHLaS9Ca4oelCLHT9kWFY9QEkZdbAQFAUvW+WxjZxlaIt
	 RpZmc5QIqDQJw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, kernel-team@android.com, linux-kernel@vger.kernel.org, Kyuwon Cho <kyuwoncho18@gmail.com>
Subject: Re: [PATCH] tracing: Take trace_access_lock() in tracing_buffers_ioctl()
Date: Tue, 17 Nov 2026 20:31:01 +0900
Message-ID: <undine-1794915061850927775-e5dfd8cf943f5fce@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261117082932.3441173-1-vdonnefort@google.com>
References: <20261117082932.3441173-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 17 Nov 2026 08:29:32 +0000, Vincent Donnefort <vdonnefort@google.com> wrote:
> tracing_buffers_ioctl() calls ring_buffer_map_get_reader() without
> trace_access_lock, breaking concurrent readers. Take trace_access_lock()
> around ring_buffer_map_get_reader(), matching the other consuming
> readers.
> 
> Fixes: cf9f0f7c4c5b ("tracing: Allow user-space mapping of the ring-buffer")
> Reported-by: Kyuwon Cho <kyuwoncho18@gmail.com>
> Closes: https://lore.kernel.org/all/179485165154.2547186.6129837870360499372@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/trace/trace.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e8c4efa8107b..456fc388a31f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7404,8 +7404,12 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
>  				return err;
>  		}
>  
> -		return ring_buffer_map_get_reader(iter->array_buffer->buffer,
> -						  iter->cpu_file);
> +		trace_access_lock(iter->cpu_file);
> +		err = ring_buffer_map_get_reader(iter->array_buffer->buffer,
> +						 iter->cpu_file);
> +		trace_access_unlock(iter->cpu_file);
> +
> +		return err;
>  	} else if (cmd) {
>  		return -ENOTTY;
>  	}
> 
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> -- 
> 2.56.1.703.gf848ed807c-goog
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
