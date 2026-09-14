Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C7F47A88D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391536; cv=none; b=mnllF2T0BjdbIUKnYmzJkf+zrXOIWa0gX2SD2PJiVvA2YCIF0VidXTL/Q49CGgimFX6vOene+ErQ5BXPGdFkKGvkAyf+J2xZF0If3qbb0V39zDBC+lmiqMcDGC1Nc/EqLaOy3NC+xMwCMUUyq+04fMfn4O+PavjQ2dTXUorkhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391536; c=relaxed/simple;
	bh=DDIVP9QeWvK9BQV73SH2LgUy+VjBfNmrr7VT2yR5e28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpvFJ/6Albn67bzLL/vzoc1TxqjJFziDp7goWhrd7Uy/UFM1XG+WzzFtvPDIO8X1v9/N9gUTMf2SD6R6VLx6kgbrvDMbps86FZQ7ubpTEZGeJcJbQ/eA3mt+ntxhJlb4xU9fPyffzNiD5QK5yZ917Gxm1gf5BRnHZh7AeZqI8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Adlr7QH9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Adlr7QH9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BSkgsCXXSaTPgBKl80Odrr1kR+LQr21Smw9P9P2OQKU=; b=Adlr7QH9fR3pIyxrg02sp5cY3s
	zrb/yKefwMnh/aUgYSnMP0tUKjZa0ZeX5KoFX1azL1106iEZ5iKmUlcgEeCEXv8oW6apO/fMT7HVh
	x/sj9m8V/sCBQPfvZe0YqGhW8FtmvCBK4E5B0X5zd+JRrwrCoCnl9QT4HqRBVDfqzPfmSNinFPbT2
	dCFWt5ry2V4Aj8T3T0V7nmEit5nFYPEWi73zTno9YFsQIRNqBwcRUwZAphIEXXxeMSD3RyIlDUZAa
	fOCchdZ3act8kqJaznWmg+nqzKp8k4GPM03sjllak/qQPrM7iobgHa3gopYFywF1YajhaZ7+RtBjH
	+ptAO6aw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x66Te-0000000B5ND-0kYQ;
	Mon, 14 Sep 2026 13:12:06 +0000
Date: Mon, 14 Sep 2026 14:12:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?cWl3dS5jaGVuKOmZiOWQr+atpik=?= <qiwu.chen@transsion.com>
Cc: "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"david@kernel.org" <david@kernel.org>,
	"mhocko@kernel.org" <mhocko@kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3] mm: vmscan: rework lru_shrink and write_folio
 tracepoints
Message-ID: <aqfypahso0rVnJS9@casper.infradead.org>
References: <20260914072433.39636-1-qiwu.chen@transsion.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914072433.39636-1-qiwu.chen@transsion.com>

On Mon, Sep 14, 2026 at 07:24:37AM +0000, qiwu.chen(陈启武) wrote:
>  
> -	TP_printk("page=%p pfn=0x%lx flags=%s",
> -		pfn_to_page(__entry->pfn),
> -		__entry->pfn,
> -		show_reclaim_flags(__entry->reclaim_flags))
> +	TP_printk("folio=%p lru=%s",
> +		__entry->folio,
> +		__print_symbolic(__entry->lru, LRU_NAMES))
>  );

Why is it useful to print out the folio pointer?  Printing out the PFN
made more sense to me.

