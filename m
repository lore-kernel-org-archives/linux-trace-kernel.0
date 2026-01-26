Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954726299;
	Mon, 26 Jan 2026 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769469464; cv=none; b=fx0cpQK96+8yt4VoTlXoiaEqtMDXQA+4xHUFkZjpFZr7sNwiPldCjCk4eJOd7ZNiZh7ImwN3sgiWrC5XNdzz4Mtyuo+kFv9dgxxeb5PuzclXybulS8J87OnWxJnkOlLfB3MtnxV9hof3eWaVSQNZUgws/NICcKfWHaBfsidro4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769469464; c=relaxed/simple;
	bh=OHgwUz6kt0jreyzbsYSEC+eZwbtZzEQ6/3xsqckDofA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=S1YceM0mXBgImlmT9/1aspkb/WwW5QS82ru27iFJH1W4Mtw94F4RrTLPiMM9EUCFwET+Nsx4ki1s9smb+d22Mvive9m/pVCn36lnBMBZTdkCPHvYpNOcUfh33htKLCy35HQtE2/fgnT7pTVxG7kuxzipgkiwcdiXwZ+GKjZsQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 8B85F5BA5F;
	Mon, 26 Jan 2026 23:17:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id A85CF17;
	Mon, 26 Jan 2026 23:17:39 +0000 (UTC)
Date: Mon, 26 Jan 2026 18:17:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] tracing: Documentation: Update histogram-design.rst for
 fn() handling
Message-ID: <20260126181742.03e8f0d5@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A85CF17
X-Stat-Signature: 8t9wjh8dxr1sw1z11m5jzkrxcjarct6k
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+B1XCaJxT/79dYhDSwlX18aHz2z+RY/uc=
X-HE-Tag: 1769469459-797448
X-HE-Meta: U2FsdGVkX1/c5G6axt8CDHfNm9KrXCqe75e1PJAh9ceS1GRRhZvk8CIg2G8p22TQyHWvuROMrwYajrFH6/KNh2J66ekc6Pqdk4Q0yM6rV9apt3Q4b2xA9pZ8Ebhr6SwY/kSw5/vwfF+6V/6zm3If0H47IupaWvCNyh6ZEo2Go35SI2VJO+YA7y8F1VTJ1T2wzQmkIiRC6LIjyM1NxEspNHlUtPpdgy+nZ1fcT16je8NMmlRe6JIAw3VMz3TRpaTrigKYta6BQuRqrzz9tW+G4wYHAoqV6U8iyldgo7GLLpVyYER0tvWVGHSH6xr1nEVNXb0Gey0ajm2Ff6uacfssJtJuLGTEvtI2qfqXYvs0YZUNljnvnnAG8lx9AjWwgb5s

From: Steven Rostedt <rostedt@goodmis.org>

The histogram documentation describes the old method of the histogram
triggers using the fn() field of the histogram field structure to process
the field. But due to Spectre mitigation, the function pointer to handle
the fields at runtime caused a noticeable overhead. It was converted over
to a fn_num and hist_fn_call() is now used to call the specific functions
for the fields via a switch statement based on the field's fn_num value.

Update the documentation to reflect this change.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/histogram-design.rst | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index ae71b5bf97c6..e92f56ebd0b5 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -69,7 +69,8 @@ So in this histogram, there's a separate bucket for each pid, and each
 bucket contains a value for that bucket, counting the number of times
 sched_waking was called for that pid.
 
-Each histogram is represented by a hist_data struct.
+Each histogram is represented by a hist_data struct
+(struct hist_trigger_data).
 
 To keep track of each key and value field in the histogram, hist_data
 keeps an array of these fields named fields[].  The fields[] array is
@@ -82,7 +83,7 @@ value or not, which the above histogram does not.
 
 Each struct hist_field contains a pointer to the ftrace_event_field
 from the event's trace_event_file along with various bits related to
-that such as the size, offset, type, and a hist_field_fn_t function,
+that such as the size, offset, type, and a hist field function,
 which is used to grab the field's data from the ftrace event buffer
 (in most cases - some hist_fields such as hitcount don't directly map
 to an event field in the trace buffer - in these cases the function
@@ -241,28 +242,33 @@ it, event_hist_trigger() is called.  event_hist_trigger() first deals
 with the key: for each subkey in the key (in the above example, there
 is just one subkey corresponding to pid), the hist_field that
 represents that subkey is retrieved from hist_data.fields[] and the
-hist_field_fn_t fn() associated with that field, along with the
+hist field function associated with that field, along with the
 field's size and offset, is used to grab that subkey's data from the
 current trace record.
 
+Note, the hist field function use to be a function pointer in the
+hist_field stucture. Due to spectre mitigation, it was converted into
+a fn_num and hist_fn_call() is used to call the associated hist field
+function that corresponds to the fn_num of the hist_field structure.
+
 Once the complete key has been retrieved, it's used to look that key
 up in the tracing_map.  If there's no tracing_map_elt associated with
 that key, an empty one is claimed and inserted in the map for the new
 key.  In either case, the tracing_map_elt associated with that key is
 returned.
 
-Once a tracing_map_elt available, hist_trigger_elt_update() is called.
+Once a tracing_map_elt is available, hist_trigger_elt_update() is called.
 As the name implies, this updates the element, which basically means
 updating the element's fields.  There's a tracing_map_field associated
 with each key and value in the histogram, and each of these correspond
 to the key and value hist_fields created when the histogram was
 created.  hist_trigger_elt_update() goes through each value hist_field
-and, as for the keys, uses the hist_field's fn() and size and offset
+and, as for the keys, uses the hist_field's function and size and offset
 to grab the field's value from the current trace record.  Once it has
 that value, it simply adds that value to that field's
 continually-updated tracing_map_field.sum member.  Some hist_field
-fn()s, such as for the hitcount, don't actually grab anything from the
-trace record (the hitcount fn() just increments the counter sum by 1),
+functions, such as for the hitcount, don't actually grab anything from the
+trace record (the hitcount function just increments the counter sum by 1),
 but the idea is the same.
 
 Once all the values have been updated, hist_trigger_elt_update() is
-- 
2.51.0

