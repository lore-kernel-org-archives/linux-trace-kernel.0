Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E53C2BEFFD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 06:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763619126; cv=none; b=RZEtErkLjH72ySNLEYJ8Bt5N/guWnxxnFrUwdpJ+3QKlxYnLcf+3cFLArGsEfppGoxY5QR+SlKv56ubw5gyPWnr+ruRQc/VfF06a6jx62HlFBkuUKgJyX7FarD4PERHcdshgGEiqyJIghYYbZpdMluDRK1YYrfcOYMP7sddvLm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763619126; c=relaxed/simple;
	bh=pyDm/WPAmz9Flk6qnMK5lVHCOsLKwooTzGtOd8kQ9ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpM4DX6JahkFagGqJezRb8uSNr/M4blWrEgh32kQbsh0OwNDE9atnJ29sv2zvhZb3UndJGfg7nEKGFblFepYBYtGzy+JOxpnQaRyhsQTLZfGKb/veXXp8dUxXY8SJwjTivV7S69OMRGxYi8tuMPurm/8NKydHc/lCJsTLmqHU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixJRlqmY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixJRlqmY"
Message-ID: <91396181-1813-4ea1-a081-06f97e703be3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763619111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Eh3iY/0Dx1yebP0GWfJ20Z3mrY3JQYu3VbYsy5OeNlA=;
	b=ixJRlqmYUW1hPKe2xcV+KHpM+JSSHkyJfk9zszG6yWhPbjZfGTICW8vMWpGZI9vjz+FI/R
	ALPqYtWd8htC60MUwW3NmoaHhXYj36vA+J8x3dEhu8jATndgvAxM14mSzfekV2fsaocrvx
	Gu2ajojAgC+vbqu80mUjxZIOhc0a5O8=
Date: Thu, 20 Nov 2025 14:11:39 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/9] mm: add atomic VMA flags and set VM_MAYBE_GUARD as
 such
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
 <97e57abed09f2663077ed7a36fb8206e243171a9.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <97e57abed09f2663077ed7a36fb8206e243171a9.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/18 18:17, Lorenzo Stoakes wrote:
> This patch adds the ability to atomically set VMA flags with only the mmap
> read/VMA read lock held.
> 
> As this could be hugely problematic for VMA flags in general given that
> all other accesses are non-atomic and serialised by the mmap/VMA locks, we
> implement this with a strict allow-list - that is, only designated flags
> are allowed to do this.
> 
> We make VM_MAYBE_GUARD one of these flags.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---

LGTM! Feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
