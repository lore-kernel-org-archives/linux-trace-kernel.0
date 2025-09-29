Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C312D515;
	Mon, 29 Sep 2025 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759169035; cv=none; b=A9+hcRkkDDHr5ViNY9vHkx1S003mqZGy7M/uG0NjmT0fDiwkUJRBVkgaDRRnsNI4cqED+Mr7MYkc1T8XgnNfFlrP4ha0GHFhKNz4XWqN40QLR2HXQswRZM1PBI9+SGPdrqyX+vuZHnYSK6O4BU/5JwgeayezYX/YqDQautepGUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759169035; c=relaxed/simple;
	bh=4JNuSJOTgcqgADV7Gk0XfDIZ5uP1/840vUsuwrTd/rE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2ifkGBbbJ+yz0rDMJpE7OtsJG7OKUu9Eb3i1z3hLytfeqeZU7khTGQGRtZ4Vm3iqq00gjdCGK/PO/bMfO/FKm3IYGcDgJE2uwYwC/olnUWuqAVHhvKAJDRfN8U0wXvswGn5vKg9NIks46J8qdq/dU/2ZKWKiyMsQw3qfuanuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B0D8958FC3;
	Mon, 29 Sep 2025 18:03:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 3181A20010;
	Mon, 29 Sep 2025 18:03:37 +0000 (UTC)
Date: Mon, 29 Sep 2025 14:03:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix lock imbalance in s_start() memory
 allocation failure path
Message-ID: <20250929140230.79c06c22@batman.local.home>
In-Reply-To: <20250929113238.3722055-1-sashal@kernel.org>
References: <20250929113238.3722055-1-sashal@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: a9m4zx4hdiskugwjbh8aowfj94ur5zsy
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3181A20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18LYf/Wb1G9qPbi3TegXCerr1JJD8iwULo=
X-HE-Tag: 1759169017-732405
X-HE-Meta: U2FsdGVkX1+ImKxOT1IRIqCobmj8OGl67EHo1K2L+759126duQT83kDAgJKgHlvaq5fmbAftds9qLowDuPOnPGBugIDeKvF2Ox+hUijbZSXZtF6xg1wqYZArUrmE1vVw+jHIR4JZrnN5zxLQXW7mwmFqE4iU8d++aWs+n3Bo/uY/CuC3sGSVmKdfPdSBE01E957TZ94UnVh6pXCAoU02j0WeKvBQFUTe0ozqOT7jpN+AWvK3+idXxcaWzYLzd54vPfZaAwydFLcUY3MFMGoNYgzzgocj68yhvXyCy9YVZGcx7JUnZl47SxHkVGDg1xeRqkQ9ns04jkZ0z1GiW43jPoGUpTjpC9vv

On Mon, 29 Sep 2025 07:32:38 -0400
Sasha Levin <sashal@kernel.org> wrote:

> iff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 9f3e9537417d5..e00da4182deb7 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -1629,11 +1629,10 @@ static void *s_start(struct seq_file *m, loff_t *pos)
>  	loff_t l;
>  
>  	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
> +	mutex_lock(&event_mutex);
>  	if (!iter)
>  		return NULL;
>  
> -	mutex_lock(&event_mutex);
> -
>  	iter->type = SET_EVENT_FILE;
>  	iter->file = list_entry(&tr->events, struct trace_event_file, list);
>  

Good catch, thanks!

-- Steve
