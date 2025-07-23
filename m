Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4458A2F2362;
	Wed, 23 Jul 2025 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279254; cv=none; b=AaZYtCCrAU62lwsTUlk3gjXL984rN9wvI3+M3S3MtYK47pGMBPc8T8LZptphrm4NiVg9g/+oQZQBsghgZ05l9Tf8EgP8vdcJwepY6A+8ohfpOc/UoWExYXE2VpOwbjhXOkK4dhls0eEnE8DHv82oxMBFgNK4gUSey3dgKOEPWUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279254; c=relaxed/simple;
	bh=nMncE97U/Ipqmpmk7mC2eWQvqR4lqGJam9I+INPmniM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPzj1bqZSM6I3MHlNYI+v5jIHJIiDCRPgjopFsa8bz86lAJH/SVK85G+QqfSJAMGMU3xnBL/NOx5Kj6p0G9i34fuUnVSZNTpLYY+am/blTHe1J06K1ZOYCKS39n6T83Ae/fToOUvLLD14ceaHk0iwOYkx9UdZSNCjtWBkPns4rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id ED66E806F4;
	Wed, 23 Jul 2025 14:00:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 2D64930;
	Wed, 23 Jul 2025 14:00:48 +0000 (UTC)
Date: Wed, 23 Jul 2025 10:00:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] tracing: probes: Add a kerneldoc for
 traceprobe_parse_event_name()
Message-ID: <20250723100049.46e8ec7c@batman.local.home>
In-Reply-To: <175323430565.57270.2602609519355112748.stgit@devnote2>
References: <175323423662.57270.14650807176845939538.stgit@devnote2>
	<175323430565.57270.2602609519355112748.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ck4g5e88xgtt5tzg1czg8zt8g63hmhgw
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 2D64930
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+KlQ1W+17VzVmvSHIC/a1RVGNS2p6REX4=
X-HE-Tag: 1753279248-335724
X-HE-Meta: U2FsdGVkX18SHHCl1w3YRptYk+NS9Mnf/UYbZl5cSp9m3fobh61D8AZjgaIq/HJH7oshE0/JE+e6/ntWrBSlZAllV4PjUqHxVa0q1pNs3Crhq1lppq9+gh0Jq9kXSRidGhTql2R+mVbP5L8glVEQydOnZSA29UWHD2dFPmkcPGGHhehkuWDrGHqHWZV5crZLzSIbXbnK6M9F7JhOk+lyWdSCHvySWvpLFOWPj2JQ7BcASXN8NJ1HLIjTpiCeoBDUxh46wf/UrJSbOgLvLhO9ObD3nIWggYPxVzOSPJezDND4TKe5yzPLxLVJQuQM5GCvveksr1KDbNTcjNp8lLWuOUkI01yYMJRuZnnEQbI1RJaBjmgX+KiwgnkGd0XsON0Uv3bAYbQYaHdfR6QQ2get6w==

On Wed, 23 Jul 2025 10:31:45 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> -/* @buf must has MAX_EVENT_NAME_LEN size */
> +/**
> + * traceprobe_parse_event_name() - Parse a string into group and event names
> + * @pevent: A pointer to the string to be parsed.
> + * @pgroup: A pointer to the group name.
> + * @buf:    A buffer to store the parsed group name.
> + * @offset: The offset of the string in the original user command, for logging.
> + *
> + * This parses a string with the format `[GROUP/][EVENT]` or `[GROUP.][EVENT]`
> + * (either GROUP or EVENT or both must be specified).
> + * Since the parsed group name is stored in @buf, the caller must ensure @buf
> + * is at least MAX_EVENT_NAME_LEN bytes.
> + *
> + * Return: 0 on success, or -EINVAL on failure.
> + *
> + * If success, *@pevent is updated to point to the event name part of the
> + * original string, or NULL if there is no event name.
> + * Also, *@pgroup is updated to point to the parsed group which is stored
> + * in @buf, or NULL if there is no group name.
> + */
>  int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
>  				char *buf, int offset)
>  {

Much better.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
