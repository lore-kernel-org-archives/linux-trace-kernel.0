Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4605026F29B;
	Wed,  8 Apr 2026 21:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775683561; cv=none; b=KH4ecwPypyJszr5rdop2A3bHm27wV3OVKwBpeiTrmpUOTcmvURWPvLT6VgwzU69T5LrM9by4l6jeOvuwspGshFfjdIhpvi+CjZCekgBqquYaIM2mK/OUsP0aDJ1l8KOONm5llKMvtCmqLYH/txEJ4t5v1ZVUWjInHJk/Jcu9E1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775683561; c=relaxed/simple;
	bh=vrU38oo5mk0tQ8vxZypC7+4pf8hBttoghWsoPLAxZz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QfGy2mENZi9p7EE8VqtsuKnY1TgYuPxeuaToOiwXDE0lAo00o5gFzoBhNBE0G+n92Ee0PAaRWDr6MQ2fuWp4F9OnkL7yaoHHj9Kb4sDB3CSsH/fab39BGKDeSZmlk9cKZMFTDZWjHMMTr/4CF3r3CsVQUtcgxEpqbqXAFEAsIKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 21D881B6E42;
	Wed,  8 Apr 2026 21:25:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 6A6F620024;
	Wed,  8 Apr 2026 21:25:57 +0000 (UTC)
Date: Wed, 8 Apr 2026 17:27:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/hist: bound expression string construction
Message-ID: <20260408172714.77343880@gandalf.local.home>
In-Reply-To: <20260407153001.1-tracing-hist-expr-pengpeng@iscas.ac.cn>
References: <20260407153001.1-tracing-hist-expr-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zax6grwrnajaesgz8aitg3p3co3b3jec
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6A6F620024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18DzHfA4Or+MSaAob5CT8/CfNJ/5TfSXyU=
X-HE-Tag: 1775683557-372231
X-HE-Meta: U2FsdGVkX1/m8/ujZv99/UOCnZeyoo55Gv2owYxnrTvd430YaLOP1CBAGza12EkP53TwwZfSNEB30u7r8QCqwsun7C+tyi9G+O/VMfLlkCJT/U+vCp3XJ3aSL7oeS5jPDDvToVTny/P0VnBhJWmEc3cGA00gWsu/C42+TDa4DAw2hi7/TWrergc/MM/XwxjxYJNOyIKp5k0rj92FBK1LwTlXkcr/PsIACi6KLcrOxIRpENljIXqT0NJCkh+Ivha/1jqfy3BhH4j8h9Ajr1TRxOOKB72UghsCIqqb3J3MGgqIFS54fhAqzB0EBjoAzVrE

