Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D91339A4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961147; cv=none; b=GkWU44uGpbkXvVwEtjMyP4ZWkH+5rEL3v5tKe/uHiM9hU3DhmoY7I75bNb5ooFbiSC1UhkngyWc6CMiAyCyg+KJUHNMk4+zbwqyZj+b0tP1Yzef4EgIjbj02dqXBF+R4Bz/PkxQKDhV3K2hWjm0YfSEwAXEYKBYCOlRK+MoYZw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961147; c=relaxed/simple;
	bh=ptMVeKmo0cJAJxCMFFAhxAIqdjU8SsUd25xogvOApnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=CT/ca9/0ZICBH7PuuR50LrAL5HxPrMtAi047/X0y7rLpqgdNqIRqr0aio6YiyMAQn7gHkg9A9k3Mq5YYoPdke5VaHxeOloG8mmse03nltY/fM0q/nSmYIMQsXXfmi1bZkxnm0yBpckqlHSHP/wOxzCcgDwPk7eHpCuFMCOPmfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LyxCmcra; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyxCmcra"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762961145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKWcLMt3tUSrlM2KU3Vt/VSpxlQv7AV3nH7hIWIR8c4=;
	b=LyxCmcragdt5va6quyILG/YQp/QoHOjExFaWjBugTchsYTAaj2UnxDUG4WZH/+y+/Wlwos
	E7d3bzky1K4wRDBWI5WVwaT5jl6jCDiMhr0Ls93eLjsTViUkgEEbFSXfbqZMm/2+CTe0kL
	drmkIdv/VM3atc/ab4eYDk4v8JizVFI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330--txuIRNJNRG8ngI2p1VJDg-1; Wed, 12 Nov 2025 10:25:44 -0500
X-MC-Unique: -txuIRNJNRG8ngI2p1VJDg-1
X-Mimecast-MFC-AGG-ID: -txuIRNJNRG8ngI2p1VJDg_1762961142
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4347bc50df4so113425ab.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961142; x=1763565942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bKWcLMt3tUSrlM2KU3Vt/VSpxlQv7AV3nH7hIWIR8c4=;
        b=ZP2VfZZG1TalLPW+gBBg0Pwu20atA2VpSO20irrT4ZlS7kX2cbfSGkHL3OZaehWeK4
         rt9FkQeZaCUadj1JFzrR5kdT+JK5wdH/rmx/Z+YWkvUyCwq82p9UE1wcSZaFyJWAEZh0
         1PM4uuieHgJIZgHnXWfUJ7RGNS8UK1ktSSCTMbD2kr9w7qeafKvA3R7WB4FtQ/YnfkRs
         5wmkhTWnV1K1/lH4dZ2htVYDnDkGKgHdPAL4bbdGK84mO+mZgl8DbNWq5e+LHRNsBulc
         V14gl/HxgiN1uB8wF1WMJzNZDPGX+t+x0jTpTql6zeIr4hkeZpUmWFUNIa/0DXMpUJoM
         XXjg==
X-Gm-Message-State: AOJu0YxrFpDRlPlpNphJGQwOh+CRZxGPG/U4+46gi6w+acF6lYdkL6Mc
	6Bqo2HpygPdlDSXVC6Ok7F8QFg/EAjGDUqUetSTk5p6fUxlM9XnWxTgWSPxB3JWJV+GEwTEnbBo
	e/pdXKfZ19pbUCXc1pYgVglmxZzTa4w9/mg2a5gFkxFsnXwqRWxXL3/NaM0mnjPgsMFLfhUI5Ag
	==
X-Gm-Gg: ASbGncv+vOzdzsbvvYBzETyRt8CwtR/PIo/7ErAXXLUEX/DhmyjSn8g6ctH0Up4hxZV
	qNuCjkAh7uEvmFKVYLuhDhn+dwTpxo4XC0+hDMoVSen9M+H+KNdr5oSDwXRWvr0ST+JUl/FxIdl
	vuDXyBTCcVOuLWFf4aydXJ+v95KevUrNgjZ5i40l9XgR7+y9OaN/HWnoUhGo5RwgcN9RzXYc3uO
	V0S2IGWpocauiWLmfWZhTNIk+apEhVBDUSSgRrpy0q3o9Lwo19TZSOGk3FhNP5ltIxN5G3Ozst3
	4WbVIRHew7qbZ5rhcKyFrnafVLnEcuTxX+RMnMlUkp/XMTzQpcRWdRDspCuhYe9DH6vfveDxJlR
	0Exwy+W7oKXk3CD1dNa0fge2F5tmiBq0=
X-Received: by 2002:a05:6e02:2186:b0:433:2d7d:b8d8 with SMTP id e9e14a558f8ab-434737d828emr44575255ab.1.1762961142364;
        Wed, 12 Nov 2025 07:25:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoc9vpIggr5uXiIWg7zA8vD2bRlVsNYXVMLKsb1gFy+wlyzeb2ACikDISRi7xFuaY0N/HybQ==
X-Received: by 2002:a05:6e02:2186:b0:433:2d7d:b8d8 with SMTP id e9e14a558f8ab-434737d828emr44574905ab.1.1762961142027;
        Wed, 12 Nov 2025 07:25:42 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347327f820sm11680325ab.0.2025.11.12.07.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:25:41 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 4/5] rtla/timerlat: Exit top main loop on any non-zero wait_retval
Date: Wed, 12 Nov 2025 09:25:28 -0600
Message-ID: <20251112152529.956778-5-crwood@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251112152529.956778-1-crwood@redhat.com>
References: <20251112152529.956778-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _5wGSys039I_DFhpAHNf0OYGtM2NBwkM5q4Ij_ISy1Y_1762961142
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Comparing to exactly 1 will fail if more than one ring buffer
event was seen since the last call to timerlat_bpf_wait(), which
can happen in some race scenarios.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index da5d5db1bc17..56cf4ad64847 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -921,7 +921,7 @@ timerlat_top_bpf_main_loop(struct osnoise_tool *tool)
 		if (!params->common.quiet)
 			timerlat_print_stats(tool);
 
-		if (wait_retval == 1) {
+		if (wait_retval != 0) {
 			/* Stopping requested by tracer */
 			actions_perform(&params->common.threshold_actions);
 
-- 
2.48.1

