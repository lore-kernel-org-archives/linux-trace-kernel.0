Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB625DAE7;
	Thu, 21 Aug 2025 15:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788710; cv=none; b=fJqvXXtmgYzmGTk4u75zV/9xmwTvgv2ILo2ec34PdI1WECJcR+gz6SzWY+HaSKok7NZWgDm5XSgU9emTaUdGdCOHamN3ToapfsM40jVzqKniu+HMv5eFTP6kqjxHGEYJ9V/Gz7KqhtdqStOaX1weUHZhy4IWXi5S4yAH7OVgtXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788710; c=relaxed/simple;
	bh=bJQig0T9oS6xig+yQQJGTH945hEMJoQh0QjDQ23dq8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mmj5uPU3Uv3/av8VhjjWmOADtnzl2XvxPCgfg5o7zvIlchX7GiOsZVw9O742qrj7JrzhRsaQyjk9+rdIY76VxXYSxpTQFpAhr8ZU/V9tSbHacCKbUDNMwqQOq3s9B3mfU8plaC3iF9PkQLJZAoaoMrWY87QYeFz5EgbmzZcPxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id E21D41A03E6;
	Thu, 21 Aug 2025 15:05:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id DE2272000E;
	Thu, 21 Aug 2025 15:04:58 +0000 (UTC)
Date: Thu, 21 Aug 2025 11:05:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@elte.hu>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] ftrace: Fix potential warning in
 trace_printk_seq during ftrace_dump
Message-ID: <20250821110503.5f5c3156@gandalf.local.home>
In-Reply-To: <20250821021120.2986553-1-wutengda@huaweicloud.com>
References: <20250821021120.2986553-1-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DE2272000E
X-Stat-Signature: w3ibgc48qu3dkmyw4ekyfohtqiqw1x79
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ThLyse5WuRnvVDb7JRaiuDEqLg6xGPpI=
X-HE-Tag: 1755788698-787842
X-HE-Meta: U2FsdGVkX1+e0KzmUl1+S6s7g6fTli/DKzqp5x5YkgvaM61Vjs8OSC5PWmAg3nDZkm2WHiZfH7k9N4FNZM2AdqdutQI4YlIl2thCFlcahyFb1NewzHWFPgCeQ5y7RcDznNC9hV+ja6I4yAMIONF2VIUITjXNveED/FD5ahoJtEgp6J2SmheC9l+9l1cXiluVneh7+DEeokFygg76ZnGeQ6wUl06GOVJDlixE0bVcofgDgt5yuzivSv8G5NdMe7FJnnnrslS4KZNRBujc5rY0ZUE7dhns9MDbRe4ijlKykyHLMEPkK+qZE6F5iJV1DBkdRx8tGIOixbxBzJC9e3Xh+S/Et33vKOyp

On Thu, 21 Aug 2025 02:11:20 +0000
Tengda Wu <wutengda@huaweicloud.com> wrote:

 tested this and was writing the change log for the pull request when I
realized an issue.

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 4283ed4e8f59..b4cec22753ea 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10617,6 +10617,7 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>  	 */
>  
>  	while (!trace_empty(&iter)) {
> +		void *ent;
>  
>  		if (!cnt)
>  			printk(KERN_TRACE "---------------------------------\n");
> @@ -10625,17 +10626,18 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>  
>  		trace_iterator_reset(&iter);
>  		iter.iter_flags |= TRACE_FILE_LAT_FMT;
> +		ent = trace_find_next_entry_inc(&iter);
>  
> -		if (trace_find_next_entry_inc(&iter) != NULL) {
> +		if (ent) {

Why do we need "ent"?


>  			int ret;
>  
>  			ret = print_trace_line(&iter);
>  			if (ret != TRACE_TYPE_NO_CONSUME)
>  				trace_consume(&iter);
> +
> +			trace_printk_seq(&iter.seq);

Isn't just moving trace_printk_seq() enough?

The code is no different with or without the "ent" as "ent" is not used in
the if block.

-- Steve


>  		}
>  		touch_nmi_watchdog();
> -
> -		trace_printk_seq(&iter.seq);
>  	}
>  
>  	if (!cnt)

