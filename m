Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085A7197A8F;
	Thu,  6 Jun 2024 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696588; cv=none; b=L5o1uPiTrSgVmfhx11aKSzjkOYqnFQ19NlPmzv8sh+IjppborJhu+DkiK6g5M5eMJFwGA7CCddIsAFuJ0GEnEyTfG1yprM5X5OCX+QXtSZMW6LEhADjPPG6WAND/oeNVooYo81ojByuOCmuoTnydN8/qwD/M3oyRgCn8VyBtja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696588; c=relaxed/simple;
	bh=f95TZ836Ou9FDPwMEm5IByJ1EjN0UoHTi7twP5cFKMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyTPwHfUVjLV0uuXs80v/0TTAj9lKV2ZETBmKI8pNxlpj1Xzqk/8QmXZtT13N0xjTQu7fkaNc9oq3zYSurQf/dV0H0B5oAnj/wbe0nUSxelIKmJSGZx393XyPPrjxqNY5oarF4uXBx12rkbWcjFUQgQXuBllbAxTeEEqb8M1ukc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0329A2F4;
	Thu,  6 Jun 2024 10:56:51 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F4483F64C;
	Thu,  6 Jun 2024 10:56:25 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:56:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 5/5] ftrace: Add comments to ftrace_hash_move() and
 friends
Message-ID: <ZmH4Rz9yAzVl3MVH@J2N7QTR9R3.cambridge.arm.com>
References: <20240605180334.090848865@goodmis.org>
 <20240605180409.179520305@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605180409.179520305@goodmis.org>

On Wed, Jun 05, 2024 at 02:03:39PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> Describe what ftrace_hash_move() does and add some more comments to some
> other functions to make it easier to understand.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/trace/ftrace.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 83f23f8fc26d..ae1603e771c5 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -169,6 +169,7 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
>  #endif
>  }
>  
> +/* Call this function for when a callback filters on set_ftrace_pid */
>  static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
>  			    struct ftrace_ops *op, struct ftrace_regs *fregs)
>  {
> @@ -1317,7 +1318,7 @@ static struct ftrace_hash *alloc_ftrace_hash(int size_bits)
>  	return hash;
>  }
>  
> -
> +/* Used to save filters on functions for modules not loaded yet */
>  static int ftrace_add_mod(struct trace_array *tr,
>  			  const char *func, const char *module,
>  			  int enable)
> @@ -1429,6 +1430,7 @@ static struct ftrace_hash *__move_hash(struct ftrace_hash *src, int size)
>  	return new_hash;
>  }
>  
> +/* Move the @src entries to a newly allocated hash */
>  static struct ftrace_hash *
>  __ftrace_hash_move(struct ftrace_hash *src)
>  {
> @@ -1443,6 +1445,26 @@ __ftrace_hash_move(struct ftrace_hash *src)
>  	return __move_hash(src, size);
>  }
>  
> +/**
> + * ftrace_hash_move - move a new hash to a filter and do updates
> + * @ops: The ops with the hash that @dst points to
> + * @enable: True if for the filter hash, false for the notrace hash
> + * @dst: Points to the @ops hash that should be updated
> + * @src: The hash to update @dst with
> + *
> + * This is called when an ftrace_ops hash is being updated and the
> + * the kernel needs to reflect this. Note, this only updates the kernel
> + * function callbacks if the @ops is enabled (not to be confused with
> + * @enable above). If the @ops is enabled, its hash determines what
> + * callbacks get called. This function gets called when the @ops hash
> + * is updated and it requires new callbacks.
> + *
> + * On success the elements of @src is moved to @dst, and @dst is updated
> + * properly, as well as the functions determined by the @ops hashes
> + * are now calling the @ops callback function.
> + *
> + * Regardless of return type, @src should be freed with free_ftrace_hash().
> + */
>  static int
>  ftrace_hash_move(struct ftrace_ops *ops, int enable,
>  		 struct ftrace_hash **dst, struct ftrace_hash *src)
> -- 
> 2.43.0
> 
> 
