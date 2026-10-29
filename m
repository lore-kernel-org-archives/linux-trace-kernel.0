Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284582;
	b=N6zQkInPM+B46ovxyU5Mi9hjssPyRNWdmB2taFBU2Kbm3sVIyuAwUpzYJpuHzT5NqWPR
	 u/tSX7lJpgVmZkbV8JszPLdP3spQOFnkgRHQ81cNjHIfENGY49NTuUBQ0HwBUR2lptRQc
	 DavbhuT+puItzD3GkeDNcmw/KCnGAtCXfnPskIJlBKOLOiHCVD2Ty7qJ2A+qPO8gOrbir
	 ik3AXEKBHzuuWhdz4hLA2ttOzsVJ+tc5//GOYRvfJWkzqZLd+BZNGXuncoNJGDw2esu7W
	 U/TwXiJQld3GVdeBIlU2ZjpEYWsf530j57+84Vgg9EkT0cPqRw3uf0oC8W5H0qq9v8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284582;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=DLWowW4hGT/hXcWpOks8o4FAs7pYlKMrY5y/WjiATro=;
	b=BnPGdp9r/WaUK+7KO3R7jNyBSRH8UzEjCOF6oYWEKFBAcDoVBNepA++UWR6cbw3Tyzq9
	 FvBsa4R8ulDlkqgQNhMaNsd8REJXJDrj9t/jGJjgKMIWeE2OntMijzHYrkRJJDxM2zdAu
	 Q0P4XEKxpX3yfbxBB7Sv1XuOzyUoUwaRV+1nNpJ+2uqwuxXe3EVYKAAtJwCxbuFppkZ10
	 Kt66rmA759yRPPzlp4eoM9++KN40F+kFUkX9P9a6pK7r51yHRt1fnCUN4psFaHbd+xeTj
	 91QbSMVHDAU85DJOhuCP6XJPSovVZ0Sd2abRkmTLxGCMa9dJVCBNdl1NAnFQdNYAC8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=K3I3DdeR;
	arc=none smtp.remote-ip=216.40.44.12
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F45606A31A;
	Thu, 29 Oct 2026 14:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3F45606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=K3I3DdeR
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 911A3A0461;
	Thu, 29 Oct 2026 14:36:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 937A334;
	Thu, 29 Oct 2026 14:36:16 +0000 (UTC)
Date: Thu, 29 Oct 2026 10:36:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Xuewen Wang <wangxuewen@kylinos.cn>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/shmem: trace swapin results and order fallbacks
Message-ID: <20261029103615.31dff835@gandalf.local.home>
In-Reply-To: <20261027094014.2432692-2-wangxuewen@kylinos.cn>
References: <20261027094014.2432692-1-wangxuewen@kylinos.cn>
	<20261027094014.2432692-2-wangxuewen@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jbyz4xfxhejg13gck3udfxaue4a38r7w
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 937A334
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18EBqo80D1z2/O46sIMk6OrtHEvAtYnb1w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=DLWowW4hGT/hXcWpOks8o4FAs7pYlKMrY5y/WjiATro=; b=K3I3DdeRwaQjfEqIygbbx5JB4QSDy4p7NZNvhe3ryA2vsvHuFWEv7JWiDsQDy1C4h1r4kxbDy2y8qmK+XNqtWrz7nu6zKQwUJXkVxavInVqEfxiqpwckrmGBPwNg/NXmYHlw1fU90vYuKhofvKQhukH8CXXt4DJbRUbF35JAwTU=
X-HE-Tag: 1793284576-636695
X-HE-Meta: U2FsdGVkX18FG5ELwnhgwqGWp4TOyMCKVvMh0nOLljHoZAWZvqkPobeGn9hkoRe9fXEnuQkTnHMUSSorjKbZfk0N7mA0ZHurJm9PkjGeRRzdM8Pp/iIhUXytEPGehituShw6jsmteiCDkiylzLv7C+FvfDRK6+PM7RUjagJthakBBPXWqo7eyTPc0KwZSy9HT/KaPft+N9rXokXpm+OC+Czy8HewPnxhqHx1C3IwlrK/zxidVIMhR6jL0eu/Ck2EUyyHyLwUZD8V86VZw815lUu+7mDmNzxu+riUBaUtuw2AI5Kv4mh7S5KHCFm8b8K0

On Tue, 27 Oct 2026 17:40:13 +0800
Xuewen Wang <wangxuewen@kylinos.cn> wrote:

> +TRACE_EVENT(shmem_swapin_folio,
> +
> +	TP_PROTO(struct inode *inode, pgoff_t index,
> +		 unsigned int entry_type, pgoff_t entry_offset,
> +		 int requested_order, int actual_order, unsigned int path,
> +		 unsigned int fallback, int fallback_error, int error),
> +
> +	TP_ARGS(inode, index, entry_type, entry_offset, requested_order,
> +		actual_order, path, fallback, fallback_error, error),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)
> +		__field(unsigned long, ino)
> +		__field(unsigned long, index)
> +		__field(unsigned int, entry_type)
> +		__field(unsigned long, entry_offset)
> +		__field(int, requested_order)
> +		__field(int, actual_order)
> +		__field(unsigned int, path)
> +		__field(unsigned int, fallback)
> +		__field(int, fallback_error)
> +		__field(int, error)

There's a lot of holes in the above structure.

dev_t is 4 bytes in size, which means you have a 4 byte hole between that
and the ino (on 64 bit machines).

And another 4 byte hole between entry_type and entry_offset.

Move the longs to the beginning and the ints after that. The order of the
structure isn't important for the output, but is important for saving ring
buffer space.

-- Steve

> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev = inode->i_sb->s_dev;
> +		__entry->ino = inode->i_ino;
> +		__entry->index = index;
> +		__entry->entry_type = entry_type;
> +		__entry->entry_offset = entry_offset;
> +		__entry->requested_order = requested_order;
> +		__entry->actual_order = actual_order;
> +		__entry->path = path;
> +		__entry->fallback = fallback;
> +		__entry->fallback_error = fallback_error;
> +		__entry->error = error;
> +	),
> +
> +	TP_printk("dev=%d:%d ino=%lu index=%lu entry=%u:%lu requested_order=%d actual_order=%d path=%s fallback=%s fallback_error=%d error=%d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ino, __entry->index,
> +		  __entry->entry_type, __entry->entry_offset,
> +		  __entry->requested_order, __entry->actual_order,
> +		  __print_symbolic(__entry->path,
> +				   { SHMEM_SWAPIN_LOOKUP, "lookup" },
> +				   { SHMEM_SWAPIN_CACHE, "cache" },
> +				   { SHMEM_SWAPIN_SYNC, "sync" },
> +				   { SHMEM_SWAPIN_READAHEAD, "readahead" },
> +				   { SHMEM_SWAPIN_POISON, "poison" }),
> +		  show_shmem_swapin_fallback(__entry->fallback),
> +		  __entry->fallback_error, __entry->error)
> +);
> +
> +#endif /* _TRACE_SHMEM_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