On Tue, 7 Apr 2026 14:09:10 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> expr_str() allocates a fixed MAX_FILTER_STR_VAL buffer and then builds
> expression names with a series of raw strcat() appends. Nested operands,
> constants and field flags can push the rendered string past that fixed
> limit before the name is attached to the hist field.
> 
> Convert the construction helpers to explicit bounded appends and
> propagate failures back to the expression parser when the rendered name
> would exceed MAX_FILTER_STR_VAL.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  kernel/trace/trace_events_hist.c | 101 +++++++++++++++++++++++--------
>  1 file changed, 76 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 73ea180cad55..caaa262360d2 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1738,85 +1738,121 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
>  	return flags_str;
>  }
>  
> -static void expr_field_str(struct hist_field *field, char *expr)
> +static bool expr_append(char *expr, size_t *len, const char *str)
>  {
> -	if (field->flags & HIST_FIELD_FL_VAR_REF)
> -		strcat(expr, "$");
> -	else if (field->flags & HIST_FIELD_FL_CONST) {
> +	size_t str_len = strlen(str);
> +
> +	if (*len + str_len >= MAX_FILTER_STR_VAL)
> +		return false;
> +
> +	memcpy(expr + *len, str, str_len + 1);
> +	*len += str_len;
> +	return true;
> +}
> +

This looks like a better job for seq_buf.


> +static bool expr_field_str(struct hist_field *field, char *expr, size_t *len)
> +{

	struct seq_buf s;

	seq_buf_init(&s, expr, MAX_FILTER_STR_VAL);

> +	if (field->flags & HIST_FIELD_FL_VAR_REF) {
> +		if (!expr_append(expr, len, "$"))
> +			return false;

		seq_buf_putc(&s, '$');

> +	} else if (field->flags & HIST_FIELD_FL_CONST) {
>  		char str[HIST_CONST_DIGITS_MAX];
> +		int ret;
> +
> +		ret = snprintf(str, sizeof(str), "%llu", field->constant);
> +		if (ret >= sizeof(str))
> +			return false;
>  
> -		snprintf(str, HIST_CONST_DIGITS_MAX, "%llu", field->constant);
> -		strcat(expr, str);

		seq_buf_printf(&s, "%llu", field->constant);

> +		if (!expr_append(expr, len, str))
> +			return false;
>  	}
>  
> -	strcat(expr, hist_field_name(field, 0));

	seq_buf_puts(&s, hist_field_name(field, 0));

> +	if (!expr_append(expr, len, hist_field_name(field, 0)))
> +		return false;
>  
>  	if (field->flags && !(field->flags & HIST_FIELD_FL_VAR_REF)) {
>  		const char *flags_str = get_hist_field_flags(field);
>  
>  		if (flags_str) {
> -			strcat(expr, ".");
> -			strcat(expr, flags_str);

			seq_buf_printf(&s, ".%s", flags_str);

> +			if (!expr_append(expr, len, ".") ||
> +			    !expr_append(expr, len, flags_str))
> +				return false;
>  		}
>  	}

	/* Add terminating character */
	seq_buf_str(&s);

	return seq_buf_overflow(&s) ? false : true;

> +
> +	return true;
>  }
>  
>  static char *expr_str(struct hist_field *field, unsigned int level)
>  {
>  	char *expr;
> +	size_t len = 0;
>  

This could all be converted too.

-- Steve

>  	if (level > 1)
> -		return NULL;
> +		return ERR_PTR(-EINVAL);
>  
>  	expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
>  	if (!expr)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  
>  	if (!field->operands[0]) {
> -		expr_field_str(field, expr);
> +		if (!expr_field_str(field, expr, &len))
> +			goto free;
>  		return expr;
>  	}
>  
>  	if (field->operator == FIELD_OP_UNARY_MINUS) {
>  		char *subexpr;
>  
> -		strcat(expr, "-(");
> +		if (!expr_append(expr, &len, "-("))
> +			goto free;
>  		subexpr = expr_str(field->operands[0], ++level);
>  		if (!subexpr) {
> -			kfree(expr);
> -			return NULL;
> +			goto free;
> +		}
> +		if (!expr_append(expr, &len, subexpr) ||
> +		    !expr_append(expr, &len, ")")) {
> +			kfree(subexpr);
> +			goto free;
>  		}
> -		strcat(expr, subexpr);
> -		strcat(expr, ")");
>  
>  		kfree(subexpr);
>  
>  		return expr;
>  	}
>  
> -	expr_field_str(field->operands[0], expr);
> +	if (!expr_field_str(field->operands[0], expr, &len))
> +		goto free;
>  
>  	switch (field->operator) {
>  	case FIELD_OP_MINUS:
> -		strcat(expr, "-");
> +		if (!expr_append(expr, &len, "-"))
> +			goto free;
>  		break;
>  	case FIELD_OP_PLUS:
> -		strcat(expr, "+");
> +		if (!expr_append(expr, &len, "+"))
> +			goto free;
>  		break;
>  	case FIELD_OP_DIV:
> -		strcat(expr, "/");
> +		if (!expr_append(expr, &len, "/"))
> +			goto free;
>  		break;
>  	case FIELD_OP_MULT:
> -		strcat(expr, "*");
> +		if (!expr_append(expr, &len, "*"))
> +			goto free;
>  		break;
>  	default:
> -		kfree(expr);
> -		return NULL;
> +		goto free;
>  	}
>  
> -	expr_field_str(field->operands[1], expr);
> +	if (!expr_field_str(field->operands[1], expr, &len))
> +		goto free;
>  
>  	return expr;
> +
> +free:
> +	kfree(expr);
> +	return ERR_PTR(-E2BIG);
>  }
>  
>  /*
> @@ -2630,6 +2666,11 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
>  	expr->is_signed = operand1->is_signed;
>  	expr->operator = FIELD_OP_UNARY_MINUS;
>  	expr->name = expr_str(expr, 0);
> +	if (IS_ERR(expr->name)) {
> +		ret = PTR_ERR(expr->name);
> +		expr->name = NULL;
> +		goto free;
> +	}
>  	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
>  	if (!expr->type) {
>  		ret = -ENOMEM;
> @@ -2842,6 +2883,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
>  		destroy_hist_field(operand1, 0);
>  
>  		expr->name = expr_str(expr, 0);
> +		if (IS_ERR(expr->name)) {
> +			ret = PTR_ERR(expr->name);
> +			expr->name = NULL;
> +			goto free_expr;
> +		}
>  	} else {
>  		/* The operand sizes should be the same, so just pick one */
>  		expr->size = operand1->size;
> @@ -2855,6 +2901,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
>  		}
>  
>  		expr->name = expr_str(expr, 0);
> +		if (IS_ERR(expr->name)) {
> +			ret = PTR_ERR(expr->name);
> +			expr->name = NULL;
> +			goto free_expr;
> +		}
>  	}
>  
>  	return expr;

