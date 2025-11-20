Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AC42C0F68
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617750; cv=none; b=m46a0SSwZufbCzkny9PY0oYj8SR41INWrABDK7UbqqGI+Jf/sXd8kYgUh7FMBBKE8pklcw18DWiJo64Rcz3BDUpEKETkcJIuoaLtURa3cvli50tad9vKcy6xP7EYe3P/EUcePY+LvdkHigFvFdVytZWB241wpwYZkseC2kf0/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617750; c=relaxed/simple;
	bh=RA75ANsCFli71Nin/P/uUZERLhitDgNZaMMrwAM1Wis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CNEx8AIi4qudoXCKb4bWRqKTo1dhoioNbhFInIdsCAIXjt0KwD5gpx2ToslLyLftn1pdBF77PwQP8jSIyPqR2R1cXLfCCbYvEdRbEc4nCD5BYisBxuU4OaXMwi7nzZChunjwpfr9qpfDr+NqoyoIeuFli2sLpbTUoJHVMPmbonQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GvOQbs2z; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GvOQbs2z"
Message-ID: <594f5fdc-567c-443b-8bec-313986bce9be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763617742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHYXCj+PBmqDHq20QynsVeuFscEdivmHkOXz0KSXfp8=;
	b=GvOQbs2zmSPWZv/p9mDvkSsQ6fkjxisB/IeYsK00ktF6cjhDx1wOZ2BcDcuJEyqdUUanzP
	QeHfedJhQbV2UHkvzxh7TdAf2BD9vFqBzYQ3IMPMglOfvAlJ4zmk7w4rq1kz5ysOLkK9Ez
	QGFRlpNAOkuAX+IK9Yw1wiWBOa7KtJ4=
Date: Thu, 20 Nov 2025 13:48:49 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/9] mm: introduce VM_MAYBE_GUARD and make visible in
 /proc/$pid/smaps
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Andrei Vagin <avagin@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
 <cf8ef821eba29b6c5b5e138fffe95d6dcabdedb9.1763460113.git.lorenzo.stoakes@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <cf8ef821eba29b6c5b5e138fffe95d6dcabdedb9.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/18 18:17, Lorenzo Stoakes wrote:
> Currently, if a user needs to determine if guard regions are present in a
> range, they have to scan all VMAs (or have knowledge of which ones might
> have guard regions).
> 
> Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> operation at a virtual address level.
> 
> This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> that guard regions exist in ranges.
> 
> This patch remedies the situation by establishing a new VMA flag,
> VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> uncertain because we cannot reasonably determine whether a
> MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> additionally VMAs may change across merge/split).
> 
> We utilise 0x800 for this flag which makes it available to 32-bit
> architectures also, a flag that was previously used by VM_DENYWRITE, which
> was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> bee reused yet.
> 
> We also update the smaps logic and documentation to identify these VMAs.
> 
> Another major use of this functionality is that we can use it to identify
> that we ought to copy page tables on fork.
> 
> We do not actually implement usage of this flag in mm/madvise.c yet as we
> need to allow some VMA flags to be applied atomically under mmap/VMA read
> lock in order to avoid the need to acquire a write lock for this purpose.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
> ---

LGTM! Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
