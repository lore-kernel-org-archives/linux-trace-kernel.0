Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BA252BE3C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868840; cv=none; b=h7IUYBOU4OGWh2REEXGiPDHJdvJE2cpxvj3Jtt1D/hzPTGMBpnFXt7wfYLsemvBDB4sLKp4sb5+YjCNLdriPkM5OLqnTzpCPu/Vo4rrAEoOpQZFR9gY1EKMsmKNy6+1ibQoeMfQ8TDCQvlrnCG8JAE4UMsjzELbH6ClqKVmAL0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868840; c=relaxed/simple;
	bh=vE5rYraDDztxsN+DverCVDxINK++fhi24ILP7gENH+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a3bnUxra0wpcQdfBtO/NcS/AwO++7ZgR9hjIhfMJXuPRavvAqBNSDNEgp+GM4ybNeIWuMsYiLwKR2fhpPKYXptCrgvR8LxOulDKn3V1urBXKLQ9BWglWEhA/unBDQ3CKjMC0tCLmOOymSnBeKVB+xDx9wSAoCMxLysZDV3w+APc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhydnY3u; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhydnY3u"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14e1fe551c3so737003c88.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 Oct 2026 08:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790868838; x=1791473638; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7R/8/9AITUujGUpkgkK/lwuX+Zqo9Tj1z8OfLHWk1D8=;
        b=mhydnY3u53y8s9AHlRQ8h9yODcJxJUofiX6onfTS1D7kKyJxShPKPEXYjYi4XyCA1W
         EpN7B0GP95G6otxJ6gwAOD7tpabWj2szoWb7qWISEULBPuU8tQGQdt2JeJIZztKVjZGk
         /MFWZn+8Cbc9uY8HRf30dWd8oaMxDUDuNCC8ulOKN11L7Sp2I3D0yVADI7gFWrXt8KH+
         WTI0jK2ufNZJxJmJKW1emK2w17SsdytR8cOx7aLSErfMyhvotEQ0kdie+JHCoR6xWSUr
         GY/Nh/XPm1ocs6fVs3sYBUxck1OvVXvQN6pR1XQvy+AuT80FJNIc+Ajs/do17FxY6nJm
         uLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790868838; x=1791473638;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7R/8/9AITUujGUpkgkK/lwuX+Zqo9Tj1z8OfLHWk1D8=;
        b=bpI3/f4fLrUmhCgd+x35NUmt2vyTaTz1aNIMWVg6V5QbzM9xKZFNRCQdGR2m4erdzB
         bfD2zIm5Wu08Xym/ZS7Sadk/oW8kv2g95OhWCLQTnCMqMBmbDu/BC+soM30R27QbFfs5
         HMdc3+JbHz+gfFNfW3DfCmnjDR/3H8CJLJ1QKXPIHKgfh7tiYDfC183Lc5CP7dUvgqaY
         11n3ZRd9rASDCpsZPEfFWruRMtvPHc56XT4SAICaUGdEdU6sxpJhIDa3kjTiTVBCa2Tx
         CHXCENbZiqxtR46hUa/oYp74LCLlYUZ2fZZVZ7iojbGmnKqbnQgFlBbDCa4RgdSWIOk3
         Us4g==
X-Forwarded-Encrypted: i=1; AKwUvByo4bXwmiuOBAt2G/yYRVA78t6bjh4PO0kbuMNu8ENTnyIoemiddvfV6hYnG1mCjKkiw96y8beoRVywFouOjHbqyhg=@vger.kernel.org
X-Gm-Message-State: AFuF++m/tIis/3ghy2tGhyzvJxJzcSkpNATL+tTnZiqv9jwkxZcZKNZR
	DkCdd2Z8uAAKTRO9aqqjt/WdrZWHpjCbUoDgp7G8LCZhenZktt9p/NG/
X-Gm-Gg: AYBFou2O76ZnMTOX2dC7gsKmmTfOweEU/i+JrvQQB6xqprwX6vSkuD3w3BZabNH0ZNT
	TJMmKRH0+DBA8rp+tbddfSDT7QuCTe1o+8aL5spllzMA3Kxla/A+oR19UBwr/s5i8Lax7VOXdj7
	2iRkRH1gMa4zkr1upOl5fFd+J0htpnuTzo/CqvqRGiHXG+lvGp3rp5mkdwPcle9Q06dHoKQXc6N
	c2Q1d8wL1Xbmt1zakyIm1S6FfCWpnMuUb3ZpGrta51e6GPjz9yjU7VkyOZ967yne+VSvzJ7ziyM
	mtQNetchS/ddC0rZLrJ48zl6y0NnCg6+cKDBwqTQWCgFST73nISvFu1jNRegeV3qOrGbOyh9OD9
	r/hDX1talE5u9cARrn6h4Vfnd3Bh5JGareZOmzEmoamS9ZrbzKFuDGlEVLZ7O+60EsDxy8gI3Wo
	9mSPx8yTkfrPawvhL3mGYKpwzSiJOWeZ+TCr8cP35Qb1eX0XP4SISQwoA5vf48bkktJQ==
X-Received: by 2002:a05:7022:eb57:10b0:143:50a0:56be with SMTP id a92af1059eb24-14d31c6d41fmr5203438c88.14.1790868838309;
        Thu, 01 Oct 2026 08:33:58 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f266d1156sm146683c88.6.2026.10.01.08.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:33:57 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH 0/2] mm/compaction: stop repeating failed async compaction
 on every THP fault
Date: Thu, 01 Oct 2026 23:33:47 +0800
Message-Id: <20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFt9vmoC/x3NSQqEMBBA0atIrS3IgNL0VcRFhorWIjEkKjbi3
 Tu4fJv/b6hUmCp8uxsKnVx5Sw2y78CtJi2E7JtBCTVKISTaY8EYcV8zmvpLDt0Ws3E7egpU0H6
 0HqQNVg0eWiQXCny9g2l+nj92WGescAAAAA==
To: Andrew Morton <akpm@linux-foundation.org>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

A THP fault on a MADV_HUGEPAGE VMA tries the local node first with a
single round of async direct compaction. A failed async run is never
deferred, so when the local node is fragmented by memory that can't be
migrated, such as long-term RDMA pins, every 2M fault scans the zone
again before falling back to another node.

Patch 1 splits the deferral state by migration mode. Patch 2 defers
async compaction on its own state after it fails, leaving sync
compaction as it is.

Populating a 4 GiB MADV_HUGEPAGE buffer on a node fragmented by pinned
memory, direct compactions drop from 735 to 15 and the time spent in
compaction from 122.7 ms to 3.6 ms. Fewer of the THPs are allocated on
the local node, 1126 instead of 1313; the rest come from the other
node. Details and the movable-memory case are in patch 2.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
Qiliang Yuan (2):
      mm/compaction: keep compaction deferral state per migration mode
      mm/compaction: defer failed async direct compaction

 include/linux/mmzone.h            |  7 ++--
 include/trace/events/compaction.h | 27 ++++++++------
 mm/compaction.c                   | 77 ++++++++++++++++++++++-----------------
 3 files changed, 63 insertions(+), 48 deletions(-)
---
base-commit: 551c722f40809618230001baccf219193e22fc5a
change-id: 20261001-bug-mm-thp-async-compact-defer-b83351bfb25d

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

