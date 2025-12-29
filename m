Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BC2E7BB6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Dec 2025 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767044193; cv=none; b=enZS1nY3cmb4LXriSvdbFMc/M7er3jltoY5MmKR1As5zVEoLqu77DDgJcqdZ+mrkMET7sRYUGt8djM7+7+iL9LrvLEcmzwulB3BSlYu1F1ZrNvN2fa5iilPS99qt/RnitktRao2zwvqVeXpSuGnXycA89tq7lWJZCSmHgTTjq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767044193; c=relaxed/simple;
	bh=6OjzT29AmImDDEnmXnUr7w7u8YcmgWIl7Kq56zqf3+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ainQ5u2bxwlRRODpD3fmTChfHRJp1Ojin9ytFKJKtGTijSue+Pwsl5r0pkHfBTbkF3htiKJks8y5gbc7J3F6FjmHD6FAoc+6TmGmetZtNqxCJcQ/fs+kYBByjvgpA0dPM4h6IPnH/kuwzal1fRJdNgNqvFQq5UaW2ZlXriZSsEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 123098C92D;
	Mon, 29 Dec 2025 21:36:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 4B26B20027;
	Mon, 29 Dec 2025 21:36:28 +0000 (UTC)
Date: Mon, 29 Dec 2025 16:36:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thomas Ballasi <tballasi@linux.microsoft.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v2 2/2] mm: vmscan: add PIDs to vmscan tracepoints
Message-ID: <20251229163634.5aad205d@gandalf.local.home>
In-Reply-To: <20251229132942.31a2b583@gandalf.local.home>
References: <20251216130302.5202ca81@gandalf.local.home>
	<20251229105427.14720-1-tballasi@linux.microsoft.com>
	<20251229132942.31a2b583@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4B26B20027
X-Stat-Signature: wpzcgfbkwd6zpssxd6wjmachnyfi4wdh
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19vnfwECd9VuIth4+80pGK3VKZT8RK3tWc=
X-HE-Tag: 1767044188-228809
X-HE-Meta: U2FsdGVkX18RJmiX90bjSIbUOSI+5lqzsjlB+XCYcHOhwxKZOfh+PsJu4HHuHmUhEqJbzYbVsl+y4pnQPqMX1g8eRxmEV2V+/7eHLEhptSGnI0lJh7ztu1FJAJnZvQUeHH7w6Xgj+7gOQsC+wIKDCEoYYC9OE6B7H52P5oGvd7qFwDf2Y96QflZq+g1xQ5wRehUTB4Qo5a14+Qys0RiANezVk6HV4G/bPw463h8sJgAWyW+VOa9DaUuvkeUGB+jqoyFNTjwkiKSRqOR25RrgEJcUNAFpqWLW+d5o8MByUrJ9Bgrn55v2d6PfpgwyOJE8wTcSVRwpNmCrYjm/sJQsxDwAPEbcSV3nr5Kb/hk/tSRSLmEmBjHj8BUORiF3a6AfZrcHVB4xMmoGJMNKvrUzUQ==

On Mon, 29 Dec 2025 13:29:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I just don't like wasting valuable ring buffer space for something that can
> be easily determined without it.
> 
> How about this. I just wrote up this patch, and it could be something you
> use. I tested it against the sched waking events, by adding:
> 
>  		__entry->target_cpu	= task_cpu(p);
>  	),
>  
> -	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d",
> +	TP_printk("comm=%s pid=%d prio=%d target_cpu=%03d %s",
>  		  __entry->comm, __entry->pid, __entry->prio,
> -		  __entry->target_cpu)
> +		  __entry->target_cpu,
> +		  __event_in_irq() ? "(in-irq)" : "")
>  );
>  
> Which produces:
> 
>           <idle>-0     [003] d.h4.    44.832126: sched_waking:         comm=in:imklog pid=619 prio=120 target_cpu=006 (in-irq)
>           <idle>-0     [003] d.s3.    44.832180: sched_waking:         comm=rcu_preempt pid=15 prio=120 target_cpu=001 (in-irq)
>        in:imklog-619   [006] d..2.    44.832393: sched_waking:         comm=rs:main Q:Reg pid=620 prio=120 target_cpu=003 
> 
> You can see it adds "(in-irq)" when the even is executed from IRQ context
> (soft or hard irq). But I also added __event_in_hardirq() and
> __event_in_softirq() if you wanted to distinguish them.
> 
> Now you don't need to update what goes into the ring buffer (and waste its
> space), but only update the output format that makes it obvious that the
> task was in interrupt context or not.
> 
> I also used trace-cmd to record the events, and it still parses properly
> with no updates to libtraceevent needed.
> 
> Would this work for you?

If this would work for you. Feel free to take the patch I posted and use that:

   https://lore.kernel.org/all/20251229163515.3d1b0bba@gandalf.local.home/

-- Steve
