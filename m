Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348B826CE0A;
	Wed, 23 Jul 2025 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753305685; cv=none; b=FzeG9xh0Pk1a5rwwOdTp0OXKY1rZzzqegnn/r/BfhD1Xn5knR1KX7NSGof09IjiqQGvmnH0WGbgUFo3UnBpNcwx68DM3lGpMJEwo7IhuuThWOoH+EFwHlcSIdYg1fWFirKoMc0TM2r5nN5WBf6QRXoBk9ha/vIGTyPJowAkMJ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753305685; c=relaxed/simple;
	bh=VPXYxYVtd6s3/QwcATqT8F0pmv/ZiyMRk5nynEKSGFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BlXsOnG59/TqgouMna+6az05t0DzcqRhnASAo1KkmRwFv6lUvgReqq27pYa7CGHuSk0aWgP4CQXSRY2EYeFfKNHlJKN0p1dFrbpLEYAkoCbKBfG3tEp9zgTg6koy9UDvSNbF2f9YmjQ23471Yyk2gRsLyPzfec1V0QqhtYklwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 8028712EE3F;
	Wed, 23 Jul 2025 21:21:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 432ED2000E;
	Wed, 23 Jul 2025 21:21:13 +0000 (UTC)
Date: Wed, 23 Jul 2025 17:21:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Guillaume Nault <gnault@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Petr
 Machata <petrm@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tracing: ipv6: Replace deprecated strcpy()
 with strscpy()
Message-ID: <20250723172114.061cc226@gandalf.local.home>
In-Reply-To: <AE36F453-DEAE-432C-9CDA-0D2DA875CDA2@linux.dev>
References: <20250714075436.226197-2-thorsten.blum@linux.dev>
	<20250714123825.6f0485c9@batman.local.home>
	<F998F71D-1244-4154-BC5F-19201C23BDBE@linux.dev>
	<20250723143625.79ab2c16@batman.local.home>
	<AE36F453-DEAE-432C-9CDA-0D2DA875CDA2@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 432ED2000E
X-Stat-Signature: kegzwk6g57adhy3wkto5u1nsueku345w
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+IsVoACPy2Z+7qVEXdlgVce576+oGEJ38=
X-HE-Tag: 1753305673-867281
X-HE-Meta: U2FsdGVkX19MUNA+JVSepE1HTC98wpo7HgiqisHjDzAD26LTzKZW3A58hsm/f3dphPQ/1p+gORdAqxdT+378F+hqf+91FZF2xDQW/DBNSHbeQbSrzCHCm2TJgYG+SKzB7ne8iLEG82vb1syDG6Cct06CZuKPUbjPY2x7IjbBxMe6VZ+ZHobF1Af4nSBSEYzxJFfbWdQAr/540miYGq/bvsp+zJTX0D+b/EkuogIPqqhSdCHq+zm/AaQcfNzqp8UdKBEyFNATaP4eGQ3iOadAweNvQwung3XpVdHWoyooyT8//lVTa2FFTMIj8Sdzhf1M

On Wed, 23 Jul 2025 14:15:02 -0700
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Thanks for the detailed explanation.
> 
> I think the better change would be this then:
> 
> diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
> index 8d22b2e98d48..3f95df1fd155 100644
> --- a/include/trace/events/fib6.h
> +++ b/include/trace/events/fib6.h
> @@ -32,8 +32,9 @@ TRACE_EVENT(fib6_table_lookup,
> 		__field(        u16,	dport		)
> 		__field(        u8,	proto		)
> 		__field(        u8,	rt_type		)
> -		__array(		char,	name,	IFNAMSIZ )
> -		__array(		__u8,	gw,	16	 )
> +		__string(	name,	res->nh && res->nh->fib_nh_dev ?
> +					res->nh->fib_nh_dev->name : "-"	)
> +		__array(	__u8,	gw,	16	)
> 	),
> 
> 	TP_fast_assign(
> @@ -64,11 +65,8 @@ TRACE_EVENT(fib6_table_lookup,
> 			__entry->dport = 0;
> 		}
> 
> -		if (res->nh && res->nh->fib_nh_dev) {
> -			strscpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
> -		} else {
> -			strcpy(__entry->name, "-");
> -		}
> +		__assign_str(name);
> +
> 		if (res->f6i == net->ipv6.fib6_null_entry) {
> 			in6 = (struct in6_addr *)__entry->gw;
> 			*in6 = in6addr_any;
> @@ -82,7 +80,7 @@ TRACE_EVENT(fib6_table_lookup,
> 		  __entry->tb_id, __entry->oif, __entry->iif, __entry->proto,
> 		  __entry->src, __entry->sport, __entry->dst, __entry->dport,
> 		  __entry->flowlabel, __entry->tos, __entry->scope,
> -		  __entry->flags, __entry->name, __entry->gw, __entry->err)
> +		  __entry->flags, __get_str(name), __entry->gw, __entry->err)
> );
> 
> #endif /* _TRACE_FIB6_H */
> 
> 
> I'll submit a v2 if you agree that this is correct.

Isn't the above pretty much what I suggested?

-- Steve
