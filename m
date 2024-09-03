Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6998A1A7241;
	Tue,  3 Sep 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369659; cv=none; b=g0HrKS9kfKBTxrh+OPaTDzJJKZBb/Eh33OIQmVMWaEj74TLGY9FF0AzEau/PZg0BM/E5/lM8VrPmouJ7gD2Um5DK+vFi/OSnAvW/jIOMFeZ/yOyxgRs3O1FCWbYuSZ7oDQkqSKyzWsUdNN1lTB2ecdAV87GlR80/Jkz0bWRFzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369659; c=relaxed/simple;
	bh=E9esfCmEIzf9ByeRji9mirDZcedtac57Ki466691NyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQDyuHyYtsJXyM73N6sHIApBkapTGXXignva0B5HxxeF1L2sbiG8pje2avrdNilAUFRSIJrZOzG9d0WDU9AeaakY4kFBnooVQKRAqj3iMxC3IDkaCk0/63WiGSnSnjErDdIG08cZ/Aa9iRook78URIdTQtxAWtOfGZP+Eqdcgsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC969C4CEC4;
	Tue,  3 Sep 2024 13:20:56 +0000 (UTC)
Date: Tue, 3 Sep 2024 09:21:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sean Anderson <sean.anderson@linux.dev>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dma: Trace API
Message-ID: <20240903092154.5f0bfafe@gandalf.local.home>
In-Reply-To: <20240903072512.GA1521@lst.de>
References: <20240826203240.2234615-1-sean.anderson@linux.dev>
	<20240829041912.GB4408@lst.de>
	<4c2c6b24-aee1-495f-ab47-662e1e818f4b@linux.dev>
	<20240903072512.GA1521@lst.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 09:25:12 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Aug 29, 2024 at 10:24:52AM -0400, Sean Anderson wrote:
> > >> When debugging drivers, it can often be useful to trace when memory gets
> > >> (un)mapped for DMA (and can be accessed by the device). Add some
> > >> tracepoints for this purpose.
> > >> 
> > >> We use unsigned long long instead of phys_addr_t and dma_addr_t (and
> > >> similarly %llx instead of %pa) because libtraceevent can't handle

I think the issue is that libtraceevent doesn't handle "%pa", which I can
fix.

> > >> typedefs.  
> > > 
> > > and a __u64 would seem like the better type here.  
> > 
> > libtraceevent can't handle typedefs, including u64.  
> 
> Weird.  The xfs trace events which were some of the first ever are full
> of typedefs and no one ever complained.  And looking at other
> trace event definitions they are full of it.
> 
> I've added the tracing maintainers to see if we can shed some light
> on this issue.

libtraceevent doesn't even really bother with the types. It gets its
information from the other fields.

For example:

 events/x86_fpu/x86_fpu_after_restore/format:	field:u64 xfeatures;	offset:24;	size:8;	signed:0;


The "field:u64" is more for humans than the tools. And it can be used for
hints when the printfmt fails to parse. But the libtraceevent really looks
at the "offset", "size" and "signed" to know how to use that number.

-- Steve
