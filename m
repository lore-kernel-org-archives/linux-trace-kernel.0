Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022893;
	b=d6o3VD2SKNSNXSBVZpa8h0vs6TbyDZTt1xlGXrWW724TqTeeymswMdFHcjvkwojX2hdy
	 H6C1qBj5mPPXMlmYHg2IoqYuodYxpqev4D0OpfDmFFoSoaN10R1vyJfQIOmZvqj8hC/+Y
	 9HTrVdScbEaSjEZJtJi66Z0jEQyblaGLIH+3a4FXZNgktIBqgH1Zcn1d/iXQcVcThDBay
	 eShOZRYC14szerA0ZS1A+lpUWkYQSR2hgOTGRnqFolmrYniBFwof4eqlMLPl6NRdD7RFZ
	 QLzMA/Pnx/Rz8apybEnFBoViTBGBw7N+KzBdc3/Pv4A92dg0sjgCJVESY3rFFuegoXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022893;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=hOTfs2v2iDvj2E4OaTxuD6RwNGMZU1vNHhMRWueYZOM=;
	b=ijlbT7A+5Av8ZKNn6R2DseFX8DK4jkixJquZdjUYnkKH+5TLclze23vj18StraIqSC4e
	 Rf2K1q4ySJWaCvPK17Nks7yLfO/Fh5MZG+mHLQ5CDdRbEkcBuSX5YClaAemi3TNO7zq47
	 DrpzqWlXc3BRPXkAHcE7o7F9iCBMa6+bl0ah0fJDV3FkptiERlkh0Bq/qNr1UCOZOnOml
	 9EeBKVxaUHim+6o/Vypt0Es/YZ3GwbblYBkisAHzIrkymot/anmo2+CHbEjX9BjBGZ0Gg
	 lLARQo4LHXrKmG0NCg0s4yViwZyb4MLNSZBVFGZNkWya2I78Lu0UjQHf3uAx8lk9qJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=bIEdJ72m;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AC0606A31A;
	Mon, 26 Oct 2026 13:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2AC0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=bIEdJ72m
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 89AAC16079C;
	Mon, 26 Oct 2026 13:54:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 979CD20027;
	Mon, 26 Oct 2026 13:54:42 +0000 (UTC)
Date: Mon, 26 Oct 2026 09:54:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/10] tracing/filters: Fix MATCH_END_ONLY regex
 matching for fixed-size strings
Message-ID: <20261026095441.6a1a7357@gandalf.local.home>
In-Reply-To: <179285913336.466249.16045710288666912574.stgit@devnote2>
References: <179285912318.466249.7425922682086130057.stgit@devnote2>
	<179285913336.466249.16045710288666912574.stgit@devnote2>
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
X-Stat-Signature: um5g6o5651taxodn41u6frb9sxnfeicw
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 979CD20027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18P7eHC48ujQBZ6Jz2qrmtd2fkpDrCPQ4w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=hOTfs2v2iDvj2E4OaTxuD6RwNGMZU1vNHhMRWueYZOM=; b=bIEdJ72mGKP9A+EcggH4T0Pcz8GKXfFecf8D3yJOoMO/ghHqb2nKod/9Qbn1Uttm3Fhkokk2kkRzAVwqUuhTWNyrfJBo8VxXmGWPZHdF1UAeHRR2fNTp1efbZVfZsVcpDEc+GcItSS6CqMmoboG5PUaPbqP8SP+lFvDcQX0zK8c=
X-HE-Tag: 1793022882-614559
X-HE-Meta: U2FsdGVkX1/JGocKmJ9ld+SXvPp0CZsI0e7L1gxOirIrx6ARJHazz6LwZspSj2g2QnSkuPXYGrhajZUX4oMkShyPsX0LRZJO9cfi7hKLx9nh177pO7SmymObhPQ+wfAz3NFPeD/3EbKbLzUh4U9FBNlBgVfgwP4eduf5fU0ZV6Z3LGeSFGByZjtg5yVoovtsa+JC4q8n+nJx2uB0EOsMV0LBBETxVRymqg5r6+gTE3RnM5pVZLOgCr3FFFMtrVeUHDl9nM2uAxivrYrSP8C5mew/3ZSIlMthNYe7zXfYB2uG+1oCCJuldcaoIPPfc6xrs+6kujdWXPph3kZ6PQkUuzjt1tlLza2l

On Sun, 25 Oct 2026 01:25:33 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> regex_match_end() calculated string length as "len - 1", assuming @len is
> the string length including trailing '\0'. However, for fixed-size string
> fields, filter_pred_string() passes field->size as @len, and for "comm",
> filter_pred_comm() passes TASK_COMM_LEN as @len.
> 
> Because @len in these cases represents the buffer capacity rather than the
> actual length of the string, regex_match_end() tests against the tail of
> the buffer (typically trailing '\0' padding) rather than the end of the
> string. Furthermore, if @len is 0 (denoting a dynamic string ending with
> '\0'), "len - 1" underflows to -1 and never matches.
> 
> Compute the actual string length using strnlen(str, len) when @len is
> non-zero, and strlen(str) when @len is zero.
> 
> Fixes: a3291c14ecf0 ("tracing/filters: Fix MATCH_END_ONLY filter matching")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_events_filter.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 5e74d2dae40a..18ce3ec00d34 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1075,10 +1075,10 @@ static int regex_match_middle(char *str, struct regex *r, int len)
>  
>  static int regex_match_end(char *str, struct regex *r, int len)
>  {
> -	int strlen = len - 1;
> +	int slen = len ? strnlen(str, len) : strlen(str);
>  
> -	if (strlen >= r->len &&
> -	    memcmp(str + strlen - r->len, r->pattern, r->len) == 0)
> +	if (slen >= r->len &&
> +	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
>  		return 1;

This slows down the code as it adds more strlen() calculations (it could
have already been done.

Let's fix the callers instead and have them pass in the real length.

-- Steve


>  	return 0;
>  }

