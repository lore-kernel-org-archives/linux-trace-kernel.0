Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C556D49550D;
	Wed, 21 Jan 2026 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006481; cv=none; b=jDqVNuDUNmQhy8hFgRDQaf8Le3ArdCzajJKQdlecSzhUxqfphpCqpP682D8oXVR9HrS4as9rkHXAxQSg1Z6Iu8MfDqFHc71cbNllPOxfM8Rb0NRW7QK7JtyNCYV0TObt4czBd1EDasWQqXUFNrf+3ER+QWPy39ihwlizHBXfyWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006481; c=relaxed/simple;
	bh=nhh1YqHaSB06C2tkPdWs+G+4E6nrx9sqgltHfPMXfRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUAaBRLRc0c/XU47xWHe3BCHyZa2MmONMsZ/4PfiSsDE9efiqYlbsXIXahAuqsnzFO9YPKUQ3EQYoo20AlCXGycb7w1KBdEWW80R/be+VIsEb0Ee2zA2swdJbnG1Cqlm1xqC3PMNgJl9/8fvedgcJHgfFjXwHeSRVal95WWlXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 368FA1A0317;
	Wed, 21 Jan 2026 14:41:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 41A7B32;
	Wed, 21 Jan 2026 14:41:09 +0000 (UTC)
Date: Wed, 21 Jan 2026 09:41:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Weigang He <geoffreyhe2@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Tuo Li <islituo@gmail.com>
Subject: Re: [PATCH] scripts/tracepoint-update: fix memory leak in
 make_trace_array()
Message-ID: <20260121094132.1e9abbdb@gandalf.local.home>
In-Reply-To: <20260121113035.20f1f464c5f416998d577784@kernel.org>
References: <20260118130247.1003369-1-geoffreyhe2@gmail.com>
	<20260118105457.755291a5@robin>
	<20260121113035.20f1f464c5f416998d577784@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: har59horrr3nrhiqtdozwo43zy7fjbgy
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 41A7B32
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19QB5g5bAAmhnvYkGUsAzcm8rYyk+GCWpA=
X-HE-Tag: 1769006469-493221
X-HE-Meta: U2FsdGVkX19TD26DR4VAf9nfMR4yF92Wwkv9nsm6D6sb+zqMoAgvQm5j/Jgosviop16MmNfe7dAV4JWEDGCv3Qd1w8DTSt1jlPlxJvmXGXHefMsOGUQb7y+KBPJhTUJCQf1rkUHW62fDiqQP3hSNiELxAf17A66b8exrGHHZb84DyyN0YgWE3xBdFV4r4ht7dlR93Gsnrf8gRngQC+xtta5ymE7F8EOUbPGtlCdWpu3eOJ2LN9H8i4zvy+Bkr5YVv0HJ6u70sphKqBAXCaDx4drTKUTwHrQct0/gnBywkjo+YA3CKDie/TltJkkDOxr0kPAvYm9zT1i53q2kihaQi9Ig2yWDvJ9GIiRqRH7PzK2BZk28gAMO/A==

On Wed, 21 Jan 2026 11:30:35 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > It would make much more sense to have add_string() free vals, and set
> > vals to NULL on error.  
> 
> I think it should be failed if it fails to add string. Can it
> continue checking tracepoints even after the error?

This patch is simply fixing a memory leak on failure (which isn't really a
big deal since this is just a user space tool that runs for a short time
during build). Returning a failure here is out of scope of this patch.

Feel free to send an RFC patch that returns a failure built on top of this
patch, and we can discuss if that should be done or not for that change.

-- Steve
