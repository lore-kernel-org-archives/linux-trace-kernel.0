Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2FF2F3C02;
	Fri, 20 Feb 2026 19:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617249; cv=none; b=gzi5beUGDqTzrwoN3PYgCBJ8tJ18n091CWx98li+tlEwc+wFkOkkKBqJtroZn2TMs2AjXU6AMF+sCIDre5XrdRykCbHp7LX3JWc1bQ/UA+ELM8VMlLSKXxpIsEMvX53Rj4BhLcFyNwPHqFNSsC8oemB8OJlZ5kyOVUtTX9sKeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617249; c=relaxed/simple;
	bh=LHEzU9vpfr0kQQbA8xIkCABvbbySP3TLqh/rpp8pLxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FSj6NxkefGXEarS4aSCzALvdN8WHld+WbqCAiczh8rDYLvrLnKQ7cbhERkGHtj9ey9mXygVK5OXiJF0e5ZSN4gnnvVgqJswqerMlQ+mnXnB0YSBLiMLkAZMqm3RZrFVMBWrzfa2sAT3rX5QfGB32x6YtFr9i3kMcp3YOaurN+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 7626E160326;
	Fri, 20 Feb 2026 19:54:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id BAA4020030;
	Fri, 20 Feb 2026 19:54:03 +0000 (UTC)
Date: Fri, 20 Feb 2026 14:53:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ring-buffer: Flush and stop persistent ring
 buffer on panic
Message-ID: <20260220145400.2ad2eb10@gandalf.local.home>
In-Reply-To: <177140966801.1537493.7352910810257662003.stgit@mhiramat.tok.corp.google.com>
References: <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
	<177140966801.1537493.7352910810257662003.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BAA4020030
X-Stat-Signature: 5musmgt41uhtfug9ysss1s358w4apui4
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+BC1rEOl8eOUjGmmhgGbP7pgjmTaZvhZc=
X-HE-Tag: 1771617243-762923
X-HE-Meta: U2FsdGVkX19MTqvy5HyuuM7HdvKRsYV9kv3Y3RT9mSwU3WTxgAVya1MYa4VaFeo5+iiHQuggLAaQ/3U2+CkNXbYehw9uQ7Cp1rINcqPGu/v89qJQ5d8dL4Mi5Qlb1s+eHO8z84uP6u/HWjvEqIWc2AJpB6HvG+4A48SqG7yqni3Qh4H3fBafUR6NcXzJ1bsVrMxOpozlWa81TpA9ULpn48ecor7gNV+mJJpfOzjgL/wJAj/mtF+o/3APo4pCeHgzCtAknsQsRLPybVCIv+3xfvbnRzxTHXeEZCMqH+tgA7jw4yFlfyLKNKechOP0O5OZTcv/ytaZsMnV7YVq3fLhxcpRGn2t5BHj

On Wed, 18 Feb 2026 19:14:28 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> On a real hardware, since panic and reboot the machine will not
> flush hardware cache to the persistent ring buffer, the events
> written right before the panic can be lost. Moreover, since
> there will be an inconsistency between the commit counter (which
> is written atomically via local_set()) and the data, validation
> will fail and all data in the persistent ring buffer will be lost.

Here's a bit of a fix up on the text:

   On real hardware, panic and machine reboot may not flush hardware cache
   to memory. This means the persistent ring buffer, which relies on a
   coherent state of memory, may not have its events written to the buffer
   and they may be lost. Moreover, there may be inconsistency with the
   counters which are used for validation of the integrity of the
   persistent ring buffer which may cause all data to be discarded.


> 
> To avoid this issue, this will stop recording on the ring buffer
> and flush cache at the reserved memory on panic.

   To avoid this issue, stop recording of the ring buffer on panic and
   flush the cache of the ring buffer's memory.


-- Steve
