Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB15D245031;
	Sun, 15 Mar 2026 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773562845; cv=none; b=KxcXi2ITh3+pEs8d6hvvtbdViQs8q1msk1ClS86oJkUKACpwwFaHLdeYy7dMptaCmj8sVd7JyEIVn3Ps7fWqy4Ab7koVdJGYGCEaivRhM4G/apxUH4BX4CwlDIAQyiwTQgcdcraMYsOQxUcsm4yYhG0aWxmTnvKEvgE/Wicphxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773562845; c=relaxed/simple;
	bh=YL7EhrSbRmaDEi8N+bhNGFZdS1Nlw7zIHlA3//YUGoU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MYPPMB4NhWuNmiZ3lYCoHS1gw+bUyeFOWh5gv5gWK4rVdJH7OLN6logdypdVqUce09rY1HvwoqAuENNIat3ggmBcXuUmtOZGcTk7roXYVaZHv/floUWJvRuW6PrJiEIWR49+IxpojjS9qs9mjmiT/Ygmstl/vtpiyE2K3oLTI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbhEyWNu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbhEyWNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AD2C4CEF7;
	Sun, 15 Mar 2026 08:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773562845;
	bh=YL7EhrSbRmaDEi8N+bhNGFZdS1Nlw7zIHlA3//YUGoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbhEyWNujzX2AYlrefaIOftaKuYuEctsLC+aTAokGa/obLF4aoGNa5UZuca098DJu
	 96YRLrXAPxAZti6avlo36RD+dr2egkX0vVaP7enhF9fV3Fj0Mmsz7+1VM7MOheHRrg
	 8k/RsZae18idqNSq4yaJGio1dy6++2b86zwsPwpKWfUf929x1SFYJozBdOZ1sLx9x4
	 RgfVx8iDMy6COBaWbvPJ7CfnLkDPKm85QE6sMVWNXOo/5I6VD4dlLRpWi5MAES1FOS
	 EKAciXwDOOgniJHufUIUcSCMGKfkV4Q6tuQAhgmJtdh9ViDQZBfh7E8nsM/4Rt2GG4
	 6cHbvlUi7p5vA==
Date: Sun, 15 Mar 2026 17:20:42 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/17] lib/bootconfig: fix inconsistent if/else
 bracing in __xbc_add_key()
Message-Id: <20260315172042.8bcd8c5859e1dc70ae297fc1@kernel.org>
In-Reply-To: <20260314230155.155777-8-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
	<20260314230155.155777-8-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 23:01:45 +0000
Josh Law <objecting@objecting.org> wrote:

> When one branch of a conditional uses braces, both branches should
> use them per coding-style section 3.1.  Add the missing braces to
> the if/else blocks in __xbc_add_key().

It is just a cosmetic cleanup.
Can you fold this with other typo fixes?

THank you,

> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 34bdc2d13881..58d6ae297280 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -657,9 +657,9 @@ static int __init __xbc_add_key(char *k)
>  	if (unlikely(xbc_node_num == 0))
>  		goto add_node;
>  
> -	if (!last_parent)	/* the first level */
> +	if (!last_parent) {	/* the first level */
>  		node = find_match_node(xbc_nodes, k);
> -	else {
> +	} else {
>  		child = xbc_node_get_child(last_parent);
>  		/* Since the value node is the first child, skip it. */
>  		if (child && xbc_node_is_value(child))
> @@ -667,9 +667,9 @@ static int __init __xbc_add_key(char *k)
>  		node = find_match_node(child, k);
>  	}
>  
> -	if (node)
> +	if (node) {
>  		last_parent = node;
> -	else {
> +	} else {
>  add_node:
>  		node = xbc_add_child(k, XBC_KEY);
>  		if (!node)
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
