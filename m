Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12911218ADD;
	Thu, 29 Jan 2026 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717932; cv=none; b=ae23oFEfEncWhdyo1VyckX+sRjrtizMUd87LhpDx6yWh81Fwf5vW1O5Fb/FhkfkJ/L6pACqpgBzayZt311HnoRgeCSe4zsScGKzKENr13vvuiCjuWEPNMS30FrkOzJy76oipc4nRmel9OxMg4A2lkquzelqlgrHD7omGAiji94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717932; c=relaxed/simple;
	bh=e4yfknTmyw95fHxVG+8zTb4mbzHsH3w+zAo8geKXDmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdqFo1tukUeYpsIwpsUht7vrQVpE8zbhdLIbrvKdgzFFjv3icPf3Qm3tEbVkALSq4oVk+BDgupZZ2zm9IEUteQ6GWHdGfvoD3jzankpLsf9S3Ps338BHOCB7XU8LyJeNu/AF4ojyJ+PPXu21dg6i+u//3IJOdElRBKtRKsvMqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id F1900B7E8C;
	Thu, 29 Jan 2026 20:18:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 6962220029;
	Thu, 29 Jan 2026 20:18:48 +0000 (UTC)
Date: Thu, 29 Jan 2026 15:19:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] tracing/Documentation: Add a section about
 backup instance
Message-ID: <20260129151900.44b6182c@gandalf.local.home>
In-Reply-To: <176955901173.2786091.7719483008240216705.stgit@mhiramat.tok.corp.google.com>
References: <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
	<176955901173.2786091.7719483008240216705.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8jf4t6s6qfqzsmxy4q1ag3n34dnhjw8a
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 6962220029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+A7moSVfg9urlwMoNrnEGHscSXt6ClBbw=
X-HE-Tag: 1769717928-445420
X-HE-Meta: U2FsdGVkX18VvbGH6zeo7IM/SlTneLa8/o5K1oXychGCPiBJ5guAiKidsLvkzl/KebgTfiqPgPBVkiTqANCE5fX9+58Wtx/KeZBjdBrzWgv8fPZlYm9VA8SjZDNy7z7Oft/xjhSGkaopNXJ24g/3VYO9Rp3pQd6hsYo4aRdj3ktKqlTs94iH4gDIUPqnoPOJt9540fV/3CpmVF55+8HrHUdgE63XbviD4s6FDaCvFdAiE5SN+Ez/CbVFgJ6Lu1feJ+lGDCwoRQdfPJLA4jvC1VNg02LnZBQsAItwvL66wWPVk7NsnXf8Jn03Owu7Kr33v2YzRVd5/TYzcdnm9bcJwV0Ezh9BKNuu

On Wed, 28 Jan 2026 09:10:11 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a section about backup instance to the debugging.rst.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Documentation/trace/debugging.rst |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
> index 4d88c346fc38..73e2154bcf98 100644
> --- a/Documentation/trace/debugging.rst
> +++ b/Documentation/trace/debugging.rst
> @@ -159,3 +159,22 @@ If setting it from the kernel command line, it is recommended to also
>  disable tracing with the "traceoff" flag, and enable tracing after boot up.
>  Otherwise the trace from the most recent boot will be mixed with the trace
>  from the previous boot, and may make it confusing to read.
> +
> +Using a backup instance for keeping previous boot data
> +------------------------------------------------------
> +
> +It is also possible to record trace data at system boot time by specifying
> +events with the persistent ring buffer, but in this case the data before the
> +reboot will be lost before it can be read. This problem can be solved by a
> +backup instance. From the kernel command line::
> +
> +  reserve_mem=12M:4096:trace trace_instance=boot_map@trace,sched,irq trace_instance=backup=boot_map
> +
> +When the boot up, the previous data in the`boot_map` is copied to "backup"

  s/When the boot up/On boot up/                   copied to the "backup"

> +instance, and the "sched:*" and "irq:*" events for current boot are traced on

                                                  for the current boot are traced in


> +"boot_map". Thus user can read the previous boot data from the "backup" instance

               Thus the user

> +without stopping trace.

           stopping the trace.

> +
> +Note that this "backup" instance is readonly, and will be removed automatically
> +if you clear the trace data or read out all trace data from "trace_pipe" or
> +"trace_pipe_raw" files.
> \ No newline at end of file

Definite articles are a pain ;-)

-- Steve
