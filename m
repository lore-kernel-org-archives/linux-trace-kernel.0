Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303B47F7F;
	Thu, 11 Jul 2024 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720740952; cv=none; b=sOaLyGnkpev0wKB662qkLGFsCbM8D9fVNmohj41XLWBClXkRvB1HONVlEJtaV2ba/QrL2wrRaUey4g4+KGBRRGWxtYZh/JY/82EJ0dm5hEaV7x2cibnZKIMvyp+hwuZPh4Ybr651QDtbK3f4sBfNPVEbgcWAGgLOwPejdmJfyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720740952; c=relaxed/simple;
	bh=w/5lAw+7InL9jCYKblkPnKzXc6bpFZzOZQ5eFWqCaEE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MPKy16nU1aWdIjBZR2EESuGGxuuex56dGDFGjb4cxSOwwYCeKzzuS+0sjQAINbRtPTi5NHvEKngzPg5OI7FcMztgR2t4Zq64hv3KCMt9pI9+8Ix5nMCkPSWM2Mo0CtRj8qrQNwwXhz6k/ISvUHXyhUg1yvBhUNLnRL8up+l99f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH8FAlgP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH8FAlgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E73C116B1;
	Thu, 11 Jul 2024 23:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720740952;
	bh=w/5lAw+7InL9jCYKblkPnKzXc6bpFZzOZQ5eFWqCaEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jH8FAlgP0Q3QYghA6dTrhTbUG/JVY/VEQzFRdP5XRmO/OPhk+6EjXtyXjUuZRcbTr
	 GR5sJs6X0zHIRCp7WmfkoU6XLq3+jMdjaGdwwGrTi9SBpDNyeJwBFR7eeZkxu0q2ws
	 3RRyYDhXbkdWW20xPiOKHzAIAKEIzuQ3ndw6yWbGYcBHgGA7vkPzd84aq9XwbzjDQG
	 vGMHmAQxesy58Mqi4sBMRhOmT7BQAZ1lBtf9EcttZNkCriXqI2NXpmh6+sq/Yyys5Q
	 EkL+BYVCI4DluqTHNHT5/iTP7LSoSOjqy7wMcRb1rdQ+FHxuCK08XghKPn5EFChdGN
	 0CNcFebDmFcVw==
Date: Fri, 12 Jul 2024 08:35:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bootconfig: Remove duplicate included header file
 linux/bootconfig.h
Message-Id: <20240712083548.374a6c4ff925251cd74db051@kernel.org>
In-Reply-To: <20240711084315.1507-1-thorsten.blum@toblux.com>
References: <20240711084315.1507-1-thorsten.blum@toblux.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 10:43:16 +0200
Thorsten Blum <thorsten.blum@toblux.com> wrote:

> The header file linux/bootconfig.h is included whether __KERNEL__ is
> defined or not.
> 
> Include it only once before the #ifdef/#else/#endif preprocessor
> directives and remove the following make includecheck warning:
> 
>   linux/bootconfig.h is included more than once
> 
> Move the comment to the top and delete the now empty #else block.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Thanks, looks good to me. Let me pick it up.

> ---
> Changes in v2:
> - Move comment and delete #else as suggested by Masami Hiramatsu
> - Link to v1: https://lore.kernel.org/linux-kernel/20240711002152.800028-2-thorsten.blum@toblux.com/
> ---
>  lib/bootconfig.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 97f8911ea339..81f29c29f47b 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -4,8 +4,16 @@
>   * Masami Hiramatsu <mhiramat@kernel.org>
>   */
>  
> -#ifdef __KERNEL__
> +/*
> + * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
> + * run the parser sanity test.
> + * This does NOT mean lib/bootconfig.c is available in the user space.
> + * However, if you change this file, please make sure the tools/bootconfig
> + * has no issue on building and running.
> + */
>  #include <linux/bootconfig.h>
> +
> +#ifdef __KERNEL__
>  #include <linux/bug.h>
>  #include <linux/ctype.h>
>  #include <linux/errno.h>
> @@ -24,16 +32,6 @@ const char * __init xbc_get_embedded_bootconfig(size_t *size)
>  	return (*size) ? embedded_bootconfig_data : NULL;
>  }
>  #endif
> -
> -#else /* !__KERNEL__ */
> -/*
> - * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
> - * run the parser sanity test.
> - * This does NOT mean lib/bootconfig.c is available in the user space.
> - * However, if you change this file, please make sure the tools/bootconfig
> - * has no issue on building and running.
> - */
> -#include <linux/bootconfig.h>
>  #endif
>  
>  /*
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
