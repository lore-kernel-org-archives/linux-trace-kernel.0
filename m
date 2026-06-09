Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4224E377545;
	Tue,  9 Jun 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021635; cv=none; b=R1DYylJ+UeW+jyL8v2MwUcotnlWhXy1JqXmVVdFWTBNDgDkTZYSvK1PHd6bjfMpzgbJXbgpStpfHcBufguhBtNPBwu2D1Kp1f/LwE9wYdY+OOkVa6KBru+caK8Rt5iUG5Y2WK250BnvkhZ/7HX5mib+S8aTvx5xGXKSY6VaNXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021635; c=relaxed/simple;
	bh=EeNLEZqt9fFg5AQaSnWHr3AkPzn0Yocy7fDAmbNLYVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYBvMm2+opCllNwe2OQTBtzrIQxeBeGkUYMdIPxoJ9B9uc8l40vaoldX8B31vcChuSKxKVqnJxfmgYQFMYkh0N5/46DFo5xCN3Cu7/gHU2M83gMGF/eNBrrGmPRUFaOaPC1lWzKvHqGOz1Yxhk0mV2CaFHC/xb7JcTN6RD9Mr2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id EF882C2033;
	Tue,  9 Jun 2026 16:13:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 0CA9B20024;
	Tue,  9 Jun 2026 16:13:49 +0000 (UTC)
Date: Tue, 9 Jun 2026 12:13:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] tracing/user_events: Simplify data output in
 user_seq_show()
Message-ID: <20260609121348.303ca675@fedora>
In-Reply-To: <b95f18bb-6603-4c22-b224-0226a49d26b3@web.de>
References: <596c2f16-a12c-4e24-8a8c-1243dce354ec@web.de>
	<b95f18bb-6603-4c22-b224-0226a49d26b3@web.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 85y13s8mku8mcn4crgwfxoydqukzzebh
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 0CA9B20024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/b/Z6qRbncojprE6YVnmSziyWv6ShZr1s=
X-HE-Tag: 1781021629-316396
X-HE-Meta: U2FsdGVkX1/68ikjB52jbbFqf1EjuOxePyAPJpkJeheceTVSpDvyYAtbtPA9c0pxrQvAFPgZ9R8zhwMHLINfWqBlU8cuYPaD5gVn/N7VmjWmJ8r61/Cy4jrFKn51V8SKd3mAhi1ZOddqDS5V/wFIVp27hv5IldzgAPq0B++Y2YYGgSupTwCknXhRPRRYThm15N8AVeIE+ohYcxxO+yLB5QH1/S0nJHGed7plp5FOEt5cA6BXf+Nznyovl+jG3gkMcFFXqMSWtpfcyTRMFtfAiV9YEnPdze3hL4tJWk7njaU3dJaQZuWW67uL4A+mSiK5

On Thu, 4 Jun 2026 14:07:45 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -2800,8 +2800,7 @@ static int user_seq_show(struct seq_file *m, void *p)
>  
>  	mutex_unlock(&group->reg_mutex);
>  
> -	seq_puts(m, "\n");
> -	seq_printf(m, "Active: %d\n", active);
> +	seq_printf(m, "\nActive: %d\n", active);
>  	seq_printf(m, "Busy: %d\n", busy);

This isn't a critical section and I find the original way easier to
read. But the other two patches are fine.

-- Steve
