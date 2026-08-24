Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F242749C1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787606202; cv=none; b=G459EdeNMxShfiBGkRnvtYIYWWrrnD+vOkLpVDW2y1DeH8J7HeWFJQFrrU2UxJi9wAl6Ec9idnYvWuJQjei9NjDzq2DosHZAdA6xCNXPTCQXebtkokNJ43qWlpnu4BXtuvDHPAVe+A+UxeBgoa/+b6ZYDa9rLRYL646Ux3oOkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787606202; c=relaxed/simple;
	bh=jQhi+n4M5Scc/a1pzByL9BKrlHKQxzaBQgKC1taqUsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dn+dTJObwVXslW3PLYuSHULGaS1laPL+zFsOVVporguR7KvX0kw0ZREtsATwDsAPSiyiGT4RjPgttoaxCzAm/hu2Z3vr2CsJVJDcqQSQCQi9rUrpPhUzNo6sbx9msEIK+YaDXz1Arxwwo/S1DcUlFEsN95p2mJ0/X7nQGe7/XQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ADU705N2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADU705N2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787606200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEc6DrA8hC+pnqOQn0Uj/OABcG8wMyqV3Ct9MFThsL0=;
	b=ADU705N2lf7sSaGaisXse4Yo2CTFmB4ek/8uClCksYrQ6w0SC8qF3mwCq/6IGbeOursWhX
	llN/Gn4dcmancZF0YoLpyR9qqKsZF7KccIFibNvMNxQhu0xAUxh9HGKXx5u2s4tiQuwier
	vUeVus+bm/LZZcgAlb8c8rgjBURJR1k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-9jxc_nEwPrWtH9PmuPH0wQ-1; Mon, 24 Aug 2026 17:16:12 -0400
X-MC-Unique: 9jxc_nEwPrWtH9PmuPH0wQ-1
X-Mimecast-MFC-AGG-ID: 9jxc_nEwPrWtH9PmuPH0wQ_1787606171
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5283df62d68so53141861cf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 14:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787606171; x=1788210971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lEc6DrA8hC+pnqOQn0Uj/OABcG8wMyqV3Ct9MFThsL0=;
        b=M2lPhRgOvLREzs7c/86ClmjaKURll+zKNplXJkL8wK7Q2medrpQ0GrltqmRzRlOlNB
         PBPdW2cLka6MPUM7NRW62gkJwue4l9I5x13JucSJM58RpYRNmHwJyAt6Z6DqKoD/okLl
         S484pGpTXOduqxCbr7ebfwOgdXaehFuT/dahsYphwuQbGuF4N+z2rss8wsf4ws2mG5Pi
         xjRt9qbPJb9qubbYxXBgmRpDVeVKV1bSKJEGu01/laQMuYHWaa6v1PW64ecqLDj477uJ
         rZPlY4lJgp50xwlejNynBXJ+iV3LhnsNNHGec8mo9EqDHu81QkBpLrxeD/4BZPwXNElC
         19Yw==
X-Forwarded-Encrypted: i=1; AHgh+RoTXA59zv6aTAISjftGfnLIuGK0Lxh413HQEydXsD34Jr98OOsuV/OI5Wkl4PZAsYFNX7ZgF3Qp5/CkpDCj1NQTsQ4=@vger.kernel.org
X-Gm-Message-State: AFuF++lmICf/ojg7NYgKBEoN+jy6sR3cXhSNKdvjnevXjvxaFGLGQ/kF
	UyVkQMEODdDnLVVautlDa6vOF8xL3GdVVslcJ8hLowqNhODa9PianKM8JBvU9Q0hWBpVi0dRQXf
	LrPM/h6LUQgQKBwrSDsEy2T5Sm7fzGgHSJocnNKDerBeVJs28jo1bmIB2j572PVNpC8cZCOjSvw
	==
X-Gm-Gg: AR+sD10QZevfLYN5pPoxx/rbWuoF9YFsapSHaLJgp90UDog9xSudTsS3vesbI42hWHZ
	yJLc1/CraAiYin10pSBKKS3CjK43vterOKu9mjAqnOX7sF35O77mqwRKh0JCUL+YfYZq9H/bO18
	G7wpyusT1wh/OSORFQ5TR5PMZIoCr6TkYmOSli8LWY6ySeAS2ogSJSIMAL7dhCBmgUD1Dbr38sH
	z3Ox4kwusj8J8DzfZtgcQHE36Cdf70rmutqrTY5wAscwXzHbLlqrTZJFrfCAQCNY89S1b2Bx9j3
	poaMCLtO9yJoB8cGtVuMeIffkA1RsOLlRw7+tax7enX9+ci7xSCxepjgnAgSU+GoWWOnvUb5ETx
	BFEY2zQcGJFNI2/zLCYcNM1LUNLxzO6dn
X-Received: by 2002:a05:622a:993:b0:52d:a1cf:a4ee with SMTP id d75a77b69052e-52df572c4cbmr331019441cf.10.1787606171292;
        Mon, 24 Aug 2026 14:16:11 -0700 (PDT)
X-Received: by 2002:a05:622a:993:b0:52d:a1cf:a4ee with SMTP id d75a77b69052e-52df572c4cbmr331018591cf.10.1787606170664;
        Mon, 24 Aug 2026 14:16:10 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp ([2601:447:cc01:6890:c623:cd89:345e:99f3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c93931452sm71832556d6.26.2026.08.24.14.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 14:16:09 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 3/4] tracing/osnoise: start_kthread: Always check OSN_WORKLOAD
Date: Mon, 24 Aug 2026 16:15:43 -0500
Message-ID: <20260824211544.3984835-4-crwood@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824211544.3984835-1-crwood@redhat.com>
References: <20260824211544.3984835-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yCCbONzGr5lOo1mst7flIr0TEFSLTHkdxaEVOK0ir9o_1787606171
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

We can get here on timerlat with OSN_WORKLOAD cleared via
osnoise_hotplug_workfn().

While we're moving this code, remove the pointless compiler barrier
immediately before returning from a function.  Even if it's inlined,
it's not doing anything useful.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 kernel/trace/trace_osnoise.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a53a07e59197..0f27af6ade3e 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2056,16 +2056,17 @@ static int start_kthread(unsigned int cpu)
 	if (osn->kthread)
 		goto out;
 
+	/* Can still happen with timerlat via cpu hotplug */
+	if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
+		if (!timerlat_enabled())
+			osn->sampling = true;
+		goto out;
+	}
+
 	if (timerlat_enabled()) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
 	} else {
-		/* if no workload, just return */
-		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
-			per_cpu(per_cpu_osnoise_var, cpu).sampling = true;
-			barrier();
-			goto out;
-		}
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-- 
2.54.0

