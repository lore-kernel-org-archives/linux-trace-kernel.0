Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859F19ABC6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864158; cv=none; b=N8swWps62QOstAVwYeAbHkDs/UYKSCUpTg54Ttzt6RFZ594mIxjOIUcupbu7L0NB05oE14J4OVoL3iZcifqQgrOJnBZ5Kc4D+8jr1UMchSiK/mE9hiPN/cOydmiFivzgBGDXXZfAIziGyC1XGXYx5SL2D5YYncB4xfooSf7rHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864158; c=relaxed/simple;
	bh=tkxyV2/SJmMyCf1/A4WWOPt/5oameV796XbiX6OYyx4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=pB+Rf664+R0rR8+/pT5qV2V5oigaO8n+gEPBwjCzHVzFNlFrxamE5XOYyOOCZ8D/CB/xxDGYQxKhAYy0qvAVmJf8ZhnfVOSdgpvUFh0AQ4R25bsPqLSJbw1qYcr7CMYbjlp7tOstC7JaKUZf/9UtoglZ/ah3DEIKjaTAL6vxkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aiD3slFd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aiD3slFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771864156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Gg0Xg7GuMZrOytFimMyWzeLYWG1wEiuU7NhsKmvk4Q=;
	b=aiD3slFd5xSvqs3iVR5eghqSklSPPfNjhzqxR5dlnnYHBzj7lBOVKajaT5LZ3kHSCJ/eEJ
	rWytY9Df2Rg3JzzN7bItQYEDHbE7k3Y+FHnjIqV1Wgevm84EdsiLBoluxQxwkiThm8Fm3K
	MWXeYS3SfZuyH0mE5zcpuqReV2ph0X4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-9dqp60XrM-Cp2BMxxspYdg-1; Mon,
 23 Feb 2026 11:29:12 -0500
X-MC-Unique: 9dqp60XrM-Cp2BMxxspYdg-1
X-Mimecast-MFC-AGG-ID: 9dqp60XrM-Cp2BMxxspYdg_1771864150
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43CF318005B0;
	Mon, 23 Feb 2026 16:29:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 03BB4180066A;
	Mon, 23 Feb 2026 16:29:07 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 12/19] rv/rvgen: remove unused sys import from dot2c
Date: Mon, 23 Feb 2026 13:17:55 -0300
Message-ID: <20260223162407.147003-13-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 9HLTVLU4vxs0fH65jNw12vKslONLJBKahRqoGj8HAo8_1771864150
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The sys module was imported in the dot2c frontend script but never
used. This import was likely left over from earlier development or
copied from a template that required sys for exit handling.

Remove the unused import to clean up the code and satisfy linters
that flag unused imports as errors.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
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
2.53.0

