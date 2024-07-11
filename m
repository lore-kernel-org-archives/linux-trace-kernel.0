Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4220EBE49;
	Thu, 11 Jul 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720660105; cv=none; b=czTu4ZxLCoTQieDXwMOphjBrW1UejbYPanE73ICshhu7eUjg6FBlSKxDr8863gHBlZW4jU27fZKHzPV1YWrka0lijm8U1tHw7EyNcVjV/vGlvTGiVvxj1z20FY1O96o6mmrWublKoJV9/68nh6DgBhWn6/O4EHvI1T5FHX5/o8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720660105; c=relaxed/simple;
	bh=SMz9nJUL1CPqXAWfimtrxdGvpG09xA8QZ9vSjFy8kcI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FPtPx/OWDT4CR1ctvzX1t5CRqf4IB6Jw1PAOResu+cs+A79eWitSNd+S4F7HcxiRyDAfAe6hXmftZ6eM76zA5hfVfsQ5xdvs3Td7AOXIuJYGWchSP+1nvI6JNWX938i9surwfb8hBsP7HheUWLSTbHFUC1XhzOyhZKoCvWFvPRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qaswazhF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qaswazhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD14FC32781;
	Thu, 11 Jul 2024 01:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720660105;
	bh=SMz9nJUL1CPqXAWfimtrxdGvpG09xA8QZ9vSjFy8kcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qaswazhFSmg1dpTeaM4t2pY1GFbjcoS6h7TUfVvM47oTwdjOdhT36qqoYMlwDl0fq
	 2VRFetKtL1GMczGeFtmSAOcvXI0euIqDs+//5u0RLaxfBjm+vnrjokUAbAC//Fnkwn
	 4FcjFc2QwxD9CH9qDYsXix92bj7eByuuD9fSHLdhOmk1yqS9lurTIn5ofoM66doQ83
	 6INEJYUjS50Le643jUajB7FaFbG+SZRzkUcZwhWxw2Jjrh/TyOYQAJL1eBOLoghDwk
	 l5GZzfzLa5PCVk0OAZb1u3E6JCi5LnF5M/TDqT5eBYgSUXoLljhUGltMg+F3i4KPRk
	 mNBR/25cLgJ+w==
Date: Thu, 11 Jul 2024 10:08:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: Remove duplicate included header file
 linux/bootconfig.h
Message-Id: <20240711100821.a1ba1449c3be80d30ea6a697@kernel.org>
In-Reply-To: <20240711002152.800028-2-thorsten.blum@toblux.com>
References: <20240711002152.800028-2-thorsten.blum@toblux.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 02:21:53 +0200
Thorsten Blum <thorsten.blum@toblux.com> wrote:

> The header file linux/bootconfig.h is included whether __KERNEL__ is
> defined or not.
> 
> Include it only once before the #ifdef/#else/#endif preprocessor
> directives and remove the following make includecheck warning:
> 
>   linux/bootconfig.h is included more than once
> 

OK, but this leaves only a comment in !__KERNEL__ part.
That comment should be moved and updated too. Please move this on the top of
this file and remove `!__KERNEL__` part.

/*
 * NOTE: This file is also used by tools/bootconfig, because tools/bootconfig
 * will run the parser for sanity test.
 * This does NOT mean lib/bootconfig.c is always available in the user space.
 * However, if you change this file, please make sure the tools/bootconfig
 * has no issue on building and running.
 */

Thank you,

> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  lib/bootconfig.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 97f8911ea339..297871455db5 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -4,8 +4,9 @@
>   * Masami Hiramatsu <mhiramat@kernel.org>
>   */
>  
> -#ifdef __KERNEL__
>  #include <linux/bootconfig.h>
> +
> +#ifdef __KERNEL__
>  #include <linux/bug.h>
>  #include <linux/ctype.h>
>  #include <linux/errno.h>
> @@ -33,7 +34,6 @@ const char * __init xbc_get_embedded_bootconfig(size_t *size)
>   * However, if you change this file, please make sure the tools/bootconfig
>   * has no issue on building and running.
>   */
> -#include <linux/bootconfig.h>
>  #endif
>  
>  /*
> -- 
> 2.45.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
