Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FB49EC48
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400016; cv=none; b=BYEucuJew2wLSUqxe8LR8Ts8l+4YFFxq0nlWAzUud891qPFsm227g1vIJdSXqwzBclc8f7+RvOcX49sknPhDHD7xPaRc/JH6sdP4h7apvp67NvUyGzmnRJhDGoPQ2wyAzDaW5l2lbW3aYlWat/LajmAOEHN6WBJqriGQw7aL+RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400016; c=relaxed/simple;
	bh=PuECBq7rHCOnPJmiez2NwEpZpJw99GayZp2VbNnwfpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmzqNUcGCXjczGHd021XDkWI0L9G2d2T+8dIGg9OUvoQ7j01O5Yn3N6iSRKbCHJAMhR8jXbgC5TYLOu/fyliEPLOCpBB6mI+ri7tJdtgKEx1rc72N1wj/qx8ilLnl8VppkzwlZIyeVBxkyzswZAoZz23V2AAsZdCKRkH5iP/fpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i51MbVfF; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i51MbVfF"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3550c917fd3so2170193eec.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792400013; x=1793004813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IUQKxK3gJveo0GbdIu8MHrrQ2HSW0SFpxRsXuUxNszA=;
        b=i51MbVfFNI/71gqMlggaWVcQXM31/I6EJ3bk32U0rNW6xvGgl8w7k+tVvvsE6ZyyRc
         KJ3uT8k4Q7utXfUiWm5jd90zD25Mks74HqfFjgMcimz3IYz5k4g8WN8PGownbJFN+CIA
         0Grdb+6olOOAEHqaB8/icDmUWxBJnW50KtJEwC4cJPGLZgsjKbr5wTLVbfLFaAuHTIts
         F9Q7AujbnYZ8tGq4JHlh7GVF24+6KZp7U5WCuyS/OST5/4mUA97DucLepQ/GVarj9Wtb
         aZo7IvlKzepPHgQ2N9D4Yf70XJwLUKOOm/iVJty6TUZdSfMN8Z0kYGrgUDmsCHkxVKVo
         VZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400013; x=1793004813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IUQKxK3gJveo0GbdIu8MHrrQ2HSW0SFpxRsXuUxNszA=;
        b=ZQsf+ktMi8QC2elkc1wu1Le6glI74ghhWQdg+7p9YX28gPLZlJV+0mUJ8oAvVvtAJ2
         t9jhbEiqSQKDDXCGG45YqIz6YfBQiZStOEE8c/Bi1IK//E4bqjZ9Lmy5sGjtXEV2KMLJ
         efH75IZuNPH72vDiy8NraatzGpBopmPNpCKvDcHYUOgR+fxOg2F1sSKzHJQmd6yDsEWB
         /CcFfVAC7fLEBnj8IUCSNLDFAqz94WaBJC5LIa972cbGGKGCOq/mKEl8OiL5myTthvuQ
         vlRbvQsPAsWUJQZjYf6hK9zqRcUnxkOI4Y8AGvDnEDr8gibMHTYZJa6Ubr0dVFNgnMs7
         gpKA==
X-Forwarded-Encrypted: i=1; AKwUvBywuROzN4yZNHUPaPYpbjTwmGphLCmfXTbiW29dKXgL9ZIp6HRI1u6iz84G85KPIdBNIxwgVF3z0uHMuXdiUBX4EDY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJO0wUBR3dNv3vP8WEYB8rYqeQM19xJ+ULFC5YCXseJrfWxTOIV
	4GoagPwv60qf5ZNyvo2U5iN5FomfEDyaJ+FiiJFlMftXrOhqsqYoG/Zl
X-Gm-Gg: AYBFou3NOQeyOxTqgn/8gFooDb1Sr4z3M0abJJH0G5zSZeuT3oREJy2TEsU67bP6L+s
	2oRRSVgw4Ueq9R/zhxFQGWTyemRG5hTYSCfhjSb/EX9crZ322ADGq4TdK8+M9gxMXXnH1fT14hT
	qRSqQ9vc0l5C+AWg3V6Ubo0HmarvAeUeCJEzXufjTSMMAnkndLMmCkYOpp2l8pTD+J/eL6Fw/sn
	o/UaKg5pqOCEUS6uZGbfwE48YkYy/7ZHDvMkHLqrp2+B6YEahhBH44zbrn92cXdh6FgIxhb68/O
	mVE9+LM8EBRsK9DXvHobQZQDGhFytlV7gjpHlFmB1Iw9Xn6x1DB4oao+cgLsrEuWIXHc3WyZLX9
	0X59WvptSfX3GT/2wWzpazLwbin/XtWKeTg1g3Yw9jNYbmdvpxNsk+LuTxSIoLsTpJWP/dVCW84
	NvewLZtG5UXazKGJkYL6ZtX0mgDXsa+JRkQMwiXYX4nwAP/n035PpHAbEOyYmM2SOCDKDFasa7
X-Received: by 2002:a05:7301:717:b0:351:1bdb:e3b7 with SMTP id 5a478bee46e88-361a186348fmr9105771eec.15.1792400013280;
        Mon, 19 Oct 2026 01:53:33 -0700 (PDT)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081bafa7asm30069333eec.14.2026.10.19.01.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:53:32 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mm/compaction: stop repeating failed async compaction on every THP fault
Date: Mon, 19 Oct 2026 16:53:24 +0800
Message-ID: <20261019085324.2562579-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com>
References: <20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A real workload has since run into the stall this series is about.

Mooncake, the KV cache store used with vLLM and SGLang, backs each
rank's host segment with MADV_HUGEPAGE memory and registers it with
the EFA NIC, which pins it long-term. Its commit message [1] says:

  "under the default local NUMA policy every THP fault on a full node
   runs direct compaction before falling back. With 8 ranks x 190GB
   this made registration take ~38 minutes."

They worked around it by binding the segment MPOL_INTERLEAVE across
all allowed nodes, so no node fills before the others. That gives up
node-local placement, and a task that sets its own policy still gets
the stall.

[1] https://github.com/kvcache-ai/Mooncake/commit/c3fa13ecaf1038df933dcb784ff8ffe026381100

Thanks,
Qiliang
