Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6F8351C22
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863063; cv=none; b=JRROcKMzUNHbxO5Y4Qi5OyYWl/WOOm3z8tqWKrIwdv4SGQFaZ7HhIH8tOmy39g1Ar0x1VF4j405u40dHDe1a5fS5xTMRjoTDkkrMBT1vR9R8WsYkeJyu2fZf+O6iHly6Zufq8dxCsqQ79zA7vsbPeW5WW9gITdor49jE9ptepUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863063; c=relaxed/simple;
	bh=ycbOGxAnuln/eZgsEbhzGMwVZ7toxRRhvRYiTsjvklA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=p2kzWhmQoEdiCAQwag0zoeDh/y1INwzJ0h1d4O9H6A6ipj1T0FfHPUNy1DGpMqKb7GfVlKZj6Bm9rlJyuA9S84FJ4OV87JKNJX5fX26Gn30Cigat+L9wFTEOoTX6CSNc9fyASDIp+uxR1By6FOMtIQdLJ1W0aVzKec3773jLgi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c0StWDdn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0StWDdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppGbxUPvKHnT6F0AzjMFxgh+dzLoqNuAQdSjdw0IdxI=;
	b=c0StWDdnLsaJbrYt5LtsDsAnmaIx97jNCcYNjjdxuc4bhAGIucudy3tKqwIBTaJmJ01pi+
	bZOuhvJEEMVjpcgxYZVQPKrzYalI9O0Db9NgQmUV6oy2mTJirsQbMkwavdjY016CU1Ptpn
	XBru/Apj456XBJHwZ+9Kg9EUTP+cpiI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-kMgp5VTJO4ayLqWU7iuJwQ-1; Wed,
 27 May 2026 02:24:16 -0400
X-MC-Unique: kMgp5VTJO4ayLqWU7iuJwQ-1
X-Mimecast-MFC-AGG-ID: kMgp5VTJO4ayLqWU7iuJwQ_1779863055
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C36019560AA;
	Wed, 27 May 2026 06:24:15 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBEF81800465;
	Wed, 27 May 2026 06:24:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v2 12/12] verification/rvgen: Fix suffix strip in dot2k
Date: Wed, 27 May 2026 08:23:12 +0200
Message-ID: <20260527062313.39908-13-gmonaco@redhat.com>
In-Reply-To: <20260527062313.39908-1-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: tQDgjxeS9HEhdIKHHN2ESu7m8zChW0X6ew8CgkUHY5M_1779863055
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
index a17294283a1f..3060aa4b945d 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -230,14 +230,14 @@ class ha2k(dot2k):
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

