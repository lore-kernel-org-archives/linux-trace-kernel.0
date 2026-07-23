Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD963E717C;
	Thu, 23 Jul 2026 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824881; cv=none; b=PhcGt5DnV09PnOW4ghM/J8imBu6kxlvIFtHttOvvNmmRrsZ//QFx5y+gDZ6cUQsqYs3mJWfWHSnvycELRlKOC6PVCw/di4ctbFXEuyiGHgCsoFfHViOc8OmL9opwsuw2Du8QzLd9py6Dkx//bzO1GSIwNhsY105w9/jEdZvdlWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824881; c=relaxed/simple;
	bh=j2Un96XyC2DIDOUwpQXHcR72uRN8/damCrZZjuD7Dus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nq3+El6sXJo+4SBsmYj1kUgOJhoFLQtAm9O6YETiwa329JPQlFq6QmM1neBGlTUxem5vWdaHlJ2KH7K4R4JKU1+SAEdE4vLpwDcZJwpDG2gqq2oW/xVV9VqUmycmppjeWqcI1QtzuFnfn3hd90DlYy3uAzrqrceVA9l33VxJ078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5F918A04F2;
	Thu, 23 Jul 2026 16:41:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 8C4ED17;
	Thu, 23 Jul 2026 16:41:10 +0000 (UTC)
Date: Thu, 23 Jul 2026 12:41:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Carlier <devnexen@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Defer trigger private data frees past the
 grace period
Message-ID: <20260723124133.2c905b49@gandalf.local.home>
In-Reply-To: <20260712161006.242797-1-devnexen@gmail.com>
References: <20260712161006.242797-1-devnexen@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: q7dwspnrd9fjpbqwfrnc76t8cdnnyta6
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8C4ED17
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18uYJrSzypzwDyoen7UF9aQcwtOp8MOhlE=
X-HE-Tag: 1784824870-335631
X-HE-Meta: U2FsdGVkX18ZYeRLJOsJMM60+ajrA6m/Q4yHydY2cHDvy2NhU+tWu1ikd04wzM4oK6SBTuIveqE6x/oTSM+kX7hKAcW9qOn4MKPX+vU6ECgJHHMKcAM1PlOUXNIewHQEmm7iGg6IAQUmqknu8RFHU+dG0P/9C0o9bZ1X16Xox720Bblwton5vfv1HEmu/NkP6O3ZBhRtzYTyfv1qYQtVNvMGw1VMcYtELdXuuhd5y/XfGXswfvANyX1A+KN4Wv+es9fRytETIgNYMZ1EC8UWtIzFH8m5uTG81PbrXQzlECnI1dF9bZC0W7MVqQd/tWcse9XnFwZOc4uT7eZeOQxTKheMQXQ0vNRv

On Sun, 12 Jul 2026 17:10:06 +0100
David Carlier <devnexen@gmail.com> wrote:

> Commit 61d445af0a7c ("tracing: Add bulk garbage collection of freeing
> event_trigger_data") made trigger_data_free() defer the kfree() of the
> event_trigger_data to a kthread that runs tracepoint_synchronize_unregister()
> before freeing. The .free callbacks that own satellite data kept freeing it
> synchronously right after calling trigger_data_free(), relying on the
> synchronize that used to run inline.
> 
> With that synchronize now deferred, event_hist_trigger_free(),
> event_enable_trigger_free() and event_hist_trigger_named_free() free
> hist_data, enable_data and cmd_ops while a concurrent tracepoint handler can
> still dereference them through the list_del_rcu()'d trigger, causing a
> use-after-free.
> 
> Add an optional free_private() callback to event_trigger_data, invoked by
> the free kthread after the grace period, and move the satellite frees into
> it. The event_mutex-requiring bookkeeping (remove_hist_vars(),
> unregister_field_var_hists()) stays synchronous; only the handler-visible
> memory free is deferred.
> 
> Fixes: 61d445af0a7c ("tracing: Add bulk garbage collection of freeing event_trigger_data")
> Signed-off-by: David Carlier <devnexen@gmail.com>

OK, so this makes one of the self tests fail:

  tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc

Which has at the end:

 echo "-:$EPROBE" >> dynamic_events
 echo '!'"hist:keys=common_pid:filename=\$__arg__1,ret=ret:onmatch($SYSTEM.$START).trace($SYNTH,\$filename,\$ret)" > events/$SYSTEM/$END/trigger
 echo '!'"hist:keys=common_pid:__arg__1=$FIELD" > events/$SYSTEM/$START/trigger
 echo '!'"$SYNTH u64 filename; s64 ret;" >> synthetic_events

The issue is that now the command that removes the onmatch() trigger has
its cleanup delayed, it returns before the synthetic event is actually
removed from the histogram. This allows the last command to execute before
it is removed and the removal of the synthetic event fails with -EBUSY
because the synthetic event is still attached to the histogram when it is
executed. The synthetic event *must* be removed from the histogram before
that operation returns.

Thus, I don't think adding a free_private() is appropriate. As you state in
the change log, the code that freed it was relying on the implicit
synchronize_rcu() from the trigger code. Now I think it just needs to call
it directly.

Hence, something like this:

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 82ce492ab268..ddd2f70dac4f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6349,6 +6349,8 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 
 		trigger_data_free(data);
 
+		synchronize_rcu();
+
 		remove_hist_vars(hist_data);
 
 		unregister_field_var_hists(hist_data);
@@ -6388,6 +6390,7 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
 
 		del_named_trigger(data);
 		trigger_data_free(data);
+		synchronize_rcu();
 		kfree(cmd_ops);
 	}
 }
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 655db2e82513..c3f54f2540b6 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1730,6 +1730,7 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 		trace_event_enable_disable(enable_data->file, 0, 1);
 		trace_event_put_ref(enable_data->file->event_call);
 		trigger_data_free(data);
+		synchronize_rcu();
 		kfree(enable_data);
 	}
 }

The above makes the test pass again and I believe it fixes the problem you
found. Feel free to resend this change as v2.

-- Steve

