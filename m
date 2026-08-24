Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCAC3A8743
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559540; cv=none; b=PF0i53r+rqZFhvU5KcJS/RIyzCeoOQJ6PkBPe5M2Kn2EdeynqFcOTi8vs0BWfF+VCRgMjA8MRSK4BpylFw0QQEB0CfOO89PPwDvdhNGDik2ULec7eiGG5RCXrXYlVgVhA0/Awuawz3HQK5VJOURqhi8EmQH5Lqg5ESXj7IeE4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559540; c=relaxed/simple;
	bh=i5V/yNDjoTdBwY0semUyIM9pWhfMJKJHEe8lJJ0tmFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=FcX3t7YhGE6/opO+vn3AkXjVG3yzLsaEUK/Jnzrdt53D6lWQDbEc/x6KHCdb0E1pzLbSq2JeFf47fzGZN9+1ls++iIzAwxSF2v0uYkjEuhAi7UIzTnVtlxkRViqGTxqythOBwDTANdF/OyCK6KVLXuFzwCWShaI4q0vpjxu+spg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmTW+DTm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmTW+DTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787559536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jauhlfr76U5wbFVyasfT79OBDBE6yDHaiClEZzAm49E=;
	b=AmTW+DTmW3iVUf0aTskUQ6Nl/MX+RqSxdCFjGCKbCcWPtG7Q/lgWZ5Hh/QemWzDzmLEUGy
	ApKjVSmy9H/cja8sIjo3AKnrvdO1M1yCQury667ljOq2BIavrJtMrXoM3tmVPWgHKZMQUz
	RWH62dUYfMOFwUEGpPswIhnMBxoV0aY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-WQxX-z_bPoak744mf-bCmA-1; Mon,
 24 Aug 2026 04:18:52 -0400
X-MC-Unique: WQxX-z_bPoak744mf-bCmA-1
X-Mimecast-MFC-AGG-ID: WQxX-z_bPoak744mf-bCmA_1787559531
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF4DD1835E95;
	Mon, 24 Aug 2026 08:18:50 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94D081800577;
	Mon, 24 Aug 2026 08:18:48 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] verification/rvgen: Use .old instead of .bak for kunit backup files
Date: Mon, 24 Aug 2026 10:15:19 +0200
Message-ID: <20260824081519.81103-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: STyCn1Zun92p1Pg3BKDXIou0IknN3JqrK77U60OYMzI_1787559531
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The rvgen kunit command generates .bak backup files and these can be
checked in for selftests (make check). Clean targets like make disclean
remove such files, leaving the tree dirty.

Switch to .old to preserve a clean tree after make disclean.

Reported-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Closes: https://lore.kernel.org/lkml/aosuwKH5GOEo0xTN@google.com
Fixes: 7b6246294eb0 ("verification/rvgen: Add selftests for rvgen kunit")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/kunit.py                         | 2 +-
 .../{test_bak_kunit_kunit.c.bak => test_bak_kunit_kunit.c.old}  | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/verification/rvgen/tests/golden/test_bak_kunit/{test_bak_kunit_kunit.c.bak => test_bak_kunit_kunit.c.old} (100%)

diff --git a/tools/verification/rvgen/rvgen/kunit.py b/tools/verification/rvgen/rvgen/kunit.py
index ed2082d7d3bc..85973f918c9b 100644
--- a/tools/verification/rvgen/rvgen/kunit.py
+++ b/tools/verification/rvgen/rvgen/kunit.py
@@ -173,7 +173,7 @@ EXPORT_SYMBOL_IF_KUNIT({struct_name});
             for path in (header_file_path, kunit_c_file_path):
                 if path.exists():
                     try:
-                        path.rename(path.with_suffix(path.suffix + ".bak"))
+                        path.rename(path.with_suffix(path.suffix + ".old"))
                     except OSError as e:
                         raise KUnitError(f"Error backing up file {path}: {e}") from e
 
diff --git a/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.bak b/tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.old
similarity index 100%
rename from tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.bak
rename to tools/verification/rvgen/tests/golden/test_bak_kunit/test_bak_kunit_kunit.c.old

base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
-- 
2.55.0

