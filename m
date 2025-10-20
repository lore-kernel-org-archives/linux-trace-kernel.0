Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69DE1F151C;
	Mon, 20 Oct 2025 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985205; cv=none; b=GfRoRcts92naTC+rhi1P+Nkf+q2JuLy1BAwe9TXzukWQpBDvBQuw5nQUbwSUZZcr4FOwa9XOoksz5xNG7j6/y4YLR4QqNUwVbUzECaZmhioNQcvuBMuKvDpMnUxfi9H7XBxzGPcyz4yuiLrHmbT/UYs7p24NUWSqpx/PyImvXx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985205; c=relaxed/simple;
	bh=5gXaYWbN7G3/7h+AXsbtIdN5dVqKRh6WWrUSpcXas9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgG3EjGE2H5GWdJVPbM7pPCitG1aoAg8R3YII9cYaw3w7ENH4sTnv6oiauzVlykEb8On8rKXB5uZ0mdaVtAH7dtjTXg0VstyHRjxteOH9Q/XbuU7RXP4h2DTfxoLfQxHziB/ZlJDewty7X8A5oDFyUrD5FpWDR0Kiwcv5mkJTuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 10FB51A027B;
	Mon, 20 Oct 2025 18:33:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id DC5B26000C;
	Mon, 20 Oct 2025 18:33:12 +0000 (UTC)
Date: Mon, 20 Oct 2025 14:33:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <laijs@cn.fujitsu.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ring-buffer: fix kernel-doc format to avoid a
 warning
Message-ID: <20251020143332.732ae92d@gandalf.local.home>
In-Reply-To: <20251020010037.2681824-1-rdunlap@infradead.org>
References: <20251020010037.2681824-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cp3ksiu1b1oasx3s4q185i3nqjodaeto
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: DC5B26000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19SHafg6TbufMcgmGIXbuTc9+HLk0fPKR4=
X-HE-Tag: 1760985192-677937
X-HE-Meta: U2FsdGVkX1/HyFtSoM0inYVG0URL6sOhceVECnY7ftRHvrgOXFpt4Y1JUlaZEWhHjT5scToxS/uqK/517pjzCeAfeInIGPa96/Yuy4y9to5HPayt2hnhS6q+ANYapn8Ou2BC6tkY40fYYHYJQdPyLeMzrPpNbBupvAVNBSh6mOev67OWZZADkFf/PXfJso+adH+bsL0g1POrSx9SIin0tHLCKGwix/uJaxvHJv/FajbRwhI9FnFAf01IOX4I3QYodIlOQaiyBKlSJ5tCjItoIFYlvexG6K8H+c8H9uxEXPFV8liKhZpJvIj3IsjJJ3ZKWJlbtyepLNOMGNGISWfzDPuimVQyRTVMO5lwdtTsWmm5LYcEylTS0FJeMYxrj+lky17m911TmwySQC9kxRdkCzetPyWCxH/85rKDkl/KgCFTXtXcBF2dEhldla3xdg/9uYf/ns8G/geRy/Mhz8MCkbxgfWvRNn7ltDcZg6lw7pgmeBuhUT7uGBYuRGyBpRxj9KiSDG4kPlTxdqg8Kncon+xPvuSy3DoRcoJggQ+ETNM=

On Sun, 19 Oct 2025 18:00:37 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Format the kernel-doc for RINGBUF_TYPE_DATA_TYPE_LEN_MAX correctly
> to prevent a kernel-doc warning:
> 
> Warning: include/linux/ring_buffer.h:61 Enum value
>  'RINGBUF_TYPE_DATA_TYPE_LEN_MAX' not described in enum 'ring_buffer_type'
> 
> Fixes: 334d4169a659 ("ring_buffer: compressed event header")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> v2: reformat based on comments from Steven;
>     add more enum types to aid with comments;
> 
> Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: linux-trace-kernel@vger.kernel.org
> ---
>  include/linux/ring_buffer.h |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> --- linux-next-20251016.orig/include/linux/ring_buffer.h
> +++ linux-next-20251016/include/linux/ring_buffer.h
> @@ -43,18 +43,23 @@ struct ring_buffer_event {
>   *				 array[0] = top (28 .. 59) bits
>   *				 size = 8 bytes
>   *
> - * <= @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
> - *				Data record
> - *				 If type_len is zero:
> + * @RINGBUF_TYPE_DATA:		Data record
>   *				  array[0] holds the actual length
>   *				  array[1..(length+3)/4] holds data
>   *				  size = 4 + length (bytes)
> - *				 else
> + *
> + * @RINGBUF_TYPE_DATA_TYPE_LEN_MIN:
> + * 				Data record with length and data as below
> + * . . .
> + * @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
> + *				Data record
>   *				  length = type_len << 2
>   *				  array[0..(length+3)/4-1] holds data
>   *				  size = 4 + length (bytes)
>   */
>  enum ring_buffer_type {
> +	RINGBUF_TYPE_DATA = 0,
> +	RINGBUF_TYPE_DATA_TYPE_LEN_MIN = 1,

Adding this just to satisfy kerneldoc seems a bit much.

If this is going to be added, then it should be used in the code.

The RINGBUF_TYPE_DATA should probably be called RINGBUF_TYPE_DATA_LARGE, as
it is zero when it is a large event (bigger than 112 bytes).

>  	RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
>  	RINGBUF_TYPE_PADDING,
>  	RINGBUF_TYPE_TIME_EXTEND,

-- Steve
