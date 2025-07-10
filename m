Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A931274665;
	Thu, 10 Jul 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752155612; cv=none; b=uXlqkffWILXYKzQAYCWBVyJYPauVubpdapCzhEvdyueTvfZmm0BSvFmtpNQHLzyLichCaZL1XTZv93/oFVUPa2Zub6a3oTxunWIEWrIXw75UtZktBnOmvmkuYepf72bUo/g2/8d6QGJeuZtCN5hsGGMrTPIiwQ2uq0PvG559YRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752155612; c=relaxed/simple;
	bh=8tgmd27PZJO+f1MkLCVnDaaj/lGU7A5SeFzrYU6FRDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAa6Dyzdxlo6Qob3m5ePkhIa6htuK3SAU1uE9rCMWDSEXccqkKkWRg9bI7npVhbLMgx2FT/E45g0gjK5jj6k3YmiU6+qH3ciaF6ikRw7M5tvVPuqDdNpA2N9w96LWT1I7+yBcnCZIIvgj1rN5r/u74YaQeN3zIh2aeF9yA0axSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 0DCE01401B6;
	Thu, 10 Jul 2025 13:53:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 52B9A1D;
	Thu, 10 Jul 2025 13:53:27 +0000 (UTC)
Date: Thu, 10 Jul 2025 09:53:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250710095327.69144489@batman.local.home>
In-Reply-To: <20250710224520.4eaf514db761ecaaee9bc1e1@kernel.org>
References: <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
	<175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
	<20250709131107.397a3278@batman.local.home>
	<20250710224520.4eaf514db761ecaaee9bc1e1@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 52B9A1D
X-Stat-Signature: 19tnw31sz843bq1nxpccj6tyzqa9gtd1
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+IJW9/QRzN9RaMvgA2YJBEQbpPpiLISkg=
X-HE-Tag: 1752155607-777588
X-HE-Meta: U2FsdGVkX1/utthPu7SJsfJznStU8xu1t7c1F0+n0Qc/Sv43I2mLOqApnVtRsNU9P9I00h1nwTh9j1lkFQD4aWnvy1GHvXDv+dlz7H5am82nlUnmvxnI+bBppuwEMQstbIsTQLmHcr29Ugw+LqynCSU9rRLpdh6/zbi+5LN46c9NG+K00gsIDKcfximup5oOVwkFQVRdfBpJfUKgyK+tZOulovsO+8OhbgiLnExZxsRbRCxH81y2ewcCu1gLSMd3sKt58hr/WvCdjcUDXwQsGVSWGSwWwxbCjroDPFNnSgbW8auL7wL43OySw5hMlfofXgqqFsjFQlLys/RMiMP6Zp96noa/GyI7

On Thu, 10 Jul 2025 22:45:20 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > And it doesn't free after allocation because it only does the
> > allocation for events that will never be freed. For modules, it
> > registers the allocated string so it will be freed on unload.  
> 
> What happen if the tracepoint in module has the __attribute__?
> (or enum etc?)

It adds the string to a linked list via add_str_to_module(). When the
module is unloaded, it searches the link list "module_strings" for all
the strings registered under that module and frees it.

See trace_module_remove_events().

-- Steve
