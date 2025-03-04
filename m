Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D644D2063D4
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Mar 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098204; cv=none; b=JNv+2TAbqUiXBOgA8xi7fJ9TtGkKAjc0YxKs8/9KP+Dfq35hqx8IocRZMJtcK5zC0snHuRbm3CMbUc+Cg48m3WunZeM827vWH1yXGTk0FzfGA9FRF0gjnphqEROcvjq7jFIB2wk1ZzXoyAzBSqWFnAl9p7obtdQx3YXD6n9G+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098204; c=relaxed/simple;
	bh=o0nIP+iK6OAB30vRcT8cW4nyCWpwPA0CBIu37QSA3C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zi+txf0W5fNaB3I6TFueYE15q25eQYt1s4DHLAXpAvxeRMYPdrjdXuD7MNaOl3L1CkcGChLJXPrpZI8wY4wLL3X84kiFHyARp6Z3XOxHePERahYv0aXA3CecdWTDIZ7c7JbdJxX2GsAerBJbhlFjU7C6HFOl0wvKgKVHfToEYOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTOMaFnZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTOMaFnZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741098201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o8Y3blARs8HOt3v7nbGnlDEcPvZYsitdJvmKLOEigGQ=;
	b=LTOMaFnZXUn391/drAglt6O2daG8u7LFWgOZfh2/gsVqAcTydb4aL6LNGKoq0EoFVyySeV
	95Ux2QCsmDFuSeB/X/YsY368pRE5ISyBiiSrNSV0KYA+SDVcncVSCztiTauRTKr/UqW3UI
	oawN2qsL/DeFU51ZNrJJCWnYMczDdzw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-DZRwrSqoNNSecsA6bCpr9Q-1; Tue,
 04 Mar 2025 09:23:17 -0500
X-MC-Unique: DZRwrSqoNNSecsA6bCpr9Q-1
X-Mimecast-MFC-AGG-ID: DZRwrSqoNNSecsA6bCpr9Q_1741098196
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DC21190ECE0;
	Tue,  4 Mar 2025 14:23:16 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7953C180087B;
	Tue,  4 Mar 2025 14:23:14 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] tools/rv: Keep user LDFLAGS in build
Date: Tue,  4 Mar 2025 15:22:28 +0100
Message-ID: <20250304142228.767658-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

rv, unlike rtla and perf, drops LDFLAGS supplied by the user and honors
only EXTRA_LDFLAGS. This is inconsistent with both perf and rtla and
can lead to all kinds of unexpected behavior.

For example, on Fedora and RHEL, it causes rv to be build without
PIE, unlike the aforementioned perf and rtla:

$ file /usr/bin/{rv,rtla,perf}
/usr/bin/rv:   ELF 64-bit LSB executable, ...
/usr/bin/rtla: ELF 64-bit LSB pie executable, ...
/usr/bin/perf: ELF 64-bit LSB pie executable, ...

Keep both LDFLAGS and EXTRA_LDFLAGS for the build.

Fixes: 012e4e77df73 ("tools/verification: Use tools/build makefiles on rv")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/verification/rv/Makefile.rv | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/Makefile.rv b/tools/verification/rv/Makefile.rv
index 161baa29eb86..2497fb96c83d 100644
--- a/tools/verification/rv/Makefile.rv
+++ b/tools/verification/rv/Makefile.rv
@@ -27,7 +27,7 @@ endif
 
 INCLUDE		:= -Iinclude/
 CFLAGS		:= -g -DVERSION=\"$(VERSION)\" $(FOPTS) $(WOPTS) $(EXTRA_CFLAGS) $(INCLUDE)
-LDFLAGS		:= -ggdb $(EXTRA_LDFLAGS)
+LDFLAGS		:= -ggdb $(LDFLAGS) $(EXTRA_LDFLAGS)
 
 INSTALL		:= install
 MKDIR		:= mkdir
-- 
2.48.1

