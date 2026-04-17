Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C3D25E469;
	Fri, 17 Apr 2026 01:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776390279; cv=none; b=nDzJL+Dog1dU7rn8XFJXcmrXgJ3FyKHAvJvC/mqN1haa/j8TodXhtWAe1WRFKTxGgsN5o/i/MI4E+bynx5QmqfcrY8KnD1PHg0pxGqbTtd2+dtNqK6+02oCrAnXN0pmUZUsIIf7AxpgiWjJdSHzRT7AG1rVWWwbs41ve219YNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776390279; c=relaxed/simple;
	bh=aPpqYZ6wa2JGgq/5yZ8HWAy7XD4fYiLYSVf6EHgEcqk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=M9KcHhdOsHw+8CJ7jJ0dT0pmihW8wtaeodmf1Q+Vy9IRLoJfyQUOLXUIwEFRnEo19sEmQpCLx/M2t423ZBtYpzYD2nIkvtw/Crs+ldynkaFXxlEWXPMA4hzwFG901JeKhoRbSOFpMVVMJ0rrXsX56U23BMeUICRysy0x5rNpKwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+yWEF5i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+yWEF5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57682C2BCAF;
	Fri, 17 Apr 2026 01:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776390279;
	bh=aPpqYZ6wa2JGgq/5yZ8HWAy7XD4fYiLYSVf6EHgEcqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X+yWEF5iykhozQFcXWnTq6i/sgY85XwWu1OVEpgPFLX2AvpV2P2Gt6u122PeyP6bu
	 ihxrdBGM+ZJqQqh8Q2pwrjFKmzewssJYicaZEJvtvvU431hmcsoOAPEDfW6cnLlL8h
	 a+D1LkIvPmHdaV0SS6JzxoghUMXoJcSVdmNWf5va8Qfm69WX021SgPCtNdcSgp4esb
	 QZDjWkI2eudcnilQ3Btkzc2r3V4SXVbFvHhqp04ELSFPbdXgTZkRI3Ox4TDrmTKoe0
	 xRIBNaaQTZ+x6Puo1RuZbCHu7f29qiJSkOQRTvdjQPxLMEVHeF1Mnev4y7+cbG4ALH
	 mjy8xs0Wjq0qg==
Date: Fri, 17 Apr 2026 10:44:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, oss@malat.biz,
 paulmck@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/3] init: use static buffers for bootconfig extra
 command line
Message-Id: <20260417104436.ece29fd5e2cb7a59c8cf8ac1@kernel.org>
In-Reply-To: <20260415-bootconfig_earlier-v1-2-cf160175de5e@debian.org>
References: <20260415-bootconfig_earlier-v1-0-cf160175de5e@debian.org>
	<20260415-bootconfig_earlier-v1-2-cf160175de5e@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Apr 2026 03:51:11 -0700
Breno Leitao <leitao@debian.org> wrote:

> Replace memblock_alloc/memblock_free in xbc_make_cmdline() with
> static __initdata buffers. This removes the last memblock dependency
> from the bootconfig loading path, completing the prerequisite for
> running bootconfig parsing before memblock is available.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  init/main.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 96f93bb06c490..b9feca55e01f9 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -369,11 +369,18 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
>  }
>  #undef rest
>  
> +/*
> + * Static buffers for bootconfig-generated command line parameters.
> + * Two separate buffers are needed because both "kernel" and "init"
> + * parameters are stored simultaneously.
> + */
> +static char extra_cmdline_buf[COMMAND_LINE_SIZE] __initdata;
> +static char extra_initargs_buf[COMMAND_LINE_SIZE] __initdata;

This is not good to me, since bootconfig supports bigger config file
than COMMAND_LINE_SIZE. Even if we limits the size for embedded
bootconfig file, it should depends on CONFIG_BOOT_CONFIG_EMBED.

Please use XBC_DATA_MAX instead of COMMAND_LINE_SIZE, or calculate
expected data length when compiling kernel.

But if we can do it, should we continue using bootconfig? I mean
it is easy to make a tool (or add a feature in tools/bootconfig)
which converts bootconfig file to command line string and embeds
it in the kernel. Hmm.

Thanks,

> +
>  /* Make an extra command line under given key word */
> -static char * __init xbc_make_cmdline(const char *key)
> +static char * __init xbc_make_cmdline(const char *key, char *new_cmdline)
>  {
>  	struct xbc_node *root;
> -	char *new_cmdline;
>  	int ret, len = 0;
>  
>  	root = xbc_find_node(key);
> @@ -382,19 +389,12 @@ static char * __init xbc_make_cmdline(const char *key)
>  
>  	/* Count required buffer size */
>  	len = xbc_snprint_cmdline(NULL, 0, root);
> -	if (len <= 0)
> +	if (len <= 0 || len >= COMMAND_LINE_SIZE)
>  		return NULL;
>  
> -	new_cmdline = memblock_alloc(len + 1, SMP_CACHE_BYTES);
> -	if (!new_cmdline) {
> -		pr_err("Failed to allocate memory for extra kernel cmdline.\n");
> -		return NULL;
> -	}
> -
>  	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
>  	if (ret < 0 || ret > len) {
>  		pr_err("Failed to print extra kernel cmdline.\n");
> -		memblock_free(new_cmdline, len + 1);
>  		return NULL;
>  	}
>  
> @@ -467,9 +467,9 @@ static void __init setup_boot_config(void)
>  		xbc_get_info(&ret, NULL);
>  		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
>  		/* keys starting with "kernel." are passed via cmdline */
> -		extra_command_line = xbc_make_cmdline("kernel");
> +		extra_command_line = xbc_make_cmdline("kernel", extra_cmdline_buf);
>  		/* Also, "init." keys are init arguments */
> -		extra_init_args = xbc_make_cmdline("init");
> +		extra_init_args = xbc_make_cmdline("init", extra_initargs_buf);
>  	}
>  	return;
>  }
> 
> -- 
> 2.52.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
