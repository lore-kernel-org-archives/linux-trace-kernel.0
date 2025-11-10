Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBC5312838;
	Mon, 10 Nov 2025 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784950; cv=none; b=l24c4F4OcCDBrxENRG5Cvc7qyToeoJDtu1EfGR31tC7sORSM1HFWf7bS49jJPlNILMuppS+ZTQ1IzYds8+NyPk9a93RoD6sInGM5MbKAGzovjiQfUyEuIOGtThVqBhwBQhKv3eNA/pSUhQeQihfJkYoh7kX6uV2XWtT352HuO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784950; c=relaxed/simple;
	bh=0KEbmuKS3lKKlkFRd4WwQtzuYwiZEI/mNytmsaIfuLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fk5IXpW9dKY7/qFQBDNEIgJeFK3OrTmjgrc4DpyARJkOYp4jDH38rHsxmSoIWwpXU7H1BBv7SfRMFKPWFVDZWX9m5L6sRLw6gMk/y1Y1oi2dFufEHi82XCW5hrSdC3lwYdewebpGk6+HC1C+34I+w57NRvNA0e81HEMVQ3/4v0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eslnmnK/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eslnmnK/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R0bFMfSQmAiR4R7u4OGiTL9L+yOue9pBltZEhnqo38w=; b=eslnmnK/Fby0VR4zb1/mKeZCLZ
	DOjph/Dw0u5GrkDwKqHSBRXk1gceTtuqJYg4BDmZaKQCemaA5q0mDDEEc0+JCXIzY0tvf2mGzrDO0
	3Hyvbw9h7V76gWnjonOCZ+T/KSmylsVj55R45EOXCYKgzjv7M1bGuJi1ntSJxMYABxdZMUUriUtiH
	hJVShixpS42kQYAQTcMKciFVE5lwxWfYKZcx6WyY8z8WJCl4h6JJ/XcMrQR+QBhYZgOz/bCH6lP82
	iWMr0TVqTcigKcg5e2r2HuFrxa/gAlk2iaFbO4JCzkjnaAq/Zr4THB3ALb6JakqPzz7ojZm3F5WV7
	Hmk61tOg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vISt3-0000000HFKB-2W7K;
	Mon, 10 Nov 2025 14:28:53 +0000
Date: Mon, 10 Nov 2025 14:28:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Garg, Shivank" <shivankg@amd.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
Message-ID: <aRH2pdhMBQ-20IC9@casper.infradead.org>
References: <20251110113254.77822-1-shivankg@amd.com>
 <aRHs3pA2kOr_uD3k@casper.infradead.org>
 <b7313a45-c36e-4390-a0b8-46f412474f86@lucifer.local>
 <39c8a4ed-53b5-48e3-baea-f67cc1e8be4f@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39c8a4ed-53b5-48e3-baea-f67cc1e8be4f@amd.com>

On Mon, Nov 10, 2025 at 07:50:17PM +0530, Garg, Shivank wrote:
> The issue is copying those binary to a freshly mounted filesystem.
> The page cache folios remain dirty until background writeback completes.
> 
> Reproduces 100% for me: fresh XFS/EXT4 mount -> copy binary -> execute -> MADV_COLLAPSE fails.

Yes, but this is an uncommon thing to do.  Really, it's the kind of
thing you do when you're testing something (like, whether ext4 supports
large folios, and whether that yields a performance improvement).
It's more reasonable to change userspace than the kernel to solve this
problem you're having.
