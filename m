Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F06838DD4;
	Thu,  6 Jun 2024 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717696553; cv=none; b=DIyf1GGhDBjEjv/KY9GJQWVxh4gueyHW1s0/qqF20TvkDbtBx+x42nX0Vg77FImYh81bboaZOaVGEUDT8Hmu9Ca/+hVJ9dM5n90S3O6D7DnYu4qCjpRTxUn4vDV1oLzudwhw6vgBZ+5eUgI8xqi3uLpom4iI15sdtGMHg0F5lnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717696553; c=relaxed/simple;
	bh=+aZc9JlPoYcncM6b/nb2pxrsKL/yaLWWvwkEqCj8ZLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKeg0or77RL4R1qpBKLFCvapQi7S+aHpJ9Monc2ohyF7F9xUsDYtJL6aZ3ANWXZIi60xjbMAFkH8XPzunB6DHpxQy0dTbAwgyoHXoQG9ANl7r2g5R5ps637edEY3zD+3eFYqyfZ8P8UyBAgb5FYh7/OJdpF3s+/aeBprmiHLxlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1FFB2F4;
	Thu,  6 Jun 2024 10:56:15 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 679513F64C;
	Thu,  6 Jun 2024 10:55:50 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:55:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 4/5] ftrace: Convert "inc" parameter to bool in
 ftrace_hash_rec_update_modify()
Message-ID: <ZmH4I77DrXQZqpe6@J2N7QTR9R3.cambridge.arm.com>
References: <20240605180334.090848865@goodmis.org>
 <20240605180409.021080462@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605180409.021080462@goodmis.org>

On Wed, Jun 05, 2024 at 02:03:38PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The parameter "inc" in the function ftrace_hash_rec_update_modify() is
> boolean. Change it to be such.
> 
> Also add documentation to what the function does.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  kernel/trace/ftrace.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 1a2444199740..83f23f8fc26d 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1882,7 +1882,24 @@ static bool ftrace_hash_rec_enable(struct ftrace_ops *ops)
>  	return __ftrace_hash_rec_update(ops, true);
>  }
>  
> -static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, int inc)
> +/*
> + * This function will update what functions @ops traces when its filter
> + * changes.
> + *
> + * The @inc states if the @ops callbacks are going to be added or removed.
> + * When one of the @ops hashes are updated to a "new_hash" the dyn_ftrace
> + * records are update via:
> + *
> + * ftrace_hash_rec_disable_modify(ops);
> + * ops->hash = new_hash
> + * ftrace_hash_rec_enable_modify(ops);
> + *
> + * Where the @ops is removed from all the records it is tracing using
> + * its old hash. The @ops hash is updated to the new hash, and then
> + * the @ops is added back to the records so that it is tracing all
> + * the new functions.
> + */
> +static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, bool inc)
>  {
>  	struct ftrace_ops *op;
>  
> @@ -1906,12 +1923,12 @@ static void ftrace_hash_rec_update_modify(struct ftrace_ops *ops, int inc)
>  
>  static void ftrace_hash_rec_disable_modify(struct ftrace_ops *ops)
>  {
> -	ftrace_hash_rec_update_modify(ops, 0);
> +	ftrace_hash_rec_update_modify(ops, false);
>  }
>  
>  static void ftrace_hash_rec_enable_modify(struct ftrace_ops *ops)
>  {
> -	ftrace_hash_rec_update_modify(ops, 1);
> +	ftrace_hash_rec_update_modify(ops, true);
>  }
>  
>  /*
> -- 
> 2.43.0
> 
> 
