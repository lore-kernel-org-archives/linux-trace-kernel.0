Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06B823DE;
	Wed, 29 Jan 2025 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738132899; cv=none; b=jPrQtDyISC1PmpgTfN9SeOXmqBrmqUE+ywRrwqGhrekLydCWEhkqpQqswPLkryg1ds5Lj9UFHUv0DoVOggGGJbxKcBTlBT249vLIZHbq1WGd6itwElPOrVkPEwNE2FdDSizwQ0O+C+B1BqFSAwYAzh22Lj8YB+lP8HP4J0xU+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738132899; c=relaxed/simple;
	bh=a21p3Y7rbH5sS0c5hLooFIW20sWziJ6izyhpAiaJ4HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=setW1JW7FbocMw3v+WQAf1sLr/1247VrzXF/R32xPtxZN6XWz7eBGSS0EWCR1dU8GBbrEGGhONdsDk2uC5vQ+PPzPYn4JOPFakMzdY7bwjrN37BeAa6Y/l7dA0t8YfM0lg9QTolyAJhubZEfMmHVeLdw8I6HlI+Us0ihyPvgfCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JpGJMOoP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cesFMelz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JpGJMOoP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cesFMelz"
Date: Wed, 29 Jan 2025 13:41:25 +0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738132895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/pENwl8A+ELmwLeIjlxf5JAW0qYpszY6xWMiWfCCLo=;
	b=JpGJMOoPwqv0mB+F480JAFr0TqGCi9D32JYYnV/ekkUj0Ysj9Pb3ANrsS6B9W8kOImHf6i
	fv34iBfx06LB8PwAXZE5AC/F23YzJmLiEAO+qB8lZp9sAYlseTCAxFcsHuZ0K61QQD3/5K
	oTWrXWvvil//5x/PD0KzW95Ctj77oUG9gXlrLVDMauSmdHW6z1FEFwE29ICPlG/cGe1wp7
	CtZTiNNr3W2bBqAn9O/nwluo+0dU5UQsRYhxxNQMJTYJbb+W1WfQHqTXR4WTu7fM41aafz
	M3YDb6NwxYm/Ee798iOt3iprJffrLaRdI6U/k98rKssMGV3P/5MZ9prOnhZjGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738132895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b/pENwl8A+ELmwLeIjlxf5JAW0qYpszY6xWMiWfCCLo=;
	b=cesFMelzUZl3pllCTpDYX7NHuACPQJ1FUQT/rhkWapRPUVsMcNHWAS9ztmu8OqYULUcYK3
	zhlUtgWtryCX81DA==
From: Nam Cao <namcao@linutronix.de>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, naveen@kernel.org,
	anil.s.keshavamurthy@intel.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: kprobe on local function
Message-ID: <20250129063916.07WPgeQD@linutronix.de>
References: <20250122075939.qw7HsuMd@linutronix.de>
 <20250122172936.09bc8c9a@gandalf.local.home>
 <20250123104842.92336327f898e546c5b67536@kernel.org>
 <20250123024224.d0h8d4HV@linutronix.de>
 <20250125011655.449075f32f50de6fa7ff20b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250125011655.449075f32f50de6fa7ff20b8@kernel.org>

On Sat, Jan 25, 2025 at 01:16:55AM +0900, Masami Hiramatsu wrote:
> Now what you could know is that the kernel does not call the
> "rt_mutex_slowunlock" symbol and it may call another copied symbol. That's
> a good to know right?
> 
> Note that this in-kernel kretprobe API is a low-layer API, so that user is
> responsible for controlling it carefully. This kretprobe API itself does NOT
> know which copy of the optimized symbols are used.
> (there could be inlined instance too)
> 
> If you need to know how many copies are generated or inlined, you need to
> use the debuginfo as "perf probe" tool does, which can not handled by the
> kernel itself because it is too big to be loaded. That is why I made the
> "perf probe" as an external tool.

Got it, thanks so much for the information!

Best regards,
Nam
