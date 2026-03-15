Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E779A39FD9;
	Sun, 15 Mar 2026 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562663; cv=none; b=n4QPBW4mVbK39g110gKIMfdtdjzBHerg64MSxgjMm/utf2EjOWjUk99BBYanobNL3CmEhAfQaEddbpxpDLbKB0P8nM1v3qcNNICie+0TOOZqcPG6bPfkMQuKzvQJEOMmGYSmTztIo1zMEDRIYRgP4ofW9wqRzLfxWIQ+zAPI0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562663; c=relaxed/simple;
	bh=i2ojNwsLwSPeDEf6e7BNmTghLUkLbKMacxA8Nk1T2hA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QwYp3Guj9FKDWj8W4OLgDlx+HuuGkrKakXdDeISXf7phEbIkcSRlgP5Rbpx2yi9Hq37SMpYcZsZ29zEFBp8kCJcTlvxWMW4VInkfV/lhtYIsAzXfwwONHDIw9zXBcaW36wOKwPE7XOtbqv8X/QXxuJs6Z6Ug7jMW74qWG824Y0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCfhnkHQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCfhnkHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53727C4CEF7;
	Sun, 15 Mar 2026 08:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773562662;
	bh=i2ojNwsLwSPeDEf6e7BNmTghLUkLbKMacxA8Nk1T2hA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PCfhnkHQ97KD7xd3bl8aG5kkc7LQLzHU4r6zROR+p2sejFl/H4ObFluCfXAp56vqA
	 sqex2kMTV1bxQvydEH7JxdrKzLcysKoFIAZKQx2PX/2DiM16vtwpoI6RqcyJds1sGR
	 Y61P8it7/ptVS+uKA+0tgOGJyymT5AExSgJ/Xc9S5OcEbsicFBo9ZTUJjnbKtBkx9u
	 6vKU3EgThTPbzhTrvrxhUlvPwHOc0oA4VFvhtfBqT6fDo8LPyvzqmA8ELZEbPwhHx4
	 XjW6hBDoyo3QcbeQrH3tHfJMAn93Gs/PC3lV+qvgrhQepXncPQnkeIp/lRFCMEnrTf
	 s1L5VeQpZMpjg==
Date: Sun, 15 Mar 2026 17:17:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/17] lib/bootconfig: fix typo "initiized" in
 xbc_root_node() kerneldoc
Message-Id: <20260315171739.5a4edade057a2677cd43941b@kernel.org>
In-Reply-To: <20260314230155.155777-3-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
	<20260314230155.155777-3-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Thanks for cleaning ups. Can you fold [2/17][3/17][4/17] into 1 patch?
Those are just typo fixes and index/space fix, IOW, cosmetic change.

Thanks,

On Sat, 14 Mar 2026 23:01:40 +0000
Josh Law <objecting@objecting.org> wrote:

> Fix "initiized" to "initialized" in the xbc_root_node() kerneldoc
> comment.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 51fd2299ec0f..53aedc042f6e 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -112,7 +112,7 @@ static int __init xbc_parse_error(const char *msg, const char *p)
>   * xbc_root_node() - Get the root node of extended boot config
>   *
>   * Return the address of root node of extended boot config. If the
> - * extended boot config is not initiized, return NULL.
> + * extended boot config is not initialized, return NULL.
>   */
>  struct xbc_node * __init xbc_root_node(void)
>  {
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
