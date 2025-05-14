Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DD322129B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 May 2025 08:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212218; cv=none; b=H2cuZdQYHckcaKnvboCbK4yjVGe7+FxAZvgYPImCRO3RVt7ix0hKm7XLy7MQQ6e+ct5xyCL1SfkEV4CqzXyK+RySO5gOUniy8qzj3umZd2feiAiYb3TuQLrqaiyGyr7wPkJnU0RrvzwLQ19DW1UqmYnwmX2oqXWztGExsMQKwa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212218; c=relaxed/simple;
	bh=xbba+HPd8MJ7D54Gm2+hTQ1NpiuwAK3ud94lCs8HFpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erHhazPsAth9gUJ8tYqkO3VVJbKX0xfNBOsSF7IHf1vUCxTZMy6XQp1Pz6S1ZLtUexMUjVGAZ/PocM8kbR92jvfF3A6Gu4Jesrt3juzYkMvGRK2cXDa52vuu3+YhcfuewQvtbMLYubhB3z9KN7wW04hpMa31n+ThHvVnvy+kYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDomdlja; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDomdlja"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747212213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6P2sRzfZTL4Az26XMlLruEd1Y1bAoWFiw+u4PxoZUpc=;
	b=PDomdljaa7A6DxSBX+gbNhl93uBGapU4Sbf8O8JQZGJqc//ubXgBppLdqjXLNGF8m1znZb
	hhL74/1J4smr9i2cxFGFglZL5tpXSs2S7eoKrNH759YStYhP3WZISJ8gB05V1DUfOVnSXq
	xbYiYPMwunWMgGaGb5QPHBWFQoKXl30=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-qovYGxfTOr2KeWauFONYew-1; Wed,
 14 May 2025 04:43:32 -0400
X-MC-Unique: qovYGxfTOr2KeWauFONYew-1
X-Mimecast-MFC-AGG-ID: qovYGxfTOr2KeWauFONYew_1747212211
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD3541800446;
	Wed, 14 May 2025 08:43:30 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.189])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A3BD1945CB4;
	Wed, 14 May 2025 08:43:25 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>
Subject: [RFC PATCH v2 01/12] tools/rv: Do not skip idle in trace
Date: Wed, 14 May 2025 10:43:03 +0200
Message-ID: <20250514084314.57976-2-gmonaco@redhat.com>
In-Reply-To: <20250514084314.57976-1-gmonaco@redhat.com>
References: <20250514084314.57976-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Currently, the userspace RV tool skips trace events triggered by the RV
tool itself, this can be changed by passing the parameter -s, which sets
the variable config_my_pid to 0 (instead of the tool's PID).
The current condition for per-task monitors (config_has_id) does not
check that config_my_pid isn't 0 to skip. In case we pass -s, we show
events triggered by RV but don't show those triggered by idle (PID 0).

Fix the condition to account this scenario.

Fixes: 6d60f89691fc ("tools/rv: Add in-kernel monitor interface")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rv/src/in_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index c0dcee795c0d..72b03bae021c 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -429,7 +429,7 @@ ikm_event_handler(struct trace_seq *s, struct tep_record *record,
 
 	tep_get_common_field_val(s, trace_event, "common_pid", record, &pid, 1);
 
-	if (config_has_id && (config_my_pid == id))
+	if (config_my_pid && config_has_id && (config_my_pid == id))
 		return 0;
 	else if (config_my_pid && (config_my_pid == pid))
 		return 0;
-- 
2.49.0

