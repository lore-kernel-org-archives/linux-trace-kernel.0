Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665A11FC8;
	Tue, 12 May 2026 00:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778544042; cv=none; b=Ei1asIunChnkEPGgKrMQvu/Z3Lq+CrpBOJCieEzcMDptQoNvLQNtkAlgTEejjZfU4IqFweHRM6sy7DV+/pyN8feX0ZjPZLe6A5AeWxM27zlRDVYkpEBxhaMx4gQBRG6cu3G+bBuLfuXb5AGpEEsxlOUse3yeVTYpaW/1iugKjmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778544042; c=relaxed/simple;
	bh=liKfkFeXuHk5RQrwWQM26tHJ2BShTYDxqkxOFhnD6QQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mNaNN+vwuGXOoIL+cvxArSHyYH4Ht6nRAxYgS2cFR9WEnHMYYPZgqKOFRrxlD5itabLSsYJVTK8/YK1FXl4UEeCOxh4qhu7eKMerJHU9M/v/ZrqhN5gGGtEEM50A9EQ/XLctCdM8exmwlPDAdEjPnVLIsJhvg/ki1KwcJfmdlv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj7oQr6u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj7oQr6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEEDC2BCB0;
	Tue, 12 May 2026 00:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778544042;
	bh=liKfkFeXuHk5RQrwWQM26tHJ2BShTYDxqkxOFhnD6QQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tj7oQr6udQg84iGU3D30eBESNaN7jFbaBys9saW6eJP/fglK0mqyI2WZO3qUMnXcS
	 6BxVdiz87WM7DpUv5nBYzgZ160sP8KIY7c98WtI+zGwhcYoiKM+7zqcw5zmeIP/293
	 +KtcntAzazgi7GAnyy4cLbvUrv//FylstzFOHra1h/5+2MveV8FLQ9q1SC4xDt/eRN
	 psiS8G9+EZgDIufvSGvxtNhrCcQzINd1sRZP8NQuN2zugLvdzCYrdei36VENrVG1MU
	 XGDmw1ktclTrGcnOyRjFIkIiYGA4m38oFI+MnSnIe8oh0feygej2Rhm8Hfc0xArCou
	 xquTCZGqdDB6Q==
Date: Tue, 12 May 2026 09:00:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, paulmck@kernel.org, oss@malat.biz,
 kernel-team@meta.com
Subject: Re: [PATCH 1/2] bootconfig: move xbc_snprint_cmdline() to
 lib/bootconfig.c
Message-Id: <20260512090038.27a8b9f9a4a485098071f3a1@kernel.org>
In-Reply-To: <20260508-bootconfig_using_tools-v1-1-1132219aa773@debian.org>
References: <20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org>
	<20260508-bootconfig_using_tools-v1-1-1132219aa773@debian.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 May 2026 06:55:03 -0700
Breno Leitao <leitao@debian.org> wrote:

> Move xbc_snprint_cmdline() from init/main.c to lib/bootconfig.c so the
> function (and its xbc_namebuf scratch buffer) becomes part of the shared
> parser library. tools/bootconfig already compiles lib/bootconfig.c
> directly, which lets a follow-up patch reuse the same renderer in the
> userspace tool to convert a bootconfig file into a flat cmdline string
> at build time.
> 
> No functional change.

Yeah, this should be under lib/bootconfig.c

Thanks,

> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/bootconfig.h |  3 +++
>  init/main.c                | 45 -------------------------------------
>  lib/bootconfig.c           | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 45 deletions(-)
> 
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index 692a5acc2ffc4..1c7f3b74ffcf3 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -265,6 +265,9 @@ static inline struct xbc_node * __init xbc_node_get_subkey(struct xbc_node *node
>  int __init xbc_node_compose_key_after(struct xbc_node *root,
>  			struct xbc_node *node, char *buf, size_t size);
>  
> +/* Render key/value pairs under @root as a flat cmdline string */
> +int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root);
> +
>  /**
>   * xbc_node_compose_key() - Compose full key string of the XBC node
>   * @node: An XBC node.
> diff --git a/init/main.c b/init/main.c
> index 96f93bb06c490..e363232b428b4 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -324,51 +324,6 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
>  
>  #ifdef CONFIG_BOOT_CONFIG
>  
> -static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
> -
> -#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
> -
> -static int __init xbc_snprint_cmdline(char *buf, size_t size,
> -				      struct xbc_node *root)
> -{
> -	struct xbc_node *knode, *vnode;
> -	char *end = buf + size;
> -	const char *val, *q;
> -	int ret;
> -
> -	xbc_node_for_each_key_value(root, knode, val) {
> -		ret = xbc_node_compose_key_after(root, knode,
> -					xbc_namebuf, XBC_KEYLEN_MAX);
> -		if (ret < 0)
> -			return ret;
> -
> -		vnode = xbc_node_get_child(knode);
> -		if (!vnode) {
> -			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
> -			if (ret < 0)
> -				return ret;
> -			buf += ret;
> -			continue;
> -		}
> -		xbc_array_for_each_value(vnode, val) {
> -			/*
> -			 * For prettier and more readable /proc/cmdline, only
> -			 * quote the value when necessary, i.e. when it contains
> -			 * whitespace.
> -			 */
> -			q = strpbrk(val, " \t\r\n") ? "\"" : "";
> -			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
> -				       xbc_namebuf, q, val, q);
> -			if (ret < 0)
> -				return ret;
> -			buf += ret;
> -		}
> -	}
> -
> -	return buf - (end - size);
> -}
> -#undef rest
> -
>  /* Make an extra command line under given key word */
>  static char * __init xbc_make_cmdline(const char *key)
>  {
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index c470b93d5dbc2..f445b7703fdd9 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -408,6 +408,62 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
>  		return "";	/* No value key */
>  }
>  
> +static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
> +
> +#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
> +
> +/**
> + * xbc_snprint_cmdline() - Render bootconfig keys under @root as a cmdline string
> + * @buf: Destination buffer (may be NULL when @size is 0 to query the length)
> + * @size: Size of @buf in bytes
> + * @root: Subtree root whose key=value pairs should be rendered
> + *
> + * Walk all key/value pairs under @root and emit them as a space-separated
> + * cmdline string into @buf. Values containing whitespace are quoted with
> + * double quotes. Returns the number of bytes that would be written if @buf
> + * were large enough (matching snprintf semantics), or a negative errno on
> + * failure.
> + */
> +int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
> +{
> +	struct xbc_node *knode, *vnode;
> +	char *end = buf + size;
> +	const char *val, *q;
> +	int ret;
> +
> +	xbc_node_for_each_key_value(root, knode, val) {
> +		ret = xbc_node_compose_key_after(root, knode,
> +					xbc_namebuf, XBC_KEYLEN_MAX);
> +		if (ret < 0)
> +			return ret;
> +
> +		vnode = xbc_node_get_child(knode);
> +		if (!vnode) {
> +			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
> +			if (ret < 0)
> +				return ret;
> +			buf += ret;
> +			continue;
> +		}
> +		xbc_array_for_each_value(vnode, val) {
> +			/*
> +			 * For prettier and more readable /proc/cmdline, only
> +			 * quote the value when necessary, i.e. when it contains
> +			 * whitespace.
> +			 */
> +			q = strpbrk(val, " \t\r\n") ? "\"" : "";
> +			ret = snprintf(buf, rest(buf, end), "%s=%s%s%s ",
> +				       xbc_namebuf, q, val, q);
> +			if (ret < 0)
> +				return ret;
> +			buf += ret;
> +		}
> +	}
> +
> +	return buf - (end - size);
> +}
> +#undef rest
> +
>  /* XBC parse and tree build */
>  
>  static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)
> 
> -- 
> 2.53.0-Meta
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
