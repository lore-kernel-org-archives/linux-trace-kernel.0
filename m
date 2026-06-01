Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A703DB653
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328374; cv=none; b=WFaTYNBRJ+YhM8oV15RH8spyv39Qlx0lmzkzTP6lVtxf4E00Mi/EHFMgySySqgO+2iVfKyDm8tsDr6ZM0QHR5O3OiJ2ylm6P3ya/i/CjzNxoi1N9PQYUigGS0XiGyhQvArbXHqdcKPwFlWaEXfsZITJL5+sSXdPSZETlsokoARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328374; c=relaxed/simple;
	bh=r4rXFUN/7fBBSqKhfTbSPIeVBvqATlTpF9F/PA2nILo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=trspPecsEFGQz0jRwZ4HDfbVgqUqYG1YAb4kE5nL2m+mCm0O62MpWc++lOMS8WYUKWwO4DtQqpwCjIYvrb3UXsC8HSQ4hdyQR30u6BayfOXSeQW/rJQfy2Dy5hteX5jbhd8se3xwKrnFPgW/1HgkWLgiUQNeC4XmN+iV4GmXp9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IATaBZNt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IATaBZNt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0Ewo6XUmfgoCK0Y2qNL9TNtZvTMryM4nesa/i9XQs8=;
	b=IATaBZNt2/5zWfqjlz9fZQ5VO/agmd+mk0xmuopl43pAWH0YFMeoY9wycsniyuENyYp6Db
	qQVfCU7CwXpu1M/Vf+o3LvD+Aurkmx/N+wEYXzt/b67B7xClrK+TaM3NkWWKACaFnZOU37
	wn44pPJ0TMrUkQFQFlCp+efcK8jffVU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-LMmJ_sO8MlyFKmF2twf76A-1; Mon,
 01 Jun 2026 11:39:23 -0400
X-MC-Unique: LMmJ_sO8MlyFKmF2twf76A-1
X-Mimecast-MFC-AGG-ID: LMmJ_sO8MlyFKmF2twf76A_1780328362
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD1C71956058;
	Mon,  1 Jun 2026 15:39:22 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0388A18004A3;
	Mon,  1 Jun 2026 15:39:20 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 11/13] verification/rvgen: Fix suffix strip in dot2k
Date: Mon,  1 Jun 2026 17:38:38 +0200
Message-ID: <20260601153840.124372-12-gmonaco@redhat.com>
In-Reply-To: <20260601153840.124372-1-gmonaco@redhat.com>
References: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 7fXn5PNRvRvkKSKMW1BJgJQk_8bNi1hp3o4WY5TKk1s_1780328362
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

__start_to_invariant_check() and __get_constraint_env() parse the
environment variable's name from sources that have it padded with the
monitor name. This is removed using rstrip(), which is not meant to
strip a substring but rather a set of characters.

Use removesuffix() to actually get rid of the trailing _<monitor name>.

Fixes: a82adadb16894 ("verification/rvgen: Add support for Hybrid Automata")
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2k.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/dot2k.py b/tools/verification/rvgen/rvgen/dot2k.py
index e6f476b90..110cfd69e 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -215,14 +215,14 @@ class ha2k(dot2k):
     def __get_constraint_env(self, constr: str) -> str:
         """Extract the second argument from an ha_ function"""
         env = constr.split("(")[1].split()[1].rstrip(")").rstrip(",")
-        assert env.rstrip(f"_{self.name}") in self.envs
+        assert env.removesuffix(f"_{self.name}") in self.envs
         return env
 
     def __start_to_invariant_check(self, constr: str) -> str:
         # by default assume the timer has ns expiration
         env = self.__get_constraint_env(constr)
         clock_type = "ns"
-        if self.env_types.get(env.rstrip(f"_{self.name}")) == "j":
+        if self.env_types.get(env.removesuffix(f"_{self.name}")) == "j":
             clock_type = "jiffy"
 
         return f"return ha_check_invariant_{clock_type}(ha_mon, {env}, time_ns)"
-- 
2.54.0

