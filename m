Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F7F26AA98
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Oct 2025 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085273; cv=none; b=r5knZQnYNoiA8KD6s1lKGVPBUnQXy0F3xGGLrEkWVOKdROcbLEuWjmfwlScBM//VgVjL29ukbdHVuZgI8I1qgRTkrT7+m2M2zp+GphPev72zZnSSEAeHrLSNDyKxD9zYsW558cgSHf0nFrS7a1d1Ps+mjkDdf/br7fkl8PBL0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085273; c=relaxed/simple;
	bh=mCyYCLeUxzP8nczjafTMCHajKjKFiu4GEEWSc+4bDkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeGnFuE6V1kWmwKkZxv0Cw63hpD3t0t2sLGCeKcGuTstYS0lFkEa0QfZ8fa4KzIjrSWHE4Vwr77yv+Ljk5bWjD4XVhu0LBKKAA2IKgXkV6q2Y7gseETAMAICXTcAJ+HAGnIMM4oG0rUTRswBWEIghpnVsUm/GNkssBWzVDBdTNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7WiWm8d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7WiWm8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760085271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V1XMRI4/v+a/C5bhtXa/khLyHUWK2jnBilgpoU7lAjA=;
	b=F7WiWm8d2pHV2BEqC8Uoh740EMbhFpicQObuJj1T9VMTp4HfCBS3szh1RRZNlAVJIJtpvC
	TNHWEq1FKlOdZodYHf9c170XlR901NHPLWXgWCyINxFQCpJrX7J801uGiVOE7b17u1AclV
	x2FOmVmmKbgcmGijVlraD04HAHnodIc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-99Nzr5ugOZmQkcT-1xOcmg-1; Fri,
 10 Oct 2025 04:34:27 -0400
X-MC-Unique: 99Nzr5ugOZmQkcT-1xOcmg-1
X-Mimecast-MFC-AGG-ID: 99Nzr5ugOZmQkcT-1xOcmg_1760085265
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9757F1956086;
	Fri, 10 Oct 2025 08:34:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 40EAD19560BB;
	Fri, 10 Oct 2025 08:34:21 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Attila Fazekas <afazekas@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/9] Documentation/rtla: Fix typo in rtla-timerlat-top.rst
Date: Fri, 10 Oct 2025 10:33:32 +0200
Message-ID: <20251010083338.478961-4-tglozar@redhat.com>
In-Reply-To: <20251010083338.478961-1-tglozar@redhat.com>
References: <20251010083338.478961-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Fix "seem" in place of intended "seen" in rtla-timerlat-top
documentation.

Fixes: df337d014b57 ("rtla: Add rtla timerlat top documentation")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 Documentation/tools/rtla/rtla-timerlat-top.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 7dbe625d0c42..72d85e36c193 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -21,7 +21,7 @@ DESCRIPTION
 The **rtla timerlat top** displays a summary of the periodic output
 from the *timerlat* tracer. It also provides information for each
 operating system noise via the **osnoise:** tracepoints that can be
-seem with the option **-T**.
+seen with the option **-T**.
 
 OPTIONS
 =======
-- 
2.51.0

