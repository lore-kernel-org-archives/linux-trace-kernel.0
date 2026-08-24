Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7EE382381;
	Mon, 24 Aug 2026 21:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787605882; cv=none; b=usj+VV0Q+/0yVmrXt4Ajnz+lpiamMCcR/2bvXCuMXrXlmWnslMCg35NYbRvhgsEYVsXxCQPQetN2LCYuxUNfm7O8g5OgJ4JZsGphRh/M6chPXnCHrdIVQe/ArTzsom6sdR+MROC8T4s/xWuIcbxqQUaHhBXMDv3CdPz2gTtQjZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787605882; c=relaxed/simple;
	bh=WvKeOXDUBJ0vzKWW52wQq9/MU2WEgonuUspqHwzV/ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p4mxOwDt88VOLoj6aPc/QM8QQ9Gkv9wbPOcjcwDtDQx4zjsiNBB/LVNpO7GWya+gup9UWf2z7D3xgkc08Gkaazfw9/hartjhaMqCGoCZ0nrw49ffFQAsuIy6o6Y9LkA6P9YnVUq6CMY1bW232kbwQofH5XndKh9+NjF1iVBfGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=OwDvdRxM; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="OwDvdRxM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=R2i2P0wGGg9fMSs8t3mDOGeyRItArPiUrhJHEUE7aQo=; b=OwDvdRxMmyAqHsMMdTnLFpZNBC
	Pko7EHNVoHfV9TPSZvbvAGTS58+MU00dexzbh2O3aypbp1g2wD/1WYLJ0Li2ho6lnaj6h5SMVuXOQ
	YGD//r2IFTxiWBG2ZZk+BS8qS4ke/9eNX87oML+Ox0379VdqyIsZ21zaezJP7QrV+sU2osfJxanCd
	w0tXVQ8R3AAd4kIiYVVrP4wh8QSro5sS/JmOx83htLUcO5CI175dZZE1Fw4BUZT8wIlfoe9q5zZiK
	78PqI07hAAaPGU4mDpsVB0VVhr+LZubqzejUPmRN/09lOfcNOozCdQsDTZ6Y5CqpzuYLdodgnjoKZ
	EKwPFcew==;
Received: from [151.115.150.205] (port=37000 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wybwt-0000000E3zh-23RF;
	Mon, 24 Aug 2026 23:11:18 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	include@grrlz.net,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] tracing/user_events: Clear copied tracing state before fork duplication
Date: Mon, 24 Aug 2026 21:10:37 +0000
Message-ID: <20260824211036.3729669-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

User events keep per-mm tracing state in task_struct::user_event_mm. It
tracks the registrations and enablers created through the tracefs
user_events_data interface.

dup_task_struct() starts a fork by copying this pointer from the parent.
user_events_fork() must then either share it for CLONE_VM, or create new
state for a child with a separate address space.

The second case can fail. If user_event_mm_dup() cannot allocate the new
state or copy one of its enablers, it returns without replacing the
pointer copied by dup_task_struct(). The child now points at the parent's
tracing state, but did not take a task reference to it.

When the child exits, user_event_mm_remove() can drop the parent's task
count to zero and queue its tracing state for release. The next
user-events registration in the parent calls current_user_event_mm() and
writes to the freed object.

KASAN reports:

    BUG: KASAN: slab-use-after-free in current_user_event_mm+0x51/0x1d0
    Write of size 4 at addr ffff888005010d30 by task init/44

    Call Trace:
     <TASK>
     kasan_report+0xce/0x100
     kasan_check_range+0x10f/0x1e0
     current_user_event_mm+0x51/0x1d0
     user_events_ioctl+0x82e/0x15c0
     __x64_sys_ioctl+0x139/0x1c0
     do_syscall_64+0xce/0x450
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Allocated by task 44:
     __kasan_kmalloc+0x8f/0xa0
     __kmalloc_cache_noprof+0x180/0x3a0
     user_event_mm_alloc+0x3c/0x1f0
     current_user_event_mm+0x88/0x1d0

    Freed by task 42:
     __kasan_slab_free+0x43/0x70
     kfree+0x13a/0x390
     process_one_work+0x696/0xf90
     worker_thread+0x420/0xba0

Clear the child's copied user_event_mm before starting the fallible
duplication. If duplication fails, the child has no user-events tracing
state to release. The CLONE_VM case remains unchanged because
user_events_fork() explicitly installs the shared pointer and increments
its task count.

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Assisted-by: Codex:gpt-daybreak-blue
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 include/linux/user_events.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/user_events.h b/include/linux/user_events.h
index 57d1ff0..2c9ac7b 100644
--- a/include/linux/user_events.h
+++ b/include/linux/user_events.h
@@ -48,6 +48,7 @@ static inline void user_events_fork(struct task_struct *t,
 		return;
 	}
 
+	t->user_event_mm = NULL;
 	user_event_mm_dup(t, old_mm);
 }
 
-- 
2.47.3
