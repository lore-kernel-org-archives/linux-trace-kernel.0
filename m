Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4529B776;
	Wed, 22 Oct 2025 19:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162754; cv=none; b=jyV3GbDPQiT5GTU5f3lBfTM/ZTbx8JdJxUxnZETGDawPzDGnCiUESElihs7Q6mAZ2pFSNtQhcnhthH4+U51rPEYDBJ/Cjqh099W7P+dugpx7OvytGBgwzmhCrk9vcAucI6+zAOt4gKFmfKyBAxH4w6Hl3hZCkGJVtBSOYZ886hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162754; c=relaxed/simple;
	bh=Haa0rbzk7uFEUkoM8PNccPAjfwpK0TMmgUFI/7nPrus=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MH/TIzGDiRhKJL3lKJRLfEwC+r/+YAUXCFkVc7DESm5klpKnu0gXQY6JFZH15kw/J3ehgak2dh+AO/N/I6DQTN56nTNFyxBUlMybu0DdLKrCqLA4kLKTKmgTxm/+ALE7HKisLqko0JrAT7OFHnRkVooIGmi7PRurAMmI9cgg1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=tAkUlDbN; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="tAkUlDbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1761162746;
	bh=Haa0rbzk7uFEUkoM8PNccPAjfwpK0TMmgUFI/7nPrus=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=tAkUlDbNTOnRRGLA2FGyHap564fehNknda1C5LM24NN5OumaiRHnf9szaKFZIw8bE
	 XxUA77mQ5kW1oW2tnEM88YAmQmij/B9xz7k4NN9hzCd4RJHeMKSgP8n8/MPAVVGyUG
	 jU+ausY+n4D/78g8H3qDTKvn4VmyxydnE1ge8LUs=
Received: by gentwo.org (Postfix, from userid 1003)
	id 3EDB6401E1; Wed, 22 Oct 2025 12:52:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 3CA074010E;
	Wed, 22 Oct 2025 12:52:26 -0700 (PDT)
Date: Wed, 22 Oct 2025 12:52:26 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Nico Pache <npache@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com, 
    ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
    Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
    corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
    mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, 
    baohua@kernel.org, willy@infradead.org, peterx@redhat.com, 
    wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
    vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
    yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com, 
    raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
    tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
    jglisse@google.com, surenb@google.com, zokeefe@google.com, 
    hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, 
    rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com, 
    lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com, 
    pfalcato@suse.de, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v12 mm-new 15/15] Documentation: mm: update the admin
 guide for mTHP collapse
In-Reply-To: <20251022183717.70829-16-npache@redhat.com>
Message-ID: <bba40f08-1b87-6b57-0e10-6e96e4d7bde6@gentwo.org>
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-16-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 22 Oct 2025, Nico Pache wrote:

> Currently, madvise_collapse only supports collapsing to PMD-sized THPs +
> and does not attempt mTHP collapses. +

madvise collapse is frequently used as far as I can tell from the THP
loads being tested. Could we support madvise collapse for mTHP?

