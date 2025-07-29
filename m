Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB80B223DEE;
	Tue, 29 Jul 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806836; cv=none; b=WEnWnP7v7CTaeEILyzWwDefOwETIt4BsED+MNb2hW05k+z0KtuKBp9kneasiyFf39a2YjzRdcPe+FKA0FQuvwOSgrA9dhWxr4AClPQRNDEmyi/J36cG/J+OkSErWmRYwFWQE4Z3LliNHArQNdCxuLEmDG8oaavmDJ/8iW5hsBL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806836; c=relaxed/simple;
	bh=mlzm5Y/eIh/7WFIXyD4N3iWWQqDhGlzk+4BfEoIbVPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1+MHqymea5hKLDNxs/iAa/rhxuseLvpzkOi9yL+IiZJHJesP1lqMU/VWEAKIiBGxOB8J4lH4uZ3cB2QptGzyZG+jbGM4FE5juIKH0op2ByaUFlhZDeH4+wBWkH9IUSCeTqzmBU5uXE3Hr4Ukjck6KQvSM31lTVndC9Yb2RyJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 79D80B6B4E;
	Tue, 29 Jul 2025 16:33:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id B5B4320023;
	Tue, 29 Jul 2025 16:33:50 +0000 (UTC)
Date: Tue, 29 Jul 2025 12:33:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250729123349.61dbcc92@batman.local.home>
In-Reply-To: <175376583493.1688759.12333973498014733551.stgit@mhiramat.tok.corp.google.com>
References: <175376582586.1688759.2122686728240441891.stgit@mhiramat.tok.corp.google.com>
	<175376583493.1688759.12333973498014733551.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1dy7f35ey1dojcgccdeqd6hg964mmpo9
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: B5B4320023
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+uTausSgjw/iKLgAU9qyvMNBIHhGdGC78=
X-HE-Tag: 1753806830-586467
X-HE-Meta: U2FsdGVkX1+1G4IniNwjWEbNOpOemV0T+JBzFOid2YdBIPU2g37Hj3zXvR2WekyfmLzjilPGc/Ugohl/JFJMN5eNJ3ro8N7Eoemfo6FFDqUIulEE9CjK2AF3Bf4oFHKd3FeHxiR4e76q54MqOdBrGTd6cc/W1dNNnvWALiA6iwtTq6ziMsg5QRojxXAfFSZevBDjFWZm+p+jqIHWxP0mS6LqtJJO36sT7uiSE8VlqoaXDSEYY2c/7CB/3H4XnT8P8e5apmBTfjSVCqwt9ddTK1ww0jrWD2uKjJljWhEkYhcD/ap4DWeGGOq4HmTiXjJUfRwW4prBPdxOGxIe/NjHq2rFyM7DamGu

On Tue, 29 Jul 2025 14:10:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

>  static void update_event_fields(struct trace_event_call *call,
>  				struct trace_eval_map *map)
>  {
>  	struct ftrace_event_field *field;
> +	const char *eval_string = NULL;
>  	struct list_head *head;
> +	int len = 0;
>  	char *ptr;
>  	char *str;
> -	int len = strlen(map->eval_string);
>  
>  	/* Dynamic events should never have field maps */
> -	if (WARN_ON_ONCE(call->flags & TRACE_EVENT_FL_DYNAMIC))
> +	if (call->flags & TRACE_EVENT_FL_DYNAMIC)
>  		return;

Is there a reason you removed the WARN_ON_ONCE()?

Even for the attribute, this shouldn't be called by dynamic events. Or
do you know of a case?

-- Steve
