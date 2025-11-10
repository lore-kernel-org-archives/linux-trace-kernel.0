Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFD1E25F9;
	Mon, 10 Nov 2025 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783439; cv=none; b=jRPrN+AcMgmXOrMNp8vQzcwZcsDUllfAst/LYQHv4WqrleIMqKG6KjDcejn37Espd/IkIxurEqrEDT4pAsu3bI5SEmXG6KeLJuIvvtVnDkv0DhC9OSYCcVtzL6rGS0xJF1IyYysPwOUqP77VdNCqvgvQfYxHkyNppBBRVbKjVTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783439; c=relaxed/simple;
	bh=/Y98uMcnJToTBczwgLqc2/K1GX9+g9UTB5e0jGzo9q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnkRYzbjKvTdENWvmjYffkgoZU/cXp2Qng76ucg24zK5K4T9wJFU7vZfgdtmTICRLfA/iXQGLwD3adiC9uGCVKlQfaEHkkxx+RuhgRDWPsgFc3G0HLgUEPaJXE84SY+YOVdxdvc2bRvfsWrzU4PhYFx+DVQVPNCK/NSG+Mtp3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=APBOPyKN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="APBOPyKN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wTntukXdaVFjnftz5WTTeF+x0iVhUlIwTUQPH67TnYI=; b=APBOPyKNe6JNBjwvNL5ANy0RHS
	6FNALoWP8USB0oxkWef8vyXGcUJ8QSiW6uIkCWiB/EIfRyqrImuDNRpbA9wWzVBdmn68foHJ1kDIh
	JLGqmtmQNQJEA9SXC9s2V5O14WEQyyPZaE19sGkWZYxsTx1WR5ZLU07/9gMwST/Zlo87g67UQMqQA
	HpbrFRnKHlhUxREbF+vv5DVk/ZNxmOF4QMCzG7IYGXk7CX/SZRGXr9miHifFgv2Gxkdf/JW7juAZk
	/reX6S9bZHznt9sJo3+2btv63m8oA7k86Bqwlg0JYGbVworWUEN3A3Nd0KlZLMiFOmTG5Wl+yIZoy
	tUGoVX8w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vISUh-0000000GkmP-35kQ;
	Mon, 10 Nov 2025 14:03:43 +0000
Date: Mon, 10 Nov 2025 14:03:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Red Hat)" <davidhildenbrandkernel@gmail.com>
Cc: Shivank Garg <shivankg@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <aRHwv3XzI4XHcLPP@casper.infradead.org>
References: <20251110113254.77822-1-shivankg@amd.com>
 <aRHs3pA2kOr_uD3k@casper.infradead.org>
 <9b622374-778a-4459-aca9-4eb406a58516@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b622374-778a-4459-aca9-4eb406a58516@gmail.com>

On Mon, Nov 10, 2025 at 03:00:32PM +0100, David Hildenbrand (Red Hat) wrote:
> On 10.11.25 14:47, Matthew Wilcox wrote:
> > On Mon, Nov 10, 2025 at 11:32:53AM +0000, Shivank Garg wrote:
> > > When MADV_COLLAPSE is called on file-backed mappings (e.g., executable
> > > text sections), the pages may still be dirty from recent writes. The
> > 
> > That explanation derails my brain entirely.  Text isn't writable!  How
> > can the pages be dirty and file-backed text?
> 
> Files are writable :)

Well, if you're root ...

-rwxr-xr-x 1 root root 158632 Jun  4 11:14 /bin/ls

