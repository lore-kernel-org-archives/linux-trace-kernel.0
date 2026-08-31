Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40F83DCDB5
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Aug 2026 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167256; cv=none; b=GxNeCMSyumiPoNkGH8I5nySqF4jS3zOmo+YRT+qjHtwov3WDJq1wW1tl9LPUIDlcbCWWPbT53A30fcCpRYsEbiiyFc2Vw4e6qWJo3TobI2Qm5+JaqIaauPPeRQyZFPFbpUFVfLc+zBBi6IvtpHmeqX9++s5pRShcVJdPLJdsk0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167256; c=relaxed/simple;
	bh=0jcN2iFHeLYz5g2Rm8sCC2sW0gbrujvXHoF4PubAbZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=HByFkAEMEfYvWRgUXlqgZUzx1mj72qbeuudAllBuGr2uP0tu03v0MbLOIqtAO6YN/FIMBpEUkxD1sfJH9xCWPzMMBB0FfDwMnLqpTJ6KEdmY1BE1xpiRnfqQ0ti/a3fBPI/BHAMjX8+P4IXOBsUIS4TLcaSbZOrXDQskWysITeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0wL0+rw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0wL0+rw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788167253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y7FpboE6dB3g0qpILJfxK978PdFVDdCOnXJM43FKdQ=;
	b=I0wL0+rw+k0V3WM4MbgGJ6elmxCR96Myf72zSPPJ9ZcmfPAtmk/M0joxa5j6IL/YYmS8Jr
	PPXuWvpmomK4+ktzeO1LTR+WD2oyAMgWpMwkU2yNeUtr4YGpkPYDn3NvC/5ohmkbZkhHzB
	vhdf9YuDfecCD5bLeFXCJLrFpsrXSbM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-9DsAUIwOPmGo7pc0SIFRtw-1; Mon,
 31 Aug 2026 05:07:29 -0400
X-MC-Unique: 9DsAUIwOPmGo7pc0SIFRtw-1
X-Mimecast-MFC-AGG-ID: 9DsAUIwOPmGo7pc0SIFRtw_1788167248
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0C02A1831372;
	Mon, 31 Aug 2026 09:07:28 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3784318005BB;
	Mon, 31 Aug 2026 09:07:24 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [RFC PATCH 08/20] rv: Cast result of model_get_*_name()
Date: Mon, 31 Aug 2026 11:05:12 +0200
Message-ID: <20260831090524.106845-9-gmonaco@redhat.com>
In-Reply-To: <20260831090524.106845-1-gmonaco@redhat.com>
References: <20260831090524.106845-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: HV9Q6hVgIbVgCAXjdIW0egrwEm4w_qz9D61-4-eaqZc_1788167248
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Functions like model_get_event_name() and model_get_state_name() are
shared with BPF monitors, however those programs don't play nice with
string pointers without fixed length and the event_name and state_name
arrays need to be defined differently. This gets the compiler to notice
those are const char and the above function discard the const qualifier.

Drop the warning by casting the result to (char *). Note, a cleaner
solution would require to modify all callers, but that would require
changing every single monitor's tracepoint and the advantage is minimal.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/automata.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/rv/automata.h b/include/rv/automata.h
index 4a4eb40cf09a..3c7070e91d11 100644
--- a/include/rv/automata.h
+++ b/include/rv/automata.h
@@ -27,7 +27,7 @@ static char *model_get_state_name(enum states state)
 	if ((state < 0) || (state >= STATE_MAX))
 		return "INVALID";
 
-	return RV_AUTOMATON_NAME.state_names[state];
+	return (char *)RV_AUTOMATON_NAME.state_names[state];
 }
 
 /*
@@ -38,7 +38,7 @@ static char *model_get_event_name(enum events event)
 	if ((event < 0) || (event >= EVENT_MAX))
 		return "INVALID";
 
-	return RV_AUTOMATON_NAME.event_names[event];
+	return (char *)RV_AUTOMATON_NAME.event_names[event];
 }
 
 /*
-- 
2.55.0

