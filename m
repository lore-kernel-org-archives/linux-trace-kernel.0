Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40969248176;
	Mon, 14 Jul 2025 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511112; cv=none; b=gFI6vtrVt4WpP4AsBAJNFRQ3ytvo5/XDBMarrpDt8oTua+YRqpA8Hj6wPOw+rg0Yi7OgbxWIbmiaDktNDZ474XX9kfBudw3hGfrHi1f+KIkuy8uN5M8eLN85LM+XJiAVx6FW7fAi31aazSpBTpUEAdYhNa+BazMbw+pt2Iu4yps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511112; c=relaxed/simple;
	bh=7DsJYVGGIS1ZzwUf364GMrQzJPF/FeA6/5DvQFchNAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KYIt1pM4DnlP6SV55Ver1l+HdSRcC+3RUdbwV3wZY6h3ONWXaaRED7hrD7EncCOizFHQ2VG6FZPjzbGgMLl1IpVflt55FpXadDd8EzAhyTZ+NT6glBrIMc9uGjW2yPnrlWSwMTaQ9UA0cGItBvvJhakPx+UK4g4XTtNe3dQRN8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 95B0A160251;
	Mon, 14 Jul 2025 16:38:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 8775120023;
	Mon, 14 Jul 2025 16:38:26 +0000 (UTC)
Date: Mon, 14 Jul 2025 12:38:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Guillaume Nault <gnault@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Petr
 Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tracing: ipv6: Replace deprecated strcpy()
 with strscpy()
Message-ID: <20250714123825.6f0485c9@batman.local.home>
In-Reply-To: <20250714075436.226197-2-thorsten.blum@linux.dev>
References: <20250714075436.226197-2-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: agarbzxstp4yw77ftn7gk9okcxg8zn86
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8775120023
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+6AcqoDoVWA1W/e4qtJEAhI65x0rg72DI=
X-HE-Tag: 1752511106-650672
X-HE-Meta: U2FsdGVkX18vpYpE7F6fEZpsBptaJuMiDi8vuKRHOjuzXxEnTUZ3mfAdVgI2FizooA2YVhHVqIorK53TMnSbcluZoZ+txqq9UimR26q5z81hMVeX08ujBLS8EF8UykAjP3+y8VnutfSFkXecMMFMzaiIaVdF0W7YVX4yjLxwNu+U9PWRnamzfjxaYiaYXQJmgTKFydCdf81ZICzaqKEC2+PU00fzYwXAoEI1N77Qj7av74exyL00iOCsvOPPViewmdNKvNSt1NpjAc5nOo0m7gjvy1+9dALRi+gy2aRoTPGURTSzbw3vAUz7DHhJBvTR

On Mon, 14 Jul 2025 09:54:33 +0200
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
> index 8d22b2e98d48..903a18836bc6 100644
> --- a/include/trace/events/fib6.h
> +++ b/include/trace/events/fib6.h
> @@ -64,11 +64,9 @@ TRACE_EVENT(fib6_table_lookup,
>  			__entry->dport = 0;
>  		}
>  
> -		if (res->nh && res->nh->fib_nh_dev) {
> -			strscpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
> -		} else {
> -			strcpy(__entry->name, "-");
> -		}
> +		strscpy(__entry->name, res->nh && res->nh->fib_nh_dev ?
> +				       res->nh->fib_nh_dev->name : "-");
> +
>  		if (res->f6i == net->ipv6.fib6_null_entry) {
>  			in6 = (struct in6_addr *)__entry->gw;
>  			*in6 = in6addr_any;

Hmm, why is that string hard coded to 16 bytes and doesn't use the
dynamic string facility? Perhaps something like this?

[ I didn't even compile the below, so it may have a syntax error ]

-- Steve

diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
index 8d22b2e98d48..98d2edb02431 100644
--- a/include/trace/events/fib6.h
+++ b/include/trace/events/fib6.h
@@ -32,7 +32,8 @@ TRACE_EVENT(fib6_table_lookup,
 		__field(        u16,	dport		)
 		__field(        u8,	proto		)
 		__field(        u8,	rt_type		)
-		__array(		char,	name,	IFNAMSIZ )
+		__string(	name,	res->nh && res->nh->fib_nh_dev ?
+					res->nh->fib_nh_dev->name : "-")
 		__array(		__u8,	gw,	16	 )
 	),
 
@@ -64,11 +65,7 @@ TRACE_EVENT(fib6_table_lookup,
 			__entry->dport = 0;
 		}
 
-		if (res->nh && res->nh->fib_nh_dev) {
-			strscpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
-		} else {
-			strcpy(__entry->name, "-");
-		}
+		__assign_str(name);
 		if (res->f6i == net->ipv6.fib6_null_entry) {
 			in6 = (struct in6_addr *)__entry->gw;
 			*in6 = in6addr_any;
@@ -82,7 +79,7 @@ TRACE_EVENT(fib6_table_lookup,
 		  __entry->tb_id, __entry->oif, __entry->iif, __entry->proto,
 		  __entry->src, __entry->sport, __entry->dst, __entry->dport,
 		  __entry->flowlabel, __entry->tos, __entry->scope,
-		  __entry->flags, __entry->name, __entry->gw, __entry->err)
+		  __entry->flags, __get_str(name), __entry->gw, __entry->err)
 );
 
 #endif /* _TRACE_FIB6_H */
