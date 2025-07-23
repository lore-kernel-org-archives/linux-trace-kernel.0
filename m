Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898772F4305;
	Wed, 23 Jul 2025 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281636; cv=none; b=anvksmoeTPwPJdAyyN/UKMnK5DxkZV8Y1BB1Z7BfnjsWgCZU6m28tSdCgiLoBi9lw2/FFwKaMmTGKsL4jJ/xyHEPNho27Ak36LcnCugaUxY47f4ytdsV9qavHYdcuX4wul/2F+q+alJcx8ZEFg/qLDxU7jcPZgoN2buxvFiJA8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281636; c=relaxed/simple;
	bh=0YaGZMSoMLNaahfcZJoR8s9IUmTq1MSvyGXpCPCDbi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAof9QkXAfMQhsEZJ2+wneyPtGMTzncezVuywtO57Lmn2fNDresO9LSR8nVkqvtGUJNoj8lS7yGhrn9CMwnGQ9ggPA45SyVwJFCdnjenxYo5+BpSqpRZPg7o81r0cnRAF9U7cjb6S5YLF0bHmyL0o0dyaQ+4D3x1BNWULyCVrZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 48B2BC0724;
	Wed, 23 Jul 2025 14:40:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 852B520012;
	Wed, 23 Jul 2025 14:40:31 +0000 (UTC)
Date: Wed, 23 Jul 2025 10:40:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250723104030.6ec24dfd@batman.local.home>
In-Reply-To: <175257696222.1655692.4019049819386139160.stgit@mhiramat.tok.corp.google.com>
References: <175257695307.1655692.4466186614215884669.stgit@mhiramat.tok.corp.google.com>
	<175257696222.1655692.4019049819386139160.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 852B520012
X-Stat-Signature: 9g7rcsa51jcoyxtf9nxq9pbeie5fhbqc
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ysHvR0mHRhaL2ZmMdI+AEiHpnygqOmIg=
X-HE-Tag: 1753281631-241907
X-HE-Meta: U2FsdGVkX19M/n9phauSB5s8yoZ2YcOoPyHtjlDIxrbZRSlv3NXJ6io4jVJDfUywfzSx3t124lqWYL9noYwE+r9NRlDMavZuMFtG+N/v699ERDAbXY9733GVmpRMvpC/Tmnmo9M2AHnFa0qqKPnP+HxkCSCQ9qW/tkBl9wk/IW8gPSQg8ifEkvaWiDryCcTyBJ2NjnoOYh9rLj3/ZmSf2klsZ69Fg+KgCZq033S0LfVzNHkO9m0tcNqVK46oezmEs6zIKu8ep6ui7Pd49Uj9DgfnaptUaZFcLoWuj3VirNcJBp/4qP9E3J6n7ajI94bt8fkkNvjCQVutSItvyO5Oa6Mrcto7OQIj

On Tue, 15 Jul 2025 19:56:02 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> +static void
> +trace_event_update_with_eval_map(struct module *mod,
> +				 struct trace_eval_map **start,
> +				 int len)
>  {
>  	struct trace_eval_map **map;
>  
> -	if (len <= 0)
> -		return;
> -
>  	map = start;
>  
> -	trace_event_eval_update(map, len);
> +	/* This must run always for sanitizing. */
> +	trace_event_update_all(map, len);
> +
> +	if (len <= 0)
> +		return;
>  
>  	trace_insert_eval_map_file(mod, start, len);
>  }

So this will add more work during boot up as it is processed on every
event regardless if it has an eval map or not. But this is only needed
if CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y is enabled.

What about having this be:

	/* Always run sanitizer if PAHOLE_HAS_BTF_TAG is set */
	if (!IS_ENABLED(CONFIG_PAHOLE_HAS_BTF_TAG) && len <= 0)
		return;

	map = start;

	trace_event_update_all(map, len);

	if (len <= 0)
		return;

	trace_insert_eval_map_file(mod, start, len);
}

-- Steve
