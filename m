Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1F54FECDB;
	Thu,  3 Sep 2026 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459185; cv=none; b=Zo6XYQy0fB0UjNpoKTEgBR4kLvlQDSR/Bbu1N+APj5HH7CkpZWaRADwSOizf9GsXfvZs9FycyWSlor7exoeqHN29+s+ClsNLd4Vs+SSoyYR7jKxdWghN2xZYEIP0Of+i5VfzLvqgL2YC3vOF4HnTBtldIVT7Q62PvxbUN1zGTIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459185; c=relaxed/simple;
	bh=lMjDwwDcEuib5CqUG8sAFJffsPxgRDckMPxZ/W2C4oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jcjeu1yX8DO0Ln9rmLFedbgYwNieCAgNUq4XDEO0159OnmE4FTcd142WmM8BpxiV8PCcXqrzo8POcWpm/qYtDqwjlJTxJQqkpb4j2KGTpsZW07kbSfKfTO7Mo557QXcVr+Q+BIGVnbxhax/R6hQ55+MLevJmy3+cIsJ3nuP6IxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=MO03n2E2; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="MO03n2E2"
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 701D1A0641;
	Thu,  3 Sep 2026 18:13:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 569992000E;
	Thu,  3 Sep 2026 18:12:58 +0000 (UTC)
Date: Thu, 3 Sep 2026 14:14:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: trace: histogram-design: fix bracket,
 improve wording
Message-ID: <20260903141401.15642336@gandalf.local.home>
In-Reply-To: <20260903071105.714325-3-manuelebnerli@mailbox.org>
References: <20260903070249.713483-2-manuelebnerli@mailbox.org>
	<20260903071105.714325-3-manuelebnerli@mailbox.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 569992000E
X-Stat-Signature: 11q46h9jp8wtgqfzztasot9fciyf3ypn
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+kupAkMGIdxw3cgI+3UO4FAllszSrbEqg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=JHDpEoWJLWHYBo/t8UiZ3kxdwGOLeR8l1PdtSTxqOPc=; b=MO03n2E2cGfJ1vUCKGMbsyFeyqLL7WihhmAnQO0m/0c/i4NQRuV2pgBvJ/Ua/JQfi2sgCiBKeaDtmlgqiWLNnZfan3dkcrvZ3E/jhiyQxBxIkVAlSw7ylGlEyt9wqRoRle+4Skw8UzCz9B16EHM+RMdZBDYLOMEsWLwAKEE1lCU=
X-HE-Tag: 1788459178-861670
X-HE-Meta: U2FsdGVkX19o/bfv712u7FyZ1FktV6m9BuPRqsBybMeu5JImhOV3A/oSf02EK0p/jTopvAxZ9qZy58tIAt3UV37c7UmDg3NUPIBkOJkR4JCrCvccurKcgM4Gva3cY/s6J2FNwuNK59sZ8RpdjLhuNm0ftc05gPSR0IVMY3UxkhiGVebGyVG7oMecMKB0i01jcDHcuw2TQGEt+Pzd10NPFNF4e3GKyVeLmpCZtAn4WUEfQESYjpjEjTyYDqdBrpBbQSn5zOqx1f48xCtBz68BuMePEM/G7ZHDRJ8aoWf/3O5nsCuBDJHPU4mt+zaLG1ea27faaZUlEUewkUuiP4uTwhktbDHugFiVci5M3hg5FaMazlbQ+m01xsq+B7C8I6kuAEr76157G9jWPhqMCF4WmFOGpwMS3Nuv03z72oWXBKbb0pDY02GkVRCXRe10l8Dy8sPg/KAtZ3EzEtigL4kcUt1pAq6IBrHec90ffY4WhtgiKU/aWXuCaA==

On Thu,  3 Sep 2026 09:11:05 +0200
Manuel Ebner <manuelebnerli@mailbox.org> wrote:

> Add missing ')' and add note about the new way of triggering an event.
> 
> CC: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> ---
> I sent the previous mail on accident, sorry.
> 
> @ Steven, I added this line to your suggestion because else the references
> wouldn't make sense. References: $wakeup_lat, next_pid
> Let me know what you think.

It still looks fine without it. Here's the statement in full without the line:

   Note that the way the trace handlers such as wakeup_latency() are
   implemented, the parameters specified to the trace handler must be
   variables.  In this case, $wakeup_lat is obviously a variable, but
   next_pid isn't, since it's just naming a field in the sched_switch trace
   event.  Since this is something that almost every trace() and save()
   action does, a special shortcut is implemented to allow field names to
   be used directly in those cases.  How it works is that under the covers,
   a temporary variable is created for the named field, and this variable
   is what is actually passed to the trace handler.  In the code and
   documentation, this type of variable is called a 'field variable'.

Perhaps it may look better if we move the text around a bit:

  The onmatch() action below basically says that whenever we have a
  sched_switch event, if we have a matching sched_waking event, in this
  case if we have a pid in the sched_waking histogram that matches the
  next_pid field on this sched_switch event, we retrieve the
  variables specified in the wakeup_latency() trace action, and use
  them to generate a new wakeup_latency event into the trace stream.

  First, we define the wakeup_latency synthetic event::

    # echo 'wakeup_latency u64 lat; pid_t pid' >> synthetic_events

  Next, the sched_waking hist trigger as before::

    # echo 'hist:keys=pid:ts0=common_timestamp.usecs' >>
            events/sched/sched_waking/trigger

  Finally, we create a hist trigger on the sched_switch event that
  generates a wakeup_latency() trace event.  In this case we pass
  next_pid into the wakeup_latency synthetic event invocation, which
  means it will be automatically converted into a field variable::

    # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
            onmatch(sched.sched_waking).trace(wakeup_latency,$wakeup_lat,next_pid)' >>
	    /sys/kernel/tracing/events/sched/sched_switch/trigger

  Note, the above can also be written where wakeup_latency() is the
  action handler instead of trace()::

    # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0: \
            onmatch(sched.sched_waking).wakeup_latency($wakeup_lat,next_pid)' >>
            /sys/kernel/tracing/events/sched/sched_switch/trigger

  The diagram above illustrates the new elements described in the context
  of the sched_switch histogram using the onmatch() handler and the trace()
  action.

  Note that the way the trace handlers such as wakeup_latency() are
  implemented, the parameters specified to the trace handler must be
  variables.  In this case, $wakeup_lat is obviously a variable, but
  next_pid isn't, since it's just naming a field in the sched_switch trace
  event.  Since this is something that almost every trace() and save()
  action does, a special shortcut is implemented to allow field names to
  be used directly in those cases.  How it works is that under the covers,
  a temporary variable is created for the named field, and this variable
  is what is actually passed to the trace handler.  In the code and
  documentation, this type of variable is called a 'field variable'.

  Fields on other trace event's histograms can be used as well.  In that
  case we have to generate a new histogram and an unfortunately named
  'synthetic_field' (the use of synthetic here has nothing to do with
  synthetic events) and use that special histogram field as a variable.


-- Steve
