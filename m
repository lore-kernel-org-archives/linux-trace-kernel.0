Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8476412B143;
	Wed, 22 Oct 2025 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761163992; cv=none; b=SbQ4uAOSO8zipAof8gbOCNIOfhXKufXlFw5DzE5awFUQvGKNCjh2Zq0m+liLTri8K+a8w/zFOhqie5KrBIo2kGiu+zWmY66ZCkk/bkI/Z/j43Mb5a6GbJtNYQohQhQ2hBsaZvU25BQYKvY+5Vo7yAwOZKI66Y64nrDBz7P088rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761163992; c=relaxed/simple;
	bh=CxePB9i0jLDo9Q1fh5oDc8++po+nTYGNO9aZzoahoFc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SeBqg/lkLkq3WrhuI1pEmApDc4iXGRqgqAotGejPsetA7IB59tKHp+T+ghB2QK45zWxcYDuv3rRD95MoFslF2252ox6iHyu5tfHl7/vAs5LnTON5ZBVB5xRu3JWt8Anh1oLISUxjS6NnWAuH7TtQlKDHs7oC0RWjp9TRj4jo1Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mG1PfqRt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mG1PfqRt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206ADC4CEE7;
	Wed, 22 Oct 2025 20:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761163991;
	bh=CxePB9i0jLDo9Q1fh5oDc8++po+nTYGNO9aZzoahoFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mG1PfqRt0ojegvhfHKA7qey5BJLEG3JKbI3DOCCJpkkQJgdeRsStBWej+dtuAJvfV
	 qZ0SCeMgJEfW/2LUOKPywokhagNy7ZYNCrUdDxz+RX++JyuEL0yWANpmP03Gmdn3Xg
	 gj7fOmq/TYsoymKBVx0U1Zsr5iKE31CGNV97hztY=
Date: Wed, 22 Oct 2025 13:13:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
Subject: Re: [PATCH v12 mm-new 00/15] khugepaged: mTHP support
Message-Id: <20251022131309.c70a2db410d7e82fbadb3d60@linux-foundation.org>
In-Reply-To: <20251022183717.70829-1-npache@redhat.com>
References: <20251022183717.70829-1-npache@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 12:37:02 -0600 Nico Pache <npache@redhat.com> wrote:

> The following series provides khugepaged with the capability to collapse
> anonymous memory regions to mTHPs.

I added this to mm.git's mm-new branch, thanks.

I suppressed the 500 added-to-mm emails.
