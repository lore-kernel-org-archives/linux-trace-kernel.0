Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ED7239E75
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856837; cv=none; b=BvuNjwmO5D+MWC0d/bYX1BVpl8EyDgERbie54cRcHJTgnARGrF9IFKOUMCmhOglGYM57Nv2a4tqgAl6+T/6J3TU59HvacYpIOdDs9fjfJUvKOV4oA0NtozklHf2HdQQfrbiDsdl4Kvd+kqiPeg0eveYn4p5MIDRsoZajRM8EC2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856837; c=relaxed/simple;
	bh=cRu5YyFyW5ncz8d6STwz6wUFck73wJUX3RXcijE+riU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTqpwoD6q9/KZFt2RzS2xR8ZmRSDCwGTaymMXQsHG6yUGmac3q+s7MShDAcIF3zHKY9gcplkM8h3Dzs05PmakX2I//wu39f/68SbbaDrou/UucgU09bwnF+U0ePxAgrMvEm8RJWDyLiT8UMj+ZSJ7S9IkCDpPKYPloHOLb2Leco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTmDSnOD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTmDSnOD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h1WMJMRweu7596gWptGsF6jL9Z0Hnc5bO/Q32rTlSFI=;
	b=QTmDSnOD7BK9S5rMcklqrIg8kzJ3F0CZB8uo4eowiatrGDVOlCRYXYSzAYzxt9tXKdA04K
	uGsMQ0QlUuYYQ9KcWkT0u0bJmtaVWdX/NeAj3oZ7xs4K2loAzi1GumDU50ggHIsfVz4X4a
	WeyhV6BvUShtu5xQfykmg11QAyz4xh0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-c80JDzhRNZ2rQ1ojstpLpw-1; Mon,
 19 Jan 2026 16:07:11 -0500
X-MC-Unique: c80JDzhRNZ2rQ1ojstpLpw-1
X-Mimecast-MFC-AGG-ID: c80JDzhRNZ2rQ1ojstpLpw_1768856830
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 79A4D1800447;
	Mon, 19 Jan 2026 21:07:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EA6B919560AB;
	Mon, 19 Jan 2026 21:07:07 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 21/26] rv/rvgen: remove unused sys import from dot2c
Date: Mon, 19 Jan 2026 17:45:57 -0300
Message-ID: <20260119205601.105821-22-wander@redhat.com>
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

The sys module was imported in the dot2c frontend script but never
used. This import was likely left over from earlier development or
copied from a template that required sys for exit handling.

Remove the unused import to clean up the code and satisfy linters
that flag unused imports as errors.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/dot2c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/verification/rvgen/dot2c b/tools/verification/rvgen/dot2c
index bf0c67c5b66c8..1012becc7fab6 100644
--- a/tools/verification/rvgen/dot2c
+++ b/tools/verification/rvgen/dot2c
@@ -16,7 +16,6 @@
 if __name__ == '__main__':
     from rvgen import dot2c
     import argparse
-    import sys
 
     parser = argparse.ArgumentParser(description='dot2c: converts a .dot file into a C structure')
     parser.add_argument('dot_file',  help='The dot file to be converted')
-- 
2.52.0

