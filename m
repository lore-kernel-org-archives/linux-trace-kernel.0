Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895897;
	b=zCv6CBh1mYMmSnEC2GDr3cdSBuGFXM51xADd1QQYgNEORsbYV+aWDwLdljzE12vqvzbx
	 gXXNN+L1j3BFCqSlRTbmunPacKYkWORXff4rvSu64B1IBD7At8KZK98fDZNmfGptMU6JY
	 ++AQL/pbPfztzlTCqTlvApioxRfKKzoZzdQcpHWRrZKfegzNHa/7vyvj5Jk+NWg22Dc9L
	 UJDb+kVHeCdXCyQpG8JoilOvH4j1JxFABdVYeVKr3mV5OeYk7RnKas0S+TrHdslYEeV+D
	 6xAJZNRWnWI7ag2P/qyK/Qb0dIDZISNcieqUV8sC3zaZvrPnwgXCCnN+oehszzdRBdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895897;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=rrtJ37+y8zHYTQoJVA57loWp5kPxlINptsMI0E2H/oA=;
	b=vu/AZMWI+tiClVMmPGBiG7lRIyhIQy+9PthIZdP6eLy9oTpQgGEM1kQrnO8gQZueAUhY
	 SFzOn4UtiHIdfGjaCXVE4PnGlGTDlWHt4oY+gD6F0QvVwsov3iXXz0IdLHYkcB6Zre4aQ
	 EGgF3tG/NlDkIx7h12AmChIqj3pjPGDGypdvbm2jqvWMllRbqj4f6uUVEq8ZuPaTnWmK+
	 VnfLryYZzhXZX8XskzeRteU6LIo4Hc2Ay9bLNHDYp8DY1r1uoLmfLb51ZqbuDEPpwgZKM
	 /160zB0e601NLk+SUaJyWcafV6Vp5FvaoI1P87Zj9A47c5GRSiypKFkkKkIat7i2XHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=tJDNPp5j;
	arc=none smtp.remote-ip=216.40.44.13
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC47F606A31B;
	Thu,  5 Nov 2026 16:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC47F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=tJDNPp5j
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B885840B5F;
	Thu,  5 Nov 2026 16:24:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 07B3120011;
	Thu,  5 Nov 2026 16:24:45 +0000 (UTC)
Date: Thu, 5 Nov 2026 11:24:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Ilya Maximets
 <i.maximets@ovn.org>, Matthieu Baerts	 <matttbe@kernel.org>, Aaron Conole
 <aconole@redhat.com>, Eelco Chaudron	 <echaudro@redhat.com>,
 dev@openvswitch.org, Adrian Moreno <amorenoz@redhat.com>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [PATCH v7 0/4] tracing: improve symbolic printing
Message-ID: <20261105112444.7873d9c9@gandalf.local.home>
In-Reply-To: <8da2902c233de42ce756b3bfba5e5821f4dfa82b.camel@sipsolutions.net>
References: <20260922110955.363677-6-johannes@sipsolutions.net>
	<20261105091216.7b91db5a@gandalf.local.home>
	<8da2902c233de42ce756b3bfba5e5821f4dfa82b.camel@sipsolutions.net>
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
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 07B3120011
X-Stat-Signature: gy5rhwc3madt4dgm5xcsxq5b8wsbrwkj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/9sTG6PEQQuYRcmSk9jyFwyrT8HVhkhgs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=rrtJ37+y8zHYTQoJVA57loWp5kPxlINptsMI0E2H/oA=; b=tJDNPp5j9xIe9Hm7CbcQ5GpMvt+wpkBHmO22K4Mwn1WpKwKJDGgmrfUDoyVC3uUuf6K1Zo3/KObna4sSlRr3ZnAI0M2KA3W6WcJaJ+QeJsEhNcl+Vrt3S8GBdAdS6QySXQ2jXuKFjA1Tyjeo/K1nQNFWC6G/beB4bFpESTenqo0=
X-HE-Tag: 1793895885-929484
X-HE-Meta: U2FsdGVkX1+Ymv/qTjr5+PASDqyqMzC6ar0l+MZkQ/3zwSZVEypab+8BnAdWfUTP/kqn/WJ1W/mpizgDW1MN7dOW0lZb+WRRT93CfDk/giJNxiforul6TbuNc2RVzpxdQnpwILs6RoYI2OOAVM5wxCX8jhgF9lA65ZVDwAhA2iPeB1zmrvaQ56GRq9NF7KrCutAWv7qdmpw6j/ayH5bCZj6IKhg6kiHv1hJR4AQnn41PXpeq06Ca4aSrdOKB6fAPmDEeBzHo4kzfcx0PZHr71Pgrqdfd6snyN6y2ZUTNG6MeL73Y00U833HFF3dWj5O7lEHnfdNfIF4P7R3WMHU+mJ12NP2ZkbdnbpIRyqmCGokz7PbH5C75ohG93+3CWUfC

