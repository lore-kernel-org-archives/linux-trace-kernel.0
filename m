Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF933A9C5;
	Mon, 26 Jan 2026 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440161; cv=none; b=fYasQ+h/R1nfhUUn32EK10AihouMyswCxa5IuV3U9D7x8O+6BOSVR4ICX/wHX3rkLrmbcyMysc/v8zJqpH0orA8enogf33pBFJzkQ4iGOjH6ipc4Oo8lNHBEwTHGXIEZz+QsFD/t6VxLcSX3K05qmupHkxPHWz5BWZTPVGvlDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440161; c=relaxed/simple;
	bh=O7b+ioRsB97Y32ljXm5Io/Gt3sgHeua5ZHEKIXJqKsU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c3777hb4uwEFgKOG0KgomGDWx6jAFLLKoVwdBIvLQmol9ZpVMZcK6uMM2823CGsoZ8ri6TzGkzFTXAVWmjs5VWAdexCcRJ29XsnKihmcWmCZH73gwsdnZyFjxzbhgV1H7AfrI0STiGOBDx1AIfDjkrYgjaci3YnCOVsJzwitW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xixd4krr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xixd4krr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F229BC116C6;
	Mon, 26 Jan 2026 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769440160;
	bh=O7b+ioRsB97Y32ljXm5Io/Gt3sgHeua5ZHEKIXJqKsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xixd4krrAPZouZ0meDgc+WkiIS97gm5oqypKP5H+EOjYNxN051VuPeWvpH/140pYk
	 T5d4RZEcxum1+pwa1SMhoya2y2u7TEAegzYymzqZCfTBGR4ibL0aN8cnbPWczQXG3w
	 qeoSEliBViEK/73FvGyRlRB5jt+d4yaUqbCMZoYI=
Date: Mon, 26 Jan 2026 07:09:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>,
 david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 jannh@google.com, pfalcato@suse.de, jackmanb@google.com,
 hannes@cmpxchg.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kas@kernel.org, aarcange@redhat.com,
 raquini@redhat.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, zokeefe@google.com, rientjes@google.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com, David
 Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH mm-unstable v14 03/16] introduce collapse_single_pmd to
 unify khugepaged and madvise_collapse
Message-Id: <20260126070918.cbbd532f4a8813e8a188108a@linux-foundation.org>
In-Reply-To: <0e79a766-811d-477c-83ee-389db29d41bb@lucifer.local>
References: <20260122192841.128719-1-npache@redhat.com>
	<20260122192841.128719-4-npache@redhat.com>
	<65dcf7ab-1299-411f-9cbc-438ae72ff757@linux.dev>
	<0e79a766-811d-477c-83ee-389db29d41bb@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jan 2026 11:40:21 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> Andrew - when this goes into mm-new if there isn't a respin between, please
> drop all tags except any obviously sent re: the fix-patch.
> 

I've been believing this is next -rc1 material.  Was that mistaken?
