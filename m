Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B5258ED5;
	Sun, 15 Mar 2026 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773563376; cv=none; b=KpzV6ti/Wt2tpWYho+ZyLldK2gZZGcG306JXTwjb+6oo8sHisPay8pTfT+/8/yB3Ze+5fBOaTEvgz/daD7dsDlnFAHliyzopiQ4XYwYkkiWv/phNQZ/0mt/SCSfNMJFwe1dTxMCIrOcQV2zJ0wBl4MFDsyk+7P7eyFuTJVDPJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773563376; c=relaxed/simple;
	bh=YXdKhav0cZJ+hNgdsxoLZ/iecUpoWbNiyCRwo/wstpU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lrZfriMOxEOwypiiT7pUd3KI2N4ZDKjUa8in6jYxY9LmLiyGO313OepyhizLq1p5aelkElyhu5NMLvuorRScy4nrS8r0HyLuUiBrcskVYyU0YXU187XBBOkWkUUxRG0PEhiqv4WXyCezERLpkSpoCSJm6W3kayHxgR7uoFJ0Kjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQcDydQL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQcDydQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB00C4CEF7;
	Sun, 15 Mar 2026 08:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773563376;
	bh=YXdKhav0cZJ+hNgdsxoLZ/iecUpoWbNiyCRwo/wstpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MQcDydQLJ+blJxTBQhIFrVBidNFAsTKdFYysGTlw6vcAG/KoPfTakhCDEB9IqbyXN
	 K4DpufT2Sv9WkY38xwr93FNu72IL9YkJde/fNs2hkq0fBKuRLDa8BZAP6lhfOe7aGV
	 xYrUVBpmM0Mh1aUHTAZAKk5lmchlcCpSOnfsqmZC1vNn0ZRv7B/4XDrQ6yitF7m9QY
	 8Dspgyq+rLa1KCwoVgrGaMSdrl50orA8Ij7MnXohwFFf0yeEq3FixUhXCS4ByZdDuD
	 0b9zOoSLnQClPCg+AlMkLTMZiilKOVZxy8AS3s7N/Pog3n6b0Q+i36v4bcFShdoKNt
	 Ek1xp6zdLKJxw==
Date: Sun, 15 Mar 2026 17:29:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/17] lib/bootconfig: check xbc_init_node() return
 in override path
Message-Id: <20260315172932.ed42a206343b7a2cc1fe4718@kernel.org>
In-Reply-To: <20260314230155.155777-17-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
	<20260314230155.155777-17-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 23:01:54 +0000
Josh Law <objecting@objecting.org> wrote:

> The ':=' override path in xbc_parse_kv() calls xbc_init_node() to
> re-initialize an existing value node but does not check the return
> value.  If xbc_init_node() fails (data offset out of range), parsing
> silently continues with stale node data.
> 
> Add the missing error check to match the xbc_add_node() call path
> which already checks for failure.
> 
> In practice, a bootconfig using ':=' to override a value near the
> 32KB data limit could silently retain the old value, meaning a
> security-relevant boot parameter override (e.g., a trace filter or
> debug setting) would not take effect as intended.

OK, this is a real bug. It should be handled.

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")

Thanks,

> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 038f56689a48..182d9d9bc5a6 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -728,7 +728,8 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
>  		if (op == ':') {
>  			unsigned short nidx = child->next;
>  
> -			xbc_init_node(child, v, XBC_VALUE);
> +			if (xbc_init_node(child, v, XBC_VALUE) < 0)
> +				return xbc_parse_error("Failed to override value", v);
>  			child->next = nidx;	/* keep subkeys */
>  			goto array;
>  		}
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