On Thu, 05 Nov 2026 16:04:21 +0100
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Thu, 2026-11-05 at 09:12 -0500, Steven Rostedt wrote:
> > Could you also add code in the samples/trace_events directory. Perhaps add
> > a new event?
> > 
> > This will make it easier to understand exactly how to add new __print_sym()s.  
> 
> I guess so. I was kinda hoping to simply convert all the others - it
> clearly has advantages this way.
> 
> Any objection to simply converting the __print_symbolic() sample? It
> would look something like this:

Actually, keeping them both would be very useful. That way one can see how
to do it the other way. We can say, the old way is being deprecated so
please use the new way.


> 
> 
> --- a/samples/trace_events/trace-events-sample.h
> +++ b/samples/trace_events/trace-events-sample.h
> @@ -297,6 +297,28 @@ TRACE_DEFINE_ENUM(TRACE_SAMPLE_FOO);
>  TRACE_DEFINE_ENUM(TRACE_SAMPLE_BAR);
>  TRACE_DEFINE_ENUM(TRACE_SAMPLE_ZOO);
>  
> +/* define the names as { value, "name" } tuples for __print_sym() below */
> +TRACE_DEFINE_SYM_LIST(sample_names,
> +	{ 0, "zero" },
> +	{ TRACE_SAMPLE_FOO, "TWO" },
> +	{ TRACE_SAMPLE_BAR, "FOUR" },
> +	{ TRACE_SAMPLE_ZOO, "EIGHT" },
> +	{ 10, "TEN" }
> +);
> +
> +/*
> + * Alternatively, you could define a function for the names:
> + *
> + * The _lookup() function returns the string for the given value.
> + *
> + * The _show() function must
> + *	seq_printf(m, ", { %u, \"%s\" }", value, name);
> + * for each value that userspace should be able to parse.
> + */
> +const char *sample_names2_lookup(unsigned long long value);
> +void sample_names2_show(struct seq_file *m);

Are the above going to be defined somewhere?

> +TRACE_DEFINE_SYM_FNS(sample_names2, sample_names2_lookup, sample_names2_show);
> +
>  TRACE_EVENT(foo_bar,
>  
>  	TP_PROTO(const char *foo, int bar, const int *lst,
> @@ -340,14 +362,10 @@ TRACE_EVENT(foo_bar,
>   *    the variable matches one of the values, then it will print the
>   *    string in that pair. If non are matched, it returns a string
>   *    version of the number (if __entry->bar == 7 then "7" is returned).
> + *
> + *    See above for the declaration of "sample_names".
>   */
> -		  __print_symbolic(__entry->bar,
> -				   { 0, "zero" },
> -				   { TRACE_SAMPLE_FOO, "TWO" },
> -				   { TRACE_SAMPLE_BAR, "FOUR" },
> -				   { TRACE_SAMPLE_ZOO, "EIGHT" },
> -				   { 10, "TEN" }
> -			  ),
> +		  __print_sym(__entry->bar, sample_names),
>  
>  /*
>   *  __print_flags( variable, "delim", { value, "flag" }, ... ),
> 
> 
> 
> It did show a bug because TRACE_SYSTEM isn't a C var in that file (and
> perhaps only in that file?), so I'll have to resend with that fixed
> anyway.
> 
> 
> > FYI, this series did pass all my tests.  
> 
> Cool. Sorry the earlier (long time ago) version had the __init_data
> issue, I'd mostly tested on UML and that wasn't protected there.
> 

Thanks,

-- Steve
