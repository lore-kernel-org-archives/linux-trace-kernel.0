Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713937C0FA;
	Tue, 17 Mar 2026 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789398; cv=none; b=k/mxnMrjw+5Rr5X+NVGlHFQ7Gg+csk+fc3QXQrGZ7k7cCVMs5kP4qLM9RhwlzerOFjdF2Lw5iK2xo+LsN5UwVqwiOR9awOuUGIj8sbR0FFk3L1sid3zkjqsjQwBc53GVvprFC5TShu/xvhmvK2sbHtuPNpxo7nCwHfQxEvL+dEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789398; c=relaxed/simple;
	bh=MDwGAC8kL2RfZuG8u4qFO0TVBhfSw4fAUhk9Vy/Awm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9gpLav1HEWXK9h42ZtfbzNVMWvfJhnYJXao4+tRSvtnloeJ1TOvU6a3plHmDiDf36JEqP4D9wB4ugfLQs576xuGFKSy3STDjNrEaE4R3hwgij+PWZw8NfdDGUTkk9JfJIvICdXaRLG/E48xYAGm3z4ylEY3RXu1pc44dEjGglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id F09051603E9;
	Tue, 17 Mar 2026 23:16:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 2BA9435;
	Tue, 17 Mar 2026 23:16:28 +0000 (UTC)
Date: Tue, 17 Mar 2026 19:16:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Josh Law <objecting@objecting.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4] lib/bootconfig: guard xbc_node_compose_key_after()
 buffer size
Message-ID: <20260317191626.5b6172a9@robin>
In-Reply-To: <20260318080351.dae637f4b5909bd9f81b27d2@kernel.org>
References: <20260317204403.72375-1-objecting@objecting.org>
	<20260318080351.dae637f4b5909bd9f81b27d2@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9r9zd3qpn4n4qk31ek31dtpy7rpr5bcq
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 2BA9435
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18Svfnsqp+prstFVqHFcor9vFJkRmqhEuE=
X-HE-Tag: 1773789388-513557
X-HE-Meta: U2FsdGVkX1+gTXDnNr/sLE1BUXhCn3UoP2ynpTsp1vYZOT+VAnz1PWaWYUj8Y5SEL3goSyb4kzGO1SjY84D8+SIDs1B8hOL2pNIuz5Dun1g6TxlfBbYVs6jz34jc+NSdv2gK1WOxQljelqU25fWaObNL5xG61FXqmOK2i7j84mY8kT+uBKxp+XLPIejg3k+RUq2RNTh3mnps/EcV2QTJEzMAbFLj5/zTCrfc3wCJdyfWcNvRf36c+tnyU9wl+IfML9xr8ApfOb9bDt64A/HIM2xpGK4XmcpFO9mrZnF9LH8RZpvc0ZEPQxzUSMTyKyBmHFXCdKCEnOchku+/gJQcT07faopSg4lw669f+BFp5NE0H06qH6WK5Kcl6KEMt8MekwGVJTAHfVNFwmhDKAAgRw==

On Wed, 18 Mar 2026 08:03:51 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 17 Mar 2026 20:44:03 +0000
> Josh Law <objecting@objecting.org> wrote:
> 
> > xbc_node_compose_key_after() passes a size_t buffer length to
> > snprintf(), but snprintf() returns int. Guard against size values above
> > INT_MAX before the loop so the existing truncation check can continue to
> > compare ret against (int)size safely.
> > 
> > Add a small WARN_ON_ONCE shim for the tools/bootconfig userspace build
> > so the same source continues to build there.  
> 
> NACK.
> 
> Don't do such over engineering effort.

Hi Masami,

This was somewhat my idea. Why do you think it's over engineering?

This is your code, so you have final say. I'm not going to push it. I'm
just curious to your thoughts.

It is interesting that snprintf() takes a size_t size, and the iterator
inside is also size_t, but then it returns the value as an int.

That itself just looks wrong (and has nothing to do with your code).

-- Steve
