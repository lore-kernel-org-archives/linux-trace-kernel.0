Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED1334D3B3;
	Mon, 10 Nov 2025 14:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784273; cv=none; b=gYhdAtKZVGdhQMxiFfLNsxskEaLZUSft5+rUcE5UhlD1jlaW9RZIQSEi7IxRV/XwBwSiexoz3VxqWe0uVMNtokhfScvj0Tk5cIOuoSPYMX1p+ZuDR8hXbvDQ06cffzvfCMzYd7Sh5MGZJr4CkYAZE+6Apqs75ZFniFGuOj2XJbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784273; c=relaxed/simple;
	bh=HBb3SJ5uKcYn9Er28YJ1af3cWeYwy7ykkfklbFTsbk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYvLmqDB/cUnvk/wUNznBVUNxWnvs5p6EHfrDFENI8ZEdeaUy99qLCV0Qh3Gxg9YcHutX/ZKqLyogmHpEdgl00csV9XVrDgeENflv2JtIl9+5hzoG8SGAp2lfAKreZIqQYFBAtO9eNG19sbyyhh7sQwWXxplIhvh1JFh6ZR7Dqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FK5/Drkh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FK5/Drkh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W6YiZUPiMldDbZBiOiBNFbkvDbr2B7fQ67wc4kW4+s4=; b=FK5/DrkhPSNaY5Y1lv3Qbw3peA
	kHgYT7Z6hGlnUjTQ9CKx2OOfYddM6ZkFV1xofLnq3yeC45RN0EXvJ5nCIeZ52NPHja4WFu6WU3D7S
	fjmTYVL23H+18iIxjrS3Fo2MhxmBcn+T/nBf1XHVDVh7EaLtLHM2Uso44v2nzYNyGAKh4F9mf++uL
	yjaRujDRYXROsRcF0Q77LDkUHzomisnPSavyPOVGZv/MR+1FGGMZOHFw5aTOIf/Os3FH6YtEBntDH
	dE014QtcupcatIpKw2A0fvjK4eZf1RphHQdl9qcY2hV6Y99GTpK99uEsxvt2kLJaY8YiplIU4Q48g
	e9H795Ug==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vISi8-0000000H256-34vg;
	Mon, 10 Nov 2025 14:17:36 +0000
Date: Mon, 10 Nov 2025 14:17:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Shivank Garg <shivankg@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
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
Message-ID: <aRH0ANHpP8VN1j9r@casper.infradead.org>
References: <20251110113254.77822-1-shivankg@amd.com>
 <aRHs3pA2kOr_uD3k@casper.infradead.org>
 <b7313a45-c36e-4390-a0b8-46f412474f86@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7313a45-c36e-4390-a0b8-46f412474f86@lucifer.local>

On Mon, Nov 10, 2025 at 01:52:46PM +0000, Lorenzo Stoakes wrote:
> On Mon, Nov 10, 2025 at 01:47:10PM +0000, Matthew Wilcox wrote:
> > On Mon, Nov 10, 2025 at 11:32:53AM +0000, Shivank Garg wrote:
> > > When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
> > > text sections), the pages may still be dirty from recent writes. The
> >
> > That explanation derails my brain entirely.  Text isn't writable!  How
> > can the pages be dirty and file-backed text?
> 
> Because they just compiled it and it's not been written back to disk yet :)

So we can avoid these patches simply by changing userspace to call
fsync()?  Cool!
