Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF71925BA;
	Mon, 30 Sep 2024 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709226; cv=none; b=aZi4thn+o8BkdUQh/3VooAKFkM3bZcDgIT05gBj6n0Yz+aYIi5mkUgEiUpUP1LM+yAJ9LybyelTblHh4meHFniCRmH9Z72bbYWMyf7OQ5dAerluYp1r/ag/Yn4SEUYtAyc5SrJj+lGuJ/txPub5+d9RcZyY1cVCjRt7HVZWYVs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709226; c=relaxed/simple;
	bh=RDP2U68GmCbPNeAGJnywMv/85tTjdNQU66ywoXQfA00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNW8+W4wWmMoDAllD31QJdAbnhoEM0eY6EoZE7nnLrTERPtGjyIyvC3PXUhoSDc0aYS/28yIwuIUjB6wIYj3zg9FueE86bsh+4KMWwt5PiPkhsWmnC6xdWonMX07MopiieTbG/KuB6H0OLmmkQWoOOGHPH6C5l96tPeJHV5HA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB763C4CEC7;
	Mon, 30 Sep 2024 15:13:44 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:14:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 21/35] ring-buffer: Reorganize kerneldoc parameter names
Message-ID: <20240930111431.258b72d1@gandalf.local.home>
In-Reply-To: <20240930112121.95324-22-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
	<20240930112121.95324-22-Julia.Lawall@inria.fr>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 13:21:07 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> 
> ---
>  kernel/trace/ring_buffer.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 77dc0b25140e..313dffbdeef1 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2384,9 +2384,9 @@ EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
>   * __ring_buffer_alloc_range - allocate a new ring_buffer from existing memory
>   * @size: the size in bytes per cpu that is needed.
>   * @flags: attributes to set for the ring buffer.
> + * @order: sub-buffer order
>   * @start: start of allocated range
>   * @range_size: size of allocated range
> - * @order: sub-buffer order
>   * @key: ring buffer reader_lock_key.
>   *
>   * Currently the only flag that is available is the RB_FL_OVERWRITE

