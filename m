Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C633EBF10;
	Fri, 20 Feb 2026 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771550223; cv=none; b=anVREyRI4WpxZF923WaNn/qioBzqjAO88jOwvXgYRE52/By13zyINKn/5E+1Jw9qWDYU3kTH9IEFrGPDusryOjN46ibsZA2FdNmTjmFcCW6ubu2OSM84oByYvlguhvI+DdW7u75vQoSyzhCaAvhazBWv/iqafb3DdiUzVsuKSbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771550223; c=relaxed/simple;
	bh=RRAq7nHO9cD8+j6WLthwWQnJar0PvnyK39LfAXzcAWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pi7yKAPWWpLP6H/OIO67I7/k7tpxtTL652kDFw0xDL1MFTJQjuxf5WJHjQINbGxNPKABieykB1DyHsQebugSU6K3E6+EYJx7cNvlUC75VAWfiabwmQr/kAuBxRHxOSGdsbHperlpNTvuCWBqONWg0CxFNwcXcSGIP5p+nasnfNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQehS3Da; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQehS3Da"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4BEC4CEF7;
	Fri, 20 Feb 2026 01:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771550222;
	bh=RRAq7nHO9cD8+j6WLthwWQnJar0PvnyK39LfAXzcAWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQehS3DaD78CseiEbUV90VwQuHE5Die8VvF7FCdYzxybkdsTpRnsnd70Z+zsipjlc
	 ONMAtSbIkxrrMjxeqctc9cOqYRDcopYWuMGC7SMgTwwtqfeNgEBgigkwYOt1H106IX
	 oow2lZwx9E/4M0EJUmZQ0lLD2//GLZgnaHqTNNO8SGlR7vtypHiGqYdiM/AQJn/Ddu
	 UZQo7Qg1J6hZ5ka3D8UYZYwtC0+d1cRznfZ73hZ5NxhQwaa18bZSCnT7AdpX5OCCRv
	 mzPQtHlQvtjE+GsvhMJyZjXcjyg3pX29FUn7Vc6RoWY2W85d6lsQ3dxcramrmFtFa0
	 j+C9+1VGLp5Hw==
From: SeongJae Park <sj@kernel.org>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	kernel-team@android.com,
	android-mm@google.com,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Minchan Kim <minchan@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>,
	Zi Yan <ziy@nvidia.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Petr Mladek <pmladek@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/tracing: rss_stat: Ensure curr is false from kthread context
Date: Thu, 19 Feb 2026 17:16:59 -0800
Message-ID: <20260220011700.127763-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260219233708.1971199-1-kaleshsingh@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Feb 2026 15:36:56 -0800 Kalesh Singh <kaleshsingh@google.com> wrote:

> The rss_stat trace event allows userspace tools, like Perfetto [1],
> to inspect per-process RSS metric changes over time.
> 
> The curr field was introduced to rss_stat in commit e4dcad204d3a
> ("rss_stat: add support to detect RSS updates of external mm").
> It's intent is to  indicate whether the RSS update is for the
> mm_struct of the current execution context; and is set to false
> when operating on a remote mm_struct (e.g., via kswapd or a
> direct reclaimer).
> 
> However, an issue arises when a kernel thread temporarily adopts
> a user process's mm_struct. Kernel threads do not have their own
> mm_struct and normally have current->mm set to NULL. To operate
> on user memory, they can "borrow" a memory context using
> kthread_use_mm(), which sets current->mm to the user process's mm.
> 
> This can be observed, for example, in the USB Function Filesystem
> (FFS) driver. The ffs_user_copy_worker() handles AIO completions
> and uses kthread_use_mm() to copy data to a user-space buffer.
> If a page fault occurs during this copy, the fault handler executes
> in the kthread's context.
> 
> At this point, current is the kthread, but current->mm points to the
> user process's mm. Since the rss_stat event (from the page fault)
> is for that same mm, the condition current->mm == mm becomes true,
> causing curr to be incorrectly set to true when the trace event is
> emitted.
> 
> This is misleading because it suggests the mm belongs to the kthread,
> confusing userspace tools that track per-process RSS changes and
> corrupting their mm_id-to-process association.
> 
> Fix this by ensuring curr is always false when the trace event is
> emitted from a kthread context by checking for the PF_KTHREAD flag.
> 
> [1] https://perfetto.dev/
> 
> Fixes: e4dcad204d3a ("rss_stat: add support to detect RSS updates of external mm")

Sounds like the issue is not that critical, but user-visible?  Would it be
better to Cc stable@ ?

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "David Hildenbrand (Arm)" <david@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
