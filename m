Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641F38AC92;
	Wed,  2 Sep 2026 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372857; cv=none; b=HiTIUQ1J/rSUw5gWPL0QkPUhCWnn1Czwcul47aVVvMmVSZH+bWw9q8y0J51Xk4bHj44YxW9iSgTW/hTWMxrVBXfcA6RS1BXxYTpAuyJ6FkFAUo5JNeq7jTR4sotlW1YbJEplhp+QU4iLh+Z5i98JjA4mWoAVPhhH3bWgmP7kovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372857; c=relaxed/simple;
	bh=X0dJkxGtxT5x/HWUKKXOpqLDvEN2gHcqx96GpUC2KB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOJmCiZven82E40YFNJ/Z8ubAauPw0uR+n9zYpb1CKUTE58ZSrLJXpqBTNIBakoFuqPl8tkojMgoOPgMJFma+LDPqUwugTZboJVQwnBVonG7E0Xs2MPUvqyL4ymzYF8Ei4zt5CNV/02mb+/6p13WUchYr8JjXjGrHpu0EP706Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=zbyJ6u5Q; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="zbyJ6u5Q"
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6F8F11C1ACF;
	Wed,  2 Sep 2026 18:14:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 6269F60010;
	Wed,  2 Sep 2026 18:14:10 +0000 (UTC)
Date: Wed, 2 Sep 2026 14:15:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Manuel Ebner <manuelebnerli@mailbox.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: trace: histogram-design: fix bracket
Message-ID: <20260902141511.64956ba2@gandalf.local.home>
In-Reply-To: <c0edc549-7dd1-4d96-a4d2-55ec6fee5caf@infradead.org>
References: <20260902151032.706407-2-manuelebnerli@mailbox.org>
	<c0edc549-7dd1-4d96-a4d2-55ec6fee5caf@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ha86g9z6w1zfk5gbtq147t6bozf6o8ct
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6269F60010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18TvkjyhgF3SAUtwSxV2e4CMltwLbavfBg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=dyE58VvLjEs1tTubEZDh6JWT0eu73UXdfa7GBeV6cBQ=; b=zbyJ6u5QLBFn8nRQ5ORRgu5Kqm4YJs1AfPz02E6Ti4biMAZHQGMCBIL5ir7hVG5oJ3It3ktmMaCFBHeK906CSOkca7neRxeMLm/Rbj4dnFific/4ICM+kgg4fToD/zfPYsqhDxmQ3SfP+Z47vCcCjaaOzm3JJspVqvuMweUndLQ=
X-HE-Tag: 1788372850-113403
X-HE-Meta: U2FsdGVkX1+WSLMXGsFUIw0F4lLDWMgywUhaVCxf78pT2v3cfHUxM3VlMlKGhPpUnFGegNEkQESzP893NXvD8mdeshoZV8nfFnyKY8pW4FmXzk25GJZQD5/lN51piwnHqjn2WIgL4kCSkCvnTgS0PuK7f7H8ZSC7l/zkzemfn3q8YXxecMsP4cPYOR3wWLsYwfSJIKHnnHscTTcEDvgSl4O92n5K+RAj20ZUJpvQWIokeeWE3GQj5uUVlp2FNsJDCyeAnbUuvLk35XOkYrshS5QrfJNWpP4WDVmZA1o0HLlGWBBwJc746bTVYQ4JJKCY16ZpQaoxQZDJXYlZFJrQ5V0xCXHOZUpb55pyO5XBUvUPU9BtAsukPyL4lXXslowk

On Wed, 2 Sep 2026 10:17:17 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> > diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
> > index 41a726cd3..b757afa22 100644
> > --- a/Documentation/trace/histogram-design.rst
> > +++ b/Documentation/trace/histogram-design.rst
> > @@ -876,7 +876,7 @@ next_pid field on this sched_switch event, we retrieve the
> >  variables specified in the wakeup_latency() trace action, and use
> >  them to generate a new wakeup_latency event into the trace stream.
> >  
> > -Note that the way the trace handlers such as wakeup_latency() (which
> > +Note that the way the trace handlers such as wakeup_latency() which
> >  could equivalently be written trace(wakeup_latency,$wakeup_lat,next_pid)
> >  are implemented, the parameters specified to the trace handler must be
> >  variables.  In this case, $wakeup_lat is obviously a variable, but  
> 
> Seems to me that the "which ..." should be a parenthetical phrase,
> i.e., with parentheses at both ends of it. IMO.
> But let's see the the TRACE maintainers have an opinion about it.

Yes, it's not an extra parenthesis but a missing one. Likely because it
would be placed in the position there is already a parenthesis.

  Note that the way the trace handlers such as wakeup_latency() (which
  could equivalently be written trace(wakeup_latency,$wakeup_lat,next_pid))  <<
  are implemented, the parameters specified to the trace handler must be
  variables.  In this case, $wakeup_lat is obviously a variable, but  

Perhaps the wording could be a bit better.

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 41a726cd3536..ec133d0692c5 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -876,8 +876,7 @@ next_pid field on this sched_switch event, we retrieve the
 variables specified in the wakeup_latency() trace action, and use
 them to generate a new wakeup_latency event into the trace stream.
 
-Note that the way the trace handlers such as wakeup_latency() (which
-could equivalently be written trace(wakeup_latency,$wakeup_lat,next_pid)
+Note that the way the trace handlers such as wakeup_latency() 
 are implemented, the parameters specified to the trace handler must be
 variables.  In this case, $wakeup_lat is obviously a variable, but
 next_pid isn't, since it's just naming a field in the sched_switch
@@ -916,6 +915,13 @@ means it will be automatically converted into a field variable::
           onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid)' >>
 	  /sys/kernel/tracing/events/sched/sched_switch/trigger
 
+Note that the above is the old way to trigger a synthetic event, whereas the
+newer way is preferred, which uses the trace() action handler::
+
+  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
+          onmatch(sched.sched_waking).trace(wakeup_latency,$wakeup_lat,next_pid)' >>
+	  /sys/kernel/tracing/events/sched/sched_switch/trigger
+
 The diagram for the sched_switch event is similar to previous examples
 but shows the additional field_vars[] array for hist_data and shows
 the linkages between the field_vars and the variables and references


-- Steve
