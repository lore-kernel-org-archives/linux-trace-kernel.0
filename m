Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A6288C96;
	Tue, 22 Jul 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224271; cv=none; b=msNe4pqxXEjaOA2+FJv/EkX5IQNrZBiKP/Kb/ACXClahcHsIl0OGwGltMMfWdo4S9vtHbzzUqf9Wea33e7RKoufEmg9qBRcW+zU6g59eDlaDxr+nd1D92OK7E2L6zZ7OaRwwiXCxmD2f5QwlsimgajEel4kVG4Bl/MBYq5nudiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224271; c=relaxed/simple;
	bh=Jda7N7pg0x484gJe9XR+a8dHcBcsTAb24iz27ImCYzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pN9lP66+Tx1C7p5XZzGNi1hiJje+Dc5oEVXRdnyUJSJofu3qnEpB8eis5I+ZnoDHMDtTBvhxWoiYHBi+9agWF7LC8mzBQjvWJAmR0n7nJ8Az7LR8o9FQA/0/NWMOXzVzjWgq9f4p0g7vdTsvwWOPb+uEaX9UDJOJPcUOzhlVhT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id DC190112D67;
	Tue, 22 Jul 2025 22:44:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 4828020025;
	Tue, 22 Jul 2025 22:44:21 +0000 (UTC)
Date: Tue, 22 Jul 2025 18:44:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] tracing: probes: Add a kerneldoc for
 traceprobe_parse_event_name()
Message-ID: <20250722184420.24a9239e@gandalf.local.home>
In-Reply-To: <175322175536.44400.179953626110801411.stgit@devnote2>
References: <175322168606.44400.9155291012158349647.stgit@devnote2>
	<175322175536.44400.179953626110801411.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4828020025
X-Stat-Signature: 9bs4wqefw6prs5peyt317rkth7ezyp5d
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+2/30nACxrOvxzsGMn+IGSEJkL/A/T/l0=
X-HE-Tag: 1753224261-402744
X-HE-Meta: U2FsdGVkX1/ASRQsQ1xsuJ6AtY6bZmgIcO9jsPSg6fWCN8/qgTtClk6jS0vxSVRj0mHutwz1qOsnluHQ8s/1G3MUgANE5DyF2+XUNN/k4cxv6jW1EEbX5MhlRNxnPS9VjtBgqKkr7ZatS+ORZWo3OJhZnt6rLcSfhn6/UsxcP+g8axTvwZMbDpNSh9c2kjwIKBeYkgS0tL1z1yT4qgli4nqvkut63uVtP7YjhqfDyS6N8rMnqk6uHWBhl6CnZyW1QqN8OpFeJArq2b6R+rCqC2MpqIVP6ysTqT2QT8bfJpWz7fgvV0Qa+a59UpsZ7F8n/4ov7InI5xBFC1OhZRHJidebJiO2mB1tQwBNPzc+ZkHMtOmjzQ2gNXyLzjln8W4RnMXm9tqDDQTR0rXAWVZD0A==

On Wed, 23 Jul 2025 07:02:35 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since traceprobe_parse_event_name() is a bit complicated, add a
> kerneldoc for explaining the behavior.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_probe.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 9d26d901c9e5..7dcc4a548c69 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -247,7 +247,22 @@ int traceprobe_split_symbol_offset(char *symbol, long *offset)
>  	return 0;
>  }
>  
> -/* @buf must has MAX_EVENT_NAME_LEN size */
> +/**
> + * traceprobe_parse_event_name - Parse a string into group and event names
> + * @pevent: A pointer to the string to be parsed. On return, this is updated
> + *          to point to the event name part of the string.

I believe, these are supposed to be single lines. What it has on return
should be in the "Return" section below.

> + * @pgroup: A pointer to the group name. This is updated to point to the parsed
> + *          group name, which is stored in @buf.
> + * @buf:    A buffer to store the parsed group name.
> + * @offset: The offset of the string in the original user command, for logging.
> + *
> + * Description: This parses a string with the format `[GROUP/][EVENT]` or
> + *          `[GROUP.][EVENT]` (either GROUP or EVENT or both must be specified).
> + *          The parsed group name is stored in @buf.
> + *          The caller must ensure @buf is at least MAX_EVENT_NAME_LEN bytes.
> + *
> + * Return: 0 on success, or -EINVAL on failure.

So the Return section here should state what is returned in the parameters too.
Like:

 *    @pgroup is updated to point to the parsed group which is stored in @buf.

etc.

-- Steve



> + */
>  int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>  				char *buf, int offset)
>  {

