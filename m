Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B036C272803;
	Fri, 27 Feb 2026 00:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153367; cv=none; b=IGdecCOOQQypEDcvxEHFaO/QPaQcHb9T8VfUInajThfAYzb483hU6JhT04P76PifCGAxinlGRgnPqHzLH+mbDWkNEYcP3vKE6twtfdxUO5rP00zF2RLPQu5ER9Wn+b2ovbmEbd25RRSUlj0e6QCl3TxrAG7f8QiN30QdcArA+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153367; c=relaxed/simple;
	bh=0ei8WZJE2FrdZHn/eCwJkCgGu/fralSeuheP3WYhs8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgQkbAZNUmjm8Sd54mhGxb4EM2wgvSJlyoIFDjLFDZyTE51EzGukLQTqJPQOpx3iw6QUatLnuqWGwpxmQXcVh18WwuEGQs7Zju6zgZk0pitmpxbyEVA3pbr/Ydy34gxhyB86APD5nVPRbc8TnfmSGzjg3OBcjkBcRMzgIgsendw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW5VLMc4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW5VLMc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905B0C116C6;
	Fri, 27 Feb 2026 00:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772153367;
	bh=0ei8WZJE2FrdZHn/eCwJkCgGu/fralSeuheP3WYhs8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dW5VLMc41+6wsYn1fqjBm5Z2dUQzsrLIbMzBUCUJdNzLWkt+tAliZNJIqTJnGoZiw
	 YZcBpJQwV0umiTacTFuaTGPnJpiWNkDjtQ67O0D4xvd2HmOIoQ383C1NJZg6x0hTWl
	 m9zMc8BqIYuIqA+2QC7M6Z7mAWWV0MIHAGQmg4fIDG/AFlCe8SM4+pyGsHQSuTmmOK
	 WSZzOC+Ss3jHGxwo98vclmX6SceFPgJdF2AiwULvTinadsNnKEqAtfzrcN1Iu6oWZR
	 VR1I//fmXR0l3+taU9//5+KG33gAyIHnLuySx+efG/BhDRB+2aE05s7mh14xOdHFi4
	 JrOhqSjrBIMMA==
From: SeongJae Park <sj@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 4/5] mm: rename zone->lock to zone->_lock
Date: Thu, 26 Feb 2026 16:49:23 -0800
Message-ID: <20260227004924.83661-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1221b8e7fa9f5694f3c4e411f01581b5aba9bc63.1772129168.git.d@ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Feb 2026 18:26:21 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> This intentionally breaks direct users of zone->lock at compile time so
> all call sites are converted to the zone lock wrappers. Without the
> rename, present and future out-of-tree code could continue using
> spin_lock(&zone->lock) and bypass the wrappers and tracing
> infrastructure.
> 
> No functional change intended.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
