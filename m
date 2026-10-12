Received: from mta1.migadu.com (out-87.mta1.migadu.com [95.215.58.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CD4A2A6C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Oct 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819686; cv=none; b=BtqFhvZ/0nisMOEw1N4L6URIA3Jthp8YZpnyI3YxLeKxqOIbiIWe7i+5LsUoKIEpzDVcXAzIe7rKvuP/WPGThXfWBEkwXrsYbYSmil8QfQqglPc41FYxRsm0RlodTcRAX//9cTZAmVRLRFPJElFyH+KN5sfRheO0BZmTzLXVU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819686; c=relaxed/simple;
	bh=f97YBpk24mCWaEC+VMRK7wh8FGCU36QI9W/V9kJ5Pag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epcXanxhFZcdr+2gPlurqTgQmJFmm9Gqf7zNb1mEYJTHZmMfzEzQkVRM3E+eMSHuqKM7ANtU4NxzUwooKnsr+gYRs8d+R5t4UwYH6jFHfogHmxIauXCmdFVwGyuO/xcmLdZwl0X9KrbKdLP6xmbagrw+eHzvDY1JvyQgEVkssTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UvHaWK9D; arc=none smtp.client-ip=95.215.58.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UvHaWK9D"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f97YBpk24mCWaEC+VMRK7wh8FGCU36QI9W/V9kJ5Pag=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791819683; v=1; x=1792424483;
 b=UvHaWK9D39PzGElltRL9VkqY9x1/enuKx4lTJz0AjblyboHc0yqWfk+DTTMmugRttX342NKE
 xcvfZdjx3zeKNPGujRK3Qo1xYny2CdMg40H8yrJNYxfMocdK/YbQriE99Muc+hU2RwFbOeOd1Tg
 aOaF0Hb8svsUBXEXRvWvwpTA=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 511aec9e5df13166;
	Mon, 12 Oct 2026 15:41:22 +0000
X-Mizu-Trace-ID: 511aec9e5df13166
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>,
	Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 01/21] bpf: Initialize ftrace_managed in bpf_trampoline_get()
Date: Mon, 12 Oct 2026 23:40:03 +0800
Message-ID: <20261012154024.29423-2-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012154024.29423-1-leon.hwang@linux.dev>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A trampoline managed by ftrace is determined by its target, that said
ftrace_managed is already known when the trampoline is initialized. so,
set 'ftrace_managed = tr->ip != 0' in bpf_trampoline_get() instead of
relying on the first regular or tracing_multi attachment to set it.

This makes the backend selection independent of attachment order and keeps
the registration callbacks focused on installing the trampoline.

No functional change intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/trampoline.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 24edb59238f3..17f2a8133f61 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -475,18 +475,11 @@ static int register_fentry(struct bpf_trampoline *tr, struct bpf_tramp_image *im
 			   void *data __maybe_unused)
 {
 	void *new_addr = im->image;
-	void *ip = tr->func.addr;
-	unsigned long faddr;
 	int ret;
 
-	faddr = ftrace_location((unsigned long)ip);
-	if (faddr) {
+	if (tr->func.ftrace_managed) {
 		if (!tr->fops)
 			return -ENOTSUPP;
-		tr->func.ftrace_managed = true;
-	}
-
-	if (tr->func.ftrace_managed) {
 		ret = direct_ops_add(tr, new_addr);
 	} else {
 		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
@@ -1286,6 +1279,7 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 
 	memcpy(&tr->func.model, &tgt_info->fmodel, sizeof(tgt_info->fmodel));
 	tr->func.addr = (void *)tgt_info->tgt_addr;
+	tr->func.ftrace_managed = tr->ip != 0;
 out:
 	trampoline_unlock(tr);
 	return tr;
@@ -1649,7 +1643,6 @@ static int register_fentry_multi(struct bpf_trampoline *tr, struct bpf_tramp_ima
 	if (bpf_trampoline_use_jmp(tr->flags))
 		addr = ftrace_jmp_set(addr);
 
-	tr->func.ftrace_managed = true;
 	ftrace_hash_add(data->reg, data->entry, ip, addr);
 	tr->cur_image = im;
 	return 0;
-- 
2.55.0

