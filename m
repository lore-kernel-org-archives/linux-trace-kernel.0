Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782533F44EA;
	Tue,  7 Jul 2026 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783437621; cv=none; b=JGTN4E9vg8hN1eH8LTFvvXUQgWWwUw09y1aiXsh20KmJWVNmD8QdVJuTKx+LyyCOp9M6PqoEQF5zMhF//T3ZoM3NhbG1ZnQvJsVXIdfbSrPBlcDpWbu1BEtQO4V3xy+uPzJpGjpWDe2nyEZyHzjBOsXeldhapvAc9BZV0u1Y0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783437621; c=relaxed/simple;
	bh=5tuWkatnVNIK5Ry5kMSoOp5IKnPnmOr+sggrp950vT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HMvpMZn+ltpEmmO2ONnWzWhmINdN/PhfwMKPG4z6ZjkPioVEArPcZggdDfciLbNCvffZ4d+qPWS11wVXxR7WYV+F5+9N0wgahfnNjVHUq+bFgXX9ERlsSMvp9UyqgdX3IzOQbkxc9yoQHrQsikfWtim54pdqQ1Lsffloh47RqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 46E861C385A;
	Tue,  7 Jul 2026 15:20:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 55EDE33;
	Tue,  7 Jul 2026 15:20:08 +0000 (UTC)
Date: Tue, 7 Jul 2026 11:20:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chen Jun <chenjun102@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH] tracing: Add "within" filter for call-stack-based event
 filtering
Message-ID: <20260707112011.7ca6f721@gandalf.local.home>
In-Reply-To: <20260608145556.94931-1-chenjun102@huawei.com>
References: <20260608145556.94931-1-chenjun102@huawei.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hspj7xkyc7wh4ha5dqx9y7cg53bumzat
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 55EDE33
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+CLvAh4fPhurGx+w7BMuJCAiIL5GIyV7g=
X-HE-Tag: 1783437608-906688
X-HE-Meta: U2FsdGVkX1+7rBmUntmm2xb7msXy/BaG7JLSO8l+87LPRiBM66T0N/QWdtUMyF0n286VGUwZYJv6wdTLK+8q1MMTa5RJEztHxRlRdtQB2UxKh/uUGSGsaTcJwy9D/gBkQzDXE+2RY1ge4GOrr5rn7NFEOFbIuOaqZ3M5uegqhS625CZqtvIiamcZVXScucgjJLasJ21iBTAoNFpPVbm8I8ihJ7cdHxwHH2rAWwtgnPRL3dv1v3jqZJPLweojT8TewoJaA+9rb3wehJDtUdZopXexO27t2vzhlFOzBxNFki3I3xtKhVSa3z3Wdfz4vqzDRpzDPodqLLXgcf/7ZQsP1142Vkc+Tzf3+Mkg/E/k2ojNsemZIRWiSPB+FMcJ6XLG/22dxhaAarX90EsjC1GQsFGXfFMF0pqXvGE7tx4C1jvVfe/hfFJ7Yg==

From: https://sashiko.dev/#/patchset/20260608145556.94931-1-chenjun102%40huawei.com

> commit dfbe6e67884d4ff73b44c46b51995f1945758a89
> Author: Chen Jun <chenjun102@huawei.com>
> tracing: Add "within" filter for call-stack-based event filtering
> This commit introduces a "within" filter predicate for trace events, allowing
> users to filter events based on whether a specific function appears in the
> current call stack. It uses kallsyms_lookup_name() to resolve the function to
> an address range during setup, and stack_trace_save() to capture the stack at
> runtime to evaluate the filter condition.
>
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index 609325f579427..34e1a7f0b3cd0 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> [ ... ]
> > @@ -1009,6 +1010,22 @@ static int filter_pred_function(struct filter_pred *pred, void *event)
> >  	return pred->op == OP_EQ ? ret : !ret;
> >  }
> >  
> > +/* Filter predicate for within. */
> > +static int filter_pred_within(struct filter_pred *pred, void *event)
> > +{
> > +#ifdef CONFIG_STACKTRACE
> > +	unsigned long entries[16];
> > +	unsigned int nr_entries;
> > +	int i;
> > +
> > +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
>
> Is an array size of 16 entries sufficient here?  Since the skipnr parameter is
> 0, several of these frames will be consumed by internal tracing and filter
> evaluation functions (such as filter_pred_within() and
> trace_event_buffer_commit()).
>
> This leaves very few slots for the actual call chain, meaning higher-level
> functions like "vfs_read" will likely be truncated from the stack trace.
> Could this cause the filter condition to evaluate to false incorrectly,
> missing the events we are trying to capture?
>

This is a current limitation that may be dealt with in the future.

> > +	for (i = 0; i < nr_entries; i++)
> > +		if (pred->val <= entries[i] && entries[i] < pred->val2)
> > +			return !pred->not;
> > +#endif
> > +	return pred->not;
> > +}
>
> [ ... ]
> > @@ -2002,10 +2021,28 @@ static int parse_pred(const char *str, void *data,
> >  
> >  		} else if (field->filter_type == FILTER_DYN_STRING) {
> >  			pred->fn_num = FILTER_PRED_FN_STRLOC;
> > -		} else if (field->filter_type == FILTER_RDYN_STRING)
> > +		} else if (field->filter_type == FILTER_RDYN_STRING) {
> >  			pred->fn_num = FILTER_PRED_FN_STRRELLOC;
> > -		else {
> > +		} else if (field->filter_type == FILTER_WITHIN) {
> > +			unsigned long func;
> > +
> > +			if (op == OP_GLOB)
> > +				goto err_free;
>
> Does this goto need a preceding call to parse_error()?  Other error paths in
> this function initialize the error state before jumping to err_free.
> Without it, users might see an unhelpful generic error message instead of a
> syntax error indicating that the glob operator isn't supported here.

This is a legitimate issue.

Chen, can you send a v2 and add a proper error message here?

Thanks,

-- Steve


> > +
> > +			pred->fn_num = FILTER_PRED_FN_WITHIN;
> > +			func = kallsyms_lookup_name(pred->regex->pattern);
