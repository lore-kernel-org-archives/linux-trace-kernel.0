Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F77260A;
	Wed,  8 Oct 2025 16:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759941073; cv=none; b=d+wXX695ej/4yFZNpX64XPgsd8pu3x+8uqN6gpZgXmRJX7nCgvF9ydDb42Ids350VFtNVZjEkMfT+rwJbcw8rPN4w3UNUj/+LnQPUEOdlgUB6Vb5VxHrjPKgd+Xro+ArBUGNL8IkY+R87iQ6mi/jQEKOkEB2GlV5mBoC1PmFlkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759941073; c=relaxed/simple;
	bh=UMfc1arKuqqKbTbJGgsaLRixb7ETywbXtRgzQLKN4+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9oJYUNyjX0pSszZ71oi/PkxVHQ+0NSLEkPqwCtlqgzx+a91ogYw6ZXdwjxKPYvIT2bgu5pYIhJak+B4ZCX3Nw/jNm+WCCvLeHmMgiaSYafIEjn4Q0to123ZVgPfm8oMnvg0TNWsPP+FyhbodOi9DDYqFt/pfl+zJX7A+sH4uoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 833AB1A05F7;
	Wed,  8 Oct 2025 16:31:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 4EFAC2000E;
	Wed,  8 Oct 2025 16:31:06 +0000 (UTC)
Date: Wed, 8 Oct 2025 12:32:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Runping Lai <runpinglai@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Wattson CI <wattson-external@google.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Luo Gengkun
 <luogengkun@huaweicloud.com>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: Re: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page
 fault during preempt_disable"
Message-ID: <20251008123259.1dfc621c@gandalf.local.home>
In-Reply-To: <CABgk4RSxm8mNJcRn0HdNH3+Y=VDL5gNVvyhhR26wjBme+i5X-g@mail.gmail.com>
References: <20251007003417.3470979-2-runpinglai@google.com>
	<20251006221043.07cdb0fd@gandalf.local.home>
	<CABgk4RQwGsn4CdP0K+_7A0j7RVOiHNfoF1ESk17wEuzCea16pA@mail.gmail.com>
	<20251007154308.5b158d04@gandalf.local.home>
	<20251007163141.1034b120@gandalf.local.home>
	<20251007174208.11fd02da@gandalf.local.home>
	<CABgk4RSxm8mNJcRn0HdNH3+Y=VDL5gNVvyhhR26wjBme+i5X-g@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: r8zu49hxhpdtiahxkmdhao9657xztcda
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4EFAC2000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18tC6P4gP7j66n2PKCd8nKW1OXW/pV26ko=
X-HE-Tag: 1759941066-448671
X-HE-Meta: U2FsdGVkX1+QZzMwSruvokeThYzi+hXa0Wk0bWwyiURdyM5B42hJSk+podUQmJfd2Hzq+vTgZ2kpZGfnAgYHCq6rd/L+hrcmV4zPCZFiYXtZXkyegqYGxAy/khFmZA3cZd1obPiutLgcTUcUbUs+L6qlaoPmCZdE3STJ+LmlIXjyeKWOgjfHHLexmZ7rhsawF5FsLbMWD7GdfzyzLFhR1xfFd3aypAdTmDX7s0Ky/eXnhu9KQZCmZwsqIcKR5URZJos/momodRopgXI3FMjO2fWLoZRUBh0jw7VbSZbsLOoEBh4gEwsMAOVIpTgCywi0Pmsc/pCdc0ABP7u5F2Npdp9U+AyymGfPnrGN2R4INs01jzXf5J2vSA==

On Tue, 7 Oct 2025 16:25:41 -0700
Runping Lai <runpinglai@google.com> wrote:

> Hey Steve,
> 
> Thanks for providing the buffer-based solution. I tried it and it
> fixes the problem!

BTW, I'm about to post a real patch, and I'm adding:

Tested-by: Runping Lai <runpinglai@google.com>

-- Steve
