Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB7230DD0A;
	Thu,  9 Apr 2026 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751583; cv=none; b=Plsw0niGPWtRyP1LC49jNtWufLHKTi0ePvBNsREHayl0pZBXxxBelthApU1yUPpVEAM/elcI9mmcMt+bf0PPm7+3qPXTpKZddr8RSEx1i0+nV2NfskVBxwAuMOQeIZIQTA7S2kL6rrIWeDQGASDi6b21e5SsIuYQk04WoEJ/4MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751583; c=relaxed/simple;
	bh=yV52mKqD51cLtSXkCcXQYL08j8VTrR3N6BSpMKZXiQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkcpVTPqFB4QU7am2VJNDbVRRhmqHRtshptj6Nng/YBy7ejC0CDxiL7lQiqoi58RwxtfBiD/bZCCN/XY5m67z2qO9WJa/RNezYnuiMwOYUdoqGZ15czrzJArxgGjMwOCjDBgGugGOEsPfacSvjatFR1uaVpnFNphJu/DG9VQR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 2247113BBB5;
	Thu,  9 Apr 2026 16:19:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 292A520033;
	Thu,  9 Apr 2026 16:19:38 +0000 (UTC)
Date: Thu, 9 Apr 2026 12:20:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Linux
 Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Documentation: Update histogram-design.rst for
 fn() handling
Message-ID: <20260409122056.7813c147@gandalf.local.home>
In-Reply-To: <87tstk9lbe.fsf@trenco.lwn.net>
References: <20260126181742.03e8f0d5@gandalf.local.home>
	<20260305110347.31d6bae5@gandalf.local.home>
	<87bjfsb37x.fsf@trenco.lwn.net>
	<20260409115200.45883a07@gandalf.local.home>
	<87tstk9lbe.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 292A520033
X-Rspamd-Server: rspamout06
X-Stat-Signature: yrp9fhaus4muube7dgbme7jm87xmnt5k
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/d4kcRb0mtRaqIBZZ0MNnUFa/ppT1xSBQ=
X-HE-Tag: 1775751578-694273
X-HE-Meta: U2FsdGVkX1+UAGey25t6JJeisDvxsVK/5juX0OHAD1OJVi4NQnlQAFHYSwL+NuMoPvNomKHm8aj56I3oCWq8iPGrB8VAD7TLQpEvGSMXD0+sjRFwDu/rDByjm0I5HBeu72qv7RJQKm9DmF6vNaewoscL++eW/KrnN1AHJYNy6yjf5KjkiQnz7OBlo4V6qM44jvW7aGjEcZn80xCXmn0LmEQU8/pLNyVsGGmMxgzkv3vWuC2jPmNqLUuTH1SFEQIO2/fKb/p+vuGI8qKnpuEBGz4KUYw5CgyKRtiQwDoicNxe2JqVH1yj6kpY+SOQcnKbqcEDJhN1NBgNv5UHYntTkfz2cwMB8tJTMO8qCx37hLUxPxXTreS/RVNHgroCIDFK

On Thu, 09 Apr 2026 09:59:17 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> No patchwork ... but there is a *massive* pile of stuff that lands on
> linux-doc that I'm not meant to touch.  I think that "b4 review" might
> be my way forward here.

There's quite a bit that lands in tracing that isn't mine too. It's mostly
for my review or (FYI), after I look at it I'll set the status to "Handled
Elsewhere" or "Not Applicable".

-- Steve
