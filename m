Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2747C2556E;
	Fri, 27 Feb 2026 01:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154065; cv=none; b=rFPl5qMscGEJheIesrjsG+j+EHXLa4IhzvosPR4DLPKKFVSFlfhWCNK47hfS3l6JHU5ryZAZp4pkRNEychd++kPo2n1ErK4QRDDGcNalbnzoz4D/KKYOhE8PixjeclrCSPncDrV1rRynpGtIq3tpc6piEcPehqkc+dbzxpCw74I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154065; c=relaxed/simple;
	bh=4YdI8/6MUimXC2VDFbWkxlvCxNeEa5FLhacHbA0d8x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeHVP26t+jwhffOGm7yVPv0N7YNnZe6Z8njf8KKxBQXQo7Xo60puT9lsrkAeNj6UnYkJQzZm/YwyY4GgKPgy/wC/l1IH8iTkJc+B9+euolMDisyytUBS4pFm5dBmDqo/t04pDOrBhBOH5i8cUy9eNrjXYJ5WqJh4gWcd7spQYPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhOiihU7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhOiihU7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9B8C116C6;
	Fri, 27 Feb 2026 01:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772154064;
	bh=4YdI8/6MUimXC2VDFbWkxlvCxNeEa5FLhacHbA0d8x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KhOiihU7ZB9Cr8MQYmAF08bXEpvDGKdqyps/7oS4ne/TiBggviba58jvCLU13BuA9
	 cIdn11OYqUHxEqH2i5ABKOPhiqRfk0NddR8fd0m3/xGNGekEcvWPG+5/allEzxFbme
	 D46WiENInelFfKP9o0GYV9RERbTkIZAYmS5e58MajYx5hxHnc4n3sVjHm6lWCnyzpR
	 LnzfwXodKZlRd6qCK/mWJEe8iITd53SLpGiJr970Ygn7jxMQ1N6fxRo++Fn4xKGDEo
	 7bbpKx4U/9xbkHRjC4U5ZIOSOkOrc/1XaxIoq0lGrBTbRPfLuEyf0gZx+2t1bXrm71
	 1o/d8n8JrMNWg==
From: SeongJae Park <sj@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: SeongJae Park <sj@kernel.org>,
	Dmitry Ilvokhin <d@ilvokhin.com>,
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
Subject: Re: [PATCH v3 1/5] mm: introduce zone lock wrappers
Date: Thu, 26 Feb 2026 17:01:01 -0800
Message-ID: <20260227010102.83789-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226195355.611ec7f3@gandalf.local.home>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Feb 2026 19:53:55 -0500 Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Feb 2026 16:38:55 -0800
> SeongJae Park <sj@kernel.org> wrote:
> 
> > checkpatch.pl complains as below.  Should be ok to ignore, but, may better to
> > kindly make it silence?
> > 
> >     WARNING: Single statement macros should not use a do {} while (0) loop
> 
> Hmm, why is this an issue?
> 
> >     #116: FILE: include/linux/zone_lock.h:13:
> >     +#define zone_lock_irqsave(zone, flags)                         \
> >     +do {                                                           \
> >     +       spin_lock_irqsave(&(zone)->lock, flags);                \
> >     +} while (0)
> > 
> 
> I know this is checkpatch and not you complaining about it, but I really
> think it's a useless complaint. I can see it better as a do { } while (0)
> because it is creating a "function" like feature but can't be inline due to
> flags.
> 
> This is one of the reasons I still never use checkpatch.pl :-(

Makes sense to me, thank you Steve :)


Thanks,
SJ

[...]
