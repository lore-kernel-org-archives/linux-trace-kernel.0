Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5432863E;
	Thu, 15 Jan 2026 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768520361; cv=none; b=tPOVDvIX1RG/qU4OLWZHkj5HjrapszVzBHWEtmb3gee5FNfrx2+M147Nm6TwSnN040Xi17clGGk/BErJq9fxsg8iZK93evddMa1/e7JMnkfscU+yEAagmJxVvlf280rmpGj2DdMUmaztVfK2GYlF5hcsL+ankQlpT1TdgyX1mFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768520361; c=relaxed/simple;
	bh=KCeARxCrKeSqaMItrCLAnyFOC+geLL3gQ/QCeIKrP0M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DRGoP8jIW5arlTD6GJgq8meT1P97QKEgWWZ2GfaGUUyk37ho6YPfv0/vIEl3hmgkVOEoN8iDhFnlpIDCcDOIbTp5AKkRIhdJ96y72hEX5+uY+wR87CuP1UAY+RRtwaPm4eZyQIIHTozFZ2zMymrEKxq+n9mK1Eg4MvRoEm8AjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RAxIlLnG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RAxIlLnG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3450C116D0;
	Thu, 15 Jan 2026 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768520360;
	bh=KCeARxCrKeSqaMItrCLAnyFOC+geLL3gQ/QCeIKrP0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RAxIlLnGNLMCPBtrDZMsUIEU3zhooo1hJa7Hoq355FoDqojW0Bh8gt7tyyySW+Bh9
	 29+Kl8v/FsTalODBJZQkPo3vx9OL1A+3innwvH4FZaP4W4FeGKNc0wwbPHN4v1ainQ
	 QV/JuRm+LyKKabK+9C+1KjxCyToZ3vd4L3BsizFs=
Date: Thu, 15 Jan 2026 15:39:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, shakeel.butt@linux.dev, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Axel Rasmussen
 <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu
 <weixugc@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Brendan Jackman <jackmanb@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Jiayuan Chen <jiayuan.chen@shopee.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] mm/vmscan: mitigate spurious kswapd_failures
 reset and add tracepoints
Message-Id: <20260115153919.6c3253ba9e81d57efe2d4716@linux-foundation.org>
In-Reply-To: <20260114074049.229935-1-jiayuan.chen@linux.dev>
References: <20260114074049.229935-1-jiayuan.chen@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 15:40:34 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> == Problem ==
> 
> We observed an issue in production on a multi-NUMA system where kswapd
> runs endlessly, causing sustained heavy IO READ pressure across the
> entire system.
> 
> == Solution ==
>
> ...
>

Thanks, I'll update mm.git to this version to keep the series under
test while Michal and Shakeel continue their review (please!).
