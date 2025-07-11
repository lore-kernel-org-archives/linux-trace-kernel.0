Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C440218E750;
	Fri, 11 Jul 2025 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752249814; cv=none; b=e/Fq212Ys78q1HWVQLnj4ILHGmokC0zlO5OX+96m8iQ0MLhmI+m55IpKN2+97GBShsDaG2SLekEruVrnNNJ4lcHhoneoqemxa03GvNO6Fi3S2m40zb1i6yummGFooULtRk+Mu8v7fG1sF67eTu1itwSDcgAX3bSXfBRpjm+evKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752249814; c=relaxed/simple;
	bh=M2rhZ6UpzBO+56biWhK8JC/KSqvxqAizce9vg2Hwl8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIPtngu5GeYt2tYcEro8sbSmWUKchfnXKIJ3wap0AA12T2c5nS1f+zEchYxVARAkE1Vxn0gW18zIO2VK+C4OTE4Ex8c35nRkeJ8ZZy5vnlkgbRxE3ow/d6D825ZjrDolQ37hIpZVocBAZmPEau2IfpWeHMfQpkWeqpfrX0eCiz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 9785D80A27;
	Fri, 11 Jul 2025 16:03:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id E87803E;
	Fri, 11 Jul 2025 16:03:23 +0000 (UTC)
Date: Fri, 11 Jul 2025 12:03:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250711120322.4ddb9b39@batman.local.home>
In-Reply-To: <20250711143703.60a1a9a9f31a45f2000eec9d@kernel.org>
References: <175197567999.977073.8989204607899013923.stgit@mhiramat.tok.corp.google.com>
	<175197568917.977073.2201559708302320631.stgit@mhiramat.tok.corp.google.com>
	<20250709131107.397a3278@batman.local.home>
	<20250711143703.60a1a9a9f31a45f2000eec9d@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uzge8baockmurhn8dmux1zg965cb6pgm
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E87803E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX195baZcmXnkODmJnqNUYI9nKpCdoyxokbA=
X-HE-Tag: 1752249803-793985
X-HE-Meta: U2FsdGVkX1840AX1DqO9JhaE0Ssy9P+/hvxo7CN/A3fGdUisgch0ZLP2XQ3mKnww+aRUOCgn9DdNf6MMLAqW+V1HlA8Si2FCDsBdg7brZMAiPCkjS4E/qmH+QbnKjoa5CcUEo3FYL2LxcYjVxfufiC/aPmP088UpSBemuy6D0WoFtrFsBjy2VTHcXYCjGwf2FUvikFPxHPCZQEIA0usUAVslJpJiF3o4T1ifbwP8H2467q6aTtYVJYbVF2KEFAF9AOIiK5NymNQq7gZI7XmQD42SUKj6Orm1edoAiLG/Zl26lH1Nc0n1BZCVmhYdIU8+XHmKAa7cp27N3pZB6tla3JWM+DgF4uxM

On Fri, 11 Jul 2025 14:37:03 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> I investigated this but it is not possible to use update_event_fields()
> because that function is only used if the 
> CONFIG_TRACE_EVAL_MAP_FILE=y.

That had better *not* be true, otherwise all the TRACE_DEFINE_ENUM() in
include/trace/events/*.h would be useless and those events would not
parse. Note, I usually run without that config enabled, so it would
most definitely break on me if this was true.

In the code we have:

----------------------8<----------------------
#else /* CONFIG_TRACE_EVAL_MAP_FILE */
static inline void trace_create_eval_file(struct dentry *d_tracer) { }
static inline void trace_insert_eval_map_file(struct module *mod,
			      struct trace_eval_map **start, int len) { }
#endif /* !CONFIG_TRACE_EVAL_MAP_FILE */

static void trace_insert_eval_map(struct module *mod,
				  struct trace_eval_map **start, int len)
{
	struct trace_eval_map **map;

	if (len <= 0)
		return;

	map = start;

	trace_event_eval_update(map, len);

	trace_insert_eval_map_file(mod, start, len);
}
---------------------->8----------------------

Notice the "#endif". The trace_insert_eval_map_file() is a nop, but the
trace_event_eval_update() is not. That has the call to
update_event_printk() and update_event_fields().

So it can most definitely be used when that config is not defined. That
config only creates a file to show you *what* was replaced. It doesn't
stop the replacing.

-- Steve
