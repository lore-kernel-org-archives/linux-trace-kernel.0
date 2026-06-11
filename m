Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E113F929B;
	Thu, 11 Jun 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182799; cv=none; b=C9ROGK3v57LEKcgj6ZWTig/A9KlBGVhnbw9VgPdAMmARdLXmooO0g8GEc5Qcw/BWHBVjxBV1+kQti0ZSJxQ1uDTBroGnk3Qun80y/x5TxhJe+sw9irQRyXM4SeDe2E4iSIsK67Q4D9gCro91Xku/iMjuuJiytROkPs43FVrD/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182799; c=relaxed/simple;
	bh=oLgcLB3EJ51Lvj/Bkpu4LzG3g5635hL3//HgZNG/TzE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPksvJiP4qA+DzKDQ2Nf32q9p3qhmDtmYlHsXHrIi6Rxj/hPpaKRWWFHpSxxvAM3hJ6JFc6D5sdlemziv/Iw89kFkboCpRSpFZLbaR7K4fMKmWFxOFSehMhl1EELueqUTlZ8QUgvu7iMt4KZX+idwuqiD1WsqwH7WIhlBV/L8EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 03204A05F8;
	Thu, 11 Jun 2026 12:59:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 3129338;
	Thu, 11 Jun 2026 12:59:49 +0000 (UTC)
Date: Thu, 11 Jun 2026 08:59:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/3] tracing/user_events: Simplify data output in
 user_seq_show()
Message-ID: <20260611085949.59017a55@gandalf.local.home>
In-Reply-To: <6762145e-3e51-43b8-8bca-a9dd200b54e2@web.de>
References: <596c2f16-a12c-4e24-8a8c-1243dce354ec@web.de>
	<b95f18bb-6603-4c22-b224-0226a49d26b3@web.de>
	<20260609121348.303ca675@fedora>
	<6762145e-3e51-43b8-8bca-a9dd200b54e2@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cdumqrpwp36c14rccxwgpxei79h6rh4f
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3129338
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18HIymanurRIToNi1ZnI3eMektQ5mD3NwE=
X-HE-Tag: 1781182789-343621
X-HE-Meta: U2FsdGVkX1+l7x5aMffYe5Ktm6WwiGkYPXDobEZgNRFIO1bai3fv/20JfYiv2eMI6nLX1OuDwWc3/3ClAWxN7+iFcW05pY5sgJX104znMbHFT3agPhFcQAkdXZZnT5/d3Ld6qk7WtQO2UlEC+rvIlNy0etuBzpqSRr6oJ5Fz9E2iYPM7H3oU8NKqWZ+HxnWfa1IrTkHz3hkb7S5I/ADNJFUX44Bey3TcSUnFa72quSaAzxi/4zYqtpzbpxRjuYSWlc0t+AoXz3HhvQXMwkBjfQQauLp0Lkk0NJHzhRZaGIWY2srkwoI0ROmRnTasHzrQBZWGl/baY4pNy6W0uGi6kbme1ue4iG4S9WNcOYSqYTr7SoSiqr/0ZggLT+uROdx/

On Tue, 9 Jun 2026 18:44:04 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> >> @@ -2800,8 +2800,7 @@ static int user_seq_show(struct seq_file *m, void *p)
> >>  
> >>  	mutex_unlock(&group->reg_mutex);
> >>  
> >> -	seq_puts(m, "\n");
> >> -	seq_printf(m, "Active: %d\n", active);
> >> +	seq_printf(m, "\nActive: %d\n", active);
> >>  	seq_printf(m, "Busy: %d\n", busy);  
> > 
> > This isn't a critical section and I find the original way easier to read.  
> 
> Would you prefer to use a seq_putc() call instead at such a source code place?
> https://elixir.bootlin.com/linux/v7.1-rc7/source/kernel/trace/trace_events_user.c#L2803

Sure, why not.

-- Steve
