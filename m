Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6755282F27;
	Thu,  5 Mar 2026 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726594; cv=none; b=XUp5H/Z+VGzDJ5K2zYq6lRsAnEozot6KQeOqWMnzDqPag/QpPVlVEECmvM/jrdDCUm0A1eDWayOo0njrk9Q4UjE2pyIR6QCC22UZRRNugM4L/jO/ARFFvX4lmIXgKP+klU4PjGgHfeqfGRLIH1kwj+XVzFVCy8Ltalszyjzfk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726594; c=relaxed/simple;
	bh=kbCdHrPQfuik8kSiEUlPcr8xDBSE+5onkdlqnirYpD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDqzG/926qVD1z516iKA3XdRixZZt9JiHuvrcn03vmAhou2XOBGmIc7awO1UiM8iBmROm0jxWulvtzCgZm8wuOK+ysgpW0SEPGLTP9VX92R+Izm0a6fVM7feh5WA9ikmA8aRvUDn7D8Aj9mzA4zAyzKXl8v1+ZHiO7gd9Eeii2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 104D4C0BE4;
	Thu,  5 Mar 2026 16:03:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 222CB20029;
	Thu,  5 Mar 2026 16:03:09 +0000 (UTC)
Date: Thu, 5 Mar 2026 11:03:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Documentation: Update histogram-design.rst for
 fn() handling
Message-ID: <20260305110347.31d6bae5@gandalf.local.home>
In-Reply-To: <20260126181742.03e8f0d5@gandalf.local.home>
References: <20260126181742.03e8f0d5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uoozexr41qgcctxprzbdjn7jkm5kuh7k
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 222CB20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/jJwSATMn83cMt9oeARCb76zNWrA+xnME=
X-HE-Tag: 1772726589-685616
X-HE-Meta: U2FsdGVkX1972E0Ssok5izdEAf7siT7PUdYoYldJnzC5jjW/ZXkGUqtti7XObvXqi550Z3CJt+CpYaPDGAjmPLcXCTaDd5jdg3x+R/74iH8VMHltzUB3LzfBXj8RG4l1UMg9gUwMPVMw9QbGDD89gcitZPRQvAREeoif/3hh+Tc74ctBpkcDf1CifFM8p1RwtwginjuYkTbXvhRcbIp5KScAmJXzZLo34tc1GyLS+1PzruVaW/E6vZwWRHiPWliMUG0gSWsvk4/XfeAT9KEcNk1GTxNBWCBxnaBvknAjxWHpm3M8D34E7wuPJ2ramACe+aehLLJdZY2kWSil9RotubcLI2RthkltFSgQ/FY23rX2DFBh+IUSBkpROC5owAdT


Hi Jon,

Can you take this through your tree?

Thanks,

-- Steve


On Mon, 26 Jan 2026 18:17:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The histogram documentation describes the old method of the histogram
> triggers using the fn() field of the histogram field structure to process
> the field. But due to Spectre mitigation, the function pointer to handle
> the fields at runtime caused a noticeable overhead. It was converted over
> to a fn_num and hist_fn_call() is now used to call the specific functions
> for the fields via a switch statement based on the field's fn_num value.
> 
> Update the documentation to reflect this change.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/trace/histogram-design.rst | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
> index ae71b5bf97c6..e92f56ebd0b5 100644
> --- a/Documentation/trace/histogram-design.rst
> +++ b/Documentation/trace/histogram-design.rst
> @@ -69,7 +69,8 @@ So in this histogram, there's a separate bucket for each pid, and each
>  bucket contains a value for that bucket, counting the number of times
>  sched_waking was called for that pid.
>  
> -Each histogram is represented by a hist_data struct.
> +Each histogram is represented by a hist_data struct
> +(struct hist_trigger_data).
>  
>  To keep track of each key and value field in the histogram, hist_data
>  keeps an array of these fields named fields[].  The fields[] array is
> @@ -82,7 +83,7 @@ value or not, which the above histogram does not.
>  
>  Each struct hist_field contains a pointer to the ftrace_event_field
>  from the event's trace_event_file along with various bits related to
> -that such as the size, offset, type, and a hist_field_fn_t function,
> +that such as the size, offset, type, and a hist field function,
>  which is used to grab the field's data from the ftrace event buffer
>  (in most cases - some hist_fields such as hitcount don't directly map
>  to an event field in the trace buffer - in these cases the function
> @@ -241,28 +242,33 @@ it, event_hist_trigger() is called.  event_hist_trigger() first deals
>  with the key: for each subkey in the key (in the above example, there
>  is just one subkey corresponding to pid), the hist_field that
>  represents that subkey is retrieved from hist_data.fields[] and the
> -hist_field_fn_t fn() associated with that field, along with the
> +hist field function associated with that field, along with the
>  field's size and offset, is used to grab that subkey's data from the
>  current trace record.
>  
> +Note, the hist field function use to be a function pointer in the
> +hist_field stucture. Due to spectre mitigation, it was converted into
> +a fn_num and hist_fn_call() is used to call the associated hist field
> +function that corresponds to the fn_num of the hist_field structure.
> +
>  Once the complete key has been retrieved, it's used to look that key
>  up in the tracing_map.  If there's no tracing_map_elt associated with
>  that key, an empty one is claimed and inserted in the map for the new
>  key.  In either case, the tracing_map_elt associated with that key is
>  returned.
>  
> -Once a tracing_map_elt available, hist_trigger_elt_update() is called.
> +Once a tracing_map_elt is available, hist_trigger_elt_update() is called.
>  As the name implies, this updates the element, which basically means
>  updating the element's fields.  There's a tracing_map_field associated
>  with each key and value in the histogram, and each of these correspond
>  to the key and value hist_fields created when the histogram was
>  created.  hist_trigger_elt_update() goes through each value hist_field
> -and, as for the keys, uses the hist_field's fn() and size and offset
> +and, as for the keys, uses the hist_field's function and size and offset
>  to grab the field's value from the current trace record.  Once it has
>  that value, it simply adds that value to that field's
>  continually-updated tracing_map_field.sum member.  Some hist_field
> -fn()s, such as for the hitcount, don't actually grab anything from the
> -trace record (the hitcount fn() just increments the counter sum by 1),
> +functions, such as for the hitcount, don't actually grab anything from the
> +trace record (the hitcount function just increments the counter sum by 1),
>  but the idea is the same.
>  
>  Once all the values have been updated, hist_trigger_elt_update() is

