Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC9F2E1747
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856518; cv=none; b=K/KJSAjiRWEwfvzPxoFAzmQfaqoeOvMawu0AkMBIXR3sRdEULivgZJ46fskLJwJB3/c5ZZ/hRNOkUdGBMyxn1LCtLKQqiogvcCJ22WSVG8lcHo1AspZUOPVoR3iUh+Ep4+Zcij3EmdPWUQAwQ1mKEfmqMBDn6MsRhel8GAXrvEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856518; c=relaxed/simple;
	bh=wCKv6i46VQo8RzJYs6rWEhK41I7MDPwLrrLLY3O/SZM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4JnO+xNmAveq6JXgtGBBxJgPvtgbP/R0moWyNku//1j3gcoR4OsB3gZarxgPPkvvKUl20kZNMCgoXKuVmCJ8qVbtLesPC8NrkyNqDamzbqmtnrpEy0m/as8EZKlAuPr7oV4lbDmbwzvGnmkwPs9jtg812tWqq6xKutHVAXK24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E2crzw/k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2crzw/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAD9YBzMW3eH6RwLMXXyDtAG2c4/YXRh5uCCHihgJCY=;
	b=E2crzw/ki1vwLD97GpYyvR26vOj9C4vF1j0flhhJCUmY2wudmEgTswavYAP1DJpiosA16A
	cEUtJqI0Yef9sgqKNhoWBBdh4rNrTg26kSBQhNIzru0m25zNeHeGSTMhSSGI4BuRhcmtyT
	kb+CMjJdbuCeaOrEKPFdPkT19ZVWDQw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-EOWiOGirNuKtyZrakNyJCw-1; Mon,
 19 Jan 2026 16:01:54 -0500
X-MC-Unique: EOWiOGirNuKtyZrakNyJCw-1
X-Mimecast-MFC-AGG-ID: EOWiOGirNuKtyZrakNyJCw_1768856513
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0F6A1956094;
	Mon, 19 Jan 2026 21:01:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2476719560AB;
	Mon, 19 Jan 2026 21:01:50 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 08/26] rv/rvgen: simplify boolean comparison
Date: Mon, 19 Jan 2026 17:45:44 -0300
Message-ID: <20260119205601.105821-9-wander@redhat.com>
In-Reply-To: <20260119205601.105821-1-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Replace explicit boolean comparison with truthiness test in the dot2c
module. The previous implementation used the redundant pattern of
comparing a boolean variable directly to False, which is not idiomatic
Python and adds unnecessary verbosity to the code.

Python's truthiness allows for more concise and readable boolean
checks. The expression "if not first" is clearer and more Pythonic
than "if first == False" while maintaining identical semantics. This
pattern is preferred in PEP 8 and is the standard approach in the
Python community.

This change continues the ongoing code quality improvements to align
the codebase with modern Python best practices.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/dot2c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index c97bb9466af6d..fa9e9ae16640f 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -202,7 +202,7 @@ class Dot2c(Automata):
         line = ""
         first = True
         for state in self.states:
-            if first == False:
+            if not first:
                 line = line + ', '
             else:
                 first = False
-- 
2.52.0

