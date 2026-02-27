Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66642049;
	Fri, 27 Feb 2026 00:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772152805; cv=none; b=cukESF8veAKY9C+pNwb6KOpiUv/83mFEdCh/eNqX/OrNDw82KUVO+rJFLPV2GWGPC3KI3kyT6Pap9DN3M3JinY1JNDDUz+fD1sPISLpgM+Do+JiXGl/GtqoOS3J49bYEG5ZP9CeTocq3dOD00nELLc6fNTUFIyd638TWmjWQSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772152805; c=relaxed/simple;
	bh=hRvAW4fgqzOEWM3gO/AL01HeScXOia9ctRQdg/T/bOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSTnqqNefabugjTHY6sRkvmtmYKy/uVujJVjlZ5bwLAzGg42PGnPFeM5gAK4rHMxKNsAfIzK8/HT7+BJ3+UQOj5FyDNN/ehKGBb+SYuGv5E1OCJsW4ttsKiUpALj/vpkY1TLT0g9x1mMoFHd2b2uE7oZ2oW2j7XbMb+ftZVBqEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2Uukdgz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2Uukdgz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F80C116C6;
	Fri, 27 Feb 2026 00:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772152804;
	bh=hRvAW4fgqzOEWM3gO/AL01HeScXOia9ctRQdg/T/bOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p2UukdgzdNb2Xp0zz3250PoXnYD5K6v9ICRhumcmxuGPPYyM3MA17u2VzdL4f971k
	 cxFlTMlg75pEGzkec4d2gZ4ZumB7YQMIaznIo6mt489g8vEef6sGYrmCfi9BeNTyxb
	 TNAT4cupkOZ4pB+cXwx4Agr5k5foIC2yAvpoJLptF1UL8biDJvsn/yVpl2CZV5pCWr
	 EylrCu4w7Z8/PgrrW1WqMSx6vRSPvtkUKGq907eQlp68IzZaLLqWx8LVg+js856IFm
	 3zuExyBfBc1qttW9P/m0dQEKTm5c1VSagjraZ+Qigl+MDOJSnEEJeSC9aYXp33X7tG
	 nkKHXvkUpYIyQ==
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
Subject: Re: [PATCH v3 2/5] mm: convert zone lock users to wrappers
Date: Thu, 26 Feb 2026 16:40:02 -0800
Message-ID: <20260227004002.83379-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <e5324d64361f86d930d940a5b49235f7996efe53.1772129168.git.d@ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Feb 2026 18:26:19 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> Replace direct zone lock acquire/release operations with the
> newly introduced wrappers.
> 
> The changes are purely mechanical substitutions. No functional change
> intended. Locking semantics and ordering remain unchanged.
> 
> The compaction path is left unchanged for now and will be
> handled separately in the following patch due to additional
> non-trivial modifications.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
