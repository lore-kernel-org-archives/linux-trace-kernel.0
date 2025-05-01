Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7443D6A;
	Thu,  1 May 2025 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746116134; cv=none; b=ixWjM6UKddzeoxa+TmM9NXSiiFCRy7f1Gtdfpumvl77wknLNVjVq/sgQjcialABNu54G1iRsD5UkB7mZegdcgIEQKLa/ZEtLyTcpFh6x+3mXwbRUooAu4f0nVUNEp4hZ7tGic7SP+1V4OozRWJ9O8MAcx6XdAo8rY7gQVShnXwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746116134; c=relaxed/simple;
	bh=k8FtybKL4CKMrKSrIJbO1OaQn6GHbqIQRu7P92f7Z9w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WBIoHO0eQg4QtnDwezNOxpMKXpXf8oFAkcGJnuviOz9NjjOpWh1IPhFERKSHh2eM6ISr1X3I09HnBsHR9RMnPH7AAMFJpqMrC9pN/VgvDmlS7wkkzhl2LS/vlVvNUJ0wT09FbFe26OaI1ifKkVj0oNioraP+rqK7uCVsEBGIdWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=sacBgbx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="sacBgbx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1E3C4CEE3;
	Thu,  1 May 2025 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1746116133;
	bh=k8FtybKL4CKMrKSrIJbO1OaQn6GHbqIQRu7P92f7Z9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sacBgbx6EAZJTpaAz4VycJ7MUVK9LMqdPXXqQea7iDpf9CGxTuaJ9khiLNnmqJlaV
	 +P2r4puO4Z3QjwjXSo5nqPhbHZ2s8nTnvGmMLFzbiv4cAOyWSRxIyxrBUAsKVtsiwR
	 DrMvKUEoZKnQUAyrXkjokOVLkrEdXojqmUGpvvIQ=
Date: Thu, 1 May 2025 09:15:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com,
 willy@infradead.org, peterx@redhat.com, ziy@nvidia.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 Jann Horn <jannh@google.com>
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
Message-Id: <20250501091531.a0fb2dc6b5a7a198894d3882@linux-foundation.org>
In-Reply-To: <7a81339c-f9e5-a718-fa7f-6e3fb134dca5@google.com>
References: <20250428181218.85925-1-npache@redhat.com>
	<20250428181218.85925-8-npache@redhat.com>
	<7a81339c-f9e5-a718-fa7f-6e3fb134dca5@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 May 2025 05:58:40 -0700 (PDT) Hugh Dickins <hughd@google.com> wrote:

> There are locking errors in this patch. 

Thanks, Hugh.  I'll remove the v5 series from mm-new.
