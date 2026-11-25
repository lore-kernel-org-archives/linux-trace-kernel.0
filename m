Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567485;
	b=y4P+bH4dfY6SUU3+7z3rlwcTbxbWN2eNgWkp+Jq97HCIxkpgmdSVcBuTCzfzwAIEkzqp
	 k9gJ5pF864kQqt/6IR7EJvhKJj4CXv8yU6PWSpE+gmqy6ZxQLtchGOjVN9LlwpKtdoc3y
	 AK0KFw4M6Np1L6e6SRVXylQQPafMQbnXUT17uNbp0soszD6CJwefsMRDipQqfdRDecRUh
	 kw246BRe+DbQYM5C4MuipK92t/zQprH/ZvDdheC/t/1PNmREjdY4CCu21mp7RGiREAxgk
	 7+jfuDHpAUpRT/imM6pTEPWcKBrbwsGnmP7sl22nGGwZdr4yEXtTPNPZT9/jMA7yIlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567485;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=eLqiru6IB8X1vm5kTLkMtYcaQdNbgpYL+qb0lIcTVWo=;
	b=dh7vNYk8T032bTY+7e7l+CZf93MQYVZffhgLGh3G32IFRSCDdvv2jv5bQIPoZlM7A8+2
	 w2HqPWskB4jshFRSeZcacVGmLYIvvP0X7OJuZKARtk3F/N/WUXKb+975NOwRsFkqajaio
	 YLwmm1fFpaAxhUF7mi0SXZjwFGwLCXp6036g7cuCgVFZK8CZeIktBsKa+0tNlwI5cC0un
	 RWIFsm/VN40Nb19raz8k76A9FhH6pQa7wasxFACNcxetXLmRPfb6J1/39/NBXZMdUpgd9
	 Q7B3iG8QSSDOOjCvllx6xwRFJLho7ZgZiJGuyosiN/+1MTkr2BhD1BXzQKDpFrRcM/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=XByrIElw;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B06606A321;
	Wed, 25 Nov 2026 00:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9B06606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=XByrIElw
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6B4F21C486B;
	Wed, 25 Nov 2026 00:44:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 75B8730;
	Wed, 25 Nov 2026 00:44:35 +0000 (UTC)
Date: Tue, 24 Nov 2026 19:44:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 13/15] tracing/filters: Fix error positions for CPUS
 mask parsing
Message-ID: <20261124194434.21d76102@robin>
In-Reply-To: <179323796570.740114.12151091552524337676.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
	<179323796570.740114.12151091552524337676.stgit@devnote2>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Stat-Signature: ytcodhten8f6ckybsp8n438zaez9mz7b
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 75B8730
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18JBBogJHR+mPThdh6z8Vw6dGAN+/JMwyk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=eLqiru6IB8X1vm5kTLkMtYcaQdNbgpYL+qb0lIcTVWo=; b=XByrIElwAmEiIV9tx4H+Gzi8X3Z0/D0XREouLdnKhWOv/fcS5n8QxJFB6GeoXRCZ6aA4UHUdlTCRjDaFHS52kuGwOGSghyUjoRGefPbwNCzddQmphIoos1HaB9u5mRenfpYgnxOs9xtxb5uBKVB5ra8mHfIx/DZXZj/TzvQf6ZQ=
X-HE-Tag: 1795567475-545701
X-HE-Meta: U2FsdGVkX19eY7ChfWCVUrNiHsjN5Stn/IWM6xZezIl6wvc2QvZUQPV8qfUSdBoYMH6uWWGglgFGfMQT/F79WxgQ171wPoYGOGnyJdq5Jt+JbzebhhcWOc6XxuMISBHG+OH7uZ88vVlOcug49ltEzkbd1coa7zoycgnAXfWhI+j5ZVaaalsC4LidI9ijgoTkGYL8trmUdgw72xUpJw37VbL+I/C7KnegeR+A4/vWAfX0/3SI9XQ52Q0Ti33EfI/HBsGMXabUQ2TsBe7hZHm+JdniUw4CACbGvOi+YByLuZDdz4HYw3LSe4+dw7KRU2uo40W9QNFEMhWgCI2n+QTqIhomJowG69CK

On Thu, 29 Oct 2026 10:39:25 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> In parse_pred(), CPUS mask error paths report incorrect error positions:
> - Checking 'str[i++] != '\'{'\'' post-increments 'i' before calling
>   parse_error(), shifting the error caret one character past the
>   missing brace position.
> - In the CPUS operator check and comparison function selection check,
>   'pos + i' points to the CPUS operand or past it instead of the
>   unsupported operator.
> 
> Check 'str[i] != '\'{'\'' before incrementing 'i', and pass 'pos + op_pos'
> for the operator checks so the error caret points accurately.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v4:
>  - Drop Fixes and Cc: stable tags since these error position fixes are
>    cleanups.
> Changes in v3:
>  - Group error position fixes for CPUS mask parsing into a single patch
>    targeting commit 39f7c41c908b and commit 3cbec9d7b93d.
> ---
>  kernel/trace/trace_events_filter.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 9b1100769676..1a9a1cc8daa2 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1932,16 +1932,17 @@ static int parse_pred(const char *str, void *data,
>  		case OP_BAND:
>  			break;
>  		default:
> -			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
> +			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + op_pos);
>  			goto err_free;
>  		}
>  
>  		/* Skip CPUS */
>  		i += 4;
> -		if (str[i++] != '{') {
> +		if (str[i] != '{') {
>  			parse_error(pe, FILT_ERR_MISSING_BRACE_OPEN, pos + i);

Instead of moving the i++ to below, couldn't you just make the above:

  			parse_error(pe, FILT_ERR_MISSING_BRACE_OPEN, pos + i - 1);

?

-- Steve



>  			goto err_free;
>  		}
> +		i++;
>  		maskstart = i;
>  
>  		/* Walk the cpulist until closing } */
> @@ -2029,7 +2030,7 @@ static int parse_pred(const char *str, void *data,
>  			}
>  		}
>  		if (pred->fn_num == FILTER_PRED_FN_NOP) {
> -			parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
> +			parse_error(pe, FILT_ERR_INVALID_OP, pos + op_pos);
>  			goto err_free;
>  		}
>  

