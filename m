Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972102E36F6;
	Fri,  4 Jul 2025 21:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751663664; cv=none; b=N5WoI8mH3spVrZtSkPrqrtm4iX0QUidXW/13OHWIQriDXDOy8Jco16iwKJvzBtLeIosyAhC0iJCYsn8HB3WudNYnWSIerfiZjJqsYP2h12g/YqZOIo1VXRPtLVZK9t6tbJmEGTc1pPECc16IUKJKtjx3fg640DgTeCW10ZIRc6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751663664; c=relaxed/simple;
	bh=4ZXjjIEFeyNziz8nI9hyycb93PeMN+TlTyQFX8ZUBy8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VGRgpLe6Ps+ifPRfesxz/MDIiCcq1cgsZG392FpvJoV8QzVLDdmzXqUDcfmmrDmTtLLfnbuUlTABgyyc8iJyk+rB7Brkbz3dn5Mn6CSSFdMUa9K6mBsnzM5uJa31c2VvNmEuKXQTTyQhlvkuxkt7qeaIvd2lyJXzmz6tmn5DxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P+mguad3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P+mguad3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8B8C4CEE3;
	Fri,  4 Jul 2025 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751663664;
	bh=4ZXjjIEFeyNziz8nI9hyycb93PeMN+TlTyQFX8ZUBy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P+mguad3o1QgfcWmYUtbI6/FsgHbbB1PA5+bCjq2nLDTkFt6v2jx4aZiXAWx0pGHX
	 GYiIki4MzU5sYOZthXKw5Qdw3sFPMG9PgFKOFzykAvnsiUDIk7rb95YkqaazLj6zw4
	 3dbkLeWZtRfOmQ8v6ZKZpz4JUS1oNnQLE+gi45Rw=
Date: Fri, 4 Jul 2025 14:14:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, david@redhat.com, ziy@nvidia.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
Subject: Re: [PATCH v8 11/15] khugepaged: allow madvise_collapse to check
 all anonymous mTHP orders
Message-Id: <20250704141422.359c89146ad69512b9be4902@linux-foundation.org>
In-Reply-To: <2f6d9541-8083-4d3c-a9c1-cba0d5bf98a0@linux.alibaba.com>
References: <20250702055742.102808-1-npache@redhat.com>
	<20250702055742.102808-12-npache@redhat.com>
	<2f6d9541-8083-4d3c-a9c1-cba0d5bf98a0@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Jul 2025 14:11:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> On 2025/7/2 13:57, Nico Pache wrote:
> > Allow madvise_collapse to scan/collapse all mTHP orders without the
> > strict requirement of needing the PMD-order enabled.
> > 
> > Signed-off-by: Nico Pache <npache@redhat.com>
> 
> I am afraid we should drop this patch from the series, since Hugh 
> explicitly opposed my modification of the madvise_collapse control logic 
> in this thread[1].

Well it drops easily enough.  I don't know if it compiles yet.

Nico, can you confirm that you're OK with the droppage and that the
series is still good without this patch?

> Moreover, since we have not yet clarified how to handle the conflict 
> between the semantics of madvise_collapse and the THP interfaces, we 
> should keep the current logic[2] (means madvise_collapse still only 
> allows PMD collapse).
> 
> If madvise_collapse is to support mTHP collapse, there will be more 
> semantic conflicts to discuss.
> 
> [1] 
> https://lore.kernel.org/all/cover.1750815384.git.baolin.wang@linux.alibaba.com/
> [2] 
> https://lore.kernel.org/all/23b8ad10-cd1f-45df-a25c-78d01c8af44f@redhat.com/
