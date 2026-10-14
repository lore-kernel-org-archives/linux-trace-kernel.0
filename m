Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B4817BCA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944826; cv=none; b=C+/AtRNbaqzqhXoSoJwz1acLPsCOTAkfT6zuLp5JwsqAGWDBLkCxWDoYnO3Z2aV7pSm0D8/PrCxA5VDj8OexCM8gH0BpSKvkMHuAE2HZTmwTcGrPojEH9hpF7qHTjepHQF9msHF4qwQzHInzCQTg76FXWAp/apoOzlK6U/Jua/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944826; c=relaxed/simple;
	bh=YWhUpRjQqYozT3ad5UwGXtD/jYUTwOtwxXZYs9s1XmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=RUlV0EhH24Xna804qv39FoRDOPCW+WQWZaAfL1eK+0vaY6FJ4yHPkP78urR6w9lBwOZ7pOECu/PJSxIiNjJT1w57R+YrtlV2VwLj/lPCdfhgAoCGQH+rqO/JMg9Df3I1UISfQyZ4EFxkFzWCXpJ8KD0Z5lm24Z8mfQCFPYNUBYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OebZUk9x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OebZUk9x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791944822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WmV0mbtNvqqbMh54hz6E3dz7S5bF7YT3jtJdJJsbWk=;
	b=OebZUk9xG7HxKnHvuH8BBR34Xpqo6HFD7avieiZP4Kxrq6z/Ijwz/hSAeQPsfiJL+P2fZc
	LTB5sxTqZVrp4MH14DYtQ8RPJVUWhQxQSYEDrJGj1/0zeK71ACDpxq+mNH/pXGK2P53C6m
	I1yQCyIedi23mTAYl4TSN/rf7mDheRE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-GZeqtmXUOCWoSsv8EQqJsQ-1; Wed, 14 Oct 2026 02:27:01 +0000
X-MC-Unique: GZeqtmXUOCWoSsv8EQqJsQ-1
X-Mimecast-MFC-AGG-ID: GZeqtmXUOCWoSsv8EQqJsQ_1791944821
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ecdc701a2so455292185a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 19:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944821; x=1792549621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8WmV0mbtNvqqbMh54hz6E3dz7S5bF7YT3jtJdJJsbWk=;
        b=UyvHuBjTNjOHdXqEje3lpDYWpFJaIYwZg0DL7bNDdesr1uUjVngZPMGajSzKtR52j6
         X/0eCEGNeAsmy7i4/mOC3Xo2U4MLSIP4i33MeDFPI90w1hEgzA3En1m2E7cRJ+nfnoIK
         qm32z0d00d+Rum2SXBybnJiDtBeerOKfTxvxBQ8jw8xjA5gpDpC4Xca9kA1xH6gAkC7v
         XrEUJqkyyzkd/ZgXTlcfe+882lk4JLCRoBlYD3c9VjvqGMSJXsSi3iYfysUAxAfxTTFc
         KHUGOqEFSYiSOw5VTWi4FHKE+U05qIMKNMVazF9KcGm/QhDU3EcME2QgYKbxZvSprL/8
         IG6w==
X-Forwarded-Encrypted: i=1; AKwUvBxskfc6zx+b6tBINfmpQ2UTemgOKJBBp9QN6yRRs9aL+f46EJOyLJaT3XCDM5tksJHYZ4a/w2pg52m50b4uVlraPIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhlsecQC7mY36iXPoBbBNFiSkvRsygiXFneFFMxi4uakBQv/rd
	xVvvxlf5S19b3B3+o2ezTI+rzrRtXUdHWfdbNkAabt+1RfegLjg5EgErJO/k3i4tmRZUh0uAElU
	oleZymW2dKYNyzWd/FFJQOTJNWh+Na5HXLI6qhkDlZwWp9B7UBvAtyeuw5g78CMLN3qdmcWgMNw
	==
X-Gm-Gg: AYBFou0DvkvbvxYTZfwCIIrN36hZF1cKZCWK8eDydBKz0Jn24mkkbkVcYziqOybvKLl
	E5ebmTpsC4PG+UJS5Q8YGN/L128HdTn/arkFDbaquxkZ2MX0dDZLBY8JPV60iUXzrHpmSSucFdb
	OHTTyd+QfKyX0JWpu/88SS8FOFRwKBEdW4ATHmsRt7MB2gnAQ/M9UaIO+/aBCM1/Pb+nMYIAei6
	npsZH9/PoQzR7tCC+VNXVs+3xqNdD6IjjMIJsmI81P5weeiXjmOUPMlJqQ71pXa48l4NNpRy7Hv
	AQN8Qcp3c9MQsu1kkcDM4U3bBZZUDZ2vYN90pG8juaD3Q3N+jmGoEceFYeBmuzfKZNOnrvtUgUV
	k8FW7W8+fesUl+MJsquFSLcitp26XNDLgjoAFtHNgNTuJ9JEunq9c4dA=
X-Received: by 2002:a05:620a:7117:b0:93c:62c4:e2e2 with SMTP id af79cd13be357-93ebd0bc2bdmr2213848085a.12.1791944820739;
        Tue, 13 Oct 2026 19:27:00 -0700 (PDT)
X-Received: by 2002:a05:620a:7117:b0:93c:62c4:e2e2 with SMTP id af79cd13be357-93ebd0bc2bdmr2213846485a.12.1791944820239;
        Tue, 13 Oct 2026 19:27:00 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b387e0sm41051566d6.12.2026.10.13.19.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:27:00 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v3 5/9] tracing/osnoise: start_kthread: Always check OSN_WORKLOAD
Date: Tue, 13 Oct 2026 21:26:36 -0500
Message-ID: <20261014022640.695786-6-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 5wbsVoRLh83RhzUfF0VYxaqAZseyIFpmaO80lbmptHM_1791944821
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
v2: no change
---
 kernel/trace/trace_osnoise.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 202d7b4254bd..3da4f1f095df 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2078,16 +2078,17 @@ static int start_kthread(unsigned int cpu)
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
-			cpu_osn_var(cpu)->sampling = true;
-			barrier();
-			goto out;
-		}
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-- 
2.54.0

