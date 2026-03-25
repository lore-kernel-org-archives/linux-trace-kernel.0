Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3622459C9;
	Wed, 25 Mar 2026 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774448529; cv=none; b=d5KSISEopUmbbbAzS2lxxpTzsoaPQ3T6yBUFenw1aAIPznMtR+iG4W6194ob6dQT4sjDDU+v9UskPgYkKhq4a8fvkoYp4DnEbHEojCKGmoUDcjr+keqSKsww8SQOiFtvWS6qWD4xJiiFEoEyJ9wet2rCEoZKxE9wFZRrwvGBLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774448529; c=relaxed/simple;
	bh=FcC7zUvMVJG2nLi4u3CW97y9JsKyyMj20e9jUCwJ7+M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sc4EMIcTJXoa/G9Ndt3JKNA7IcwW2uZMbVyFhC/7SPbgAWI+r24XOikPmXZ69RZZ+rSR0AJ2itXP2ik4dqWBtEyCyzk5eoFT6Qw8EecmszNd1dHZAAJANfckPvYLHWz1oyyMkCe+faeP0HTRAe8lnhewE+9leYvrLFI3Hd33IBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWeYM2xo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWeYM2xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2B4C116C6;
	Wed, 25 Mar 2026 14:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774448529;
	bh=FcC7zUvMVJG2nLi4u3CW97y9JsKyyMj20e9jUCwJ7+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWeYM2xojzU3ezdSd+YVGP4AWA1+L1jD1vB2f1MGEqxKU1mZU6MMl7znljTpCCjX2
	 ZToAYvNGGMsc1poGLSjcNgMMxThy+vgao7mJfqiUHdq04Qx/anfLIaR7ny5sQyeab4
	 OLlspiA3SQM+rsbJa0y6JgF1/7zb0mGnsJmjEAWKzlPkMUwM6SzwgXYkQLWsyEZaxx
	 woKn5lHNbVgMT7lVs5urpGJwuElSkau5A2YkNR4LMZEwgII7aEidwiEc5qxXAoH/Z2
	 X83rfP9h2di+VASZFhq6t2shwUUfqMn24GpZslQ+PdWDnekwYGhM0PuKf7Z3QRTzJN
	 mAVFXTi2pbxiw==
Date: Wed, 25 Mar 2026 23:22:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-Id: <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
In-Reply-To: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Breno,

On Wed, 25 Mar 2026 03:05:38 -0700
Breno Leitao <leitao@debian.org> wrote:

> Bootconfig currently cannot be used to configure early kernel
> parameters. For example, the "mitigations=" parameter must be passed
> through traditional boot methods because bootconfig parsing happens
> after these early parameters need to be processed.
> 
> This patch allows early options such as:
> 
>   kernel.mitigations = off
> 
> to be placed in the embedded bootconfig and take effect, without
> requiring them to be on the kernel command line.
> 
> Add bootconfig_apply_early_params() which walks all kernel.* keys in the
> parsed XBC tree and calls do_early_param() for each one. It is called
> from setup_boot_config() immediately after a successful xbc_init() on
> the embedded data, which happens before parse_early_param() runs in
> start_kernel().
> 
> Early options in initrd bootconfig are still silently ignored, as the
> initrd is only available after the early param window has closed.
> 
> Document this behaviour in both Kconfig and the admin guide.

AI review made some comments. Some of the review comments seem
reasonable.

https://sashiko.dev/#/patchset/20260325-early_bootconfig-v2-1-6b05a36fbfb5%40debian.org



[..]
> 
> diff --git a/init/main.c b/init/main.c
> index 453ac9dff2da0..14a04c283fa48 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -416,9 +416,64 @@ static int __init warn_bootconfig(char *str)
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

[sashiko comment]
| Does this run early enough for architectural parameters?
| While setup_boot_config() runs before parse_early_param() in start_kernel(),
| it runs after setup_arch(). setup_boot_config() relies on xbc_init() which
| uses the memblock allocator, requiring setup_arch() to have already
| initialized it.
| However, the kernel expects many early parameters (like mem=, earlycon,
| noapic, and iommu) to be parsed during setup_arch() via the architecture's
| call to parse_early_param(). Since setup_arch() completes before
| setup_boot_config() runs, will these architectural early parameters be
| silently ignored because the decisions they influence were already
| finalized?

This is the major reason that I did not support early parameter
in bootconfig. Some archs initialize kernel_cmdline in setup_arch()
and setup early parameters in it.
To fix this, we need to change setup_arch() for each architecture so
that it calls this bootconfig_apply_early_params().

> +{
> +	static char val_buf[COMMAND_LINE_SIZE] __initdata;

[sashiko comment]
| Can using a single shared static buffer cause data corruption for handlers
| that save the argument pointer?
| Several early_param handlers assume the passed string pointer is persistent
| (like the boot_command_line) and retain it internally. For example,
| setup_earlycon() calls register_earlycon(), which sets
| early_console_dev.con->options = options, where options is a pointer
| directly into the passed buffer.
| Because val_buf is overwritten on every loop iteration, the stored pointer
| will point to the value of the last bootconfig key processed.

Ah, good catch. Since we don't have any standard way to handle the
parameters, some of them does not copy the value but try to keep
reference to the given string. 

> +	struct xbc_node *knode, *root;
> +	const char *val;
> +	ssize_t ret;
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

[sashiko comment]
| Does this loop handle array values correctly?
| xbc_node_for_each_key_value() only assigns the first value of an array to
| the val pointer before advancing to the next key. It does not iterate over
| the child nodes of the array.
| If the bootconfig contains a multi-value key like
| kernel.console = "ttyS0", "tty0", will the subsequent values in the array
| be silently dropped instead of passed to the early_param handlers?

Also, good catch :) we need to use xbc_node_for_each_array_value()
for inner loop.

> +		if (xbc_node_compose_key_after(root, knode, xbc_namebuf, XBC_KEYLEN_MAX) < 0)
> +			continue;
> +
> +		/*
> +		 * We need to copy const char *val to a char pointer,
> +		 * which is what do_early_param() need, given it might
> +		 * call strsep(), strtok() later.
> +		 */
> +		ret = strscpy(val_buf, val, sizeof(val_buf));
> +		if (ret < 0) {
> +			pr_warn("ignoring bootconfig value '%s', too long\n",
> +				xbc_namebuf);
> +			continue;
> +		}
> +		do_early_param(xbc_namebuf, val_buf, NULL, NULL);

[sashiko comment]
| How does this handle valueless parameters (boolean flags)?
| When parsing the standard kernel command line, parse_args() passes a NULL
| value to the setup function for flags that lack an = sign (e.g., ro or
| earlycon).
| However, the bootconfig parser returns a zero-length string for valueless
| keys, which gets copied into val_buf as "" and passed to do_early_param().
| This semantic deviation breaks handlers that explicitly check if (!val).
| For instance, param_setup_earlycon() and parse_lapic() check for a NULL
| argument to enable features. Will passing "" instead of NULL prevent these
| handlers from working correctly?

See fs/proc/bootconfig.c. You can check whether the key has a value or
not by checking xbc_node_get_child(knode) != NULL.

Thank you,

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
> @@ -427,8 +482,17 @@ static void __init setup_boot_config(void)
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
> @@ -466,6 +530,8 @@ static void __init setup_boot_config(void)
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
