Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E26DCE1
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909931; cv=none; b=ZzYXx/sZrSSN4dv7XZ6toCa+rozrGP8Sz/Wkstvjd3yPtWP5/Zend7sbeMO9BvLGeI0SGDTYmRHeN9gnxDuacZQqYRqD12e5qlzyvBA/m+MwJhuWArc0NtuZNUeq36JNzInA2w9dmTPA5yU3XMrT/eOE5y7LJJFdCsoTnpoNVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909931; c=relaxed/simple;
	bh=m0jGN75aBujP9iovf8fBfvMrLqIAVW7S/lcUPB+92D4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TYruAlbDeFtuTSSiRFlPQnISiH1MzI7bgjjUn0ZpioqbiGDScEHekJhJw0qYtO5U8ddS7xVpGrotuhH5nwHcFh1kGzGhLDY377huJVhzOFlrgWSBMbK/ICEylIW4Mnwd6/oWAiHmMmkOP7NJVjLsDRrP9U43rJo/Ky2zfc4F/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1xEh7Lf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1xEh7Lf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C61B1F00A3A;
	Tue,  8 Sep 2026 23:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788909929;
	bh=YRHlSpaKfPAZXNSRV5/NpeUjctbvYAA7maNZ9n9Umx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=o1xEh7LfOkLwTSTSzTDenaDAWL7g/PkKIc4D721mtMimgkn7Xt2SEO/jDCy6sNl1V
	 qlpX+xxAcLrYAaxoqhmwCkj27owUhcG3gFENJmWegxX9smZXYuaJcCooaTOvHfYzzK
	 ecIxoPLIRqXld35OlKjWk5peoJpnIoYmUxDaznWSMx/zqzqgNSTa7D8Sea0AVOsHIO
	 S9IjEQjHPVWtmFRC3UPBe3k8QzGmV4lqXJwN1ApEYyVjgaRItuUws56oraoq5gNyTJ
	 2TLz/e2K3jZgNSl9p6d87KdRUVvS4MMPAByUgx9P++s4ZBA2n/RUSAicJIVUgANNHA
	 TKd5jvZ+9uZSg==
Date: Wed, 9 Sep 2026 08:25:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: merge _xbc_exit() into xbc_exit()
Message-Id: <20260909082526.19601bb6a61b31fc141d8f57@kernel.org>
In-Reply-To: <20260908165712.1703439-1-ekffu200098@gmail.com>
References: <20260908165712.1703439-1-ekffu200098@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Sep 2026 01:57:11 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Since commit 87ce9e83ab8b ("memblock, treewide: make memblock_free()
> handle late freeing"), both branches of xbc_free_mem() call
> memblock_free(), and the early argument has no effect.
> 
> memblock_free() also does nothing if addr is NULL, so the check
> before the call is redundant.
> 
> So remove the argument and the NULL check, and merge _xbc_exit() into
> xbc_exit().
> 
> No functional change.

Good catch!
Let me pick this to bootconfig/for-next.

Thank you!

> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  include/linux/bootconfig.h |  7 +------
>  lib/bootconfig.c           | 22 +++++++++-------------
>  2 files changed, 10 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
> index deda507500da..fdc15b6f4d1b 100644
> --- a/include/linux/bootconfig.h
> +++ b/include/linux/bootconfig.h
> @@ -291,12 +291,7 @@ int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
>  int __init xbc_get_info(int *node_size, size_t *data_size);
>  
>  /* XBC cleanup data structures */
> -void __init _xbc_exit(bool early);
> -
> -static __always_inline void xbc_exit(void)
> -{
> -	_xbc_exit(false);
> -}
> +void __init xbc_exit(void);
>  
>  /* XBC embedded bootconfig data in kernel */
>  #ifdef CONFIG_BOOT_CONFIG_EMBED
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 89c88e359179..aba11caf6903 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -187,12 +187,9 @@ static inline void * __init xbc_alloc_mem(size_t size)
>  	return memblock_alloc(size, SMP_CACHE_BYTES);
>  }
>  
> -static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
> +static inline void __init xbc_free_mem(void *addr, size_t size)
>  {
> -	if (early)
> -		memblock_free(addr, size);
> -	else if (addr)
> -		memblock_free(addr, size);
> +	memblock_free(addr, size);
>  }
>  
>  #else /* !__KERNEL__ */
> @@ -202,7 +199,7 @@ static inline void *xbc_alloc_mem(size_t size)
>  	return calloc(1, size);
>  }
>  
> -static inline void xbc_free_mem(void *addr, size_t size, bool early)
> +static inline void xbc_free_mem(void *addr, size_t size)
>  {
>  	free(addr);
>  }
> @@ -1123,20 +1120,19 @@ static int __init xbc_parse_tree(void)
>  }
>  
>  /**
> - * _xbc_exit() - Clean up all parsed bootconfig
> - * @early: Set true if this is called before budy system is initialized.
> + * xbc_exit() - Clean up all parsed bootconfig
>   *
>   * This clears all data structures of parsed bootconfig on memory.
>   * If you need to reuse xbc_init() with new boot config, you can
>   * use this.
>   */
> -void __init _xbc_exit(bool early)
> +void __init xbc_exit(void)
>  {
> -	xbc_free_mem(xbc_data, xbc_data_size, early);
> +	xbc_free_mem(xbc_data, xbc_data_size);
>  	xbc_data = NULL;
>  	xbc_data_size = 0;
>  	xbc_node_num = 0;
> -	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX, early);
> +	xbc_free_mem(xbc_nodes, sizeof(struct xbc_node) * XBC_NODE_MAX);
>  	xbc_nodes = NULL;
>  	brace_index = 0;
>  }
> @@ -1189,7 +1185,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
>  	if (!xbc_nodes) {
>  		if (emsg)
>  			*emsg = "Failed to allocate bootconfig nodes";
> -		_xbc_exit(true);
> +		xbc_exit();
>  		return -ENOMEM;
>  	}
>  
> @@ -1202,7 +1198,7 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
>  			*epos = xbc_err_pos;
>  		if (emsg)
>  			*emsg = xbc_err_msg;
> -		_xbc_exit(true);
> +		xbc_exit();
>  	} else {
>  		ret = xbc_node_num;
>  	}
> 
> base-commit: 85595d3f964825c833fd2597521fcef67c3071de
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
