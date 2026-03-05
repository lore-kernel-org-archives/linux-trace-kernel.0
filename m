Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25573377EDE
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772703088; cv=none; b=oHz8UP1frWQ3kQ/Gr7DG5yeTmxxWKIWtMROoyLmWBqjntE8E0SipV4PhaqW+CKLfCtwx8X5puzDBqDtTHmf+/2dZWQNSqWgBErmptscczfhc6icrXfFgXWD6zCrIO0S5CvKnbmKQyVPUVpOY+sVHh+BjgHZCLvi4Q2+TCdEazK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772703088; c=relaxed/simple;
	bh=HsnH82U8MoHHwwnlKdRLZIiykCyrVjf5ZpUQvUSsi7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=EPFAkniq5Ds5cNuti9sXpzdUZd0lJp19GKxJ5zKInGKEIh9FddhrEYY1FXVFjJPLDdW6B+sx8bOOKRMePotPAgAwcxvvDyEUkfrXCVDIgB+W5gXUpl/Q5SmwNLnmrEZkBElfGPbHYkZbhsn8ITz8mJ20UVX2FfDS8P8C1OXTqZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QecN59Ez; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QecN59Ez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772703086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GLSnB2QNLhEdpv4xnt2zl/CO6QBnADjFZsKO7EY9kJo=;
	b=QecN59Ez/EyRirDMUnSXMeneLdV/MVASmj8mEMeTgU8mHm86Hdj7M7XwQYTXoiNsbpP/I0
	4OyOoaBhUtwWDV+Ij6/bjB4/REGVebl2mohXVNmjCWjoKtXLQvxXH3phLX8YDTNI9YGBID
	G1PjcxF1MmiHsD2cZ2JQbWVZTOLN4zw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-HmxIGhgfOgmxkzsQJtDO1w-1; Thu,
 05 Mar 2026 04:31:23 -0500
X-MC-Unique: HmxIGhgfOgmxkzsQJtDO1w-1
X-Mimecast-MFC-AGG-ID: HmxIGhgfOgmxkzsQJtDO1w_1772703082
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A2443195DB8E;
	Thu,  5 Mar 2026 09:31:21 +0000 (UTC)
Received: from fedora (unknown [10.44.32.232])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AD7AA1800576;
	Thu,  5 Mar 2026 09:31:18 +0000 (UTC)
Received: by fedora (sSMTP sendmail emulation); Thu, 05 Mar 2026 10:31:17 +0100
From: "Jerome Marchand" <jmarchan@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jerome Marchand <jmarchan@redhat.com>
Subject: [PATCH] ftrace: Add MAINTAINERS entries for all ftrace headers
Date: Thu,  5 Mar 2026 10:31:17 +0100
Message-ID: <20260305093117.853700-1-jmarchan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: BxKOtavP-NE8y9SO1lfCmTO0BDLNd3IwMCVUyOuWbH8_1772703082
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

There is currently no entry for ftrace_irq.h and ftrace_regs.h. Add a
generic entry for all *ftrace* headers to include them and prevent
overlooking future ftrace headers.

Signed-off-by: Jerome Marchand <jmarchan@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61bf550fd37c2..b8d1ad952827e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10484,7 +10484,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
 F:	Documentation/trace/ftrace*
 F:	arch/*/*/*/*ftrace*
 F:	arch/*/*/*ftrace*
-F:	include/*/ftrace.h
+F:	include/*/*ftrace*
 F:	kernel/trace/fgraph.c
 F:	kernel/trace/ftrace*
 F:	samples/ftrace
-- 
2.53.0

