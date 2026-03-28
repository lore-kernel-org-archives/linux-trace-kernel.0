Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8E0320A00;
	Sat, 28 Mar 2026 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774665035; cv=none; b=gsmuHEfFjXHkiHIM9iPTHYw4lay5mCV5QckHRT6JuDX4qpYv2dON/5v/235zrVQS5OZPQ9ijk+PMbRjhlU1hZaj8/x6nVNaI3i3dKSLzU3sDY5XwMRbCbg5WXymrJKQZLgf2jm6dTPQSEtZm4mxpfcmSv7YgLO4H51wLydPWYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774665035; c=relaxed/simple;
	bh=YGJ/jhla2c2fCx7MkFmsZRgc90rphrVYBijnB4yfR6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPkg8RJYabYz/QhTpMY9+aIIG3Vp9e3lGRD9LJ+dEcVXc0tffkinlTsqOa26cSq1cFbIRslsjILIPmhl9G+INrNApm+QPBIq5y0zGeepnieO8z9PVeeu853vVPmHuQh4ztHyd9SyYHJ6YhW9PVpzGZygRO8f+FiUTKCp4ts+dxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 45D9513CA74;
	Sat, 28 Mar 2026 02:30:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 4D91F20027;
	Sat, 28 Mar 2026 02:30:24 +0000 (UTC)
Date: Fri, 27 Mar 2026 22:30:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Wesley Atwell <atwellwea@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 tom.zanussi@linux.intel.com
Subject: Re: [PATCH v4 2/2] tracing: Drain deferred trigger frees if kthread
 creation fails
Message-ID: <20260327223022.167defcc@robin>
In-Reply-To: <CAN=sVvzFMC1m2aGT23aRpPpoddBVP59mQBmEsQyEPKBYm3J_Vw@mail.gmail.com>
References: <20260324221326.1395799-1-atwellwea@gmail.com>
	<20260324221326.1395799-3-atwellwea@gmail.com>
	<20260327150634.5df3cf4f@gandalf.local.home>
	<CAN=sVvzFMC1m2aGT23aRpPpoddBVP59mQBmEsQyEPKBYm3J_Vw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 867prrxxakdgkryzye84g63gb81a9xr9
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4D91F20027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+l3G1zDrIQ21CLa9jmjnHsd7OBfH6R1O8=
X-HE-Tag: 1774665024-695282
X-HE-Meta: U2FsdGVkX1/glWykLMuTVzgg2sZfyEUHqVp8nvFHJiyYHM/zJZxWuYvIU1wfxagd7Cq1n8GZd9e3s3kA+4ni+s6ND2pO28jLPA4o98H6Auw7gHbUtMPA0zsAHUIFgHqw72oo0sdBZ0P+rFe/OMN2dP+nvN3i+vCM0c6KLbiqLbz8nLZcUZOB/wb9WWznz1WkIioQqi8a65lUqk1VxDtptkyDEtCltc7j+SmzyQcSrU+brqijAj0Ggt8ZtGkL365RNiHaOgkbvmgyEJQQNvcheks8XgmsN/60PGHw06JJWFiQU5gzNumuq4WiKVs2aS7+DczRyl0R6BKEmEbPa7oZ9EHax/DO7o9a

On Fri, 27 Mar 2026 16:41:52 -0600
Wesley Atwell <atwellwea@gmail.com> wrote:

> Yes,
> 
> This kernel command line reliably reaches trigger_data_free() during boot:
> 
> trace_event=sched:sched_switch
> trace_trigger=sched_switch.traceon,sched_switch.traceon
> 
> On an unpatched tree, that crashes during early boot before userspace.
> The call trace goes through:
> 
> trigger_data_free()
> __kthread_create_on_node()
> try_to_wake_up()
> 
> The stack also shows the boot-time trigger registration path:
> 
> event_trigger_parse()
> trigger_process_regex()
> __trace_early_add_events()

Thanks for this. I can reproduce the crash. I'm also going to add this
to the change log as it is useful (I'll even add it to one of my
regression tests). I'll take this patch separately (this didn't need to
be a patch series, as the two patches do not depend on each other).

-- Steve
