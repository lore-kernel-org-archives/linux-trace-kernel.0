Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13708226CF1;
	Sat, 24 Jan 2026 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769280657; cv=none; b=dTh6E6GobDd8Kn+06LfLrQdiK7BMdSOJdD5QBuwk2DQenxbQ+OmX5BLSsk9P0nt2BwQ3mdOx7bREjQ8q9FrpThB4KBhnYcplN8rO0somJ60PxJ0Q+STN/VwIIuIxJO+phGsmnQSBZVssfn4BUCbPHToTfW9V/a5zQ4a02YOitQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769280657; c=relaxed/simple;
	bh=JcCGZ2uC1MpkCn2pm9NM8da5B8PWL+fl0WJGYUv8718=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9i3wmY3FYidpcLSOjG0G4/k1x6iOG7CyYkvHaCyNUt0Q7P43trTwUmPUl4zWDpevrdU8ynsP+JGUA40dFDDM9ls5TggrLaOrNUX+/40xsrMMEGajHFcDeN7wkIyMoudA7d/kqKi9affnj3mo0u/tX1XRTdC56oNrPzBed7X/r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id CFB13D2601;
	Sat, 24 Jan 2026 18:50:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id C3B4220027;
	Sat, 24 Jan 2026 18:50:45 +0000 (UTC)
Date: Sat, 24 Jan 2026 13:50:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Crystal Wood <crwood@redhat.com>, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] rtla: Synchronize sample collection methods
Message-ID: <20260124135044.366a313b@robin>
In-Reply-To: <20260123152534.1036533-1-tglozar@redhat.com>
References: <20260123152534.1036533-1-tglozar@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gigee76rzzj9jt3bhpmwk4xn6nabfkte
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C3B4220027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+XhuTDkxOssB9Ync+uxf5kyn3ZpFZ0kM4=
X-HE-Tag: 1769280645-44113
X-HE-Meta: U2FsdGVkX1+FJqX8nb8TqhxKSL9cV5kbKFFVBzlFEs+hhmRdz5/xYEAKRjuKwqs9+AvV3yS0aiE3CpAFDtNYrpHSi1OAvGoTZ1Q/1vmYIO+GjXrKhp+ShMlw+Myc+UnaeOEi1ehTpyOhpdMmGSRh4Ci6CpjXN90q0VYHVXnhfNtFW59NUBsbCbJo3mZ8YB+Yegv4K08wiaDEtDL+NVvSbOwwNPsbXQ0OhQajBOICUwJRpXmUlKmLLHc4vSW7WzuTYh4d2Yk9b0gWkkWPfVWp9MI8pFoDJBQfDtu1Kr2MbuLBQQlibEJhOGPL02+ZpVIf56heMLeI/Q1/HJO2fupQUnr9S4jgaiU5

On Fri, 23 Jan 2026 16:25:31 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> To enable RTLA to analyze samples consistently, the first patch adds two fields
> to the osnoise:timerlat_sample tracepoint: instances_registered and
> instances_on. During the recording of a timerlat sample, timerlat counts
> how many instances are registered and how many are on, and attaches
> the information to the osnoise:timerlat_sample trace event, which is moved
> to occur after the samples are recorded.

Can't RTLA simply write into trace_marker or trace_marker_raw an event
that states "tracing is now active" and ignore anything before that event.

Heck, it will include a timestamp, so you only need to write once and
ignore any event that occurred before that timestamp.

-- Steve
