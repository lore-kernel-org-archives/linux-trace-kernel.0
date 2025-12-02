Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382AD2848AA
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764693790; cv=none; b=qc1uZQlAaurxT6VLqypJtYVUca9KzbFwJJQKg6j8m/J1TYF295WchRa9X8Ij/FFab9RNri1uLMzlRYQNxolbzWRuyoh2diTpjtI+zb8HCgx8jtYgrygIoUzrP4FoKXOtyDrQzsTQjQVhOBaanism2t3qO/jrp4hwElsI+5p375s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764693790; c=relaxed/simple;
	bh=DNmjmKVvRCO5/wyt+jeFNrrcnuqu+bO21JyTaNxM/aw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJrWR0gQSjX4ZXVXBFV52tXqX95kIPeU1L9sQTHy+6CHssHT4/C7ohw6pGOJ83kYMFEuf6WnJi6e8v4J3xpMW2nPbRQIifmghCqTTo61K39pu99WBqlGLT5lPoNyTVcveCdHTDjOb2Z0twHI3kPCANhBlEy2WC1TU08r+nFlLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 536DEC0257;
	Tue,  2 Dec 2025 16:43:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 6D4A817;
	Tue,  2 Dec 2025 16:42:58 +0000 (UTC)
Date: Tue, 2 Dec 2025 11:43:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: yebin <yebin@huaweicloud.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, naveen@kernel.org,
 davem@davemloft.net, linux-trace-kernel@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH] kprobes: avoid crash when rmmod/insmod modules after
 ftrace_disabled
Message-ID: <20251202114358.5e46cbae@gandalf.local.home>
In-Reply-To: <6929089E.10706@huaweicloud.com>
References: <20251125020536.2484381-1-yebin@huaweicloud.com>
	<20251127125248.a1367d15c0bbc7faad3b0e87@kernel.org>
	<20251127131820.152fd7651ece26139778cc25@kernel.org>
	<6929089E.10706@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6D4A817
X-Stat-Signature: huy79783w74mpbwkcxkp8aqyf6a9mi9w
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18X1cwx+twllCTq2SqJTzp8qcsNOROJmdQ=
X-HE-Tag: 1764693778-994246
X-HE-Meta: U2FsdGVkX1/GEeHHxSraG2FbYxJ4nFFzGiOoAbjoBvYhF6y67rx9MhGSehqCsOACbWqdGYNh8Wa5u9iQg9aE9avqVhJuXs/C5AfAQH9xLBUBnKzSVgo1p45GN/Qf0jElirj797Efd/TVmPwVcH+r8Bct9sCC+0mKwo+uYYZ6WuPdlqmgvYSV54k9bzDssQBKAntLFX8gdJg6OrwrCtrcMMH4UmHa3TnOc7USfHgsII311QdJf/doTi2b1oNr4qey+JVglX2gTJ8vhdGVP5nR3/l/LHJXVGQSIeGkyP0YFeuRyXs1p7KqqVexSNSDFCTddQ69t8qOJChHBg1+2n5Sb6OWEyemwY66

On Fri, 28 Nov 2025 10:27:42 +0800
yebin <yebin@huaweicloud.com> wrote:

> >> right before this BUG, don't you?
> >> If you reported with that line, it's more easier to understand.
> >>  
> Yes, there is indeed a warning generated. I might not have expressed it 
> clearly enough. The issue below is related to the problem that occurs 
> when the second module is unloaded. When the first module was unloaded, 
> some nodes were left in the hash list, causing a use-after-free (UAF) 
> issue when traversing the hash list.
> Therefore, this patch aims to resolve the UAF problem caused by residual 
> nodes in the hash list after unloading a module while ftrace is disabled.

ftrace_disabled is equivalent to BUG(). But it doesn't crash the system
immediately, but requires a reboot ASAP.

I'm not interested in fixing residual bugs that happen because of a
ftrace_disabled was triggered. The ftrace_disabled triggering is the cause
of this. It should *never* happen. If it does, it needs to be fixed.

Let's focus our attention on fixing the cause of ftrace_disabled. Anything
else is just waste of effort.

Do you have the output of the first warning when ftrace_disabled was
triggered?

-- Steve
