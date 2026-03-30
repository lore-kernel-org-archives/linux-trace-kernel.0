Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF99199D8;
	Mon, 30 Mar 2026 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774888618; cv=none; b=Vx1GIkvBq3GJDLFaaZ18029ZXucPlWVLc/SvSGPzwYXE9m9TKPRbu18DC967nS6WVYX0VkgacqsX9ILvYb8pupH5q7w7xB59vMy9ek+/L98vMLVscZFWMtxLOOy/Oz21ytNhC7/tWyiqMKTtOzTKw3UULogKWXALIEIAMIpzXWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774888618; c=relaxed/simple;
	bh=gLoP6d9cayxGFFF7aUy5nxWkAuv9afR7MDJEtIKf7II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kIshkhdTmgs2fcSPxHxlPOdRJFys9UwjIcmH0X3x/8cMKS9/Zazi3DagGWhEKkdeEiFVDHogYnKiwurfaU4wud+94nwfwvQ6K5ZBOjcD5cSXYxhZ9Mr+32SIH2KuzNcE2L6KIX4bGum0Z4sNJxiRikQxJ/bm/70VsaWe7uFNAFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 23720C21A2;
	Mon, 30 Mar 2026 16:36:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 362F120031;
	Mon, 30 Mar 2026 16:36:48 +0000 (UTC)
Date: Mon, 30 Mar 2026 12:37:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tracing: Preserve repeated boot-time tracing
 parameters
Message-ID: <20260330123743.5cd30e56@gandalf.local.home>
In-Reply-To: <20260330104322.7403c660@gandalf.local.home>
References: <20260328201842.1782806-1-atwellwea@gmail.com>
	<20260329184254.1813273-1-atwellwea@gmail.com>
	<20260330104322.7403c660@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 362F120031
X-Rspamd-Server: rspamout06
X-Stat-Signature: hcxefqe43i64j9y6yjuy4njyssoa1txb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18kb0hZo+lVgboiV6TnomSSZ10SrRPNBWU=
X-HE-Tag: 1774888608-338937
X-HE-Meta: U2FsdGVkX19WXGhR6VkGQ0bWhPDSwoAGoC/9lPAB5LfOT6HV7lav6X8idqFkxVQ/J5wGOlTtXdF1ZB+yVgs95AVBNTOfLoqr/KAV9v86C1HHrdmNpUjb34zjuVl9aQegrR5dT8Jl7w/xxrc1E52Y9rgb2UiHsCxu4OsScRWYKaLEXxNCYa9GkRoWAEqd3mczm7m9r8OIaAiPBIf3E1NMUowRdcwPsu8ZmJKyCoZoSOH0+rSRBZFPYU1S4DFJ2aGLlpv3yso9Hix5HJzzTAb2LiFVYxk0DcGFTGSKcW/9r9DPgKhcj9C6rjp4VE+AZKwBE+FzpGivXc3eoB6WSQbq8h7F4NZoknsK2AwlRwfjGyy1nyIQ52d4h/IBYnXDOKyB

On Mon, 30 Mar 2026 10:43:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 9928da636c9d..7754a8adb58a 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -3677,20 +3677,24 @@ static struct boot_triggers {
>  } bootup_triggers[MAX_BOOT_TRIGGERS];
>  
>  static char bootup_trigger_buf[COMMAND_LINE_SIZE];
> +static int boot_trigger_buf_len;
>  static int nr_boot_triggers;
>  
>  static __init int setup_trace_triggers(char *str)
>  {
>  	char *trigger;
>  	char *buf;
> +	int len = boot_trigger_buf_len;
>  	int i;
>  
> -	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
> +	strscpy(bootup_trigger_buf + len , str, COMMAND_LINE_SIZE - len);
>  	trace_set_ring_buffer_expanded(NULL);
>  	disable_tracing_selftest("running event triggers");
>  
> -	buf = bootup_trigger_buf;
> -	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
> +	buf = bootup_trigger_buf + len;
> +	boot_trigger_buf_len += strlen(buf);

The above needs to skip the '\0' too:

	boot_trigger_buf_len += strlen(buf) + 1;


> +
> +	for (i = nr_boot_triggers; i < MAX_BOOT_TRIGGERS; i++) {
>  		trigger = strsep(&buf, ",");
>  		if (!trigger)
>  			break;

