Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D1F49362C;
	Fri,  4 Sep 2026 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530509; cv=none; b=fIsKUgIOvMHOxXeeucjmpkOb3IyN8b58k5BOdU3ePgVCjIwnVvw9f/dvighPgSLjkI+PK5ehB4fLRNTfU3ufbcDDr7M8sowfePNMAkMfsV5//52feitNHV5az0x4oHM1qjGHBDwTIZyIw2RoqErR8vZebyy7/tVDBK/E824jNzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530509; c=relaxed/simple;
	bh=UwRD2WUfuDoxmcivM5qX0VBAz63TN1nNnpQ29bLmIiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnrzW2FUVrGDP/2o5wARQJGrCLkxPyBYmm8DbRwrg4RQQzvhAE/6tPHzq+0Xqa+UmPHsUlgCeKnANdMv1dQXfxg2ObMk/jp3SNUh0zf7PCcZjhktOEE7Ck1g30LwRH8ESeXUt1mYylmonaa6jt9l6lEe5GyOAI2v1U3ebIDvT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=JRFBXRy1; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="JRFBXRy1"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2FB3C4142C;
	Fri,  4 Sep 2026 14:01:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 3F58E20028;
	Fri,  4 Sep 2026 14:01:40 +0000 (UTC)
Date: Fri, 4 Sep 2026 10:02:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/4] ring-buffer: Cap static ring buffer nr_pages
Message-ID: <20260904100245.245f7bdd@gandalf.local.home>
In-Reply-To: <aprB6OE1juuopC7q@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
	<20260901155445.1475405-4-vdonnefort@google.com>
	<20260903125621.36cd33b8@gandalf.local.home>
	<aprB6OE1juuopC7q@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 46hbtgd7nu8oh9pu3iuwixgqpzkdefot
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 3F58E20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/1yATNb5ROcziw3rVKwj4vZnD1MYIjET8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=/TjXvOb3lkdNV/sBn5FPU3DChTGoZhV4vkAONSsG7WA=; b=JRFBXRy1UmsI4COxTPifQmTzRKFmWgaN1CYS7q8RgSs37R0xK0gqT1WDMZDbLFWSmQeDEGVKx4LYLOOBAuM428CYACOaiIZYaLJMMhAnBwgNmKG0zhzE6dL+W0JPN/0CRLCu/IRfDGrpygDg7dkRrU7p82nr09AeWmAJsX+cwwg=
X-HE-Tag: 1788530500-960308
X-HE-Meta: U2FsdGVkX1+QMpBzt2qqbjWM6DFtDwvqWRXwkHgQ4jnA11lna/1LEX+lb/BHUKq9s00+CZpt6YysJIbZqpdXFTIdoDJtyYDoNXFN1E30z01QrFES1QKiMCd8Am6h733IT+Hu8hmqzIbOzOSRn35sz3j7Wki1+p/qTJufVbiwpjez47HrkJC2kli7Hh4/nmJhXQ+Yel7UQAyZPxEpTo78BX3l+7/G/ABQPdas6kLIHNf3LjG3nLWUkncbFdW9nWOUQSWAmHxw9c9RbHaq5LKOrbYhjbAOm8NyhM51XgCqd9nZtFqdLJU7wg5tG4mJ5PvRjAQYbkVvdEtFMnEzMYIWnxnIKkmaoxyB

On Fri, 4 Sep 2026 14:04:40 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > If you want to add something, we could add to the beginning of this
> > function:
> > 
> > 	/* Prevent ridiculously small sizes */
> > 	if (size < PAGE_SIZE)
> > 		return NULL;
> > 
> > to shut up Sashiko about overflows :-p
> > 
> > -- Steve  
> 
> tracer_alloc_buffers() uses size of 1 for non-expanded buffers.
> 
> I'll test size just before 
> 
>   nr_pages = (size - sizeof(struct ring_buffer_cpu_meta)) /
>   	(subbuf_size + sizeof(int));
> 

Ack.

-- Steve
