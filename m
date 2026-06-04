Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1925C3CAA27;
	Thu,  4 Jun 2026 10:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567851; cv=none; b=IAsKoArTFdQe7PnqrlYh/5w1wVh4CH74fo2kSTop9CHnRbmf9N6co0vUDjBduuOMsb3QnJJoXKWBPGCeJDvJZcLm1yNEtcPll11/ppnRsH2HI9IenD+ggQZNfU9OnYYNvdnsKBbg88T0FvcwkpN4TrP9B90E8uuTao50SEBBMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567851; c=relaxed/simple;
	bh=cltcT7YURRzZTuy0YlL8lZfC1GAWVnKijUYy89tqg7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7+4gc+dT4yLih8koFLi0dbiB8CuCnbFC+gi6uAePem9t2ZkvQpaEC3PM/NeXatTKBkeBeVqUNl3piVr44D2n1iiBNMUnzTr3Zlt+B6zylPxixMatZ8PULVeScBTQtBRlBxEy6OGXIqX05FCCpT2AHwsedNZRxnxKryeqe47UCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGZwQshl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGZwQshl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFE81F00893;
	Thu,  4 Jun 2026 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780567848;
	bh=gkkN3rSsy1x2rUTT5oj5wUdRNrzE7spA48FJt094/So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CGZwQshlxmc2XZ65+AI3hGi3KK0c2VD681fArvK6f2BFHTSRHLswxUOmVCb4sCt1W
	 Z9ma7nQfGtuA7lQiYx2fKdTlqUTmG+BIcgeCQfL2Ft0oGgI/3HNPGgog9ahiuDtETX
	 Xl1geh7I6bXjCsa2AirqS/z5tS58F7lwXKyYMrt7K0Zn7yig38OJG+sWAonnRQKFgI
	 0Laur7+CZ0U1AMh/yCTt6ur8/8bQ2CJgb1YdPFW+rBo7sBOuBgGRUEuBu/3wqv/Vug
	 UnntTmIGdNO1wzr7z87TEUllZ3vkysu/4bTLtGwNaq+Hf2B6fuzhyIqe6KE7/Mjw0X
	 +84CVI1y8zr/w==
Date: Thu, 4 Jun 2026 11:10:32 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, 
	kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
Message-ID: <aiFO1RlpZ7Ki44y1@lucifer>
References: <20260522150009.121603-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522150009.121603-1-npache@redhat.com>

Not sure if already addressed for v19 but I just tried building a kernel in
mm-unstable and saw this (clang 22.1.6):

mm/khugepaged.c:1357:6: warning: variable 'pte' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
 1357 |         if (result != SCAN_SUCCEED)
      |             ^~~~~~~~~~~~~~~~~~~~~~
mm/khugepaged.c:1458:6: note: uninitialized use occurs here
 1458 |         if (pte)
      |             ^~~
mm/khugepaged.c:1357:2: note: remove the 'if' if its condition is always false
 1357 |         if (result != SCAN_SUCCEED)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
 1358 |                 goto out_up_write;
      |                 ~~~~~~~~~~~~~~~~~
mm/khugepaged.c:1352:6: warning: variable 'pte' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
 1352 |         if (result != SCAN_SUCCEED)
      |             ^~~~~~~~~~~~~~~~~~~~~~
mm/khugepaged.c:1458:6: note: uninitialized use occurs here
 1458 |         if (pte)
      |             ^~~
mm/khugepaged.c:1352:2: note: remove the 'if' if its condition is always false
 1352 |         if (result != SCAN_SUCCEED)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
 1353 |                 goto out_up_write;
      |                 ~~~~~~~~~~~~~~~~~
mm/khugepaged.c:1296:12: note: initialize the variable 'pte' to silence this warning
 1296 |         pte_t *pte;
      |                   ^
      |                    = NULL
2 warnings generated.


Is this already addressed in v19/review here? If not could you please address it.

Thanks, Lorenzo
