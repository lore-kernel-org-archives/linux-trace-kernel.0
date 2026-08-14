Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B42492515;
	Fri, 14 Aug 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728957; cv=none; b=QSdNo10z30C8wY1thiw8WbhKmYSpzCu17UWIefrGnGTQUb1ZM/PGF1XJ0G+9MWipT2JgSpxMLCxvP0oDveGTmWWRPdwh/H2USf2kKLxCYhTiuNCiyYJJIWGtfHBjYJ/H7Xagz3vJx8XwIeMOTJQ6GDmA4qFeULxOmRMpUh2v+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728957; c=relaxed/simple;
	bh=Rh7YmftQk3S0jxfjxrGMdKV//RENjflqpuDNP9eLxYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGxvlu+qwG3osDfxeA9bqPyLgxCe1QUIEiJuL5hyGfKlXaf3t4NGhAiYv+ONyZNbhHSuoj2Hx8TmB1hT+DI0rSHX52RjR6mQMWDPEKJd26qWjLTgAYAewYoFqGyn4EOOtUmduDke0EfXK/dSPlE8bNr5xXqfmBCunCs7Fk3sF4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=VOlVyjHW; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="VOlVyjHW"
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id DC12B14016A;
	Fri, 14 Aug 2026 17:35:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 3423E1A;
	Fri, 14 Aug 2026 17:35:52 +0000 (UTC)
Date: Fri, 14 Aug 2026 13:36:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/4] selftests/ftrace: Add a boottime tracing test
 framework
Message-ID: <20260814133610.32eb5da9@gandalf.local.home>
In-Reply-To: <20260815010524.b361dc036dd2e997d23cc421@kernel.org>
References: <178649540853.438282.4271870161169100680.stgit@devnote2>
	<20260815010524.b361dc036dd2e997d23cc421@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3423E1A
X-Stat-Signature: e3xy4kwfse6hoorbp6wbx9ea14gb9mo1
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+IlRGdQa8Sj4kzmsASPsiH5S/NInFQq9A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=t4FISVqsfs6nJtW26w8JkGUvUUjrOIuGS2r6809IyQw=; b=VOlVyjHWN7syomysvwK+A3S08FzrwqAsOnS3r3qejwp8WuxApyUy1QVFdNHPmjIPsB9S9HFL9zFoIdHJ5GkCLIl2QmHlJGFKChYaAeTBnisLdISp05TXpDMGi6dWtrHZqdiRQso0ihsh7Fxn4of29MviJOp6Umij0mkaW9EqEYc=
X-HE-Tag: 1786728952-314789
X-HE-Meta: U2FsdGVkX1+zbFzPf+U5hv/21sGfk/YDMA4skqQzfloJB86IYspdICqKMU9Hy+ynVgddXfa8E7w2hQVI4nBI9M5SIcTa9o48AMIJ5xg4e3XrORQo2SaXHVvekSCeSz37CcsaUeGK47OvSULBTu23YNVt7GatEpjZk56unMVV0M3RDyW6hHRll/uEc6AKdQzSefqdr3Paw8tUFdHSPguSAUHRDUxJiuq55xmXq6R0/YVYTD4EHP1jAGjdWhPnAmzCm1ogt73WErAyoMKUa/nTE0qnXz2QX+QM/6CjAOEq+AKxhm7OKT+nZnqMPTckx4+qFG/25Xq+mcAOpFm1y+mKRrDoIjTR90sd

On Sat, 15 Aug 2026 01:05:24 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> Would you have any comment on this? I would like to pick this to probes/for-next
> for ensuring boottime tracing works correctly.

Hmm, it's a bit too close to the merge window for a good review of it. I'll
be traveling next week and I'm trying to get all my pull requests ready
before then. You sent v1 on Monday and v3 on Tuesday. Sounds to me a bit
rushed when you have 3 versions during the -rc7 release week.

This isn't a trivial feature. I think we should let it settle during the
next merge cycle to do it properly.

-- Steve
