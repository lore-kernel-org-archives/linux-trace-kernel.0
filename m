Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793599278;
	b=Kb2hRgILJCb0yaMnvtG2gJKpIDvk8g1U1wvAe/HGpdwroMLiotn5/Eyd2mIiVH+kmhkV
	 4JHZDUMcuM+zVtXL8sul4jbhVylgIN8iYuOIVVIvhsACR9AviITVfDt+SoM8cf9STxZZK
	 sDBDSuFh+8lANZoMc/OFPKzT16Gum/BiBWZ5+bopJ0AdLSBM804I2g7fJWVzSJiOoTZbE
	 qfk8pc2cG6Ylk16do766i9TOzt+r93gYrOQvXZ8Cyt/u5Uc3P/ASXvpXnN15uz1TiPuFL
	 Nw9lHL3dNl88kIO6hYnCFm4O9EYXRO/uypte+x9x/yRtONxpyjOQTPSfhWCBs3Pof7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793599278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer;
	bh=ou8EB+rPMhnf6RRUAQStNUkip0wMkSd2FjxAyfUCwH4=;
	b=PPW3f49o7MhS5FInqtKpfuiM/ZM/e76/rYjXkwSGTQc7k2kQRNpxY095OTg385XZWSkQ
	 wB4cdrs7cRyYZssTLqs639hgN7OsDH3NUJ6MTul7xX+rcyv+VKPDeKAMr8qqUory8QAi3
	 84O/COZjqLiKbIuJHNqRbEJGHocQFOTCjg7SkH27zDNvzDNuJZyr89MLsO8pD4CTDdPJQ
	 wLHZtWwi+CqAYylGi7BUeUKz04f+HVqqlhpxSgUPk8lTf2ZZ++PT9KMDGiNH1gBOM/LQW
	 TEA19p28p9uueV6RRmwfM9m1tH3tu8zUWNK/DADhpRik64qjdCA5KdVi3JQ0bkc06qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAt93oyS;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D279606A326
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Nov 2026 06:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D279606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vAt93oyS
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so3794965eec.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 01 Nov 2026 22:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793599277; x=1794204077; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ou8EB+rPMhnf6RRUAQStNUkip0wMkSd2FjxAyfUCwH4=;
        b=vAt93oyST0TOWWjaRGac3B2kdtPpouocthcWK1tzbB6OilItbjc5NR+e/q1Q8UWRe+
         PQ+ZbdULCo6loIh9ZVFmQEsQJr9UPlgUylzXc+NnzECjNsfbzic870pEDuTTuxKMDDD/
         UGF7CFd8ViDI8ennlQZ8lPx5Zfp31ELzCOhDZk3B5b8S/V/NJqVHnQKXYBDlzxZ/7zhB
         D3td762eghKIvtZKWYBoQ50EkBdCX9DS2eztcrmpMTeovILV8U1Ywx+8Cp3aAV+Giq/d
         RNEtqlt/Ehb/amxtCaTzHxr8gF1/4/iEuWJmIg/HEILCem6TVIHhaDjQDhdj/fFxRkMP
         8Iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793599277; x=1794204077;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ou8EB+rPMhnf6RRUAQStNUkip0wMkSd2FjxAyfUCwH4=;
        b=xl3W+FcKnLUiuP/6PBep12jeXjbM73S8F0iOdRZj086qK6iLJBNFm4uXk5bu5mjRRu
         /UGAK86JCgxP+7r/m7YZVQNeka1OWCV8O9dgfJCMLaP4ZXuEmn7Oa3s0oAQLYtHEWZ45
         IL6KTzou7lpOymWGxVx08L8T9bGIjQtyjqQAzS7R4T+B2wJ4J7XXopc/aiYcnPiFZbB4
         gvvPeQZSne8QYx24si4EjvqjR/4fmEmMbWSl/x6DhU4Vh//sCcMrCtaFVGLiqpdFi9kR
         3g29pNXRP2QjGnkjrN26ECsb3MKsGFSvxblpjmG5+choy9CmhOyK6orImbg3TqodwVwu
         FNBA==
X-Forwarded-Encrypted: i=1; AKwUvBxHeg7obHOEGSMWBG4HsYvZ9LHWU2H4tTY9+0yDuP9WWlInHIP0LP813ZVoL41pIua1emVWunBgDcuy6D1os4dV8pE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHDwFH2y/O5RWCbENH4SGA/8Q1by81YK9DNGYqRhemHKpSRGQX
	2Fsyad+kl0DO18ElzlPpeFla+lHthfHbBWV9acn/SY5NFaTYiF3gPIdI
