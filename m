Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5E390983;
	Tue, 24 Mar 2026 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774366702; cv=none; b=II+aZzreisUSC2oh2Ve0vRNLp54LB9JYzgomVYoex08dOnoMp/JymWOrCMl91lD4YSjusA2n53oNTektamBY3TkUtqaITKauGObAfpQexxTm9ofQ2eZbubc53tVGV0Q5fPC0RY9S9Im/YEVgX3pWuAfmbgSWIwGCd5W+NvvAvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774366702; c=relaxed/simple;
	bh=j3EzsSALfxwk9wPQbcSXHk2QexvSXxMd1TAMhav0qJ8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j3Kxb1tuls75Q1PAzHvXbA1K9kUsVxrsXVSoZHk0lzDMEfEqTkib5PLqUp5O0H504XkH+9+n+9zZiIYufpQDag2qAbQV6DechG4I852wk3vr+/9kumlBeNMJLvDTrXA6+KQ4WWO2YijiGZLCv8wY7uXrqdNfgYOKhJl2iwd6Bao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhOQkWzW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhOQkWzW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B392FC19424;
	Tue, 24 Mar 2026 15:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774366702;
	bh=j3EzsSALfxwk9wPQbcSXHk2QexvSXxMd1TAMhav0qJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhOQkWzWWLuVrxZZIkyr3JCqXp/BBo4evWGiTqWSxEbjB1+329LUmWM5F+WjTTQxw
	 IXGCwWQKKPwT6zIvf+18yA5N+9GTtcMbdJLwlrF7TSN93FUYhEcb70riTmVsSYp+7M
	 Iszn1tEf4CD9xxGmVH6RZ7Z6rrhyR+vu2KtPrE35JOgBqMdp2euaso4LCWLJbZXlkx
	 2hNkVfSUTLvg1PriJGNFMPXYqyM7+ncmzIku8MhSVP2Ejyvwk512pLXyEChEN2hH6Q
	 V99CNDDYn7/pY3u7zSV2+PaiGq5X+Ei0B3e0hDXQGQ8XJbJvyvw5/ik9GrEH+XVYzp
	 HMOzRxDWBqtKA==
Date: Wed, 25 Mar 2026 00:38:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org,
 kernel-team@meta.com
Subject: Re: [PATCH] bootconfig: Apply early options from embedded config
Message-Id: <20260325003817.c3c2aee509b4048d4c5c786e@kernel.org>
In-Reply-To: <20260324-early_bootconfig-v1-1-1c0e625aff06@debian.org>
References: <20260324-early_bootconfig-v1-1-1c0e625aff06@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 05:52:33 -0700
Breno Leitao <leitao@debian.org> wrote:

> Right not is impossible to set early parameters in bootconfig, which
> limits the usage of bootconfig to some critical parameters.
> 
> Add bootconfig_apply_early_params() which walks all kernel.* keys in the
> parsed XBC tree and calls do_early_param() for each one. It is called
> from setup_boot_config() immediately after a successful xbc_init() on
> the embedded data, which happens before parse_early_param() runs in
> start_kernel().
> 
> This allows early options such as:
> 
>   kernel.mitigations = off
>   kernel.irqchip.gicv3_pseudo_nmi = 1
> 
> to be placed in the embedded bootconfig and take effect, without
> requiring them to be on the kernel command line.
> 
> Early options in initrd bootconfig are still silently ignored, as the
> initrd is only available after the early param window has closed.
> 
> Document this behaviour in both Kconfig and the admin guide.

Thanks Breno, this makes things clearer.
This looks good to me.

Thanks,

> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  Documentation/admin-guide/bootconfig.rst |  4 ++
>  init/Kconfig                             |  6 +++
>  init/main.c                              | 67 +++++++++++++++++++++++++++++++-
>  3 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index f712758472d5c..e820f33d3ad16 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -169,6 +169,10 @@ Boot Kernel With a Boot Config
>  There are two options to boot the kernel with bootconfig: attaching the
>  bootconfig to the initrd image or embedding it in the kernel itself.
>  
> +Early options (those registered with ``early_param()``) may only be
> +specified in the embedded bootconfig, because the initrd is not yet
> +available when early parameters are processed.
> +
>  Attaching a Boot Config to Initrd
>  ---------------------------------
>  
> diff --git a/init/Kconfig b/init/Kconfig
> index 938fbe6a91e15..5e8057e73fe06 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1534,6 +1534,12 @@ config BOOT_CONFIG_EMBED
>  	  image. But if the system doesn't support initrd, this option will
>  	  help you by embedding a bootconfig file while building the kernel.
>  
> +	  Unlike bootconfig attached to initrd, the embedded bootconfig also
> +	  supports early options (those registered with early_param()). Any
> +	  kernel.* key in the embedded bootconfig is applied before
> +	  parse_early_param() runs. Early options in initrd bootconfig will
> +	  not be applied.
> +
>  	  If unsure, say N.
>  
>  config BOOT_CONFIG_EMBED_FILE
> diff --git a/init/main.c b/init/main.c
> index 453ac9dff2da0..eba42b2351d47 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -416,9 +416,63 @@ static int __init warn_bootconfig(char *str)
>  	return 0;
>  }
>  
> +/*
> + * do_early_param() is defined later in this file but called from
> + * bootconfig_apply_early_params() below, so we need a forward declaration.
> + */
> +static int __init do_early_param(char *param, char *val,
> +				 const char *unused, void *arg);
> +
> +/*
> + * bootconfig_apply_early_params - dispatch kernel.* keys from the embedded
> + * bootconfig as early_param() calls.
> + *
> + * early_param() handlers must run before most of the kernel initialises
> + * (e.g. before the GIC driver reads irqchip.gicv3_pseudo_nmi).  A bootconfig
> + * attached to the initrd arrives too late for this because the initrd is not
> + * mapped yet when early params are processed.  The embedded bootconfig lives
> + * in the kernel image itself (.init.data), so it is always reachable.
> + *
> + * This function is called from setup_boot_config() which runs in
> + * start_kernel() before parse_early_param(), making the timing correct.
> + */
> +static void __init bootconfig_apply_early_params(void)
> +{
> +	char val_buf[COMMAND_LINE_SIZE];
> +	struct xbc_node *knode, *root;
> +	const char *val;
> +
> +	root = xbc_find_node("kernel");
> +	if (!root)
> +		return;
> +
> +	/*
> +	 * Keys that do not match any early_param() handler are silently
> +	 * ignored — do_early_param() always returns 0.
> +	 */
> +	xbc_node_for_each_key_value(root, knode, val) {
> +		if (xbc_node_compose_key_after(root, knode, xbc_namebuf, XBC_KEYLEN_MAX) < 0)
> +			continue;
> +
> +		if (!val) {
> +			do_early_param(xbc_namebuf, NULL, NULL, NULL);
> +			continue;
> +		}
> +
> +		/*
> +		 * We need to copy const char *val to a char pointer,
> +		 * which is what do_early_param() need, given it might
> +		 * call strsep(), strtok() later.
> +		 */
> +		strscpy(val_buf, val, sizeof(val_buf));
> +		do_early_param(xbc_namebuf, val_buf, NULL, NULL);
> +	}
> +}
> +
>  static void __init setup_boot_config(void)
>  {
>  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> +	bool using_embedded = false;
>  	const char *msg, *data;
>  	int pos, ret;
>  	size_t size;
> @@ -427,8 +481,17 @@ static void __init setup_boot_config(void)
>  	/* Cut out the bootconfig data even if we have no bootconfig option */
>  	data = get_boot_config_from_initrd(&size);
>  	/* If there is no bootconfig in initrd, try embedded one. */
> -	if (!data)
> +	if (!data) {
>  		data = xbc_get_embedded_bootconfig(&size);
> +		/*
> +		 * Record that we are using the embedded config so that
> +		 * bootconfig_apply_early_params() is called below.
> +		 * When CONFIG_BOOT_CONFIG_EMBED is not set,
> +		 * xbc_get_embedded_bootconfig() is a stub returning NULL, so
> +		 * data is always NULL here and using_embedded stays false.
> +		 */
> +		using_embedded = data;
> +	}
>  
>  	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
>  	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
> @@ -466,6 +529,8 @@ static void __init setup_boot_config(void)
>  	} else {
>  		xbc_get_info(&ret, NULL);
>  		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
> +		if (using_embedded)
> +			bootconfig_apply_early_params();
>  		/* keys starting with "kernel." are passed via cmdline */
>  		extra_command_line = xbc_make_cmdline("kernel");
>  		/* Also, "init." keys are init arguments */
> 
> ---
> base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
> change-id: 20260323-early_bootconfig-2efc4509af3d
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
