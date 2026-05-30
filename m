Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341BD3B388B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150657; cv=none; b=BA5ZUhRJ6wkjelSjndQay816Vagj2COExHxWb8pP1Yho3qiMBulriftICrs633I0UoxIJGdq1UXtctYpGGO1WbfNWZaCvv+qPUaKUbFsR3TFBGLlDibIJqoGU3dauKFHxMjfdRVfhcVuYCYiAcpJ2QCBeTr5VTsyKUwf6A9+8ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150657; c=relaxed/simple;
	bh=gTgst4RG82v+Pzr7Y9TZwyGFXX+pyH41XUeKD8aNXY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=VrDbgkO4KOIGptD/pdw9UDgpKbYcREMFH7Uip3rot8xlR4a+1mOfwK3CjameYVEPfO/AKuFXoBv7AEK99bamPrpDDvm0pamhoZpP7b1mU5MDdnJCZEriAU3URXhRrTwl9HcqhPQTMPm6HnF2fDoTVU/FMPmQFSj8WAB/Eq6RogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KCrSphYL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCrSphYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780150655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o9EXyjATGOAG3X90xS7c9ANBwF437oeU5IhxqaG7rLg=;
	b=KCrSphYLq4hOjofgq760L7aUpsVQeqTEPcqDCKpnSLqbXmLdHiwaqTH9wL/w2jiz1mOmDx
	grjK8ZRKPqD4DkoE6hlfuYRTdCC8km/vfubHnr+qXOxwoSia1i8jK5UXv1Dnomy3q5blrU
	MzQ4JCzH/Go2kRfRuS3aMZoVqdRRUOg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-hl6vEHqvMcqdBbzP15S16A-1; Sat,
 30 May 2026 10:17:33 -0400
X-MC-Unique: hl6vEHqvMcqdBbzP15S16A-1
X-Mimecast-MFC-AGG-ID: hl6vEHqvMcqdBbzP15S16A_1780150652
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 843741956096;
	Sat, 30 May 2026 14:17:32 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA9273002D2D;
	Sat, 30 May 2026 14:17:30 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 11/13] verification/rvgen: Fix suffix strip in dot2k
Date: Sat, 30 May 2026 16:16:50 +0200
Message-ID: <20260530141652.58084-12-gmonaco@redhat.com>
In-Reply-To: <20260530141652.58084-1-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: _IKK05QZvkPCUGRKZVx9oiyHx9cVN4lb76B9ft0i_QY_1780150652
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

__start_to_invariant_check() and __get_constraint_env() parse the
environment variable's name from sources that have it padded with the
monitor name. This is removed using rstrip(), which is not meant to
strip a substring but rather a set of characters.

Use removesuffix() to actually get rid of the trailing _<monitor name>.

Fixes: a82adadb16894 ("verification/rvgen: Add support for Hybrid Automata")
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

