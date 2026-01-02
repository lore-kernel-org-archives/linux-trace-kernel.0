Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5071DF748
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Jan 2026 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767380181; cv=none; b=M0uCxC0VwnC5wLfdxzSgff1yprBLx65/CXaaDJZRtaHMwcUHfnaSKWQayt4G+6rU7c39w/n+dtMG7SoIL/OimQiKf1VygVxLLN7NFgKBkONdrFOCA7oCTke4jz8EYJXx7FceGQu/+1TSwXJo471ldl2nECMehQ9LDgBO3NsNRWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767380181; c=relaxed/simple;
	bh=BXUNzkCsgZRHcyPjl1Ako/omwR2Cr+wIsuUcfjd20TI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzSbdjJACoPqfVKk5TbNgyV6AvvNMFqA5opMJ/pdyF8CiHvzIP9c2nZNNhjm4LkU6QHSCdTuqeo1WBRVzu+ECK1H5tiA+Vo5jEFWIrQZ/GdkLQY4fvn5BNh8O7Gtx3Hq6joKGZlSog/aC5BTI7l4CdMTfSuVAPnbh/JG0EKO6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 56EE05BEED;
	Fri,  2 Jan 2026 18:56:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 733B820028;
	Fri,  2 Jan 2026 18:56:15 +0000 (UTC)
Date: Fri, 2 Jan 2026 13:56:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: pengdonglin <pengdonglin@xiaomi.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20260102135630.0a5d91fb@gandalf.local.home>
In-Reply-To: <aS6kGi0maWBl-MjZ@stanley.mountain>
References: <aS6kGi0maWBl-MjZ@stanley.mountain>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 733B820028
X-Stat-Signature: yjsbpwu81hwgynh1j1uo4w4o8j6toa9j
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+78HZo2OcQYTsCTotTgngwo9c+HqDZVAk=
X-HE-Tag: 1767380175-561444
X-HE-Meta: U2FsdGVkX1/PZ9RHhQMpTH/JOXjfBMfIBZrgXkokK4Aep/Bwr9Xhl1tC2NoAgpk8Wb1nc3Ab0j2vvPNth3OucOU27Eyh3YxbEudcbEdJPHRNROYOHtW1DelrC+pesisYhFigyk6jQJfiL5SLrSEG/V3dVfqQT9WIA87fYwkD7E3cy+YmrbCtguh/iwBH8nZbbtSpVVhIZTTiOfcXdXmOd/MZraew48nPHF1lf9YAyRV8jblq2zMMuxCmw0ar2fXDiXqLIC2PtXurx0g1ndfdKT4vsXEkA76PHP1RBBGTyohA1yOFqxtEsx1Icg/Eoaj7aUicmKftr2HYKLBQyPmK/ngU+iOMaihquIvJhrTt04zO9rxoLxrmsVDmdL/C+D/U

On Tue, 2 Dec 2025 11:32:26 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

I just noticed this email.

> Hello pengdonglin,
> 
> Commit f83ac7544fbf ("function_graph: Enable funcgraph-args and
> funcgraph-retaddr to work simultaneously") from Nov 25, 2025
> (linux-next), leads to the following Smatch static checker warning:
> 
> kernel/trace/trace_functions_graph.c:1033 print_graph_entry_nested() warn: unsigned 'call->depth' is never less than zero.
> kernel/trace/trace_functions_graph.c:975 print_graph_entry_leaf() warn: unsigned 'call->depth' is never less than zero.
> kernel/trace/trace.h:1130 ftrace_graph_ignore_func() warn: unsigned 'trace->depth' is never less than zero.
> 
> kernel/trace/trace_functions_graph.c
>     1012 static enum print_line_t
>     1013 print_graph_entry_nested(struct trace_iterator *iter,
>     1014                          struct ftrace_graph_ent_entry *entry,
>     1015                          struct trace_seq *s, int cpu, u32 flags)
>     1016 {
>     1017         struct ftrace_graph_ent *call = &entry->graph_ent;
>     1018         struct fgraph_data *data = iter->private;
>     1019         struct trace_array *tr = iter->tr;
>     1020         unsigned long func;
>     1021         int args_size;
>     1022         int i;
>     1023 
>     1024         if (data) {
>     1025                 struct fgraph_cpu_data *cpu_data;
>     1026                 int cpu = iter->cpu;
>     1027 
>     1028                 cpu_data = per_cpu_ptr(data->cpu_data, cpu);
>     1029                 cpu_data->depth = call->depth;
>     1030 
>     1031                 /* Save this function pointer to see if the exit matches */
>     1032                 if (call->depth < FTRACE_RETFUNC_DEPTH &&
> --> 1033                     !WARN_ON_ONCE(call->depth < 0))  
>                                            ^^^^^^^^^^^^^^^
> The patch changed call->depth from int to unsigned long.

Yep, I'm fixing this with:

			!WARN_ON_ONCE((long)call->depth < 0))

Thanks!

-- Steve

> 
>     1034                         cpu_data->enter_funcs[call->depth] = call->func;
>     1035         }
>     1036 
>     1037         /* No time */
>     1038         print_graph_duration(tr, 0, s, flags | FLAGS_FILL_FULL);
> 
> regards,
> dan carpenter

