Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9EC383C7F;
	Thu, 12 Mar 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349592; cv=none; b=Ebd+H6kFpo6bP33s+CFVBQkd+wHLmH15LhJbppF8Esu3105Bd02RI0R5HMG1AP5u4CCioZgsWTrCBRk+f5+HQxn1aoVLQxmPGrAj7OMVvDznD6EjCs0wIMzeL0dFfbJqr0CbSuThm3mbT+OhmazCr/MOJ9gqocI1f6WH6mFHQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349592; c=relaxed/simple;
	bh=nWb5mp+p9Y21N8D7Mt4REpwNCPCdd2RIV/ct8Naap2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzhPAGzh6aoE8654RUIRyBW2t6yLOTNPX4n2irhBe4FvGPcUTrentrPhDNKP8aEXjxAGFMK8Eh6M7+jd7WYaKGElFx8GVLUGIPCBa7DeorwiIQhW1uav2ociu5hzE/RdeJ4ltWwL3iqPsX7kn3AIyFpF/EalGfU9hTFLRB2BVXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 3C9B713AB4B;
	Thu, 12 Mar 2026 21:06:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 203463E;
	Thu, 12 Mar 2026 21:06:28 +0000 (UTC)
Date: Thu, 12 Mar 2026 17:06:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Law <objecting@objecting.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] lib/bootconfig: check bounds before writing in
 __xbc_open_brace()
Message-ID: <20260312170643.4b0f926b@gandalf.local.home>
In-Reply-To: <20260312191143.28719-3-objecting@objecting.org>
References: <20260312191143.28719-1-objecting@objecting.org>
	<20260312191143.28719-3-objecting@objecting.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 203463E
X-Stat-Signature: uc4tdhbgi5khhxc9ts987pi1ogdbwg3h
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19cC0q3K0lT63UEM7Kn/KgvA5Rdy92mv0M=
X-HE-Tag: 1773349588-285084
X-HE-Meta: U2FsdGVkX1/fG9H7DXMbwkSoK6EavXhwvMM2ye/tcieROPjWqh5V+dbHhcwgTY4GXZMv+QiY1kQM8DaXFVOPj41XaYhzt+C02AkLiAD07VPJ+A4MUo3tYvjhDmtVymjxkOqvIssDoC2Qu5QruSjkZ+8902ijA9eB695DNlbuDIzOxWSRX3TMSjFeX3IcQSIimRA7mPxDLjaTPAz07a09aPRoBi5AYkT4MLK52VDWkrBCLyt/21iY+6NCajpfG9Zcg+OIUe8kHgoMu59s4YV+EUiqDftd+hrH+ZgdEpC7JEeAZr7PO1ElpOTE5blJhG5WCMWDqHUO+HcDKef+6JJLoZ37ImiNQqkBpx8Qhb08dAByiAYfftnVtKD+HttG0KM98primW8pNpR0eeLbV+TPAA==

On Thu, 12 Mar 2026 19:11:42 +0000
Josh Law <hlcj1234567@gmail.com> wrote:

> From: Josh Law <objecting@objecting.org>
> 
> The bounds check for brace_index happens after the array write.
> While the current call pattern prevents an actual out-of-bounds
> access (the previous call would have returned an error), the
> write-before-check pattern is fragile and would become a real
> out-of-bounds write if the error return were ever not propagated.
> 
> Move the bounds check before the array write so the function is
> self-contained and safe regardless of caller behavior.

This is the only place that increments the index, and the check is >=,
which means even if there was just one space left, it would fail.

As there's no other place that updates brace_index, I don't believe this
patch is needed. It could even replace the >= with ==.

-- Steve


> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index a1e6a2e14b01..62b4ed7a0ba6 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -532,9 +532,9 @@ static char *skip_spaces_until_newline(char *p)
>  static int __init __xbc_open_brace(char *p)
>  {
>  	/* Push the last key as open brace */
> -	open_brace[brace_index++] = xbc_node_index(last_parent);
>  	if (brace_index >= XBC_DEPTH_MAX)
>  		return xbc_parse_error("Exceed max depth of braces", p);
> +	open_brace[brace_index++] = xbc_node_index(last_parent);
>  
>  	return 0;
>  }

