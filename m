Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1963ECA52;
	Sat, 12 Apr 2025 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744492917; cv=none; b=b5aKz2lXPLz2MyYCaUQ6dhQiN0epWPS65SoAzcjPtqQ3g8W2BYY5sdfteYWHvEGqh8Jfpi7O4uFjpnf0EzpBbbVNFyHF+rzaO2frFdvC6m3/nsifHs5YScdi0WOaZs/E6OrAGNoR2LgpTuK7Z+HOnbd+6hhVCsKIE2NnX5JeDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744492917; c=relaxed/simple;
	bh=whvDAOl6OU2jhHDfgM2XsPS4jM6CHs/GhWz7GjJ7kBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPHmAzrQ+ob8lqgGk93unW4/+fSi4yQuhMk60vPf7aT6K7yiravl3R2rJosVY0oNqCBdjR5FzviPsXF9bt65NaDTvKMhnv/LU6pHaV5ebDT0GCo5lI8+lFWXV6a3N2PmmjXEdUDXUSYboJgkMpsAMOoTG7pYGcVD/jFk+Qd+l78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9B1C4CEE3;
	Sat, 12 Apr 2025 21:21:55 +0000 (UTC)
Date: Sat, 12 Apr 2025 17:21:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sven Schnelle <svens@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] ftrace: Fix type of ftrace_graph_ent_entry.depth
Message-ID: <20250412172154.0a0ee9c6@batman.local.home>
In-Reply-To: <6bbd72b60478d363d03c268ce8095f8a@linux.ibm.com>
References: <20250411172207.61332-1-iii@linux.ibm.com>
	<20250412120712.67fc45d9@batman.local.home>
	<6bbd72b60478d363d03c268ce8095f8a@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Apr 2025 23:01:05 +0200
Ilya Leoshkevich <iii@linux.ibm.com> wrote:

> On 2025-04-12 18:07, Steven Rostedt wrote:
> > On Fri, 11 Apr 2025 19:21:41 +0200
> > Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >   
> >> 
> >> -	F_printk("--> %ps (%lu)", (void *)__entry->func, __entry->depth)
> >> +	F_printk("--> %ps (%d)", (void *)__entry->func, __entry->depth)  
> > 
> > depth should never be negative. Why did you use "%d" and not "%u" ?
> > 
> > -- Steve  
> 
> I used int, because it's int in ftrace_graph_ent and all other events.
> If you think it's a good idea, I can change them all to unsigned int in 
> a follow-up patch.

Hmm, a change like that should have been in the change log and explained.

The reason the code has int is because it uses negative depth to break
out of iterations and such. But what is recorded is always zero or
positive.

Yeah, let's keep it exposed as unsigned int.

Thanks,

-- Stene
