Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943142D8DA3
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Oct 2025 06:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299047; cv=none; b=jWov3haucrMC+vHumb2gpUKztkP1/xaheEF/F+JqRkAZEoqlh30zDJ8JVAIP1dPqXXLJZ1uQuHeRzJD1IjVEb598eShPrQS/YNfVgw96WtXjr6SCeqe+yaaYqKR/6z2Dqjowok84pGYzzXOgXHCZlr6RBBcB0gdlfS5WhUkeQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299047; c=relaxed/simple;
	bh=dd8tAMAvunlHBs2TbfV6XdzIsVPgnLl/i4lwLZiiVVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=giL10tuzhQz74WJyk+wl40ar1FiTSK2N9OladIWxky3VpH9V0pAnFhp/9SQ+aLAp1v0e1NBgFx0GD06eoXFQhPwBFsfxsdtc8Ks+uX2uwFhvdcm28rSRPRPYC2XjcV/h3k1BQ2sHFJ0u/tBEEPQKyBXWc8JoR4dOz3nsXdH7KU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WEmC3XDz; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WEmC3XDz"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b47a5a17303so1929666b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759299042; x=1759903842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=96lBuGyGNqGdmWvV/PJjpenC1fPHuudOMddkc9JukfQ=;
        b=WEmC3XDzfBuZJ32BHtahV8bpQI4iqkdQXPau8DKG4pVQzpgCGCTV8+VQkxELZ0x7GP
         RJ0WHocK6+20a6LkOtV3uJPv1KcMXV1fi94VX6z0yA4OzbKBgzl1gfHIfQg3HthCje0u
         csadRUj3cLQyBg+aKmjZI4g42h496IH7vaSNkCmR9dxTpJIkvi74Z//hmapMXyeZtugw
         QZ622bltb9fraYQ32pcK5pVJhDToUEBZUNC5a9cxvyp16puZDFxnX9IgKzqdnWHsn0zf
         eUpXrWMYDuF4DWZ273eM26TcqKZpCaHpMSdZJLxwky+9aTQ7wrd79KLKAbPtKeA59n71
         9KyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299042; x=1759903842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96lBuGyGNqGdmWvV/PJjpenC1fPHuudOMddkc9JukfQ=;
        b=uxPy7Mf0EpfIw7Ub50zBs5+gheSlynndEWs+xYIaegdVIG7o0/zmSltCiHRJU4YI1c
         Ftg9njudT/dFlNtnPrgF6qjOx3MbybqL1tUl39j7A0hujQu2vcNM4Wx9gpH7ONUV6yPF
         wvo+Fj3IwXxaTsP1ueUDkU+rMuQ+yMDpnmPfGiy6XAynou4/d9OlBihP/Bfx2UbBd78e
         t3Vf9njNKxvYTrg3w8idAfrgO/ymC611BsTxlneqp1Wyr5MXT7EBARGH/EaZjnfmpx0L
         NDM06Wzo2V56HvmCmC4wIUwto1aeNo7ud4gUeU/8U3Vj/48ZsA36047lg7XKl8iIr290
         x0Dg==
X-Gm-Message-State: AOJu0YwQZOYotmPN3zPE8+dQHn9imiQLysnCSGDSNjxbAPSIp4SIfi+N
	sexorMTgalRk2YfTDuGQXbdfCAwQuvznTI67bwvKHzl2uYLDK3pzIdhhFLRslMfHsNk=
X-Gm-Gg: ASbGncu6pbM+V6GwJJXvBH572ULX2LU1EGU8FHuWizI7UBbLHHp4m66QxikaEDJT1xU
	q30eTK1Nk19GsyCoTYS2/Q9xrWKfsShmtRLcvq5iSM72GuYRhmkg69TDMQbLlsKR/JGvD4dqgLc
	thJOgYUhoTV/gnzO1MMyjW5l88g448bI4KdGWO3Sqea+s5plIFKdWCTt1MPH2OTKCyYzUligVTw
	8TDuLuxgLJvc6CA6mbuJLCW7bzIX9Th90pod5ujtebG9pFcTWkaYaNvkUqoovdxKavSz8MpSo+V
	aI5wHjxXKqb1LTncE2bqiJoF1Z+KmI6XqZht7Ol8HZSDObnSPBdsWgbzuwc3DO3hToXMNN8BvdN
	4rG3PgsjUE4MSaaXv+RfqmoVUUW4bAZ3dGa2PyWIggI8H2cqCe8Msvl43K4nujpeloDrAlHjgp2
	mq8gyX20BKyfCA4yh8TY+R0HZmI9W5UHaksnm1rQ==
X-Google-Smtp-Source: AGHT+IHt6fDP7kqpTGubIfHOuw2BR4PvD5qV97YMPv7HNHGrcP6MVN59nJX/Qk5316ImtAkfWPzuaQ==
X-Received: by 2002:a17:907:868a:b0:b41:1160:a3ef with SMTP id a640c23a62f3a-b46eb7aa04cmr150622166b.10.1759299041854;
        Tue, 30 Sep 2025 23:10:41 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b353efa46b2sm1288658966b.24.2025.09.30.23.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 23:10:41 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH] dma-mapping: fix direction in dma_alloc direction traces
Date: Wed,  1 Oct 2025 08:10:28 +0200
Message-ID: <20251001061028.412258-1-ptesarik@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set __entry->dir to the actual "dir" parameter of all trace events
in dma_alloc_class. This struct member was left uninitialized by
mistake.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Fixes: 3afff779a725 ("dma-mapping: trace dma_alloc/free direction")
---
 include/trace/events/dma.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
index d8ddc27b6a7c8..945fcbaae77e9 100644
--- a/include/trace/events/dma.h
+++ b/include/trace/events/dma.h
@@ -134,6 +134,7 @@ DECLARE_EVENT_CLASS(dma_alloc_class,
 		__entry->dma_addr = dma_addr;
 		__entry->size = size;
 		__entry->flags = flags;
+		__entry->dir = dir;
 		__entry->attrs = attrs;
 	),
 
-- 
2.51.0

