Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F79239072;
	Tue, 29 Apr 2025 17:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949062; cv=none; b=VhAdsCpJkkU1eyWdOPObPXnQW4yS7sJESS80FfkFHkBCoCeOdeO1+0e0c9ta4V4y3OkYcms32eCn5cbP08a2S1MxQCa4zWVKej2XkgtPU0gOsopIR2h1gEyydY3B1H034MGbnQgLW5tth1bNfzSg8MlXzYybcaCOMgmg7TBjQ48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949062; c=relaxed/simple;
	bh=Iw8Wa9ZRgOojjhRhHP4GvLG9MuFK2w+E50QoyC4hl9o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZlcGLcwZaZFoVDRI0892CMIHBhxJ8+E3kjwAobKqcOCaOcQ9DPyHw/0iSjrYsgttHOXR1BGbtYiEFR/jkQKqGj0J/ySNQwvkGtXIuQ9NYS+hR6DhAvZVufGAvhMOO7nSe4iEP2Nkszx7seCevvaat932iQFr14VcKfzCokGQAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=VOtLQ77d; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="VOtLQ77d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1745944729;
	bh=Iw8Wa9ZRgOojjhRhHP4GvLG9MuFK2w+E50QoyC4hl9o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=VOtLQ77d9bEAh6Py00ThK7o9ARTip/gI+OiwbQ5xwG4pls1/BJvFgPuz9YlxB8MdU
	 vx9YzPtsNJTA2qqHHAsFBiH5nlzRqVspHwUeziWJ86SejooDmGtPURI46gsy2l6Z1m
	 GVnlmFoRBPV/qc9zHkOpq04XVhhrI9wTE4Zy9Z04=
Received: by gentwo.org (Postfix, from userid 1003)
	id 1EE09401FC; Tue, 29 Apr 2025 09:38:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 1C3E2400C6;
	Tue, 29 Apr 2025 09:38:49 -0700 (PDT)
Date: Tue, 29 Apr 2025 09:38:49 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Nico Pache <npache@redhat.com>
cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
    mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com, 
    baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, 
    willy@infradead.org, peterx@redhat.com, ziy@nvidia.com, 
    wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
    vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
    yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com, 
    aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
    anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
    will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
    jglisse@google.com, surenb@google.com, zokeefe@google.com, 
    hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, 
    rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
Subject: Re: [PATCH v5 12/12] Documentation: mm: update the admin guide for
 mTHP collapse
In-Reply-To: <20250428181218.85925-13-npache@redhat.com>
Message-ID: <6fd003dc-2a2d-ca15-e7b6-9af988fdbc3f@gentwo.org>
References: <20250428181218.85925-1-npache@redhat.com> <20250428181218.85925-13-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 28 Apr 2025, Nico Pache wrote:

>  THP can be enabled system wide or restricted to certain tasks or even
>  memory ranges inside task's address space. Unless THP is completely
>  disabled, there is ``khugepaged`` daemon that scans memory and
> -collapses sequences of basic pages into PMD-sized huge pages.
> +collapses sequences of basic pages into huge pages.

huge pages usually have a fixed size like 2M and are tied to the page
table levels.

Would it not be advisable to use a different term here like "large folio"
or "mTHP sized folio" or something like that?

