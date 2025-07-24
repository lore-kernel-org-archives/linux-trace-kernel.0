Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D554C8F;
	Thu, 24 Jul 2025 03:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753329142; cv=none; b=BJ42vkQJGd0chEy/SsQq9V0aeJwqwf+dSAMIVtw7EHfRCIvhZHj9idneA8w9LUNtH7gIVH9ve2Su1mlyHF4xMLWklcBl3mPmIJKH/oEAAk2jk//7N8vTGFV/6CcQsp8OVU2LqL1rEa0WJXqZZyvY2/8+aAvstpfnhljxoOqmAYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753329142; c=relaxed/simple;
	bh=0mWtWIzDFZ1wRmE/EGHeHocAoCFvLmNst0CZlSZlvz4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BDf4xKRvVbhflC7Kc4FwbA08y6DsgVeGtL/u8QIShrzXCTJhlq6at9+CrBYTHlUmqZR3hBhLHMjsJAuCi0ZJkXVizlS3ZxlLZqMtQRDC948cij56YECnphtTjVpv9sHUBGs48vQuYavs6+QF2xHzymwkQ72+hSzAIc1qWEzsQ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRo6YXLY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRo6YXLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98541C4CEED;
	Thu, 24 Jul 2025 03:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753329142;
	bh=0mWtWIzDFZ1wRmE/EGHeHocAoCFvLmNst0CZlSZlvz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HRo6YXLYiLbMoMl/dLb2EWJ6sMHLHfeLRrnMMW4QdVaZCzfGOXT+8JR0AKpLV+pNf
	 pXNmWp+xItAQ8Oiw9wItlHlwy01GNUXVjEJqh0xXCgv56zqCM3SReaUTsNJlKpeGv6
	 zvHW4QxX0atzj+BjYpKaiSS1QqYng4fydHhYZsD2lkkpLMaA/1A8kQfQBvlrAKJwIE
	 1KHuqlN8tnPXtcp+o1maczSmLoeHT2plrf/iojYUr0nOCiqOFIcMYHeB0Uz0jQXiVN
	 jis97Ym11o9RbCM5D9H7NNuqx3acGuit5hCM3QVNGVhSxPYZD7iqKBmh5gSJL5v/+5
	 HmfRi+Y6vO2gA==
Date: Thu, 24 Jul 2025 12:52:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] tracing: Remove "__attribute__()" from the type
 field of event format
Message-Id: <20250724125220.49e1cbb559dcd69f630e9af2@kernel.org>
In-Reply-To: <20250723112329.691ed421@batman.local.home>
References: <175257695307.1655692.4466186614215884669.stgit@mhiramat.tok.corp.google.com>
	<175257696222.1655692.4019049819386139160.stgit@mhiramat.tok.corp.google.com>
	<20250723104030.6ec24dfd@batman.local.home>
	<20250724001806.2dfd6baf4990f952ee77b6c6@kernel.org>
	<20250723112329.691ed421@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 11:23:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 24 Jul 2025 00:18:06 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > So this will add more work during boot up as it is processed on every
> > > event regardless if it has an eval map or not. But this is only needed
> > > if CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y is enabled.  
> > 
> > Hmm, In this case can we check it in trace_event_update_all()?
> > If we need to sanitize more word, it is easier to add a condition
> > there.
> 
> If we need to sanitize more words later, then we can open it up to
> more. But why do this work when it's not needed. We are going from
> calling this function a 100 times to calling it a 1000 times. That's an
> order of magnitude, and I'm not sure we want to do that if it's not
> needed.

OK, then check before calling.

> 
> > 
> > Or, maybe we can sanitize it while building the kernel as a part
> > of post build process.
> 
> Ideally, that would be best, but parsing the elf file isn't trivial.
> 
> I would say let's just add this conditional for now, and then we can
> start working on a way to parse all of this at build time.

OK, I'll put this in my TODO list ;)

Thanks!

> 
> -- Steve
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
