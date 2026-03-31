Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF5546AEDF;
	Tue, 31 Mar 2026 21:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992017; cv=none; b=djPx0rkOePn96DnWU2inscMelABy04ifA31s+pAEU+uuuzC+PZMgK1QJzWCbrsil5cxW3VMateXR2hF+PZ0TLDrwz5oK3A7vn3MEymmc6B+osqbB6pqaNvVKoq1he8SWSDuBgX0o6KG6Uwzp0c3cT0mNtToWM6dbdNa0+NidzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992017; c=relaxed/simple;
	bh=+v68zlcZQbgBArQ3/5VYlDE3eE4JUr4zE++uuwb20JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibss1Jc/OAryw1WMq2I1r8mGY9FC4Ifq227nkpTrcIXHeyarVRiTnHe/MAMPFWkPdXVt1EAJpGIZORe1NVxqI6b05PFS/NAPu/61rtjUFs1Ft48kP6KYBCK4FEfbCQ351jLEmXHvSihvDmmzUQvRvgM64cTzjB4R4ozb6WduYLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 0125EB86BF;
	Tue, 31 Mar 2026 21:20:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 5AAA320015;
	Tue, 31 Mar 2026 21:20:07 +0000 (UTC)
Date: Tue, 31 Mar 2026 17:21:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/3] tracing/Documentation: Add a section about
 backup instance
Message-ID: <20260331172105.609d59aa@gandalf.local.home>
In-Reply-To: <177497476117.569199.18085846838539980210.stgit@mhiramat.tok.corp.google.com>
References: <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
	<177497476117.569199.18085846838539980210.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: t4dppshh1c4frweectcwpn8zrhkqb38z
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 5AAA320015
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/bmrrhBfFF//4KG5QDsNkDC//iyL/CmtU=
X-HE-Tag: 1774992007-278459
X-HE-Meta: U2FsdGVkX19Wfgfh/R/vB2cfrv8VbZrSmrho14ZE+korkV/HDJh8sS9EnuP5tfkIvCZtqIMXaf0+vNu3Jl9jyyb1nk1UD1WOYwvbt01iEWGLwND/WXxxj1wJ3G4Lk7xONspnX761RbiTHCULqcUl5SmvQLTFkZOeDyzHqk41//CWZYM7ipIUFc2uUjbeRBXlzOAPpV4w+gqJi/7DeT6ZFDKTDJEwCpHxUMqGII2l1u0dCqnCBCAV7+04YnQtetj+1g6xLRC7gbTbEmtFGJp79ch72Ua+QJqpHjJMR7dq5tGzQnUwD93G1Dm77nl0bbyJoGehXqMQMNrLDS+lWhKl1JBLmG0FO5Y+

On Wed,  1 Apr 2026 01:32:41 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add a section about backup instance to the debugging.rst.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   Changes in v6:
>    - Fix typos.
> ---
>  Documentation/trace/debugging.rst |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
> index 4d88c346fc38..15857951b506 100644
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

The above didn't actually work well without my patch to enable events on
the persistent ring buffer with the backup. But keep it, as it will work
with my patch ;-)

-- Steve


> +
> +On boot up, the previous data in the "boot_map" is copied to the "backup"
> +instance, and the "sched:*" and "irq:*" events for the current boot are traced
> +in the "boot_map". Thus the user can read the previous boot data from the "backup"
> +instance without stopping the trace.
> +
> +Note that this "backup" instance is readonly, and will be removed automatically
> +if you clear the trace data or read out all trace data from the "trace_pipe"
> +or the "trace_pipe_raw" files.
> \ No newline at end of file

