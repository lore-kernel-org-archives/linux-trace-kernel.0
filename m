Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667F429011
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973209; cv=none; b=dG/R4elGsA8r+nndIl+6It0QB4G69UIh545nSwmxy/Pi5FjSeho9seqIZxbhDyJrzi2vFXVMckVE5v/0j9RBAoeoHs0vsmDZ5kkLLSQxMTWP0mCO36lGnQz/oMHNxQbur2tdriaeEAKDTMOErCrA0jfFVg3S1blcKveGPJuitSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973209; c=relaxed/simple;
	bh=OvJFo1KbSmJgP3geNtFhm8IaDtdNV4aZSt2whHxGCxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCGlIIX0PMbkzsVWgtz6UPapb26QklQYAktOeLj531mhI4791wMsqvP/ZRyUUkDUXgSidIiYLVP2ZvZ6RKKpD1jBeMYS0NL7oN0xwuapX2jJey+y3wF4zN4VSxycK+ZHiReli890WcYEl4PkVN/15OYYFYF4sRkAYvORF/5T01Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=GZ+HIq7i; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="GZ+HIq7i"
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id C11BDA078B;
	Mon, 17 Aug 2026 13:26:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id CAF3320012;
	Mon, 17 Aug 2026 13:26:43 +0000 (UTC)
Date: Mon, 17 Aug 2026 09:26:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Hui Su" <sh_def@163.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Fix crash passing ERR_PTR to kthread_stop()
Message-ID: <20260817092642.0e65f5bf@robin>
In-Reply-To: <20260817121532.9C14A1F000E9@smtp.kernel.org>
References: <20260817120642.668375-3-sh_def@163.com>
	<20260817121532.9C14A1F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4g3dfq1uwtdmob3b6tmbhqxbw6ipw8ce
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: CAF3320012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19oo9EL2vbgQS/ZeVI6vyicotGQsqOKcqo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=BTUKkLa3F85pMF6sWXs4mQcLU9dzg2/ZBR7pC3kkv68=; b=GZ+HIq7i+11yrSKl2vD7Vs9fHGLiBtukjc7zsDOeEclTuJEs01nuihQQHspUoj3pFw2R6epRNVi0kNch6TCS567tTCOsKvTgz0rvPZXOoqlRxQ6jvDw/LpYqL8LehgjiLOeHaUS5znL+gwZx617NXR9qomP7VWZ6C+s7gB771Gs=
X-HE-Tag: 1786973203-967486
X-HE-Meta: U2FsdGVkX1/pwJ5XILhp+inqYGvZ+L5XFrde3L0hteVUVs1v1RQCzKOQSucw2iyyGWx45PSPvNlKt01167MRdGaEpLIga0Gd1rQ6nHV6w6m5QTg8VKh1jtJVIwiwzmyENisrhF0x+n9rAY9OE+upvf55amrOml6NZO0xTWhohq1Lwg0QyRyhaBl6CBCLHE5WPX6gHYT30OgbVO8ADQ1KoB9U7ytYnNCPQSGY+WMM6IioSlM+ygsv0Fqos3VgnqpmkV8obH4P8GOCypS+5F/sLggyzjx6PCXJQFOOq69VBGRrr990mW2ZDel4SmLcjp057PVecDyTWGVxt3w4F4Kb46ev121rlyN1

On Mon, 17 Aug 2026 12:15:32 +0000
sashiko-bot@kernel.org wrote:

> > diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> > index 0356cae0cf74e..9e941e5805f5e 100644
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -3866,6 +3866,8 @@ static __init void event_test_stuff(void)
> >  	struct task_struct *test_thread;
> >  
> >  	test_thread = kthread_run(event_test_thread, NULL, "test-events");
> > +	if (WARN_ON(IS_ERR(test_thread)))
> > +		return;  
> 
> [Severity: High]
> Does this risk causing a console flood and soft lockup if thread creation
> persistently fails?
> 

If that happens than the system is doomed to begin with. We don't care
here. This patch is good enough. It's for a debugging feature, not
anything that would be run in production.

Just look at the name of the function: event_test_stuff()

This is where AI has a hard time with subtle requirements.

Thanks,

-- Steve
