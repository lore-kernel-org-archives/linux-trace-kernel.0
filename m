Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551436654C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944836; cv=none; b=BrMx1ldhwwnq4O1MH0IitJbzlLlM3fwjalEioYFNd/iCBYS0Hrp18hu5LjMNxe1duPnD/9RSk/tmxkYzGi1nBwJRAQ5rSboEMtu+B8Kudit/xos1oQkBjH0ip248iz3Oe1HJQYQzzzK7SzGOmo18W3f4BpvxL+rDIBX8QHHO6vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944836; c=relaxed/simple;
	bh=syvuoa4lapmQfXi8eX5+79Kzo1jijVYfOy8pl/HtiVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=H+MYHTlHQXIOV+BbHRRLdtNPyDEbsT/zYq264svd+V+iL0ZKnRNoZ0QVrrAYG7VcjaDDQgyEZrpRGj0C5UYUiM/Apl2JdOHqvBsnaR85xcbw/qsVa7FSqfX2uEH9KtJTm3ireKgUNZFQJ/b0+/MzjTPZ13yoX89aiq34dH+Qxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CI3b+rin; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CI3b+rin"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791944831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRiZIW0m5+sSjStRsXiBdpvIrODCS4/UGCRlYsfZ/0E=;
	b=CI3b+rin6E5LAqOnbLhSkLds0vqFlOyitRSvRT00eZB+dPq0R4wwZDJC+W4NAglMd3Kk1F
	SK2YtsnGumhtTf86ujZNBTUfQPVtQFC+0mbkhGTqGvcyYuwWPPyGsgPVa+Fp9liICx87hG
	BGS/V9oCxCc90IHKbzaB5yE9WzIUd74=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-LhorMbymP5-0hwEh95jRGA-1; Wed, 14 Oct 2026 02:27:04 +0000
X-MC-Unique: LhorMbymP5-0hwEh95jRGA-1
X-Mimecast-MFC-AGG-ID: LhorMbymP5-0hwEh95jRGA_1791944823
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5339739b343so76340471cf.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 19:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944823; x=1792549623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yRiZIW0m5+sSjStRsXiBdpvIrODCS4/UGCRlYsfZ/0E=;
        b=OG7HuQbcRQNT74tH1rCbdVxqiB+ZimtwTLyiKsd6w9P32WPbJRLPkJgL9HEZl4aqRt
         t6DSWlOpO+jW+mlWFOYsUVhzot9nNy7SWqgC55S/N9/53Uc6UpVQeOrchY4MeH032KNN
         wOlMYwdO5hEtGmFQ9qhNEt9AT0viYcFMfrkNPgQeF9R+P1p32ngH8g/pJOGdfDp2B8Vx
         BXKztogtnHUmdd5PUFDxsdQi6lGO1arI1728KFJJsLPFS6Vvi+LLt+t5a3AQugho48VV
         kgi3g9r0nYEVZTFvr7WMLjSrFVwTr0PramSvvf7ftOxDfQUsgYrGKUEnhsrcNRVAvFuH
         3QiQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBhXe7+endpPMsiwxegWhf3D5ZoJ7wwkoVP/2SYOOg/WA/vaaRk6mbdciXJIbK180B2GQK46etclUZsDHjISqAejo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFfXICINr4/at8J4uZhpwGgBzTiSEsiWyS9xXEhZpZ0WRqKHAk
	TX+EXEpuIGOLtd+O346puWqmVRf3QMuwTdtbT5LQ6AD2Vl5KCGgZ+4cQDFZyrqGcAx7y0WFKxvH
	j2J1EHTsgBRi+zNla8IMggJRwWNeJiic8HwA2kxNDznBWbGO4jIUDemKHlKdXltXK0bgKcBk/fj
	Re6S7t/Q==
X-Gm-Gg: AYBFou2qNtPgmqhcelNl//E0mqbXpZTM2DGHFypIQLrKQMdhnN7/7vcsanzfih3ZSfo
	YSJAKL5YiJvRTa201sE0wBOuHycfcNpv3QdH0TAa+Jb4VuRuDpxqopO1Ai80APuzTdS7c7Hc3Kr
	XcgR1KeyMXKPp6iBJ1Ri3u9eV7sW6EEmWjVKlWsUMXUTOjTpiBW0snHIUyQCHIrvoTfaQePDIYr
	s0Hqvd+SXR8xpw5y9OqSF9HU8tm3TAeq6sAXkBnZ4XXVkLeoTAGI300CHV8bnsl+v9aFXBW7IJG
	wtqu8ozYtu3twhJI4k4Uh+OBE6H+S47AJ1CDFyokFbmIr7rTsQbsIlNm1g/0L0CNlfaZZbgaC2R
	ECJue87uTTNm34NiJLgRSAhSqDjsqF9hd9X6H8Y1nKea9xI8eqc/GuMo=
X-Received: by 2002:a05:622a:2486:b0:533:8f97:9362 with SMTP id d75a77b69052e-5359fdd0ba0mr222024991cf.49.1791944823407;
        Tue, 13 Oct 2026 19:27:03 -0700 (PDT)
X-Received: by 2002:a05:622a:2486:b0:533:8f97:9362 with SMTP id d75a77b69052e-5359fdd0ba0mr222024821cf.49.1791944822986;
        Tue, 13 Oct 2026 19:27:02 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b387e0sm41051566d6.12.2026.10.13.19.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:27:02 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v3 8/9] tracing/osnoise: Print taint message for timerlat
Date: Tue, 13 Oct 2026 21:26:39 -0500
Message-ID: <20261014022640.695786-9-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014022640.695786-1-crwood@redhat.com>
References: <20261014022640.695786-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WeqNhYE0MBGEIPkSEjQ5mqpTQkJIAvxALpaSqqdCrJU_1791944823
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Provide taint information the same as is done in print_osnoise_headers().

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v2: new patch
---
 kernel/trace/trace_osnoise.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index d799c400ed9b..9ca45b0b8cb3 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -577,6 +577,9 @@ static void record_osnoise_sample(struct osnoise_sample *sample)
 #ifdef CONFIG_PREEMPT_RT
 static void print_timerlat_headers(struct seq_file *s)
 {
+	if (osnoise_data.tainted)
+		seq_puts(s, "# timerlat is tainted!\n");
+
 	seq_puts(s, "#                                _-------=> irqs-off\n");
 	seq_puts(s, "#                               / _------=> need-resched\n");
 	seq_puts(s, "#                              | / _-----=> need-resched-lazy\n");
@@ -594,6 +597,9 @@ static void print_timerlat_headers(struct seq_file *s)
 #else /* CONFIG_PREEMPT_RT */
 static void print_timerlat_headers(struct seq_file *s)
 {
+	if (osnoise_data.tainted)
+		seq_puts(s, "# timerlat is tainted!\n");
+
 	seq_puts(s, "#                                _-----=> irqs-off\n");
 	seq_puts(s, "#                               / _----=> need-resched\n");
 	seq_puts(s, "#                              | / _---=> hardirq/softirq\n");
-- 
2.54.0