X-Gm-Gg: AYBFou3MdmbVLT/cvA3WX4c8KkpiN3nZ5a7V5wTUTmw08y+STMA8dpmidTYdNlWO54+
	h85ZBPq+x85BN4/utLuzaxoHraf/c567OE8+TDGTPta/qn7S6lo/WQNpnz6HN6lHrEvxmzMFWep
	luMZIyFQ/ul2W0xx0Jn7PYysHzzyBGOI7ek08geJdZC94NeehJYgbc7acYLylCWB9z88rYTIXed
	NlF3n3JIJ3tYZVvf7r/61CrqxgKqyHrydCxbV6rHRTpY8L+JXqu42q+wwnhU2H+kkCwe36LT7+W
	MK7vE+ZPRRHEPwBv/jLbrzMSga9Uoh1gjEK0/uze2N0P2Krv+YgpRd6dw5gXGDy73IHG4BfBcEX
	ywDcH2PA8+J2L7TBIScsPzGuwRdTSe9odBAC3gl4RzetlrxikuoyofGB75LBfCw6fJOAUmhzJwa
	fc3hISk3Q7biv3PfMUIOVoWV8fmYOBWkiWY3wD4MkZg1f1oo0DttDNQFkodgzAp4u5OCeFgfKpR
	Z/WfSnVOxNMSQUImrFyM3zfwDY8NWmHv9LHyuf/Ku7QFdEPveZSyONUFIzOImIQsrFfaGnPu3Bz
	SXqi2pBjw0lxNTp6o1UGAKES
X-Received: by 2002:a05:693c:6211:b0:36a:1cbc:1093 with SMTP id 5a478bee46e88-36a42417707mr13155080eec.30.1793599276780;
        Sun, 01 Nov 2026 22:01:16 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm28755363eec.4.2026.11.01.22.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:01:16 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH v2 0/2] mm/compaction: stop repeating failed async
 compaction on every THP fault
Date: Mon, 02 Nov 2026 01:01:06 -0500
Message-Id: <20261102-bug-mm-thp-async-compact-defer-v2-0-b407e974db54@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACIn6GoC/42NTQ6CMBBGr0Jm7Zj+gKgr72FYtGWASSw0LRIJ4
 e5WTuDyffny3gaJIlOCe7FBpIUTT2MGdSrADWbsCbnNDEqoixRCon336D3OQ0CT1tGhm3wwbsa
 WOopor1pX0nZWVS1kSYjU8ecIPJvMA6d5iuvRW+Rv/Vu9SBQoZF26+qZ0qcWj94Zf5/yCZt/3L
 1k2+CzMAAAA
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

Mooncake, the KV cache store used with vLLM and SGLang, backs each
rank's host segment with MADV_HUGEPAGE memory and registers it with
the EFA NIC, which long-term pins it. Its commit c3fa13ecaf10 [1]
reports:

  "under the default local NUMA policy every THP fault on a full node
   runs direct compaction before falling back. With 8 ranks x 190GB
   this made registration take ~38 minutes."

Mooncake now binds the segment MPOL_INTERLEAVE across all allowed
nodes, so that no node fills before the others. That gives up
node-local placement, and a task that sets its own memory policy
still gets the stall.

A THP fault on a MADV_HUGEPAGE VMA tries the local node first, with a
single round of async direct compaction, before falling back to other
nodes. A failed async run is never deferred, so when the free memory
of the local node is scattered between pages that can't be migrated,
such as long-term pins, every 2M fault scans the zone again and fails.
A node that is simply full doesn't pay this: compaction_suitable()
turns compaction away before it scans anything.

Patch 1 splits the deferral state by migration mode. Patch 2 defers
async compaction on its own state after it fails, leaving sync
compaction as it is.

Populating a 4 GiB MADV_HUGEPAGE buffer on a node fragmented by pinned
memory, direct compactions drop from 649-1473 to 9-41 and the time
spent in compaction from 118.6-264.2 ms to 2.6-5.1 ms, with no fewer
THPs on the local node. Details are in patch 2.

[1] https://github.com/kvcache-ai/Mooncake/commit/c3fa13ecaf1038df933dcb784ff8ffe026381100

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Describe the Mooncake report in the cover letter
- Emit mm_compaction_defer_reset for both states (Sashiko)
- Reset the pageblock skip hints only from sync compaction (Sashiko)
- Rebase on v7.4-rc1 and rerun the tests

v1: https://lore.kernel.org/r/20261001-bug-mm-thp-async-compact-defer-v1-0-0174c7923430@gmail.com

---
Qiliang Yuan (2):
      mm/compaction: keep compaction deferral state per migration mode
      mm/compaction: defer failed async direct compaction

 include/linux/mmzone.h            |  7 ++--
 include/trace/events/compaction.h | 27 +++++++------
 mm/compaction.c                   | 82 ++++++++++++++++++++++-----------------
 3 files changed, 66 insertions(+), 50 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261001-bug-mm-thp-async-compact-defer-b83351bfb25d

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

