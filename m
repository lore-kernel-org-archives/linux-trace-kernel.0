Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B933E26E179
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710663; cv=none; b=FRPxiVh4C7jRkv/uVHNCt1zYMtW7XZD7E/TYJQijxfL5rKoZkwhCcZOe1Csi3LhJnkzjpmtTKOkf4AsI7j397SDawYffnpcmrJBlgSrfE3yNMWeXgKq098x53tVG8U2jycse/pGlGxQcNhcGBiCCnP2eRLxCFv7klK5kkexaiss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710663; c=relaxed/simple;
	bh=R+/yV0o+JJnLpKjC8wFlT8d76sjjU7GgmQ3rxh0TbUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5BRqmff/UJ0s0S0r3GRUMOlfVqXyhYVHbbQOP+QtDRR55/7yTrBPBnMwSWmWoVgTvHauDfw6uXe8XzhpKj7izS/sIKGaRtUNP9pka3MTy3dYeb3MOZZOtDzE24cI9yKnS2fuWBD/RctZn5LAoBffgxj+Qp4nw9nFO/SPlrGE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdlG5o8B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdlG5o8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33+qEpO2Qn72iKBG/1o3SKyae0IY1w7svQavRlY7+HE=;
	b=EdlG5o8BS9khg9ZIsIomUoNfpPFA5lslBbWjz6b4Q1bZ0oRyUMD99yCPlPk3XomcyUgclA
	aDdaDy26rorSTST596VvzvhL1guQFhokVVPPShJuhkLS9fZGRIojdfH29kpsImJ7dNQ0nk
	CB/SPZ5wy1kDsP05EocLAFsYXZ04/4Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-8Trl0vo5PGKkezOVXM_GLw-1; Mon,
 28 Jul 2025 09:50:53 -0400
X-MC-Unique: 8Trl0vo5PGKkezOVXM_GLw-1
X-Mimecast-MFC-AGG-ID: 8Trl0vo5PGKkezOVXM_GLw_1753710651
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CE6551800366;
	Mon, 28 Jul 2025 13:50:51 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 218B81800D88;
	Mon, 28 Jul 2025 13:50:45 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v5 2/9] rv: Remove trailing whitespace from tracepoint string
Date: Mon, 28 Jul 2025 15:50:14 +0200
Message-ID: <20250728135022.255578-3-gmonaco@redhat.com>
In-Reply-To: <20250728135022.255578-1-gmonaco@redhat.com>
References: <20250728135022.255578-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

RV event tracepoints print a line with the format:
    "event_xyz: S0 x event -> S1 "
    "event_xyz: S1 x event -> S0 (final)"

While printing an event leading to a non-final state, the line
has a trailing white space (visible above before the closing ").

Adapt the format string not to print the trailing whitespace if we are
not printing "(final)".

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv_trace.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index b6f310498466..17ba07329b67 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -29,11 +29,11 @@ DECLARE_EVENT_CLASS(event_da_monitor,
 		__entry->final_state		= final_state;
 	),
 
-	TP_printk("%s x %s -> %s %s",
+	TP_printk("%s x %s -> %s%s",
 		__entry->state,
 		__entry->event,
 		__entry->next_state,
-		__entry->final_state ? "(final)" : "")
+		__entry->final_state ? " (final)" : "")
 );
 
 DECLARE_EVENT_CLASS(error_da_monitor,
@@ -90,12 +90,12 @@ DECLARE_EVENT_CLASS(event_da_monitor_id,
 		__entry->final_state		= final_state;
 	),
 
-	TP_printk("%d: %s x %s -> %s %s",
+	TP_printk("%d: %s x %s -> %s%s",
 		__entry->id,
 		__entry->state,
 		__entry->event,
 		__entry->next_state,
-		__entry->final_state ? "(final)" : "")
+		__entry->final_state ? " (final)" : "")
 );
 
 DECLARE_EVENT_CLASS(error_da_monitor_id,
-- 
2.50.1

