Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B621C84AE;
	Fri, 25 Apr 2025 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745553252; cv=none; b=N4ZwonGWG2SgxZQPMfPEqC8B1F35AgFss/SXfpi3T6sQyOqXAZNGjw5PAUC7LWfa+giVO0qKRxvDLa98lkMJAwDaWRHbhk0pvGo09sbT3cb9F+DkJqMsNxET8Mf2c9HhRRZadRtjaQ7ubD4WujDPNKn05YXWw4jLsTNdGEHQTf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745553252; c=relaxed/simple;
	bh=hHafEMC1zjbqTr4UVvkBxEJaf9x57Yo6yCgXAZHDcq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TkRPJ0Qg9SCmhxbuxR2Xd/R0f1M5TBeOa9V6sFDLKHYbYSxdu/7T1gV9uuF8wXQ29A7Jg1fyfx1/ntfsSrKdWF+kG093SBGigZivAWaAkjz8+tccIdtV8NCsc1Q/UMyXD802u8xUmFNnUF3w9hpEBQESMHjkbSJ5QHS3i463Hco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ox4Xt8WW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ox4Xt8WW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7shqdOiVhHCcIAIT4yzufh3XKM7CeHmj+fqBHY1a078=; b=ox4Xt8WWCDLVunCladJZnp2dyB
	OCHJx3MavjMVWkclCPptvOeryfBsZz4DQgHRXGU4Iq26m88tvgbl0eA03YCG3SceH2J7HvQ5pdRnO
	oo6rZyqCuo5xj/1liWKPFWWd0tXERxK4ULvxIu2aaami+jeGPPeAM4+H4ykzENbAr8uSJp2jBXi+t
	BhD0uwmqcs/jtX0esHPRSadX1/BEhASMyqKVJNlhmyFckbwkPz7DY1fxoCBgCRrs+FpzamUYzrBJL
	rTuLRqhtZAhtjjQ0tzL3jgZw0MXrPJs+WnRS8Cb38lg1oRWC8+1RHbWfPM55wRyNMCjhTNQ3Vtd18
	anqXgWrQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8A8P-0000000Dhqw-4BxZ;
	Fri, 25 Apr 2025 03:53:54 +0000
Date: Fri, 25 Apr 2025 04:53:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: nifan.cxl@gmail.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org, akpm@linux-foundation.org,
	david@redhat.com, fan.ni@samsung.com, yang@os.amperecomputing.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, npache@redhat.com, mcgrof@kernel.org,
	a.manzanares@samsung.com, dave@stgolabs.net,
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v3] khugepaged: Pass folio instead of head page to trace
 events
Message-ID: <aAsHUZ6HTGFBRyXO@casper.infradead.org>
References: <20250425002425.533698-1-nifan.cxl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425002425.533698-1-nifan.cxl@gmail.com>

On Thu, Apr 24, 2025 at 05:16:51PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> The trace functions trace_mm_collapse_huge_page_isolate() and
> trace_mm_khugepaged_scan_pmd() each have a single user, which
> always passes in the head page of a folio.
> Refactor both functions to take a folio directly.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Nico Pache <npache@redhat.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Yang Shi <yang@os.amperecomputing.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
