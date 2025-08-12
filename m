Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8172FE580;
	Tue, 12 Aug 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023853; cv=none; b=e7wZFjwt/MiBfOemXG6SXOz48k65430VhBUF612L9cSYWhKNZA5iSIdRvQ/0h9gExpo47qa6pOB5Y8gvMxwynsFAYOiY+77gkPADKDcNMZbd0AshuKrybP/2KDV0+ZaP6nES1whw20NCGe2kWbM8Y0uNEuwdcTmgh8Lv8jrODxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023853; c=relaxed/simple;
	bh=xdyl3wNJUL9EHqqJro185lpBfTTfmDjVvZZoTQKXqtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tv420E5XnKCdg/hmzUbvxg3wSruqM3ZSu4Fm1ukOwTq8gGL3NiU3jZyQ6b5DQwaD08r34pHx8Sj6TyjFFCOvjcwofofVrUrT1CLcPf0xtMSEKshJH0aUG5jiiM0XITBlIX4jks0tsNlwopcgDHVpUSHG+RMz3LBdNBcVJ6QHkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id E0AA1C0162;
	Tue, 12 Aug 2025 18:37:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 1B4A82000E;
	Tue, 12 Aug 2025 18:37:27 +0000 (UTC)
Date: Tue, 12 Aug 2025 14:38:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 pulehui@huawei.com
Subject: Re: [PATCH v2] tracing: Limit access to parser->buffer when
 trace_get_user failed
Message-ID: <20250812143812.3df42a3c@gandalf.local.home>
In-Reply-To: <20250806070109.1320165-1-pulehui@huaweicloud.com>
References: <20250806070109.1320165-1-pulehui@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 5a185amd6tbuffwtnkh7ciux83yz84x3
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 1B4A82000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18gcOGu3+FY9SK9Wp/5BgUn63hPXMMlCoQ=
X-HE-Tag: 1755023847-742556
X-HE-Meta: U2FsdGVkX18vGft3o/UTStQhqbdctPJOfkt53+XA2AoFDMHSNw23K2lfAkeTyB5Q7I22VVi49E9cKnZP5TImEQ567G1V/qx3WIjQ1fE0oD4O4DpSMT6VnHNG55qe1mvT/GwO+wTemynh7DKcKPkKNbvQtEV7c/mWxNQH5IqqdQkpCJV2gjNnrpOu81K/nNEXGMLuZ7OKtJyAsivzk62pxGwAVGVp7YS/8fB222T0FqFi9NVSJ8XmEtHUING/k3aA/S7283Kjw3KvPc3ylfYzPTQ/6ZVixjQjsUfkAbO0AN/n4YecKlkxqy+iEYU9sVHqy92w4YXUd3SMwZzLIH19KVziwM3df7IH

On Wed,  6 Aug 2025 07:01:09 +0000
Pu Lehui <pulehui@huaweicloud.com> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 4283ed4e8f59..138212f4ecde 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1814,9 +1814,11 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  	if (!*ppos)
>  		trace_parser_clear(parser);
>  
> +	parser->fail = false;

This should be set when the parser is initialized.

> +
>  	ret = get_user(ch, ubuf++);
>  	if (ret)
> -		return ret;
> +		goto fail;
>  
>  	read++;
>  	cnt--;
> @@ -1830,7 +1832,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  		while (cnt && isspace(ch)) {
>  			ret = get_user(ch, ubuf++);
>  			if (ret)
> -				return ret;
> +				goto fail;
>  			read++;
>  			cnt--;
>  		}
> @@ -1848,12 +1850,14 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  	while (cnt && !isspace(ch) && ch) {
>  		if (parser->idx < parser->size - 1)
>  			parser->buffer[parser->idx++] = ch;
> -		else
> -			return -EINVAL;
> +		else {
> +			ret = -EINVAL;
> +			goto fail;
> +		}
>  
>  		ret = get_user(ch, ubuf++);
>  		if (ret)
> -			return ret;
> +			goto fail;
>  		read++;
>  		cnt--;
>  	}
> @@ -1868,11 +1872,15 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>  		/* Make sure the parsed string always terminates with '\0'. */
>  		parser->buffer[parser->idx] = 0;
>  	} else {
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto fail;
>  	}
>  
>  	*ppos += read;
>  	return read;
> +fail:
> +	parser->fail = true;

Should have a helper function called: trace_parser_fail(parser) and use
that.

-- Steve


> +	return ret;
>  }
>  
>  /* TODO add a seq_buf_to_buffer() */
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 1dbf1d3cf2f1..5072bb25a860 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1292,6 +1292,7 @@ bool ftrace_event_is_function(struct trace_event_call *call);
>   */
>  struct trace_parser {
>  	bool		cont;
> +	bool		fail;
>  	char		*buffer;
>  	unsigned	idx;
>  	unsigned	size;
> @@ -1299,7 +1300,7 @@ struct trace_parser {
>  
>  static inline bool trace_parser_loaded(struct trace_parser *parser)
>  {
> -	return (parser->idx != 0);
> +	return !parser->fail && parser->idx != 0;
>  }
>  
>  static inline bool trace_parser_cont(struct trace_parser *parser)

