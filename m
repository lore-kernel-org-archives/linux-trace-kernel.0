Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A237C103;
	Thu, 21 May 2026 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374669; cv=none; b=uE3JfFUkC6cK04USPegATxVGttckAmALtnGKynHRCP6rDVud+DQNlkQnfodMIdXC3efe9CxeUc/rim7xnj4XUKwBBzeOppslihs0QpM3ExYg4cP6tZSijZsV8EE6XvLO0o/EQIGyS0K4Zrbic7WaOeWaiaLH7QFk3DZwCgV4Hng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374669; c=relaxed/simple;
	bh=YWnuCmo39VRXWuhYlAChjOFc5n3q+YRgpgB65eXQpec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9rvQPc9+iK+b5kqmix89j7T8QpOzMxUo2MWZFxTTe/V5+ju5PwAQeVcpH/No0niObaZUHpIyiu1uQ8SktVZHEdGDLPh+5uT4wHhg/n9Z7khseeXu6/aie++yATzdE/ZszjghgVfmERsxYzkUygORut2so5AwFdm9wlaLbisHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id CB378A064A;
	Thu, 21 May 2026 14:44:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id F2F3420010;
	Thu, 21 May 2026 14:44:24 +0000 (UTC)
Date: Thu, 21 May 2026 10:44:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] tracing: Bound histogram expression strings with
 seq_buf
Message-ID: <20260521104445.29827219@gandalf.local.home>
In-Reply-To: <20260521022817.38453-2-pengpeng@iscas.ac.cn>
References: <20260521022817.38453-1-pengpeng@iscas.ac.cn>
	<20260521022817.38453-2-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6fxmo1bducn5nfkm7b6rsqw1se7y1wjd
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: F2F3420010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Elt9ygHV5E/1Q1dnePQDUL4896XB0nyo=
X-HE-Tag: 1779374664-455280
X-HE-Meta: U2FsdGVkX1/soynrhDH2dI97GNkbddK4DJtxPxM7ChfOraAohUdo8KS5nLyZvf0e9VAEQzNGFGiDxc8uWcLNLHm6CQyqpyHoM7EZjTyvoImytgRdYXmnWcMn4tNFRPwqo/fdkIh/D56SNuXziDfTw0ApT4sGYVl3+KQDx6xP7yIH1cRcjOkT/ysXJc52BMKLC7pO8/duy+hjZPYDGJLiNNOZjSMvYdB7yOgJU0r8yCd6ypbNjF3+4xWx82sOnCq+ikfFEHsEPC2F38fqiucFCz0vl9nKpnwYSBwXCIpSnNzjkC+NbbruXeNVrLdJqPE6

On Thu, 21 May 2026 10:28:17 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> @@ -1778,47 +1783,56 @@ static char *expr_str(struct hist_field *field, unsigned int level)
>  	if (!expr)
>  		return ERR_PTR(-ENOMEM);
>  
> +	seq_buf_init(&s, expr, MAX_FILTER_STR_VAL);
> +
>  	if (!field->operands[0]) {
> -		expr_field_str(field, expr);
> +		if (!expr_field_str(field, &s))
> +			return ERR_PTR(-E2BIG);
> +
>  		return_ptr(expr);
>  	}
>  
>  	if (field->operator == FIELD_OP_UNARY_MINUS) {
> -		char *subexpr;
> +		char *subexpr __free(kfree) = NULL;
>  
> -		strcat(expr, "-(");
> +		seq_buf_puts(&s, "-(");
>  		subexpr = expr_str(field->operands[0], ++level);
>  		if (IS_ERR(subexpr))
>  			return subexpr;
>  
> -		strcat(expr, subexpr);
> -		strcat(expr, ")");
> +		seq_buf_puts(&s, subexpr);
> +		seq_buf_putc(&s, ')');
> +		seq_buf_str(&s);
>  
> -		kfree(subexpr);
> +		if (seq_buf_has_overflowed(&s))
> +			return ERR_PTR(-E2BIG);
>  
>  		return_ptr(expr);
>  	}

Wouldn't the above if statement be a lot nicer as:

 	if (field->operator == FIELD_OP_UNARY_MINUS) {
		char *subexpr;

		subexpr = expr_str(field->operands[0], ++level);
		if (IS_ERR(subexpr))
			return subexpr;

		seq_buf_printf(&s, "-(%s)", subexpr); 
		seq_buf_str(&s);
  		kfree(subexpr);

		if (seq_buf_has_overflowed(&s))
			return ERR_PTR(-E2BIG);
 
		return_ptr(expr);
 	}

In fact, the above is so simple, you don't even need to use the __free()
guard on subexpr.

BTW, because currently seq_buf_printf() does add a '\0' to the string, I
may update the API for seq_buf to state that you don't need to terminate
after calling that function. So you can leave out the sub_buf_str() after
calling seq_buf_printf().

-- Steve
