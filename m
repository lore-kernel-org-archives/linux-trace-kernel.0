Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD737CD57;
	Thu, 12 Mar 2026 21:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349379; cv=none; b=WTdilFPGIE8H3l30uh4FcEfAIk7U/7fJG8E3R8zU/i6L6GAgwNkiJLglH8TFy5v2B6sjD3CoHe6Vi+Kzliy/zQo6+En8Gt8WypZnkNt9kSYjcsMWZVA2c4usxiL9Hp32kpCs5Ex7OBMmVDCLnJOXXNArkqgWEavZSYi3iTaK7a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349379; c=relaxed/simple;
	bh=DJlOVJM3fm1IhiBktK6gtAAmyxsdcNNhll0tvxjLqEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTQi1+In+eInURVNpTERt4lgb6xp5YDkTXB7x9Q4FYnFFQXMhEFAsSZ1Ekv42DsiF1zvlzrYcbeRD7ZYYekmwakSqAZQYQFEdX2cwVJ/3jcomHwuIm5wzLZESHU3H8KwsXpdIhOfDgbl/0eCSLPNr+hb6VzqTlrXr+mbYCKS1XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 8FF6313AC35;
	Thu, 12 Mar 2026 21:02:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id B5D731D;
	Thu, 12 Mar 2026 21:02:48 +0000 (UTC)
Date: Thu, 12 Mar 2026 17:03:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Law <objecting@objecting.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] lib/bootconfig: fix off-by-one in
 xbc_verify_tree() unclosed brace error
Message-ID: <20260312170303.61c1233c@gandalf.local.home>
In-Reply-To: <20260312191143.28719-2-objecting@objecting.org>
References: <20260312191143.28719-1-objecting@objecting.org>
	<20260312191143.28719-2-objecting@objecting.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hmwtngpgyygex5qbdegf8goipoaqkehb
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B5D731D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/s1dRkQi0j6hsucEyNB9f3oPHaYwl+ikc=
X-HE-Tag: 1773349368-717073
X-HE-Meta: U2FsdGVkX1/ssGB6KlQONgXySq7yqR7Bk6UzaI8TdymGdidP3WeJLzIuF5yqcN2jlXKe7eEIxHCIsJTSwvl+skUKHEPAkZf9ApocD/vJNf5XHLR0v97dXosUD3e6wT+fhf+sdvMq2vq2nk1+S3G3nq2Nzu7ZwPLvAyTqVnLounTl5Ju6WNOBO9bjkviPPaX44PzSvcreMMmhhncFByfzFqF7Ykck65lfQBXE8D2dG3DJ9Hj0X1U2Mixpqz13POPdzti99dMWhKoumxJH79seAbYhlnvXLL4gfqmSMC2yF+/ChwHW9ll9pE5Qv3hMmgCHmVhozEOM6a7wBvoSozo9zpmg0szrBtwVK0wrszor8Wl20JoBiya56XvTLShkZgLPifoSmnGR1pkxqFDSel3lmJMHRyhzAFifEb9jplSins9bsQfhwYjU50iZKf27PUtwpiWMojV1IojEZuc7pWJQ8A==

On Thu, 12 Mar 2026 19:11:41 +0000
Josh Law <hlcj1234567@gmail.com> wrote:

> From: Josh Law <objecting@objecting.org>
> 
> __xbc_open_brace() pushes entries with post-increment
> (open_brace[brace_index++]), so brace_index always points one past
> the last valid entry.  xbc_verify_tree() reads open_brace[brace_index]
> to report which brace is unclosed, but this is one past the last
> pushed entry and contains stale/zero data, causing the error message
> to reference the wrong node.
> 
> Use open_brace[brace_index - 1] to correctly identify the unclosed
> brace.  brace_index is known to be > 0 here since we are inside the
> if (brace_index) guard.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>

Nice catch. May I ask how you found this.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 2bcd5c2aa87e..a1e6a2e14b01 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -802,7 +802,7 @@ static int __init xbc_verify_tree(void)
>  
>  	/* Brace closing */
>  	if (brace_index) {
> -		n = &xbc_nodes[open_brace[brace_index]];
> +		n = &xbc_nodes[open_brace[brace_index - 1]];
>  		return xbc_parse_error("Brace is not closed",
>  					xbc_node_get_data(n));
>  	}

