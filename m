Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0209617A586;
	Mon, 24 Aug 2026 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603970; cv=none; b=Avxz/XGsAfkOdrQThA4QOegnZflrbXLulGPiFkh1KVNeN4Bm9PcWkOcg+k4ib98LLt++rjcNooJpCHe2w3YgwASTEHhdnv3/hxYWmEQgvOcOUWKKjqA/3ZRsXcr8YO5xbMTYxEmAnZDoQExRDOYWe+uqdfQSr6kxBgpyvLIz6Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603970; c=relaxed/simple;
	bh=P3T/wTvDwVQ/z5rH4jAZzB7tr9PvbIlOEcK+2ATCOME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MG18h4+jkD7QbjSMfFj8C33NNc4l1K7Va6lQ28jJYM/V9+Jp1A3HNt/um1xnWaXPQbYaCo2UubdunJOGJe3aMzAdGGf8ikxzeFNe48OqJF5bepISt7gJ6GXe3OHrF8XOadiP0TOvYtNThprXJiYFPk9/lXJxPQQ2cVWbAqSQFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=1bKtZ5aX; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="1bKtZ5aX"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 40E79A0202;
	Mon, 24 Aug 2026 20:39:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 677B52000E;
	Mon, 24 Aug 2026 20:39:19 +0000 (UTC)
Date: Mon, 24 Aug 2026 16:39:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [PATCH] tracing/user_events: Don't destroy fields when event
 removal fails
Message-ID: <20260824163955.522cb5b0@gandalf.local.home>
In-Reply-To: <20260824102907.4173063-1-bsdhenrymartin@gmail.com>
References: <20260824102907.4173063-1-bsdhenrymartin@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: h4gsx3r767mgt1mzqiewebyawfbprkkp
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 677B52000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19uAoyxjf6L7xul2TPS49drofXaslWNxRc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=pw1uqXR7UVv+MJbzTW4GHV9PKBiX/qlBHt3HK7X9tLc=; b=1bKtZ5aX+pIZtucXVrK0yj0wivXS9smhCPWf+stIPgxyFaqHPCix0VZivhAQeqrnKTAR86FYG7+BJPF4asa+z0BdoYfNW//dbGq569mAoxe1hJXsd6yXeCMP051Gp7iRLhuy26HYg7MBh5ZNDKqRb5YwxFq641iJOmwa+RIL9RQ=
X-HE-Tag: 1787603959-347586
X-HE-Meta: U2FsdGVkX195xlkZD5P+FMQLnhSSloc59SuWsmGF+qPn4legLj5h0pOikUcNknKj2X/wJTTXUzgLYXtgTweDGpelc4vSmxHn95M7PDqTwsX9BZ4dQ6fEFGqyDwtqfffqIpnWV+8xPq/Ni/XSurrxiHQfmIhCRGub0S5EYznK5B7HTkvNfFP1OIjwMSyc7SUof4FrWOg/G5KUJhznPuXbQu+8VVpssF7Ws+5thlawCWPzhymbJHyr6PnWwYeQTiitU3FFKL3AfN/K2G/acPrxrvKYPQp5t33niaEKuPmsJqJYJmpYct5h/TbUiAomyMSpYQm/Hq+d1gUegJbXE6TfKf2wHKeOlamu


Beau,

Can you review this patch?

Thanks,

-- Steve


On Mon, 24 Aug 2026 18:29:07 +0800
Henry Martin <bsdhenrymartin@gmail.com> wrote:

> destroy_user_event() destroys the event's fields before attempting to
> remove the trace event call. If user_event_set_call_visible() fails,
> e.g. because the event is still enabled and trace_remove_event_call()
> returns -EBUSY, the event is left registered with an irreversibly
> destroyed field list. Any subsequent interaction with the event then
> operates on an empty field list while it is still fully visible in
> tracefs.
> 
> Move the field destruction after the call removal, and splice the
> field list back onto the event when the removal fails so the event
> remains in a consistent state.
> 
> Fixes: 7f5a08c79df35 ("user_events: Add minimal support for trace_event into ftrace")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  kernel/trace/trace_events_user.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 8c82ecb735f41..0b021c212995a 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -1119,10 +1119,9 @@ static void user_event_destroy_validators(struct user_event *user)
>  	}
>  }
>  
> -static void user_event_destroy_fields(struct user_event *user)
> +static void user_event_destroy_fields(struct list_head *head)
>  {
>  	struct ftrace_event_field *field, *next;
> -	struct list_head *head = &user->fields;
>  
>  	list_for_each_entry_safe(field, next, head, link) {
>  		list_del(&field->link);
> @@ -1499,17 +1498,21 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
>  
>  static int destroy_user_event(struct user_event *user)
>  {
> +	LIST_HEAD(fields);
>  	int ret = 0;
>  
>  	lockdep_assert_held(&event_mutex);
>  
> -	/* Must destroy fields before call removal */
> -	user_event_destroy_fields(user);
> +	list_splice_init(&user->fields, &fields);
>  
>  	ret = user_event_set_call_visible(user, false);
>  
> -	if (ret)
> +	if (ret) {
> +		list_splice(&fields, &user->fields);
>  		return ret;
> +	}
> +
> +	user_event_destroy_fields(&fields);
>  
>  	dyn_event_remove(&user->devent);
>  	hash_del(&user->node);
> @@ -2209,7 +2212,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
>  put_user_lock:
>  	mutex_unlock(&event_mutex);
>  put_user:
> -	user_event_destroy_fields(user);
> +	user_event_destroy_fields(&user->fields);
>  	user_event_destroy_validators(user);
>  	kfree(user->call.print_fmt);
>  

