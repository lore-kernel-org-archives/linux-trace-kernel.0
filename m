Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8683484A3B;
	Fri, 21 Jun 2024 08:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956862; cv=none; b=MF3xSjdjG7cqYli0u+jqu6rh9fZfqgiMvJa+kIU7A6NP+Kc5AKKLnKCo8MidXeyqafooo+izDZIjNWS4uA0q8+Eq5gq6PUi7sUD8x0x3tReq17NH+POJLYrjDoHC26/mwXZUe4C3AjVRglVopiu2FaG8Vy87xR88Th7sNlwGNys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956862; c=relaxed/simple;
	bh=79uHlnttJepyz6wjLqBHqDBH9rnuTEAmit5+JYFFtgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Pa6MEtDf5Ecijh+NHB4yDrUPD0am2bwGJDzFOs5vcf6iw454hDOm6rVHGAp97NewFDWeNeYPon1FiQq1f1hjub0uvhg/YnhDMVqFneIAJR8JcixUpINKo2kljwiArdvEh+GXNzM2j2fvrC8rZLPYZIBs2hZmUDE3l47JT4WDGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7l2ga2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7l2ga2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D97C4AF07;
	Fri, 21 Jun 2024 08:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718956862;
	bh=79uHlnttJepyz6wjLqBHqDBH9rnuTEAmit5+JYFFtgI=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=u7l2ga2OpM+1ELNAwlwCWVUVHmHa47s8I/9/KEB4vCZAvhSwWHWUqzdIFI6JGwYjP
	 j7W3fDOkdkiet4895wDHQf00kYB1BO9UgW8gw4t0PhlQ6biGCpxqcU/PBHY9kXvT9t
	 acoqyfgdhwxaAzMj3vITW9yOBUhdpjJaUx2FIe82tDnKWng7qU3Nq6bvi/9WrFISxD
	 UTwd3Zv2Ntq/7020K+hVyLEgSNgoxmb8FLQeW8hp2eoce2WInO/pvFqbfafwhChGG4
	 RUk9ply8M+T3hossQa9SSizJO4SPdIRrWCg+NktimMut0QrZrW38TLjsQ0imt2B8CG
	 RTN6I8Zd7DmEA==
Message-ID: <101b0854-7b39-486d-af63-4fe72566e8e1@kernel.org>
Date: Fri, 21 Jun 2024 10:00:52 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtla/osnoise: set the default threshold to 1us
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>
References: <Zmb-QhiiiI6jM9To@uudg.org>
Content-Language: en-US, pt-BR, it-IT
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <Zmb-QhiiiI6jM9To@uudg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Luis,

This is not rtla/osnoise but tracing/osnoise, so the Subject would be:

[PATCH] tracing/osnoise: Set the default threshold to 1 us

On 6/10/24 15:23, Luis Claudio R. Goncalves wrote:
> Change the default threshold for osnoise to 1us, so that any noise
> equal or above this value is recorded. Let the user set a higher
> threshold if necessary.

The reason why I place fear instead of one was "fear" of having the loop
taking more then one us, creating false noise notifications because of
execution time.

But it actually never happened, even on low speed arm boxes... Also,
all users I know are setting it to 1 on rtla... so I think it is safe to
move the value to 1.

Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>

> Suggested-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> Reviewed-by: Clark Williams <williams@redhat.com>
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
>  Documentation/trace/osnoise-tracer.rst | 2 +-
>  kernel/trace/trace_osnoise.c           | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
> index 140ef2533d26a..a520adbd34765 100644
> --- a/Documentation/trace/osnoise-tracer.rst
> +++ b/Documentation/trace/osnoise-tracer.rst
> @@ -108,7 +108,7 @@ The tracer has a set of options inside the osnoise directory, they are:
>     option.
>   - tracing_threshold: the minimum delta between two time() reads to be
>     considered as noise, in us. When set to 0, the default value will
> -   be used, which is currently 5 us.
> +   be used, which is currently 1 us.
>   - osnoise/options: a set of on/off options that can be enabled by
>     writing the option name to the file or disabled by writing the option
>     name preceded with the 'NO\_' prefix. For example, writing
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index a8e28f9b9271c..66a871553d4a1 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1444,9 +1444,9 @@ static int run_osnoise(void)
>  	save_osn_sample_stats(osn_var, &s);
>  
>  	/*
> -	 * if threshold is 0, use the default value of 5 us.
> +	 * if threshold is 0, use the default value of 1 us.
>  	 */
> -	threshold = tracing_thresh ? : 5000;
> +	threshold = tracing_thresh ? : 1000;
>  
>  	/*
>  	 * Apply PREEMPT and IRQ disabled options.

