Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4AB290F;
	Tue, 29 Jul 2025 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817493; cv=none; b=sHH6fFL2EVvOnIVwF4ccF6ToMknK8Ad8y7ECB0Tba5XVWHlGUBRWDYbz/vGVYoXpSHyW82ubRwvt2HMagt/QcXu8pzGE2oci2fEYCSVLkpSnF5vGKM5q1GUnMTPpDEPKvUU/fQ8OHm2Z5hVzFgAkfvRPinJ9AOKQl56EuXYjVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817493; c=relaxed/simple;
	bh=lf6ecvMS5lLzD0DRcpsuhPk873JChd5ltyBTyFxKsro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoTZhM0v6Riv45tXyOncDN1gohE5LTHouP83Cy8gOZaJ54KpxcHhSWHBfVR/J5VaBrm73K1BLuk6aw42mgaDFVhyTMNEfJ2ZfeEPkDiW5l4aGepiPdxrb1QmIWpeF3WcRFNpBhD0QblmLkNiks5i+BGyWGCjrQid5ziDeKjbRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bxn7XCOv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bxn7XCOv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=8UtUbjq+gsXVwNRHEqmPskVJ8RBN/bsJxXpAuzkbI2o=; b=Bxn7XCOv7anPwOISWDwXK9AZvk
	s6PmHPur67emnifPf5wGCBw80V8TwAiukXaw42qwHm9n+s4S024vJjgLCnTII2Y9ALe7KO4UGyVCD
	6784V+tKf5Yv9n8el10fAX6wLvDgS9e6D5Z/j3dGuQuRbDIPHz4NRv03psVOzgU/ADwMW5lDqNGiQ
	99WFvuYIb1N9Z5nGpSYbJHq+En/1suw3Dd4jOwMPUo0Lh8ZwNdkjzaAGkAGQq/4TbYrpQbKyzNh8S
	pZI1a3l4Z/m7ANpVfUJLAgro22SQT1VuzH6L9lziSAnS0iqQWT34gbDyW57I0xcx5qk8N9Q+RHpue
	AOLqM3pA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugq2t-0000000HYfs-0e84;
	Tue, 29 Jul 2025 19:31:31 +0000
Message-ID: <3b0a2731-6072-467f-937b-4135f53b9031@infradead.org>
Date: Tue, 29 Jul 2025 12:31:30 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Documentation: tracing: Add documentation about
 eprobes
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Namhyung Kim
 <namhyung@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20250729161816.678462962@kernel.org>
 <20250729161912.226505358@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250729161912.226505358@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Steven,


On 7/29/25 9:18 AM, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Eprobes was added back in 5.15, but was never documented. It became a
> "secret" interface even though it has been a topic of several
> presentations. For some reason, when eprobes was added, documenting it
> never became a priority, until now.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/20250728171522.7d54e116@batman.local.home
> 
> - Renamed to eprobetrace.rst (Masami Hiramatsu)
> 
> - Fixed title of document (Masami Hiramatsu)
> 
> - Fixed grammar and spellings (Randy Dunlap)
> 
>  Documentation/trace/eprobetrace.rst | 269 ++++++++++++++++++++++++++++
>  Documentation/trace/index.rst       |   1 +
>  2 files changed, 270 insertions(+)
>  create mode 100644 Documentation/trace/eprobetrace.rst
> 
> diff --git a/Documentation/trace/eprobetrace.rst b/Documentation/trace/eprobetrace.rst
> new file mode 100644
> index 000000000000..6d8946983466
> --- /dev/null
> +++ b/Documentation/trace/eprobetrace.rst
> @@ -0,0 +1,269 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +Eprobe - Event-based Probe Tracing
> +==================================
> +
> +:Author: Steven Rostedt <rostedt@goodmis.org>
> +
> +- Written for v6.17
> +
> +Overview
> +========
> +
> +Eprobes are dynamic events that are placed on existing events to either
> +dereference a field that is a pointer, or simply to limit what fields are
> +recorded in the trace event.
> +
> +Eprobes depend on kprobe events so to enable this feature; build your kernel

I mucked that one up also. :(
Please s/;/,/ above. Sorry.


> +with CONFIG_EPROBE_EVENTS=y.
> +
> +Eprobes are created via the /sys/kernel/tracing/dynamic_events file.
> +
> +Synopsis of eprobe_events
> +-------------------------
> +::
> +
> +  e[:[EGRP/][EEVENT]] GRP.EVENT [FETCHARGS]	: Set a probe
> +  -:[EGRP/][EEVENT]				: Clear a probe
> +
> + EGRP		: Group name of the new event. If omitted, use "eprobes" for it.
> + EEVENT		: Event name. If omitted, the event name is generated and will
> +		  be the same event name as the event it attached to.
> + GRP		: Group name of the event to attach to.
> + EVENT		: Event name of the event to attach to.
> +
> + FETCHARGS	: Arguments. Each probe can have up to 128 args.
> +  $FIELD	: Fetch the value of the event field called FIELD.
> +  @ADDR		: Fetch memory at ADDR (ADDR should be in kernel)
> +  @SYM[+|-offs]	: Fetch memory at SYM +|- offs (SYM should be a data symbol)
> +  $comm		: Fetch current task comm.
> +  +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*3)(\*4)
> +  \IMM		: Store an immediate value to the argument.
> +  NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
> +  FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> +		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> +		  (x8/x16/x32/x64), VFS layer common type(%pd/%pD), "char",
> +                  "string", "ustring", "symbol", "symstr" and "bitfield" are
> +                  supported.
> +
> +Types
> +-----
> +The FETCHARGS above is very similar to the kprobe events as described in
> +Documentation/trace/kprobetrace.rst.
> +
> +The difference between eprobes and kprobes FETCHARGS is that eprobes has a
> +$FIELD command that returns the content of the event field of the event
> +that is attached. Eprobes do not have access to registers, stacks and function
> +arguments that kprobes has.
> +
> +If a field argument is a pointer, it may be dereferenced just like a memory
> +address using the FETCHARGS syntax.
> +
> +
> +Attaching to dynamic events
> +---------------------------
> +
> +Eprobes may attach to dynamic events as well as to normal events. It may
> +attach to a kprobe event, a synthetic event or a fprobe event. This is useful

                                                  an fprobe event.

> +if the type of a field needs to be changed. See Example 2 below.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
