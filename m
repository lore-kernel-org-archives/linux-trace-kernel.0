Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38AC13A24D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727361296; cv=none; b=jZcHV0SOfz9vZyvL06MgXWLafW7cQUq4SwJdSY8MI/AKUOadADae43thlwLji5vdAX9bXzX1J4pljy6Cqt4X8BI5DiYwnKa6f1HaN9HDAXXU+NAKtFh5wPXtTOy555Gz+WfinYMU+WbbfSpEp2XjzuMZ2J8qwIGFsIRKsnT/H/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727361296; c=relaxed/simple;
	bh=+WScVdfovixo0ZPCL9eSPSMSKuZ7RAGeUilkyLQGOvo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uCCWFHDzQ9zx/pOJA2QfBxiUHKkACHKisn5jFXbASp2n6Cx763PlUFUstwrjTsJxCg6sQqJQwcsFV86Vay+lVCShmU63oKvA7IJOkIKsKb4RbdO7dWtiGB+Gjk5v8gthm5DMKhon1bX/p3KStZySYGyh+49i7ovT5dR9LVrFi0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ay2H53hV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ay2H53hV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727361293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SSHYC4Q5Z+iBFAoFsX5X4KzGymPFRdWV82Y9YZAZ6ug=;
	b=ay2H53hVanorC3acC8ABa3lzq2w8PFVvhutHttEX8J6s50K6wLQxQChi4jE8EOVek0buBG
	ODfIkIpC4QkuxUqHs/rO5L2tqgHA0fwiAmicN+Zx34vCMZ8wA6M9G/dBhCpVsYIig+5j1D
	mff72zuxhJz770Wk+hiPWTdocnM1nQA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-jS_tIlAKP2W2O0EEgm1nPA-1; Thu,
 26 Sep 2024 10:34:50 -0400
X-MC-Unique: jS_tIlAKP2W2O0EEgm1nPA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A03E41954AF1;
	Thu, 26 Sep 2024 14:34:49 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.194.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FE6E1979063;
	Thu, 26 Sep 2024 14:34:46 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH] rtla: Fix consistency in getopt_long for timerlat_hist
Date: Thu, 26 Sep 2024 16:34:17 +0200
Message-ID: <20240926143417.54039-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Commit e9a4062e1527 ("rtla: Add --trace-buffer-size option") adds a new
long option to rtla utilities, but among all affected files,
timerlat_hist misses a trailing `:` in the corresponding short option
inside the getopt string (e.g. `\3:`). This patch propagates the `:`.

Although this change is not functionally required, it improves
consistency and slightly reduces the likelihood a future change would
introduce a problem.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a3907c390d67..1f9137c592f4 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -778,7 +778,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3",
+		c = getopt_long(argc, argv, "a:c:C::b:d:e:E:DhH:i:knp:P:s:t::T:uU0123456:7:8:9\1\2:\3:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */

base-commit: 11a299a7933e03c83818b431e6a1c53ad387423d
-- 
2.46.1

