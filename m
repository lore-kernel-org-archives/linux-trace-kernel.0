Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AD19B3DD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559042; cv=none; b=jQ6AwwEOYhec/yDyEOyl+uEInvcxAqQq1zNWcH5lyFgsZ1Ipg+c23B6+704mk3qCaXHbflVOX7gfgfvlngiJeWkdDDIAisspxSJFmsG5JikcwsKnuFRV+wL1hc12aAHA0oIhhbXJz+Uy549KdLCidf0QTDJBN8RaPFVfyGykSkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559042; c=relaxed/simple;
	bh=7xz9xO0BH+XbR37GvL+QAQBFu+Odncv+Cg+8Ri5QxYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p3go6iWgXgP9iDCOFCwT6pIIJzLLVSF8PksEThMwK55OXSyMwQTIRA6n9pmI6cuIhOyu6BMJHOY3yav4TQOW7w5nsW3EQc0Ar6efl5c9tnt7r7STtdbe/PMclr4ItkhX0lPu1sR9zBh9pN5gK2/uK24h/+z4GKehoyERedMLYas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dLCKrS+Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dLCKrS+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723559039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FQe4RFWT5NHB4r2kFDC75BaAeXRBlSwVTPsyF6A5XbM=;
	b=dLCKrS+Z5wDrDzdUTOtzTqTdK3qH/iZETeXyauW/9zuaheB7RW12kCiT95M6XumeSgW7xf
	ehrNDhwnwBRyCOzlFiTwFF+0ilF+7ngoAMQVHAlK0YNwxrXR92XQI3R1bHTBYIvnZGTdvv
	AGOiYqKbKCK4OcwV2x/kqNw69Hf8lQk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-twUwsggDMwWaC3xcTKb0rQ-1; Tue,
 13 Aug 2024 10:23:58 -0400
X-MC-Unique: twUwsggDMwWaC3xcTKb0rQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B11B1925383;
	Tue, 13 Aug 2024 14:23:57 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.192.249])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A9E11955F6E;
	Tue, 13 Aug 2024 14:23:54 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: linux-trace-kernel@vger.kernel.org
Cc: rostedt@goodmis.org,
	jlelli@redhat.com,
	jkacur@redhat.com,
	williams@redhat.com
Subject: [PATCH] rtla: use the definition for stdout fd when calling isatty()
Date: Tue, 13 Aug 2024 16:23:38 +0200
Message-ID: <20240813142338.376039-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Use the STDOUT_FILENO definition when testing whether the standard
output file descriptor refers to a terminal (for better redability).

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 tools/tracing/rtla/src/osnoise_top.c  | 2 +-
 tools/tracing/rtla/src/timerlat_top.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index f594a44df840..73106683c281 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -627,7 +627,7 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *p
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
-	if (isatty(1) && !params->quiet)
+	if (isatty(STDOUT_FILENO) && !params->quiet)
 		params->pretty_output = 1;
 
 	return 0;
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 8c16419fe22a..94a2f5bbaeb7 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -850,7 +850,7 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 		}
 	}
 
-	if (isatty(1) && !params->quiet)
+	if (isatty(STDOUT_FILENO) && !params->quiet)
 		params->pretty_output = 1;
 
 	return 0;
-- 
2.46.0

