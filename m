Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B15275AF
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 Oct 2026 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790868137; cv=none; b=Mi0bby3KdVjJSzCFsRmhR9j+x0Fewnilnud7kUNU9pgt54HueOokG1TQcOSmuZ5f0D6rY+hD6LHqQKO7dZNtdbAAx9VP+/wLodXGUwS4LmuftGU/AdbD25X1zm55mNncLDPAe6NEPoGi4WjZuaJ5iCH7OIq80yOQcB5kj/QAapc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790868137; c=relaxed/simple;
	bh=zI2YI6aReIsoSRE1TE13CsuOGxAKDRDO8kngeMjcQ7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CYw4eTZyB8nx7pe5LmNGZ/IkxvKqpySeJ2EpUdLTcz73reUCjAgcEficfUxP9Azq8Q6smqpMia4FzeLowxFk+tlJjLbZNXwBaPwcNCKUTCWkg5iCiZQdr6qVjValFRFH9c9e4EOsQ9gTcENqj0AJi9msYDvUDJpj6z30m4NBKIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QL2JkUuO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QL2JkUuO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790868134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=feYEemLNHRk82Zu69wkYHuGGghEgRdXVuguz2t/TLs8=;
	b=QL2JkUuO3od82LQAMW7AaH8vt7vFXrEDq5d59HiMTEe6eqijTACasF81r0p/Up1UJCHh4C
	j8MZTcipmz+rPdMs0VXVCV8UpEOLokgipFnKoFLrtHG1QUdIFqVZa4TXPkVvXCW44lF7vm
	KiqKZJDvUK/Z0epHD53KoBTZTfzqBRc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-HfkqHvDENLynBRgUYJn3Ww-1; Thu,
 01 Oct 2026 11:22:11 -0400
X-MC-Unique: HfkqHvDENLynBRgUYJn3Ww-1
X-Mimecast-MFC-AGG-ID: HfkqHvDENLynBRgUYJn3Ww_1790868129
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 243D019541B8;
	Thu,  1 Oct 2026 15:22:09 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 48DEE1800352;
	Thu,  1 Oct 2026 15:22:06 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH v2 11/15] tools/rv: Define CONFIG_X86_64 statically for BPF monitors
Date: Thu,  1 Oct 2026 17:20:38 +0200
Message-ID: <20261001152042.124445-12-gmonaco@redhat.com>
In-Reply-To: <20261001152042.124445-1-gmonaco@redhat.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: h7rUV5rU6avFnXesBev9TOKGrEjTY4lNbODvx-WWADw_1790868129
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

BPF atomic macros require CONFIG_X86_64 to determine barrier
instructions. Reading this from the system Kconfig can fail if the
configuration is missing or in an unexpected location, causing the
loading phase to fail.

Since the rv tool is compiled for the target architecture, the
architecture is known at compile-time. Define the CONFIG_X86_64 value
statically via the libbpf open options to bypass Kconfig dependency and
ensure reliable loading.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/bpf_monitor.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/bpf_monitor.c b/tools/verification/rv/src/bpf_monitor.c
index 9a3f00febfeb..d43ee75d3904 100644
--- a/tools/verification/rv/src/bpf_monitor.c
+++ b/tools/verification/rv/src/bpf_monitor.c
@@ -719,7 +719,16 @@ static struct bpf_object *open_bpf_monitor(const char *path, struct bpf_monitor_
 	struct bpf_object *obj = NULL;
 	int res;
 
-	obj = bpf_object__open_file(path, NULL);
+	LIBBPF_OPTS(bpf_object_open_opts, opts,
+		/* Define statically as arch is known, Kconfig may not be available */
+#ifdef __x86_64__
+		.kconfig = "CONFIG_X86_64=y\n",
+#else
+		.kconfig = "CONFIG_X86_64=n\n",
+#endif
+	);
+
+	obj = bpf_object__open_file(path, &opts);
 	if (!obj) {
 		err_msg("bpf: error opening object: %s\n", strerror(errno));
 		return NULL;
-- 
2.55.0

