Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79653BCD01;
	Wed, 20 May 2026 22:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779316945; cv=none; b=YFwULeUjSm5X6ihrZM7VKZ3VLqIzxrmxrGZIo4wZdWqwvaUKbB+e7L52+ZbVtGu/1jT/AGa62QvTcdpapqJLji1ou0YJWkwnzeUZteCVffBrYXgbAHofzaf/wyplOO4k6dD4xLu7fJZTa6SE0P60xoDmeVTO6vOPnBrylvnrXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779316945; c=relaxed/simple;
	bh=XcrevRWHrMEpSQrTLpGvf1Z5bTsfvxftTAIHSrO/ie4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCGu3QZYeTKye4saNSwpJw929vcwBhQ3mmRdu5ziUkpMkohKZ+X8opmopw2HGjrzjJxvv6zMGuBvkU18c/a/QzDGMNso57nOuEBI9+2s3a2oYi73EahJYLY23MKTzovZZxiYmuGRHnMiKpXGwuwBgCvlghBSzSmGt9CHYIy34e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnyWUsVB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnyWUsVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7459D1F00A39;
	Wed, 20 May 2026 22:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779316944;
	bh=3fUlzy/+2nrv0Gc7n85Bt/0f4zwepikT9hrknENYJmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SnyWUsVBGtgd8H4wKL1/myN/eIgage2CTpFdPSLjsuzTsvN6ZVdy4OY/ti5WTqMUa
	 YC10Z9lF4+LYSRP0SoKgE8zQ3ocSw3b48bqVIPTLU7wUK+opIuRikfFcArSQgckWtc
	 xSofe6Xb9AXAZuVBwdeeFQxVgekqunh3JO/va0wU4E1zEISxPiVePkxqZZVPAnxGhA
	 c1+H61iinnair0ZlIK48BAD5u9ZEtNQFIo5GENF++Z3/Gi068w5oVMlfKbmuzT9mx3
	 uSvtIDF5qNWuSMhrOcexYGnpxZCibettinnz55mT5XL/i91g8+b+L/S+1GfBQ1XeOF
	 cYJcntaoWcAEg==
Date: Wed, 20 May 2026 15:42:19 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Create output file from cmd_check_undefined
Message-ID: <20260520224219.GC1607511@ax162>
References: <20260520-tracing-ringbuffer-check-v1-1-d979cfab1338@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520-tracing-ringbuffer-check-v1-1-d979cfab1338@weissschuh.net>

On Wed, May 20, 2026 at 08:01:55PM +0200, Thomas Weiﬂschuh wrote:
> As the output file is currently never created, the check will run every
> time, even if the inputs have not changed.
> 
> Create an empty output file which allows make to skip the execution when
> it is not necessary.
> 
> Fixes: 1211907ac0b5 ("tracing: Generate undef symbols allowlist for simple_ring_buffer")
> Fixes: 58b4bd18390e ("tracing: Adjust cmd_check_undefined to show unexpected undefined symbols")
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  kernel/trace/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 1decdce8cbef..b5797457f9f4 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -154,7 +154,8 @@ quiet_cmd_check_undefined = NM      $<
>                echo "Unexpected symbols in $<:" >&2; \
>                echo "$$undefsyms" >&2; \
>                false; \
> -          fi
> +          fi; \
> +          touch $@
>  
>  $(obj)/%.o.checked: $(obj)/%.o $(obj)/undefsyms_base.o FORCE
>  	$(call if_changed,check_undefined)
> 
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260520-tracing-ringbuffer-check-3a6e748d37b7
> 
> Best regards,
> --  
> Thomas Weiﬂschuh <linux@weissschuh.net>
> 

-- 
Cheers,
Nathan
