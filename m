Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE74F332629;
	Thu, 26 Feb 2026 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127397; cv=none; b=s6xb6Jp3sSjV9K1L/7/NRzKB3CI8y93Qct1WoX5AfBAHUvEf+Hph73Kh4D9wI4Z2r72oTW8ZUPF6pHOYKvI/va8Q1PPkbOblSyRj9k7yCrzIgPEatYBPjuyh6bnRHlkNBZ+NDVAfWl9TXJ4WA6Ajdnjn1TJQmhFR12wFd9JFXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127397; c=relaxed/simple;
	bh=clKjpLwJiQkI3wyvl2Da5W9C455aJyBwL+2RpRZJIko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xp38ucEkdAtuYddtCjiA5B+hp3cU5DJq6cdkQuBN+8voNXdlTAL4SGdl1ZRsoJ7bMOPbRnbM9STo7A+me/Ra+gEUT/d+trIRjzoeMHc76YLt2Ip4ojleru1mtyIGosyTfr43omn1nQC80Z/QDdc68RzloUxtY8Q/mZ3qdUtasTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id D45DD587D3;
	Thu, 26 Feb 2026 17:36:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 207DC1B;
	Thu, 26 Feb 2026 17:36:33 +0000 (UTC)
Date: Thu, 26 Feb 2026 12:36:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-ID: <20260226123655.4d2ca691@gandalf.local.home>
In-Reply-To: <20260226215833.4ad4f07f2cd06c9ccf5c1afa@kernel.org>
References: <177191595057.435720.10116014529518464418.stgit@mhiramat.tok.corp.google.com>
	<177191597760.435720.2484229987964512451.stgit@mhiramat.tok.corp.google.com>
	<20260226215833.4ad4f07f2cd06c9ccf5c1afa@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 207DC1B
X-Stat-Signature: gjbshfef4ebzfqx91teg6fu5cde8136q
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Fn/E2FXi/bBAS8K+U/shLmgUIWYKErqo=
X-HE-Tag: 1772127393-43070
X-HE-Meta: U2FsdGVkX1+LKatPv63OdrtOGnLJzqbphUJrUVG1ieBYoI2A7KWxfTDmr/k7f+ifjinY7NjcV6DBwiLxjVk4O1qQf5CGPKV7oDl5Nspcy0HaN4EfT4N8DRtdPILDUB2tORDo1novXqbhGI3bMFl1KbeelptwgAawPFqOcYGqyrjWeEj/fSkf/owx4hNRe0xQ4haEfAY1NGGvq4MFOQTyzBxdi9VVOR7VI9gA2Rp+TwKk/vPBFMIp3keTHGcgbsxrsmTLXv/6/0f64t+H6ZmmaQe/kYh3FJu07/n5bdtN6soCnKOHQmPHnnK1aJo2Qw6cxiL7dk0hZvlk1hVTQqiDTQknlEneFtwE

On Thu, 26 Feb 2026 21:58:33 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -2058,17 +2058,18 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> >  		if (ret < 0) {
> >  			pr_info("Ring buffer meta [%d] invalid buffer page\n",
> >  				cpu_buffer->cpu);  
> 
> This pr_info() should be removed too, because multiple pages
> can be discarded.

I wouldn't discard it, but instead add a "once" variable, where it shows it
only once per CPU.

-- Steve
