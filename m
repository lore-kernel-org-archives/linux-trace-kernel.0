Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3D4414410;
	Thu, 10 Sep 2026 19:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069791; cv=none; b=PIlRHswpU67Bqzvtkw5C9tZSKX832KQcTzVFNNtlFTTzS18GC/QJ61o3Vml2rLYb0cNF+kSy7NzuHfWHfgXqllGGEFCw8tNjYYEiDYyMMwqRqGn0H0fqRjkoilIBdoN5oeYJZEI641/4PdnQjM0zOzZbl7sZN6YEV5bp0YCjAuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069791; c=relaxed/simple;
	bh=o0E3ej8IJtZG62v+U24bvvYCrYmceoNHmQDSn5theBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O4KCLtxXiQih1m8qz7RliYvaxT0aXcdS55GUz2/M7KS0ADDc9E1rpdpYJ+rQnW5hIPJM/uDWZ7+r+6Go01PHWMzttpSa9glPyxsOovSG/0ErpUSUCQfBCEV0bqhygEfNb295+IcxpvLWCth65Avcqe700sJ3c6fL9WormINDTS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=x5wBNy7/; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="x5wBNy7/"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 970EFA0673;
	Thu, 10 Sep 2026 19:49:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 9B82B20011;
	Thu, 10 Sep 2026 19:49:39 +0000 (UTC)
Date: Thu, 10 Sep 2026 15:50:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Vincent Donnefort
 <vdonnefort@google.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ring-buffer: Add a MAINTAINERS category specific for
 the tracing ring-buffer
Message-ID: <20260910155058.1ac4c991@gandalf.local.home>
In-Reply-To: <20260908094035.0b180833@gandalf.local.home>
References: <20260908094035.0b180833@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9B82B20011
X-Stat-Signature: ribqy4p5ukfsif7e7wp91hkc8s9h9gde
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19DodBne/ofLE9S7IVSyvAwgITE8f+bW20=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Yn7RNSD/LScTzHZCOG+4Zox0+rWkWpd3yxzMobe1abM=; b=x5wBNy7/5+mLP7vfeKLeKslo78KDRITNZsLUa+cBIzNlODtFmsGp1HhtnaP5ZVYYt6MkJdvViKlHv95nj6Q/oA7uSd+VbCn9uuR48hHyD2Oth+YmwnNkK0jFUXyxGx101W4ARkAV6KGT6hFV83tinPazda5AvM3Kf6n9WruW7yY=
X-HE-Tag: 1789069779-415868
X-HE-Meta: U2FsdGVkX1+QjHhT41MEdqQ1sIY7IeScQVsEZ2m0yzpH3vQPGAY1yj9K9eBVcZSplzIa4GzONczlwWdbmIzjvywHEePwiATVRB8qR2gSLW78JuZA6fkDvbzY74qo+89gvzFZ+O+OovTcy2YWIbXtBZYzV78wQu/8SmsZV99F6sRUxcZ+8++7Aer6XoB5Yd6+eELzFhI8UhET5Cva8TUFzJIJz6GM26B1GHOTF65SQEMtdprnt23PM1Q3LjFp51D6fKOVlADYO9rX8udLdjoBjStjfNq9dtINo/y0vXksLTKT5dpnHEAbcv+ZvBG8+5Lhsv/pSGQQm4qPGbuJFn4BwRXNC26C3Z+pFIuZvAxUsw1WshmO71zmPu0au5zJwsmQm3AoxCy9V46aW4S7ajkYcLAN9FVvgQVHjlGgZtfeXXN0ktvj4KQf/VK4vVWeCYYQJmnop5sL3ClYiuMlrygUCbkHAD/2Hzs2gfzkVRdyfjYkbpYW6VE+J4ujkIpz8ON6


Masami,

Can I get an official Acked-by on this?

Vincent, you can also give an Acked-by too.

-- Steve


On Tue, 8 Sep 2026 09:40:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The ring buffer code in the tracing directory has always been decoupled
> from the tracing code. It had a clean abstracted API to allow it to be
> used by systems outside of tracing. The API even allowed the ring buffer
> code to be drastically changed without affecting the tracing sub-system.
> 
> Recently, Vincent Donnefort has been contributing a lot of work to enhance
> the ring buffer. He implemented the user space mappings and recently
> created a version to allow pKVM hypervisors to use the code to trace
> the hypervisor and expose the events to the user.
> 
> Create a separate category for maintaining the ring buffer code so that
> Vincent can become an official maintainer of it. His work has little to do
> with the tracing code itself. In the future, he may even be the main
> maintainer of the ring buffer.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a19da74d00c..71bd2f57055d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27778,6 +27778,22 @@ F:	kernel/trace/trace_irqsoff.c
>  F:	kernel/trace/trace_osnoise.c
>  F:	kernel/trace/trace_sched_wakeup.c
>  
> +TRACING RING BUFFER
> +M:	Steven Rostedt <rostedt@goodmis.org>
> +M:	Vincent Donnefort <vdonnefort@google.com>
> +M:	Masami Hiramatsu <mhiramat@kernel.org>
> +L:	linux-kernel@vger.kernel.org
> +L:	linux-trace-kernel@vger.kernel.org
> +S:	Maintained
> +Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> +F:	Documentation/trace/ring-buffer*
> +F:	Documentation/trace/remotes.rst
> +F:	include/linux/ring-buffer*.h
> +F:	kernel/trace/*ring_buffer*.c
> +F:	kernel/trace/remote*.c
> +F:	tools/testing/selftests/ring-buffer/
> +
>  TRADITIONAL CHINESE DOCUMENTATION
>  M:	Chen-Yu Yeh <chenyou910331@gmail.com>
>  M:	Weijie Yuan <wy@wyuan.org>

