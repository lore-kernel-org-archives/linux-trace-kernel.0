Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942637D104;
	Tue, 17 Mar 2026 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770547; cv=none; b=fQJzWKOz6H6p4F7YQrneTel5iXndho20ArdHvDZJlDFobRsulLw8S7RuRGKi1VIdtQ4QYaJRu8Z73LTq1AKCLt2vnlGAT6BPZS9sXPpznOr8lhkaYhM7vmil27hdFvp/GNfKQQYQpZcITRk9GbmWvQKX1bIaaJ26czUXnOMIJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770547; c=relaxed/simple;
	bh=U21Fm+Pd7N26CdbBoxPwiPqm80Oy/Qc5dcpRifonEVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7qMPf2GfbvudNAg8FjIkNEeq5gX3EG0Sqw/I9adnwN1xEHK56iIFi9xvTqNf09A5M5f70K5ZdZpUhHUUZsPQQtQYb/7vpEPyNJwqFKmvyqF40XSGZYZqZHgXDDSxOC0zBLKKh+xaQj41AElB16RRD15uzVlIJ7PKVuwY6QLfDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 24F5D13A56F;
	Tue, 17 Mar 2026 18:02:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 4340632;
	Tue, 17 Mar 2026 18:02:17 +0000 (UTC)
Date: Tue, 17 Mar 2026 14:02:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Law <objecting@objecting.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bootconfig: guard xbc_node_compose_key_after()
 buffer size
Message-ID: <20260317140243.2b581226@gandalf.local.home>
In-Reply-To: <20260317173703.46092-1-objecting@objecting.org>
References: <20260317173703.46092-1-objecting@objecting.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: yn9kuqdj54ci984ukhckh6x71pp7fq8n
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 4340632
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ecmCM0/D0UDCz229kqbzNL0ek2Q+rA24=
X-HE-Tag: 1773770537-373768
X-HE-Meta: U2FsdGVkX196dGnTEs26272PNxmfKQ94iJX6ZYa1Ul3MQ9jWokY3A+9qQFpHgkcPgT3yMe/XwAlWWI3/2jKtgQVuZ7r3/ah6g3WiEbXxZULwfkdo45zNXv18B8Y5zf2dXAz/lh1G4PgqEsF0K4QiGa8OwreRfd4kFz+/B2v4Tm7GhhYONhIzaXVGqXB1grwMpu20l5GUsFk9x3ZN5OfAQuYW5r8kBrfQ0mP6sntpFk4UCQgAm0y6lIrU1UEdxBtW3xqu7/zUsVN3eETXssGNS18gEFHuJaqfVg8fCmohPrNlVXem893zsU4eqBeUNSKIPW2WE9hr8/956oHmjCQ9f4rclm2h/AxCr/R4Dx+xmAFZY0LXT7Xaw7TG2V2Au+Q0

On Tue, 17 Mar 2026 17:37:03 +0000
Josh Law <objecting@objecting.org> wrote:

> @@ -313,13 +313,16 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
>  	if (!node && root)
>  		return -EINVAL;
>  
> +	if (WARN_ON_ONCE(size > INT_MAX))
> +		return -EINVAL;
> +
>  	while (--depth >= 0) {
>  		node = xbc_nodes + keys[depth];
>  		ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
>  			       depth ? "." : "");
>  		if (ret < 0)
>  			return ret;
> -		if (ret >= (int)size) {
> +		if ((size_t)ret >= size) {

Hmm, if size can't be greater than INT_MAX, this code should be able to
stay the same.

-- Steve


>  			size = 0;
>  		} else {
>  			size -= (size_t)ret;
