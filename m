Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717730;
	b=s9whiuBQVaj1pr4bD7oxigBNjUJmCK3e7AQjKhckfUC0SpkNyAfzBXYtRUj9n8izA2nj
	 Ru3P0EPFvSFK4T1EysaTmSl/zxwp2rEnecZJUTtTnaQWAYYdDNhCYqiCZO22WUc5+qeZu
	 fb9GP6xtk2A7hhfR3ciBxz9HrjeaDZlxi5wS7EbULuZ34SK0DnZhaJ9mHUkZ7AIOO6m+g
	 dlPX1I6fKrG1cJpuiRyJsxUQqOnsol/r046aPR5DFI+Nip15dmDOF6TgJtwkxb2GbiFP4
	 pmeXPpCwIkSXGBs1qX+IA5oDZWqH0SJfJi/8TnpCLJAcFM4QuvR5B5YK6/zlnqE6NxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717730;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=yfddeYQH6ujsdtrqW+DK7nJG3jSGc85HvZV3WQ41HAI=;
	b=0TuJpa0FmYyA4ukaKCFNVQ6cClJALKjl41FEOnzMh/gSTRS/7yszpWzxAUReqq16CWlC
	 fAw9GpbsCpTHtql6KWglNMo+f+up3HoPeSrmkIl9BIE4HuaoZojlQqb6oIBBCZrG1cteX
	 Lrb0FNt2RA3XPH2NhZb1lCZLdJmgVA/Boa5hsB8VRd3iVIqvhIUeTZPZsQ5UbngKsNvh1
	 kqIUK+/asKTeWMSvSdLObN3oCkm+X4K9JSakItXUc2H4AbHkQqKJo+CDfX/su2BxvQ7qU
	 oVkiX/3biepeYPEquJlBUPTqndX3hGSjPKjo6m128KIbe/78jThESFmE+lXXUOxnfxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ccOpwd2t;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29F5606A785;
	Tue,  3 Nov 2026 14:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D29F5606A785
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ccOpwd2t
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 9CF50A0427;
	Tue,  3 Nov 2026 14:55:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id C284720028;
	Tue,  3 Nov 2026 14:55:13 +0000 (UTC)
Date: Tue, 3 Nov 2026 09:55:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: pmladek@suse.com, john.ogness@linutronix.de, senozhatsky@chromium.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
 surenb@google.com, mhocko@suse.com, kees@kernel.org,
 anna-maria@linutronix.de, frederic@kernel.org, tglx@kernel.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 brendan.jackman@linux.dev, hannes@cmpxchg.org, ziy@nvidia.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH v2 4/5] printk, tracing: Support console flush
 suppression and tail pinning
Message-ID: <20261103095512.7b8c2d3f@gandalf.local.home>
In-Reply-To: <20261103024453.922373-5-atomlin@atomlin.com>
References: <20261103024453.922373-1-atomlin@atomlin.com>
	<20261103024453.922373-5-atomlin@atomlin.com>
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
X-Stat-Signature: nc4kisin8m3wyjdgtdpom7c1au41iqa3
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C284720028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18bF8bDrvU8IQ31ZfoMj2/1FBDtsGgnaNM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=yfddeYQH6ujsdtrqW+DK7nJG3jSGc85HvZV3WQ41HAI=; b=ccOpwd2tRjlDkvLbOszT0B1ym6UiYCfrRWT0qA4+g9GnoqpEdGbtdba9bNqnSGo8WEXhJAmxC0nC9r/jQRz0ydIwgnnbdbE+fkNtv7+eOe9CahVZ9Tf38wAfwDUrGkJffHQpfufHMkf6c76Qt5z5WupeU0bID+ji4KLPijQfrbw=
X-HE-Tag: 1793717713-47761
X-HE-Meta: U2FsdGVkX19lBMKb7T+S15I1bJ1yR/TpScDr1lLD4QbN59L8ZM4I0NZGtNhm2A8c1bmSxupnsLnRAsBUwVGiAfWzpLEfSX3Adc9DNtb6PKQ5qJNeVEATThLVWUurVwo9CE5t/iLx93jzKYVjROq1YZpyEKFbbFeS0fkiZcRmgC2kbjBnXH6i1894/YQUb3zmpt9AzD9eP/WJIIhyybCls1BbTVchuLjJ9gzzG6y6eMRLctFBr4SOmLD53JvLUC49y8ZRAywfuklEeeyZQgz1N8jIf42a2Jf292eBO4csSC2VZy7+hRLMlrdiX2PfR5HNPn57OrUIwJiwWiRoeehnpiHDKniSg9g5+r1a5FR/JVhzWytRVeYOTvnpX6+QVIy/

On Mon,  2 Nov 2026 21:44:52 -0500
Aaron Tomlin <atomlin@atomlin.com> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index e8c4efa8107b..35a56f04e9b3 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9519,6 +9519,9 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>  	else
>  		iter.cpu_file = RING_BUFFER_ALL_CPUS;
>  
> +	if (printk_is_tail_full())
> +		goto out_enable;
> +
>  	if (tr == &global_trace)
>  		printk(KERN_TRACE "Dumping ftrace buffer:\n");
>  	else
> @@ -9537,10 +9540,13 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>  	 * and then release the locks again.
>  	 */
>  
> -	while (!trace_empty(&iter)) {
> +	while (!trace_empty(&iter) && !printk_is_tail_full()) {

Wait? Is this to prevent overwriting the printk ring buffer? If so, this
is wrong here!

In your change log, you mention not losing the initial oops or registers.
But if someone is using ftrace_dump_on_oops, that's not what they are
after. They want to know what happened that lead to the crash. That output
is at the *end* of the trace.

By stopping the output of the ftrace buffer early, you just lost the
information you are looking for.

-- Steve


>  
> -		if (!cnt)
> +		if (!cnt) {
>  			printk(KERN_TRACE "---------------------------------\n");
> +			if (printk_is_tail_full())
> +				break;
> +		}
>  
>  		cnt++;
>  
> @@ -9551,19 +9557,25 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>  			int ret;
>  
>  			ret = print_trace_line(&iter);
> +			trace_printk_seq(&iter.seq);
> +			if (printk_is_tail_full())
> +				break;
> +
>  			if (ret != TRACE_TYPE_NO_CONSUME)
>  				trace_consume(&iter);
> -
> -			trace_printk_seq(&iter.seq);
>  		}
>  		touch_nmi_watchdog();
>  	}
>  
> +	if (printk_is_tail_full())
> +		goto out_enable;
> +
>  	if (!cnt)
>  		printk(KERN_TRACE "   (ftrace buffer empty)\n");
>  	else
>  		printk(KERN_TRACE "---------------------------------\n");
>  
> +out_enable:
>  	tr->trace_flags |= old_userobj;
>  
>  	tracer_tracing_enable(tr);

