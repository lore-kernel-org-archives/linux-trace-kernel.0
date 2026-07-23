Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F90242D6C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792825; cv=none; b=C70nnNyJLQ/oksd+VVyUMQc+8tcHQZ64FB0ejX3wZCasv4VML1uTBfxGxFdz+Rxv50dh83gAlegQ/540vws6iht/SERfXZn0mJ/d1OekrYjWw2VrRSTlui3dQYj3dTpy6IEdlbfqW0lm0FrUwGy0CEbgTJgGkdBSAgC20xENAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792825; c=relaxed/simple;
	bh=xXaIarO6met28YkseyNHcQizFWioTZjYEayWFFiF7no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=SS7H1YJcmVK+zGQawX9+H9pX1tKE8pkt6zNaqrrqflHMwc79MbMkv/DvTkJErvSI8hvBxAUjuhZWULLANTrp1AoL57ifwQTAmoDH+Z4C5dy6NrA427UtXLw2PESfFxNZoaie4C3a2Dq1VgqMCIhH6A0aOyULly4YKGgOW4UuJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VkubqJlr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VkubqJlr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784792822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0rg8/odVrC6K+/oPHjo8skQzS2Qub6L3Pd7Jhfnd+C8=;
	b=VkubqJlrasK+k+fWqrYh9ObKjgn8nfHp5pG/qTVMpBRyDCcqdtQ34F9XA19BJU0ovS5ZDg
	QLIg1J1CWp22eGmrhwSDA08hcGQt8xKXP9IpY8FmevzkCbTBoPRCR36r2pceY4yCvfYpoR
	cRFhsy0ih8W9upNnK3BHJpd/KZ9/tIw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-O-v-SyrYP4yyO5ZFSP0wog-1; Thu,
 23 Jul 2026 03:46:58 -0400
X-MC-Unique: O-v-SyrYP4yyO5ZFSP0wog-1
X-Mimecast-MFC-AGG-ID: O-v-SyrYP4yyO5ZFSP0wog_1784792816
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84CFD197753D;
	Thu, 23 Jul 2026 07:46:56 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.local (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60D76180029D;
	Thu, 23 Jul 2026 07:46:53 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 11/17] rv: Export task monitor slot and react symbols
Date: Thu, 23 Jul 2026 09:45:28 +0200
Message-ID: <20260723074534.43521-12-gmonaco@redhat.com>
In-Reply-To: <20260723074534.43521-1-gmonaco@redhat.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: JusjNFerOyvd1UqzbUI28XQAhpSLf0zehvkjX48PulA_1784792816
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Export rv_get_task_monitor_slot, rv_put_task_monitor_slot, and rv_react
to GPL modules so they can be accessed by KUnit and future monitors
built as kernel modules.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv.c          | 2 ++
 kernel/trace/rv/rv_reactors.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index ee4e68102f17..9d58c730821d 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -189,6 +189,7 @@ int rv_get_task_monitor_slot(void)
 
 	return -EINVAL;
 }
+EXPORT_SYMBOL_GPL(rv_get_task_monitor_slot);
 
 void rv_put_task_monitor_slot(int slot)
 {
@@ -205,6 +206,7 @@ void rv_put_task_monitor_slot(int slot)
 	task_monitor_count--;
 	task_monitor_slots[slot] = false;
 }
+EXPORT_SYMBOL_GPL(rv_put_task_monitor_slot);
 
 /*
  * Monitors with a parent are nested,
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 460af07f7aba..2f5fc8d18dea 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -479,3 +479,4 @@ void rv_react(struct rv_monitor *monitor, const char *msg, ...)
 
 	va_end(args);
 }
+EXPORT_SYMBOL_GPL(rv_react);
-- 
2.55.0

