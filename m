Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823E224245;
	Mon, 10 Nov 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782447; cv=none; b=CNN7vxrydMSfj/ZglMaZcRbY7rhCFDGYLCchAOWe8wp5KLv/SdLJUG0ppR95MCeCZW0SV59FVm9iRVd9zj43l48KBkcIGLR/In7GWPQ/kezeSHKVuRRPc8s2/qqGihLbZ7JXRZBRo6wq6Mu2bUdxx1WBGjGsn1Vd1M+2tQEEW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782447; c=relaxed/simple;
	bh=iUCCsqraBZeL1D33i6SPrN2J9VYix1PBToVkbN2tT5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BljOmNbFm2IjskUvb2zBNLWeOTP9GnOjeJ+mnYUlAyofUIDEgQt6hY6qT7evbS6w3eMHXH1LUgJ/WdUb9TiSCbPsxHWnTL2MGW1GNEcvJVJlUQUC4ncgHBsXIBP3i6Mh5S7IjyZybvO1+EJqKIydO1YRMrWEIXRZ93hA3tnQwD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dw4eMTIO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dw4eMTIO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=goqVguA1QAyVzrtFHbWfsQhLgAORjRs2GF7ed8xJBeQ=; b=Dw4eMTIOCLZh+8e9syvo8UvtPa
	85tzOjadzFjPNK67JGgZWaLk9mFqs6FCAYeNDGQcUOjfoKmcH0Dc1+UsYZRhQefp1lNPMF+KcsSWv
	mcc71dwR8/orCgUUbJuexZQPJXOHleDBpxxtJUjR6vyv7fLN2Zr6NC54Bc101vKVuIwv3ukE47a94
	rJWKPXG74Qp5cEHpAOOIDNKMemct5svlpimMhaKYksbPYhUWEfHtVzhGy/YItZqUlXeHGljJqWS0n
	sCzqjRkn3jZq1YZs5r9EJq7DzKAt943PB1l1TXhc52b03ha9DnU5PiYAOW6RJAv8LHKl2ztROgiOw
	LN9OlODg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vISEg-0000000GSVV-41BN;
	Mon, 10 Nov 2025 13:47:11 +0000
Date: Mon, 10 Nov 2025 13:47:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Shivank Garg <shivankg@amd.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zach O'Keefe <zokeefe@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Branden Moore <Branden.Moore@amd.com>
Subject: Re: [PATCH 1/2] mm/khugepaged: do synchronous writeback for
 MADV_COLLAPSE
Message-ID: <aRHs3pA2kOr_uD3k@casper.infradead.org>
References: <20251110113254.77822-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110113254.77822-1-shivankg@amd.com>

On Mon, Nov 10, 2025 at 11:32:53AM +0000, Shivank Garg wrote:
> When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
> text sections), the pages may still be dirty from recent writes. The

That explanation derails my brain entirely.  Text isn't writable!  How
can the pages be dirty and file-backed text?
