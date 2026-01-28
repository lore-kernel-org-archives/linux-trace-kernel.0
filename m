Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDDA33A701;
	Wed, 28 Jan 2026 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636606; cv=none; b=Cu9r8vZr/Um/vUPn55dgamEIV5SrIN0IYunlm2A9aFpkk/3mM41R4m4ODeVlPYLCNlXV8FPbFfZdqvpJ1vHkPOIDF58DOTSDtg/ePENzRj/saWAxuUth1WaztCd9pzsjGe7Ud89OF0UbwtftaNagVfDTASJ6SO4jVk8oiZ+6bbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636606; c=relaxed/simple;
	bh=u4mbROTnoL4E3tRZgwFyuEDzVdJJLw6GzGEdqeKjA7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWyGVw2JDLkEPvx8d/jR57BoFJKSTAXNWRULS40D1tfgzTwJ9bahW4CCZxcZPCdrkj3UNwUY9Yo+vXKWv39cDk0vKw/RSYJiTY8jWpRvEfu6+68f/o0L8jAKhnrQ9DvpLjzebCqtu9v0WXpPsjHl/cVz/dvT+cQQVTTdWidsL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 915968C3BC;
	Wed, 28 Jan 2026 21:43:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id BD21D18;
	Wed, 28 Jan 2026 21:43:14 +0000 (UTC)
Date: Wed, 28 Jan 2026 16:43:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: trace_mmap.h: fix a kernel-doc warning
Message-ID: <20260128164323.38128375@gandalf.local.home>
In-Reply-To: <20260128062522.403456-1-rdunlap@infradead.org>
References: <20260128062522.403456-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 586bk9xozh74x6im4b919t4j118duqq8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: BD21D18
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19xQLPq0EdFHETwqfvcC/GejiRCH+Wecqc=
X-HE-Tag: 1769636594-409718
X-HE-Meta: U2FsdGVkX18KuozlXsyPsMW8gYq5uTiLs+oPd+q1SeBN8YP270Ot03WAhu95PoOX7tZ3HwueFqpYf6LlF7yBGoyFqAuFo+UHChLFrcFT4gpjblnzoqtTR06pNbZjPMlWUUUs6WB0NLcWZaXd5Fxza9IYy0tfM33WC6/f77zoZTCZUHjAVUcWoK7AH2lPxWDLZvAZEqm7EoBSXDmQ0trLPjNJ/ZZmz5KprF6JFVhL7R/paZyVLWNc49UDAeJm8CMbamV6wMgtuSP5TnrC33ItgU5+UZeDT9HWnCitvTEZkb3/+kwgRyDGjz7/6362Y3HJZfWYN0vrcadpbfSRzf1v0ST+2NRXVBNv9ysWT3SJsGIlaYvzwOz8xSeIBlJk8KDHrN460oO73/92QpCoQCWNLmxGPXeYCfLxBo9RK8uFrHRR7j997PRH1ly1JVmbd5GkP1YyrRTAoLi4xByPEMFEoXtO1fKYmtuwSj64/b6cxZ4uydw1n5if/8/YbSn11WSUSeNrSdjFoNE=

On Tue, 27 Jan 2026 22:25:22 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Add a description of struct reader to resolve a kernel-doc warning:
> 
> Warning: include/uapi/linux/trace_mmap.h:43 struct member 'reader' not described in 'trace_buffer_meta'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: linux-trace-kernel@vger.kernel.org
> 
>  include/uapi/linux/trace_mmap.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20260126.orig/include/uapi/linux/trace_mmap.h
> +++ linux-next-20260126/include/uapi/linux/trace_mmap.h
> @@ -13,6 +13,7 @@
>   * @reader.lost_events:	Number of events lost at the time of the reader swap.
>   * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
>   * @reader.read:	Number of bytes read on the reader subbuf.
> + * @reader:		The reader composite info structure

Wouldn't it look better if @reader came before its field descriptions?

-- Steve

>   * @flags:		Placeholder for now, 0 until new features are supported.
>   * @entries:		Number of entries in the ring-buffer.
>   * @overrun:		Number of entries lost in the ring-buffer.

