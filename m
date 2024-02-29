Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFE716FF21
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244185; cv=none; b=uuWPue80940udGc5ebpfNJUi713HKAb2C/DtsfCglRW3Y4GyEY9eL9O2I6HSTGD5xJozUzB+HB8UProXvQE20C8nDtc5ZYo/Z1F6PXvsfEJCQJ5yHqbG0B2clQpbhecL0zXUO05j/tZ//AyOlm3/qTxdzugd8EhVv5Td3T32wOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244185; c=relaxed/simple;
	bh=t8ugEdHJ9c8d/9Jv/+nQw124fw+6JVjWqtoWTZHbq8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PlrkXcD1DZK60QKDQKmEqg9i1kumuhPxIDKkk8YnV8rNjLxb2NbRBaWehuRxp1RtGmylNmQzEAr8c6QELN95g2kwHnsEaadWCrVZhYj5KtirOxlR3FLeUE8rOmCBfdFHt3Rfypsy5m8wJOs8KyL1MIj7AQy5JUCKY3jQQR4jPlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A610CC433C7;
	Thu, 29 Feb 2024 22:03:04 +0000 (UTC)
Date: Thu, 29 Feb 2024 17:05:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: How to display a ktime value as trace timestamp in trace
 output?
Message-ID: <20240229170511.045cc3d0@gandalf.local.home>
In-Reply-To: <2217765.1706712451@warthog.procyon.org.uk>
References: <2217765.1706712451@warthog.procyon.org.uk>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 14:47:31 +0000
David Howells <dhowells@redhat.com> wrote:

> Hi Steven,

Hi David,

Sorry, I just noticed this email as it was buried in other unread emails :-p

> 
> I have a tracepoint in AF_RXRPC that displays information about a timeout I'm
> going to set.  I have the timeout in a ktime_t as an absolute time.  Is there
> a way to display this in the trace output such that it looks like a trace
> timestamp and can be (roughly) correlated with the displayed timestamps?

Have you tried the other clocks?

	{ ktime_get_mono_fast_ns,	"mono",		1 },
	{ ktime_get_raw_fast_ns,	"mono_raw",	1 },
	{ ktime_get_boot_fast_ns,	"boot",		1 },

The above are the functions used for the tracing timestamps.

-- Steve

> 
> I tried subtracting ktime_get_read() - ktime_get_boottime() from it and
> displaying the result, but it looked about one and a bit seconds out from the
> trace timestamp.
> 

