Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195443;
	b=ssr8H7E4zXpr7vj+s6yJQVKRdyV2HBpzeymQrrOXgA965osR3lIvzu/dyi+hW0+J+rZB
	 x4HwKp4zmDbCEROdLrRKMrkHbbgBqe9EnuEIe2ramH3u7VabhOq/2iYaUUPhTITjkyAd9
	 IioX4GKAWnHHi+VqtK4+re3pVXclos1oM950Y3zvSQ/onF9CLiY3RiaUhVbHdbf9CqnAP
	 g8SSt/tj8h2KxEQsL47hZYu1WEOn/yxGUE3oLaVUYCtcBIM3G043HP+fNMFYxO1OPjIm5
	 Lkf7cILlGsecV4KRFpiQEH2QviK0IAfBh85D682znnHP6YxvR1SE+YNVNz98AIXpMqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195443;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=kQovNqOnu/lDqzmDc2nmur9m8xiHHfYg6zgT6o8CmZc=;
	b=xDyeza449PxChqkjLhiyQz4IMjIfbt5pPHDuwYWw2S0NSEWq07bltZoEev46XIrVFY/x
	 AwqztVlIQGi3c/W+uhzL7QvN1Sq7fO/7uUFSSBoRJToeGXHo7kptRGN/Z7q2JKheij+bU
	 bVRCKjnPiowF+4HD36Ato3KJ1NCESCJTJqXgBFiEalQLGpUKtoq1geaI4ULLuIH29rr2C
	 GF6ENji5oAzFDP7oKlhYEqPPuhfs9FvCdS65ZDDZ49WVei2KBCrUG1oIFnwXCePjw54co
	 pICPCbbUJanFSAP3SpU/oEsNZymRj/AF1DYe++RXYwFHyRcbFq74HNCofhFYIDv7vng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=dLcsRIce;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B2606A31C;
	Wed, 28 Oct 2026 13:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F39B2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=dLcsRIce
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 68BDF1A0C85;
	Wed, 28 Oct 2026 13:50:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 74D398000F;
	Wed, 28 Oct 2026 13:50:38 +0000 (UTC)
Date: Wed, 28 Oct 2026 09:50:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 09/16] tracing/filters: Reject stray quotes and
 parentheses in unquoted function event operand
Message-ID: <20261028095037.39c9109a@gandalf.local.home>
In-Reply-To: <179314828848.684037.8273600995293830928.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
	<179314828848.684037.8273600995293830928.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 74D398000F
X-Stat-Signature: 8i1w7ab9n58q41tpqzdh1u3htskrbhs5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX195paMB6BqNfe7MT1rNQtQVS+Ffdp0Jqmg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=kQovNqOnu/lDqzmDc2nmur9m8xiHHfYg6zgT6o8CmZc=; b=dLcsRIceUIsmwYxxJI/TPiEVDsd0QqacHgQxYZHuFD8ESFbj6rvGTpO/0CDwnoLF1SRRDzfPJJrG9msGP5s6decjXrC5wWnMAhsQziy2r2FmmBeAhJv6U2SysTbULkM3iIqCq1l8rVHLCNtFunJje/XVhgByMoIbEUZI3XSxBpY=
X-HE-Tag: 1793195438-634045
X-HE-Meta: U2FsdGVkX19skSxYU4ojqKihr13ef/QFf7dXJEFZyGynjhbNkVcJUZ28CA7foZdltKZGvCICP0D5fKodnnXS+laz+wX+h33JshqsA3jUjozxo5NhXG5F7xAfn2AZ+DhY2rRP4ERyBbm3k5/Z+I4/m11ea/yjeNucg4H94KvHZfyQDp6RHo1u2dwaFlMXlr10dEcbyHdrEykYx8Yf8QU/wBFS/cNFW3RQSsO6/yc6zR6SEH2Ckrg5JQnKYcqEd7I9mVUO248gYz2hai4Jmx8higkdbhpkfX1vHP3NTjKFuNiiaGNAOTf6C4EWXANh98uZJ3BJjUizeUmst+lix+Ha5F+5ENWDt6OF

On Wed, 28 Oct 2026 09:44:48 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In parse_pred(), when parsing an unquoted operand for function events,
> the loop only stops at ')', '&', '|', or the NUL terminator.
> 
> However, calc_stack() parses '(', '\'', and '"' independently to
> determine stack depth and string boundaries. If an unquoted function
> operand contains stray quotes or an open parenthesis (e.g. "ip == foo'bar"
> or "ip == foo(bar)"), parse_pred() consumes them as part of the function
> name operand, causing parse_pred() and calc_stack() to desynchronize.
> 
> Reject unquoted function event operands containing '(', '\'', or '"'
> by reporting FILT_ERR_INVALID_VALUE.
> 
> Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> Cc: stable@vger.kernel.org

I wouldn't really call this a fix, as I can't see this breaking anything.
Yes, the calc_stack may say there's more elements than what parse_pred()
sees, but the parsing still fails.

This looks more of a clean up than a fix.

Unless, the current code allows something to actually be broken. Does it?

-- Steve


> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v3:
>  - Split from the monolithic function event parsing patch into a
>    standalone patch rejecting stray quotes and '(' in unquoted operands.
> ---
>  kernel/trace/trace_events_filter.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 96977eb9af85..48e16d75be74 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1863,9 +1863,17 @@ static int parse_pred(const char *str, void *data,
>  		for (; str[i]; i++) {
>  			if (q && str[i] == q)
>  				break;
> -			if (!q && (str[i] == ')' || str[i] == '&' ||
> -				   str[i] == '|'))
> -				break;
> +			if (!q) {
> +				if (str[i] == ')' || str[i] == '&' ||
> +				    str[i] == '|')
> +					break;
> +				if (str[i] == '(' || str[i] == '\'' ||
> +				    str[i] == '"') {
> +					parse_error(pe, FILT_ERR_INVALID_VALUE,
> +						    pos + i);
> +					goto err_free;
> +				}
> +			}
>  		}
>  		if (q && !str[i]) {
>  			parse_error(pe, FILT_ERR_MISSING_QUOTE, pos + i);

