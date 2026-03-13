Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44531A267;
	Fri, 13 Mar 2026 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368816; cv=none; b=DgSrYBkm1TjjBpp5IYictTJLY9dTa1GJHDscWenN/thR3JMHFn6XcmSXtmRK4Vh/w8AcAvaQWYPjhqts24KAwuQYFMBYwUnPvZIslAt+2vDUAQaODQY4KP74xaUfDcjPDQtJiJynSNBNNmuKu2y6C9kPRSMHTcUkbU8b9Bd59jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368816; c=relaxed/simple;
	bh=LFyclqZwemoID6W7OZ9uCtPIBTrteWpAtRT9b9viEmA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S1AJZtEAtmainxq1HsVyqsgwewB/I6+Yq9bgjz0jk7+teolYUu8PTAuPK46C8SUmwJm8fFjESXVe3/OVfTkAHT+HvlI0DUt/dPvJmS3nBTcaGaI82T+Fi73hiE3Wv3cH22oz/b0BcT8J79OZZ6sVogUb1GDboRzuQUGb629DlOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6owGfe/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6owGfe/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74B2C4CEF7;
	Fri, 13 Mar 2026 02:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773368816;
	bh=LFyclqZwemoID6W7OZ9uCtPIBTrteWpAtRT9b9viEmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r6owGfe/Wjn3X55WYKlxwA489oQA2v3hQr/GORH8CxSKWzw2/onjmMNr0XWWfDWO8
	 +g1064PkCK/QDTKjRTQb9ELEZ3VrMfSNdCIKUb6+opvmos+Y7EhRcKq1SuNYwQgCko
	 G3cyBUERzQ9IHe3U/Gp8jCID/TZV5F2XlfRY9mlpku6i1H9yQ58xWpDGc16i5Mb/dy
	 pj+cSO0fe5ymQJhuLHjYv/f3tAnYgvIsTdGeTbUwHL5lW6s0xb/FLvGkfPWpIZqvTc
	 37s3VMvLLq9QKutZIqddmcq5HZvcbRjqsoXjP6z/BSyNwEDVT4czq2CnS6tXu6tgj/
	 wyllHOIlK6LuA==
Date: Fri, 13 Mar 2026 11:26:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Law
 <objecting@objecting.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] lib/bootconfig: fix snprintf truncation check in
 xbc_node_compose_key_after()
Message-Id: <20260313112652.098e6cb456091d0936032663@kernel.org>
In-Reply-To: <20260312191143.28719-4-objecting@objecting.org>
References: <20260312191143.28719-1-objecting@objecting.org>
	<20260312191143.28719-4-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Mar 2026 19:11:43 +0000
Josh Law <hlcj1234567@gmail.com> wrote:

> From: Josh Law <objecting@objecting.org>
> 
> snprintf() returns the number of characters that would have been
> written excluding the NUL terminator.  Output is truncated when the
> return value is >= the buffer size, not just > the buffer size.
> 
> When ret == size, the current code takes the non-truncated path,
> advancing buf by ret and reducing size to 0.  This is wrong because
> the output was actually truncated (the last character was replaced by
> NUL).  Fix by using >= so the truncation path is taken correctly.
> 

OK, but this one is a minor issue, because either way, remaining
size becomes 0.

		ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
			       depth ? "." : "");
		if (ret < 0)
			return ret;
		if (ret > size) {
			size = 0;
		} else {
			size -= ret; // if ret == size, the size becomes 0
			buf += ret;
		}

Anyway, to be clear the correct error case handling, this
should be applied.

Thank you!

> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 62b4ed7a0ba6..b0ef1e74e98a 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -316,7 +316,7 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
>  			       depth ? "." : "");
>  		if (ret < 0)
>  			return ret;
> -		if (ret > size) {
> +		if (ret >= size) {
>  			size = 0;
>  		} else {
>  			size -= ret;
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
