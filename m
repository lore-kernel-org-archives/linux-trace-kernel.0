Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05B34AB06;
	Wed,  8 Apr 2026 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775665450; cv=none; b=JsfgVELeeiHvvpHFN18FsxLDDieNxG7DQnhB7qRDBqlgZwRR2Br9xths2JkGdef8wAzpjdsgUDSrxtpr+Gant2aduO+r4kMcM9BNeZmwgYLPgp21IWp5vGibt3Jklu/ryuAedBwuk/ZyCgddV2wctkYxmfUndiXBFbNM+vUr9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775665450; c=relaxed/simple;
	bh=eVWbEv2us443TdPAKs5opbwbZ/03T8UKZos0FNLbUb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XkRrARGlPXtiuXQRwVZo/nV8FrbB2Euc6CpH++hpYlXsmfaNDwL8JwxD094D6TQt76sgpMOejYOmp/JvZmx7pIz4NT2T45RqU4KMuhxBL1zBIoMayX1meort44GSQpv3SpgJ9T45YBUGVC9I9iGaZIkstBz+V8qqFT2cA0VbOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 1594EC0A3E;
	Wed,  8 Apr 2026 16:24:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 356EE2002A;
	Wed,  8 Apr 2026 16:24:00 +0000 (UTC)
Date: Wed, 8 Apr 2026 12:25:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing/hist: rebuild full_name on each
 hist_field_name() call
Message-ID: <20260408122514.60bbfd61@gandalf.local.home>
In-Reply-To: <f59d594ff21658db45c58a094edeab0f92ae8345.camel@kernel.org>
References: <20260401112224.85582-1-pengpeng@iscas.ac.cn>
	<20260407210502.102e5d37@gandalf.local.home>
	<f59d594ff21658db45c58a094edeab0f92ae8345.camel@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sdxjxqxy6ap5rb8j6c34xbehdcrrtt7o
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 356EE2002A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19MBQlGdiQeZkP9JmrciJU55nAvIWLJHxY=
X-HE-Tag: 1775665440-968312
X-HE-Meta: U2FsdGVkX18CXhgWgRyhCFMg8b6NeC+zpxHyCv5LPl1zKzKqO/exBP+dS5ivgFKbcM9CLDjVwd1FsS1KF+ugou6dU+qO14tol5PcIUGAlqHPPeUK2jx+5GM72jqvmlp3ZXalM3MB21z5xqnY3CRQ8x/HhFRRgqLFpUt46PiQvwy63SGGpgbVBjl0KxArb5OcEwGefmfRxEHcUZGIej/VKA70ILaXUum/mwiW3O7E38DxqrwddUiZ7ekk0mZUte/qlLf9IPLCqIN1hME9wnUTVEjQ8mVtCxqCAb2c/UbiMowIkEfOu7RWjVZTNz1G5HUl7SMcUGDaczAoW3dEY2WcDs89u3i0eRFu

On Wed, 08 Apr 2026 10:58:06 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

Hi Tom,

> ->system is set when using fully-qualified variable names. For  
> instance:
> 
> echo 'hist:keys=pid:ts0=common_timestamp.usecs' >> sys/kernel/debug/tracing/events/sched/sched_waking/trigger
> echo 'hist:keys=pid:ts0=common_timestamp.usecs' >> /sys/kernel/debug/tracing/events/sched/sched_wakeup/trigger
> echo 'hist:keys=next_pid:lat0=common_timestamp.usecs-sched.sched_waking.$ts0:lat1=common_timestamp.usecs-sched.sched_wakeup.$ts0' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> echo 'hist:keys=next_pid:vals=$lat0,$lat1' >> /sys/kernel/debug/tracing/events/sched/sched_switch/trigger
> 
> Here, the sched_switch trigger would error out if the unqualified $ts0
> variables were used instead of the fully-qualified ones because there's
> no way to distinguish which $ts0 was meant.
> 

Yep I see that now. I never had a need to use it before, but I probably
should implement this in libtracefs to be safe.

We should definitely add a selftest that tests this. There's one case that
does use it but it doesn't use multiple ones. We should add a test that
does so.

trigger-multi-actions-accept.tc has the system, but it's not needed here.

We should also have a test to test the output of theses lines.

-- Steve
