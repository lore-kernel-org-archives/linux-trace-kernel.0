Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C302F32B989;
	Mon, 16 Mar 2026 23:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705464; cv=none; b=ZHNe24eehk042vAvG5FfVa+YfMIySdb3AxXZB8Sg/oiLHHQ1IRQOWNwKsGhVEoIhASj83XPGoRwiQZrAKeboIA0BTZEt2AIg9emjUq3gCVhM6utQA3sM62I/hl8OvjO+m4Bhq2gJaTZA5U1WfzAJXIgWqZYLKNr0tE3WxLx7lfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705464; c=relaxed/simple;
	bh=1NmvH8pmQ8q9dCzOzOTTeLRQgMfsAKAnu6U9VRGjDSU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fgClMFZpq66pIBitzzCclMVgePNUJhgGfYCFRlH7pWGceAxf3UTqIkBIVtPnJBayWIYe3eTFPOHiKpDd/nTd0wzBbcm4z6m6B2utWzmMBMXMb7n6aA/CIkjHuzk2g3reRQI4F4p7XgfgG8AxOQuZo9MJidnldbiAAhJrwNachio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gwj6ae65; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gwj6ae65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B42FC19421;
	Mon, 16 Mar 2026 23:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773705464;
	bh=1NmvH8pmQ8q9dCzOzOTTeLRQgMfsAKAnu6U9VRGjDSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gwj6ae65CX1JQBjOj3AWqQUmY9pfIvLTikmONEJcbfX9GYCVB9VtIXRGpz4RlMNfj
	 IoAMKGhphtnTeR7CdCzIc6w1ZYnLML0xl9lKeADoo6RTA7Qg45YEMgtqByNJAM4n9c
	 VIx9An4q1rQX6dy8JBs+7qhHNE7vQ+TTmsBxIoqNerSLlu48PcEoBc6qbKgyLbPLyp
	 cJCBAt4NTUa450jxGk4GLVExLmNiaZaNqz7U175HqpWpW31Xi3n46RK+HJaz4SrnxF
	 /E6X32dFxQcQUc3L3Sp2WhXEoOGB3SDQSdbL+ywWeX7MmjCVlqB+yKQUp57Tb/tk/6
	 6HWb12KLx6/fQ==
Date: Tue, 17 Mar 2026 08:57:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/17] lib/bootconfig: fix signed comparison in
 xbc_node_get_data()
Message-Id: <20260317085741.7ba7d7464cee2c905193fa08@kernel.org>
In-Reply-To: <20260315122015.55965-13-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
	<20260315122015.55965-13-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 12:20:10 +0000
Josh Law <objecting@objecting.org> wrote:

>   lib/bootconfig.c:188:28: warning: comparison of integer expressions
>   of different signedness: 'int' and 'size_t' [-Wsign-compare]
> 
> The local variable 'offset' is declared as int, but xbc_data_size is
> size_t.  Using ~XBC_VALUE as the mask also involves integer promotion
> rules that obscure intent.
> 
> Change the type to unsigned int and mask with XBC_DATA_MAX (which is
> the 15-bit data mask) instead of ~XBC_VALUE, making the expression
> self-documenting and eliminating the signed/unsigned comparison.

Please follow the warning message and use size_t instead.

Thanks,

> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 182d9d9bc5a6..806a8f038d24 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -183,7 +183,7 @@ struct xbc_node * __init xbc_node_get_next(struct xbc_node *node)
>   */
>  const char * __init xbc_node_get_data(struct xbc_node *node)
>  {
> -	int offset = node->data & ~XBC_VALUE;
> +	unsigned int offset = node->data & XBC_DATA_MAX;
>  
>  	if (WARN_ON(offset >= xbc_data_size))
>  		return NULL;
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
