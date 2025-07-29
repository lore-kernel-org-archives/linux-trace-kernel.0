Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523A287266;
	Tue, 29 Jul 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804493; cv=none; b=i/dNPv+eg0JGtUeMILZQx+Fkp/xxDBracOYIUXtmQCtkF5CjWNoioehKTWd943gh/S7t2C3ShHC5KVfoFywLaup+rtMXJOKeSu1mobWU7fhooqK4yvQxEq+MF8ICiCZwocHnPppmy9Wu7xM7t6/oMi81eGd4ozDDdAcrlTJHqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804493; c=relaxed/simple;
	bh=VzWYU+ByVgQ1LT0LRRQp9faaHAyx15cReublwXhGACw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQxuiyFfaXTqT98NezCutp4UHGDZEQNSUIXeud6DEgOYdnZje5ia5DTeCehhOq8+qF34hxGLONFMamLNuA/F9xnb4a2FF/f04hrgjMJkCTQDWrYq74yuWE4Womj84JVMziDxe3hv4g576dzdNbZXsNlfZ7CjNVjLf5Q8zBWj2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 6AEE356364;
	Tue, 29 Jul 2025 15:54:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 2B12A30;
	Tue, 29 Jul 2025 15:54:47 +0000 (UTC)
Date: Tue, 29 Jul 2025 11:54:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland
 <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Namhyung
 Kim <namhyung@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Documentation: tracing: Add documentation about eprobes
Message-ID: <20250729115446.06aa72e4@batman.local.home>
In-Reply-To: <20250729102636.b7cce553e7cc263722b12365@kernel.org>
References: <20250728171522.7d54e116@batman.local.home>
	<20250729102636.b7cce553e7cc263722b12365@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2B12A30
X-Stat-Signature: g98medgmg944wwns496mtu6cwxes6y9o
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18v9kyW3pn/R4pjNUE7UK8AZqyei/LPwUo=
X-HE-Tag: 1753804487-96631
X-HE-Meta: U2FsdGVkX195b9jnsLnPpRI91bN+toQccvf56IaqYRj54b2j/OazQrLhZppIt9WkQvN1b3TZoPzK3OAX0mGuUi7MsZEJmQarXs0QD1WhTkl6dBTE5LWwmvLgj8RR9bNhDrZY6Dk5k+UIZNvddBu9lqlUVyQyZ7/XuZ+SToxC8bWy0ayCLRtWr5Ru6A1Q3gGhqknlAI+XMb/cx1W5Yinszu1iMZ1TWUfOZObU8Y5vlyh1dfnMFHrbfeFuPC+9sq+kdm/L67W9c6JzPlOS7poB29wTiSy3su5rMb7iVZOkY4S83Pj+4xA0Kf0b7QsekFjZK8kOidz+zVu59wYEwEGpEQsvZVn+kxD7yEGCykVDV4aOPw+CztJnRy8a9wuSRGFfKEoSpWebXSAG/NkjjZmHwQ==

On Tue, 29 Jul 2025 10:26:36 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > diff --git a/Documentation/trace/eprobes.rst b/Documentation/trace/eprobes.rst
> > new file mode 100644
> > index 000000000000..c7aa7c867e9e
> > --- /dev/null
> > +++ b/Documentation/trace/eprobes.rst  
> 
> BTW, can't you rename it as 'eprobetrace.rst' as same as others?
> I usually name the doc of "a probe feature which provides only in-kernel
> APIs" as '*probe.rst' and the doc of "a probe *event* feature which can
> controlled via tracefs interface" as '*probetrace.rst'.

Sure, no problem. Will update.

> 
> > @@ -0,0 +1,268 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=====================
> > +Eprobe - Event probes  
> 
> What about below title?
> 
>  Eprobe - Event-based Probe Tracing

OK.

> 
> > +=====================
> > +
> > +:Author: Steven Rostedt <rostedt@goodmis.org>
> > +
> > +- Written for v6.17
> > +
> > +Overview
> > +========
> > +
> > +Eprobes are dynamic events that are placed on existing events to eiter
> > +dereference a field that is a pointer, or simply to limit what fields get
> > +recorded in the trace event.
> > +
> > +Eprobes depend on kprobe events so to enable this feature, build your kernel
> > +with CONFIG_KPROBE_EVENTS=y.  
> 
> Is this correct? It seems that eprobe event only depends on event trigger
> (by implementation. Actually we should fix the kernel/trace/Kconfig.)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/tree/kernel/trace/trace_eprobe.c?h=trace-v6.16-rc5#n576

I noticed there was no config that selected it, and it only gets
selected by CONFIG_PROBE_EVENTS which requires something else to select
it. I guess adding an EPROBE config would be useful too. Let me do that
too.

Thanks for the review.

-- Steve

