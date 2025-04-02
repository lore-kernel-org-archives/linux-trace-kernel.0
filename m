Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F216420CCFB
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Apr 2025 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578098; cv=none; b=M6LATrotY20uFt5Zj8FWwzPgq640C32QgU/C78LBY48CjA8w3VaVmJKIaW0heEz2wKhEUqBuyNkpmjxgojw6Sun5teEhW+qBvFK0RVOP3eyCUsphIJoLHEIpE52CO0kWgOYlIICB1RZx4x9mAXvpZmOP+wGL9YStkH9VZAdthk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578098; c=relaxed/simple;
	bh=FOtpYeBp4zVQl3ctHjTlko2k1XohN/LrcFybr1axKz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=naPLJyX7hf0+xhQK9kmfJ7gO3VPGCL1l/fLVf2LGThoxVbcIzi2wmKLV9xYI3vGYH0KOw19mysPR8s9NigDJpT6nBHnkb4JVuiJz3Ozy+Yir0KfE8AubywQyeP/VzwxuH+w3Lum94IIBOEjaMfut5FFl7irRp7d7lo+nERdvyug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQ2VJsyE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ2VJsyE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743578094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qh1ya57MIjo5Lkmn722x+JI5fDV/4skd8xfb1oy7zXs=;
	b=eQ2VJsyEhmmqbjyJKvRKn7MXWDXPQrqFWH12HyyJ5roLbY3+PDxozHytyj9efK9ybjR2ae
	C1BmHEjRnTn7/1e7DC4PvQZziuVp9zS2uv06YLbdcwd0r//I0cTVfyVQT6Ua7YVyFZrdC8
	Ap0OgBBTIjcdTTtbCs6faAv0VhroUqc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-XcjVldcLPfmmluMdhWpxZg-1; Wed,
 02 Apr 2025 03:14:49 -0400
X-MC-Unique: XcjVldcLPfmmluMdhWpxZg-1
X-Mimecast-MFC-AGG-ID: XcjVldcLPfmmluMdhWpxZg_1743578087
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 591C11955BC9;
	Wed,  2 Apr 2025 07:14:47 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.220])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11FE3180174E;
	Wed,  2 Apr 2025 07:14:43 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] rv: Fix missing unlock on double nested monitors return path
Date: Wed,  2 Apr 2025 09:13:52 +0200
Message-ID: <20250402071351.19864-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

RV doesn't support nested monitors having children monitors themselves
and exits with the EINVAL code. However, it returns without unlocking
the rv_interface_lock.

Unlock the lock before returning from the initialisation function.

Fixes: cb85c660fcd4 ("rv: Add option for nested monitors and include sched")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202503310200.UBXGitB4-lkp@intel.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

This fix is not critical since currently no nested monitor registers
nested monitors and doing so would require another review for inclusion
in the kernel code.

 kernel/trace/rv/rv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 50344aa9f7f93..968c5c3b02464 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -809,7 +809,8 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 	if (p && rv_is_nested_monitor(p)) {
 		pr_info("Parent monitor %s is already nested, cannot nest further\n",
 			parent->name);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto out_unlock;
 	}
 
 	r = kzalloc(sizeof(struct rv_monitor_def), GFP_KERNEL);

base-commit: acc4d5ff0b61eb1715c498b6536c38c1feb7f3c1
-- 
2.49.0

