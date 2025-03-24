Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26C23A9;
	Mon, 24 Mar 2025 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795156; cv=none; b=AjmaIxK3AoRrQvsy1boC49ibilsMCEX0bC+AxGbDtBU8NDHPm6jkkrvaNgN0GM67wUO/IQfBHk1Boq43wCJHMgyF/SpSdTrDgU7Q9e5Ck0fotWn1QlaBxaZ5ARGfl4IrNYlHhoCQ+tWhfRTGvnj7Ts9bDjgx1YWQxOCAZP0W8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795156; c=relaxed/simple;
	bh=0jvW7nz7pOOA0IOuCXljauxGCOytip26AbipW7bgnGk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HRh6vKLp3CEY11ydeVcMIDiJHgZYvvXXFVKL1/BhJDJrPpsSGXNzAR82dPDer4Q1fKM70h8jPXKFyMKhooK0SYubf5F8UGtcDVooYGKL/BaCt2VinkRX+zd5BnOREFml0xa1EQWbsHc62UA5ygxvqDqKpyHtwXKw5zGwvsanoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REIdq1Q2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REIdq1Q2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC86C4CEDD;
	Mon, 24 Mar 2025 05:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742795155;
	bh=0jvW7nz7pOOA0IOuCXljauxGCOytip26AbipW7bgnGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=REIdq1Q2LUUxZwRNgCX6Fpay85QeDfW1H/ysEYqCTdGazj6TLpiLBOcY5fHtaSHIo
	 XBFkPes7cAFISuEzaeb/l3ZDuULTIoEUho+lTqNz4hV2I7rBRhXcGSH7a9EUUKYmJJ
	 n2p7Vo6MWg+ZjuZyjX3qObKnQes7JxW9CWur42/XfWeSnh4GfGr620TgAkaFS3yHxr
	 hvN721nqxvOiUI0LtmLgVSThVKoc0SSVTpY6xpEt1KmBaHdL0iu+T59gG+BF/N2nZP
	 IC0VJpUumWIcCtmexmO9gBAWPZTjx/jpae0r3wYlIHAEK1M8LqsrIekRrNMM9Ss3vB
	 lx7dpFMosiaPw==
Date: Mon, 24 Mar 2025 14:45:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Douglas Raillard <douglas.raillard@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix synth event printk format for str fields
Message-Id: <20250324144551.fc290f9cf9f57b3d2f205354@kernel.org>
In-Reply-To: <9d234136-05b9-46b6-849f-901df83bf54c@arm.com>
References: <20250318180939.227696-1-douglas.raillard@arm.com>
	<20250319211858.6d8166e3fb202e6e5a658557@kernel.org>
	<9d234136-05b9-46b6-849f-901df83bf54c@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Mar 2025 14:34:19 +0000
Douglas Raillard <douglas.raillard@arm.com> wrote:

> Hi,
> 
> On 19-03-2025 12:18, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > On Tue, 18 Mar 2025 18:09:38 +0000
> > Douglas RAILLARD <douglas.raillard@arm.com> wrote:
> > 
> >> From: Douglas Raillard <douglas.raillard@arm.com>
> >>
> >> The printk format for synth event uses "%.*s" to print string fields,
> >> but then only passes the pointer part as var arg.
> >>
> >> Add the missing precision var arg.
> > 
> > I'm not sure what you want to. Would you mean showing the string length too?
> > But I think actual output(*) shows only string, right?
> > 
> > (*) the output data which can be read from `trace` file.
> 
> The "%.*s" printf/printk format specifier has 2 components:
> 1. the "*" part that in printf documentation called the "precision"
> 2. the "s" part that is called the "specifier"
> 
> For a "s" specifier, the precision is interpreted as the number of chars to display from that string.
> In any case, using "*" as precision means the value is passed dynamically, as a parameter to printf/printk,
> before the actual char *. Both those args are consumed by printk to display "%.*s", the precision is never
> displayed on its own.
> 
> In the current state, synthetic event use "%.*s" for string fields, but then only a single `__get_str(field)`
> is passed to printk, so it's missing the precision arg. Both trace-cmd and our parser report an error because of that.
> 
> The alternative would be to just use "%s" instead of "%.*s", but I assume whoever wrote the code initially had a reason
> to use the precision (maybe to print non-null-terminated strings ?), so I simply fixed the arguments.

Ah, got it. It seems that the first precision parameter is for limiting
the length of the string according to the commit;

https://lore.kernel.org/all/b6bdb34e70d970e8026daa3503db6b8e5cdad524.1601848695.git.zanussi@kernel.org/T/#u

So, I think it should always print the STR_VAR_LEN_MAX value.
Steve, can you check it?

Thank you,

> 
> > 
> > Thank you,
> > 
> >>
> >> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> >> ---
> >>   kernel/trace/trace_events_synth.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> >> index e3f7d09e5512..274b9b1d9f7d 100644
> >> --- a/kernel/trace/trace_events_synth.c
> >> +++ b/kernel/trace/trace_events_synth.c
> >> @@ -620,7 +620,8 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
> >>   		if (event->fields[i]->is_string &&
> >>   		    event->fields[i]->is_dynamic)
> >>   			pos += snprintf(buf + pos, LEN_OR_ZERO,
> >> -				", __get_str(%s)", event->fields[i]->name);
> >> +				", (int)__get_dynamic_array_len(%s), __get_str(%s)",
> >> +				event->fields[i]->name, event->fields[i]->name);
> >>   		else if (event->fields[i]->is_stack)
> >>   			pos += snprintf(buf + pos, LEN_OR_ZERO,
> >>   				", __get_stacktrace(%s)", event->fields[i]->name);
> >> -- 
> >> 2.43.0
> >>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
