Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776DC21D00A;
	Sun, 13 Sep 2026 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316736; cv=none; b=XHkoJeFQgtPOmK/GXMVjuvjaVssivtwykvFx3Ogn4X7xoZXf/WvGrtwHZ1HozNcV2P2qSQlM8dn88X5FN5L9zS71jMk8QyAs2RPdLX+anJdPOjJ2PjeTINu/I9o+Yg9ghtGScTrutjsaNkNepHfwl/9J8HTN1uRPqlgrU2dyljU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316736; c=relaxed/simple;
	bh=t58wA0U2rRkGGxn9d5mJDqR9N1AKdw0A+2xBJiErvIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQhcfa/nPknluKk2fLSY6lQqF21GgRiILsMsE6iF9Ojv+QsorcuRQj37d5sY8qB3hka1EeQrw9lEf/A8dkveW720K+5KVxjaQJiUP+VKOkfEFog3bt4CjK6sSu4bfmQXN0f5AL9Q+x9rGgigFuRaowoc0HOKy+yNKihTmTnK8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=KREALo7m; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="KREALo7m"
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id F21BD807FC;
	Sun, 13 Sep 2026 16:25:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 2121D6000F;
	Sun, 13 Sep 2026 16:25:25 +0000 (UTC)
Date: Sun, 13 Sep 2026 12:25:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix NULL dereference when copying keys for a
 field variable
Message-ID: <20260913122523.30f487d9@robin>
In-Reply-To: <20260912094722.3271147-1-donggeunyoo.kernel@gmail.com>
References: <20260912094722.3271147-1-donggeunyoo.kernel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: rfe1bw7mj8pgdxez1cr8r4r67k1791rr
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 2121D6000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Uu2mIVEUaNY6bZB42XRPP3Vd1zo8Z/Zk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=0xI+e331Zk5EeA2olu0jWNY2IHo+mIOtGgU4Yfq4pi8=; b=KREALo7m63I43hODuK8bjCMvgLRZ+YmbTLdd9bWO8I7vOa9SDu7SFeaH19b6hJX/QtiQXeKVL344CqBkg8Il41eqOR8EHGvQJS1IikV1QczH2q9+3t8IQ31NkkL/fZe9F1U0Ui22TkeBEPm2Zp2gsMP62pgtJEVzqoBsiQtLRdk=
X-HE-Tag: 1789316725-630573
X-HE-Meta: U2FsdGVkX194kXgf6Nhi5doGigKmxRRMFykkSSYFV9NU0NcrevSDXhatOHWu781sT3iCwWQwAzhoDMmTn3cvpYUZg9lO6m2Lem7gouCZvfTWNpwRx6Jf2yVrdkGmhneXp0gtgeAShogyglT8x6log4VMstasN/Cey/3qgoybcr/1vIvN9iYlLSoO4Q7K4X+hRBqrLKzPjcXo6pEMSNnmGyIlhMZ35quHQSEJzOgovZ1wn4uKMLqHtSE4BKBAcp85tmCTYOblXb8jyChSKp+kiw9+CNUB4+mvKRg/UzfbgmGmi18lMMwiM6HQqCRblv8/N/Lg9emhnI/ApqAdD6ybaHC3SewXpDV2

On Sat, 12 Sep 2026 18:47:22 +0900
Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> create_field_var_hist() builds a hist trigger on the onmatch() event by
> copying the key list of the compatible histogram found there, reading
> each name from key_field->field->name. That pointer is NULL when the key
> is not an event field: parse_field() leaves it NULL for common_cpu,
> common_comm, common_timestamp, common_stacktrace and hitcount.
> compatible_keys() compares only the type, size and signedness of each
> key, so two common_cpu keys match and the loop faults.
> 
> The generated trigger is a real histogram whose element the variable is
> later read out of, so it has to bucket the same way as the one it
> mirrors. Render the keys with expr_field_str(), which carries .log2 and
> .usecs, modifiers that change a key's value. Two things it did not carry
> are added here. get_hist_field_flags() reports .stacktrace for the
> common_stacktrace pseudo-field too, which parse_field() takes only on a
> real field, so gate it on having one. And it reports a bare "buckets"
> with the size held separately in hist_field->buckets, so append that the
> way hist_field_print() does. expr_field_str() also renders expression
> operands, so an expression over a bucketed field now prints the size
> too, matching what hist_field_print() already shows for the key.

The above change log is extremely hard to read. Did you get it directly
from AI? That tends to be overly verbose and adds way more data than
needed making it harder to find the important parts. Please make the
change logs more precise to what the issue is and remove the unneeded
details.

For this patch, I'm currently testing it, but let me try to decipher it
(but please clean up future patches)...

OK, I gave up on the change log as it's just garbage. I ended up
triggering the bug mentioned and looking at the code and figured it out
myself.

OK, this patch does three things so it really needs to be three
different patches. One, it fixes the reported bug by the change to call
expr_field_str(). The change log for that bug should be:

   In event_hist_trigger_parse() where it needs to create actions like
   "onmatch", it calls:

     event_hist_trigger_parse() {
       create_actions() {
         action_create() {
           trace_action_create() {
             trace_action_create_field_var() {
               create_field_var_hist()

    Where create_field_var_hist() does a loop on the hist_data
    representing the keys. The issue is, if the keys uses one of the
    pseudo field types (like common_cpu), the hist_data field element
    will have NULL for its field member causing a NULL pointer
    dereference when accessing the key_field->field->name.

    Instead of accessing it directly, use the proper handler
    expr_field_str() to get the name.

> @@ -3090,7 +3093,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
>  		key_field = hist_data->fields[i];
>  		if (!first)
>  			seq_buf_putc(&s, ',');
> -		seq_buf_puts(&s, key_field->field->name);
> +		expr_field_str(key_field, &s);
>  		first = false;
>  	}

The changes and the change log for the other two is confusing and it
doesn't show examples of the errors. They can be dropped from the NULL
pointer dereference fix and sent separately with examples of what is
actually wrong.

Oh, and there's another bug here. With your example, where you used
"prio" for sched_switch (which isn't a field), there's an error message
created, but the command still errors out.

[  415.300003] hist:sched:sched_switch: error: Couldn't parse field variable
  Command: hist:keys=stacktrace:wakeup_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).my_synth($wakeup_lat,prio)

-- Steve
