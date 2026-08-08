Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913F42C1594;
	Sat,  8 Aug 2026 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786150258; cv=none; b=RpAWI48JVkzk72sT8yjZnYxzXy7c6E9nvDeqBhGlXMjumfFCp05RltCj79SVXgfNqdRfAt95tn5CF0MQmjTgAKS3/f2hX0cnsxNduHutcIUlOWCOp/TNLdJ7xTW5N+tcIFPO+IF808VDhmFJxlnZudt7VWMC+OVo84nCT3C5EvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786150258; c=relaxed/simple;
	bh=wCjMZJxiQb5jNPngAYFU602tT3LnRqedsDi0U55tcTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQBdPGDmdy/tu607XVBNjqFSaYWnf6SyaCIj2dPeZBiCdK0b2YPVQWG3rXHMoTKLU3KnHvH54PI49ilvkM1eiERZBT3mZeDOYNa1dbj+20CquagRxu5ZXijtcwL6iIwO3tVSFuzoWP/z8NiTqQ7BBDP8T1O070zZTa4Mc4EAyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 1B4358020C;
	Sat,  8 Aug 2026 00:50:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 522E12000E;
	Sat,  8 Aug 2026 00:50:50 +0000 (UTC)
Date: Fri, 7 Aug 2026 20:50:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Pekka Paalanen <ppaalanen@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] tracing/mmiotrace: Clean up coding style and
 redundant debug logs
Message-ID: <20260807205053.7000eef0@gandalf.local.home>
In-Reply-To: <178524301945.56416.2087305624947649637.stgit@devnote2>
References: <178524298182.56416.7520852015178187644.stgit@devnote2>
	<178524301945.56416.2087305624947649637.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: but57si57nhqcgc6yng1suher1mosm3u
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 522E12000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19gRu8bUZ9VZnlDoRBGEO+tZKahHYXFwsU=
X-HE-Tag: 1786150250-943132
X-HE-Meta: U2FsdGVkX1+WHC481oLJWAA19yCFqIbY1AD5kD10b9zjYdqPGVuqTyJDTlsfGr0ZRtGwSyRfHk9WjqEkwfRCFNQopbZL89yvsCebadSWHixmFQWA8YzADAlUaIpxpYr/hzDTrW/GjndiCmSN+9f2ENi4M3ak1dQsOsluTWqRpFNhx35RjGcFajI9bYZ45Ke7abt+pFHko9dEpgMyN9g5Lcq22AOAdJFnrA6euvPhbDjyU69JrobJyGPVN/22GoZRcKJCQf4pf8xGGz9P521ZhIL1ZnqS3pYUsqfCQlaGnNhNtO/onqmhmXU1gbyVgDAy/J2fdPkePP7pgWLNfMdIV/10LA0mos2p

On Tue, 28 Jul 2026 21:50:19 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Clean up coding style issues in trace_mmiotrace.c:
> - Remove redundant pr_debug() entries in tracer callbacks.
> - Fix opening brace placement for mmio_tracer.
> - Prefer 'unsigned int' to bare 'unsigned'.
> - Add missing blank lines after local variable declarations.
> 
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_mmiotrace.c |   16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
> index 77120d467e11..ce16e1c53d12 100644
> --- a/kernel/trace/trace_mmiotrace.c
> +++ b/kernel/trace/trace_mmiotrace.c
> @@ -36,7 +36,6 @@ static void mmio_reset_data(struct trace_array *tr)
>  
>  static int mmio_trace_init(struct trace_array *tr)
>  {
> -	pr_debug("in %s\n", __func__);

So how are these redundant?

Are there pr_debug() prints elsewhere?

>  	mmio_trace_array = tr;
>  
>  	mmio_reset_data(tr);
> @@ -46,8 +45,6 @@ static int mmio_trace_init(struct trace_array *tr)
>  
>  static void mmio_trace_reset(struct trace_array *tr)
>  {
> -	pr_debug("in %s\n", __func__);
> -
>  	disable_mmiotrace();
>  	mmio_reset_data(tr);
>  	mmio_trace_array = NULL;
> @@ -55,7 +52,6 @@ static void mmio_trace_reset(struct trace_array *tr)
>  
>  static void mmio_trace_start(struct trace_array *tr)
>  {
> -	pr_debug("in %s\n", __func__);
>  	mmio_reset_data(tr);
>  }
>  
> @@ -113,6 +109,7 @@ static void mmio_pipe_open(struct trace_iterator *iter)
>  static void mmio_close(struct trace_iterator *iter)
>  {
>  	struct header_iter *hiter = iter->private;
> +
>  	destroy_header_iter(hiter);
>  	iter->private = NULL;
>  }

This is fine.

> @@ -170,7 +167,7 @@ static enum print_line_t mmio_print_rw(struct trace_iterator *iter)
>  	struct trace_seq *s	= &iter->seq;
>  	unsigned long long t	= ns2usecs(iter->ts);
>  	unsigned long usec_rem	= do_div(t, USEC_PER_SEC);
> -	unsigned secs		= (unsigned long)t;
> +	unsigned int secs	= (unsigned long)t;
>  

OK.

>  	trace_assign_type(field, entry);
>  	rw = &field->rw;
> @@ -215,7 +212,7 @@ static enum print_line_t mmio_print_map(struct trace_iterator *iter)
>  	struct trace_seq *s	= &iter->seq;
>  	unsigned long long t	= ns2usecs(iter->ts);
>  	unsigned long usec_rem	= do_div(t, USEC_PER_SEC);
> -	unsigned secs		= (unsigned long)t;
> +	unsigned int secs	= (unsigned long)t;
>  
>  	trace_assign_type(field, entry);
>  	m = &field->map;
> @@ -249,7 +246,7 @@ static enum print_line_t mmio_print_mark(struct trace_iterator *iter)
>  	struct trace_seq *s	= &iter->seq;
>  	unsigned long long t	= ns2usecs(iter->ts);
>  	unsigned long usec_rem	= do_div(t, USEC_PER_SEC);
> -	unsigned secs		= (unsigned long)t;
> +	unsigned int secs	= (unsigned long)t;
>  
>  	trace_assign_type(print, entry);
>  	msg = print->buf;
> @@ -274,8 +271,7 @@ static enum print_line_t mmio_print_line(struct trace_iterator *iter)
>  	}
>  }
>  
> -static struct tracer mmio_tracer __read_mostly =
> -{
> +static struct tracer mmio_tracer __read_mostly = {

OK.

>  	.name		= "mmiotrace",
>  	.init		= mmio_trace_init,
>  	.reset		= mmio_trace_reset,
> @@ -322,6 +318,7 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
>  void mmio_trace_rw(struct mmiotrace_rw *rw)
>  {
>  	struct trace_array *tr = mmio_trace_array;
> +
>  	__trace_mmiotrace_rw(tr, rw);
>  }
>  
> @@ -353,6 +350,7 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
>  void mmio_trace_mapping(struct mmiotrace_map *map)
>  {
>  	struct trace_array *tr = mmio_trace_array;
> +
>  	__trace_mmiotrace_map(tr, map);
>  }

Honestly, for one line functions like the above, I think it looks better
without that blank line.

-- Steve
