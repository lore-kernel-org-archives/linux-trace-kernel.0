Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467031E83D
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053183; cv=none; b=hadksw5MMPly6gE96aj+jEMilTtAh42AZArenyhR1w271RMH9AQF02Eivse5oEWWWxxC5swpt2w046waxlAAboZzW14OsyHMohcl1wAH3oFaBkU9Nl4CqM8WmufBqMtFhbhHXfRvR6znJ9v1yUyEZP2RMDHbquK0zhJNFQzTxcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053183; c=relaxed/simple;
	bh=1XTpm4URt0IkfvvA3Q7ZAK7H3fkNGIUgUKGK+pqmYDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1/Wp74oOmKMTTfbjYaZp0y0v4Bl747LcGkISsmEkXEa4hpyfS1cmXgXbSmueBhpflAke8NtzXIJawkq0W0+KTphNa3WVQBOPw2PFch0/xP2FLtWmMVhTlULp8a12CXq5aiMwSQ6iAyvn99NQlAK8I96AffYW10l6/ku4MPfubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1S9UdAe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1S9UdAe"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4957eefd361so20052185e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786053180; x=1786657980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=avK/Zi8hIhs1R5+1CNpCZLSMDvwE9dj5Z6g59fOUQxM=;
        b=E1S9UdAe67KUTyOb4y2ra3lKRN/7u9DaYNyJfY24sNDc0QJCME6RsiXvb8mE05sNoW
         Z/05YhnM8pne8N1gu4Dh8fwubFDxoYAR+cKJ6/mogLV6+Ci/PgjgzQaqyFZKzqBeqnnY
         Y1CXzXnCmow2+tjMZsHOc7qPO+e2rGdCN2/8vIcv7TNCeLlIQW9t1Obxup2VOkHjHMF9
         5jGWyaGWWNVGZauKLrjcl2fTG2H0A0Q0/8LA+iElAAR17EnBhDSLegCnD34ApWclmRi6
         QNqhJvA/Jd4yvxhqXn7VHjq5PTMpOJCFrkUIFgT+R00QjCw7b7mR69aYMvwLlbNq0N1F
         yIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786053180; x=1786657980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=avK/Zi8hIhs1R5+1CNpCZLSMDvwE9dj5Z6g59fOUQxM=;
        b=RFofXDPXMcf/Z6rGgqDKJ6VfFgJQBj10GG2sKlvGnxCcSOw4nNCHWGP26Mi7D20H2u
         0WCEZ/cl1c2jOJi7C0Yo7hsP5vKf6C8iCM8sjIunuWSgsQOIooonzpW3S4qZ/wpiVGVE
         4eWIF4L1G5a7+tAaX4VKth2uI9asYQaWh2wu4q0WwZM8/4lkVvwC117F5Aqq99pXXriT
         dXtCcMUIZqsR21/5agceiKRNUqBhUX0Cb6lR1WX+OLOBBB9jxWaJEktaHDUUgee4k/t2
         K416o8KTOKODVyt3/Drl8bQJYENUTJnP+kbZBRUdGk2Y7pkAzUmnt/R1DodJsejju7kB
         upUA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1M6AFIdwk7TKXEvyA+NCM92IiC520ulDNSbwGsiBv8tAQRCzK+9srZnMaIu1JGdNPYwRbHmRzGmnvNUKar2t+xjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8qxk4KHWcp1lcpfuHYXd6oOakahR561GS0qdvdwmTFI/ZphGf
	kniMM4/DXQzFOiMgsgAW/2LVVFDJsYs5IEt07/moBp+x3tEKMqRIjtSL
X-Gm-Gg: AR+sD11P829+BrWPprhPV2m3yFOutEDVUW8ADRjSh55t8Kj1dGgSQBwX07jgJqb/+ch
	ln43FUu4j5KMmfUDvCHIKggbsbiZyfk7mwgb5qeMh6wVysy5V7dKjZKhEtQ5M52qO9L2+LFUhdk
	+rMIvfZ7HjslcFJ+l93ic003VUmBuapdZj7cHkByffZvT58mLsWXTS97rgDWni4gRFuVijvly2P
	QgOKjlCAct/yATCRrZHnzesXB5u5oLhHbWF1JGexcXPjNHtOFoZZxvYLGgWedz6zVN6Jmif8ZGV
	YMjH1/TDYrSSyNfw11e4sqQ0iF3Ugk/9P5nxOX9VIdmNPxvuY9n4wPA1wA3jP/x1wfQ3jTB6Ey3
	H1r5DD6f2wmTgAwyjXRRecbo+p2oVHBbUFTopBy1KrKiilN7y7dO84qqIs3dsj240ncKLfIkt6h
	0XuMWBvAdFh9Jg3dTFDaUzLq8mMhXtkrN8wS9BK/GNSxIun4SewheHt+CF2pMeYwlQX/ai8BkcA
	Og2VBF7e/EtZHsjhq5kusw5Bc6BujWILt2pbnc4Qg9sQYGZ
X-Received: by 2002:a05:600c:529b:b0:493:a613:56b2 with SMTP id 5b1f17b1804b1-4994e71d3e5mr261220245e9.8.1786053179725;
        Thu, 06 Aug 2026 14:52:59 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm91381405e9.0.2026.08.06.14.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:52:59 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] tracing: Report every TP_printk double dereference
Date: Thu,  6 Aug 2026 22:52:56 +0100
Message-ID: <20260806215256.1680267-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806174110.11fcd317@gandalf.local.home>
References: <20260806174110.11fcd317@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WARN_ONCE() splats once per call site, so only the first offending event
registered is ever reported. The tree currently has six:
ice_{rx,tx}_dim_template, two hfi1 txq events, mtu3_ep and edma_log_io.
Whichever registers first hides the rest, and each has to be found again
on the next boot.

Add a pr_warn() next to the WARN_ONCE() so every offender is listed, the
same way test_event_printk() already pairs WARN_ON_ONCE() with pr_warn()
for unsafe %p* dereferences. The WARN_ONCE() stays so the condition still
fails tests and panics under panic_on_warn.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a8590d2394e3..ce902482ec7c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -415,6 +415,8 @@ static void test_double_dereference(const char *str, int len,
 		ptr += 5;
 		for (; ptr < end; ptr++) {
 			if (ptr[0] == '-' && ptr[1] == '>') {
+				pr_warn("TRACE EVENT ERROR: Event %s has double dereference in TP_printk: %.*s\n",
+					trace_event_name(call), len, str);
 				WARN_ONCE(1, "Event %s has double dereference in TP_printk: %.*s\n",
 					  trace_event_name(call), len, str);
 				return;
-- 
2.55.0

