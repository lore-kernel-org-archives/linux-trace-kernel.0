Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F75CF4F1
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599051; cv=none; b=VaVh2Qk8lyL8B2QGHJzlPnIa6xqglWk5GT6eltLe1nMJfqqOP1FkSv6xVUi8bGGKorhqplt2adBdOWhZlDdKUxp+/3IfyFgFZBM9NeSDSVzPdRdyoLr2bTR8s0imLPbaUxb1XiqXa4pnPFkTNQ6Q6DMSzdNXs3b+af9qV1rxMdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599051; c=relaxed/simple;
	bh=lRT0aza0NWuT96rFQ2PsZoDXzXe3SKgbZzvzY7rI8JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=vAnTlW0zc1wdTR6Mpa5E1xJ47tm70ZkjLV+skLkDIqVvsz881b3Xi44KXJ4+vujcE859TsF50jnryPl/jjA9OECQStjWMpmpx4JtKYUwZrO+GTIkzUH1DTgVUsXBdTrkdFbf2t6eZ82/bQhbAgQ40UVzarQAsVHPl1CXmBCis+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hu0E6NRp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hu0E6NRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791599049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HmVf9AbsSg0zVgvJy/FQMRsxDCsVZP07UVC0nTPSnbE=;
	b=hu0E6NRptmImvjtOkyuMl5ylbGCxCtLTRFgDVXj58DeRjhIEawmWH7L+Y1Ea4sYGwgR4Po
	dESOTQC6sz5lUr/TebIXvRpK3KJbaHxWIE2LKgT2zgNeOucADNoyaEJqYzIbsdLukYxtGe
	jTGllB3fwUO3HWWNncgCYxtLNIwMKXM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-MuQrwGE7OkCeG8Sb3-8DpQ-1; Sat, 10 Oct 2026 02:24:07 +0000
X-MC-Unique: MuQrwGE7OkCeG8Sb3-8DpQ-1
X-Mimecast-MFC-AGG-ID: MuQrwGE7OkCeG8Sb3-8DpQ_1791599047
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-535851217d9so7031431cf.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 19:24:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599047; x=1792203847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HmVf9AbsSg0zVgvJy/FQMRsxDCsVZP07UVC0nTPSnbE=;
        b=DS5Daaw3vaMcyR/ZtLdm47Ds/s2DIHYDiOFlxI8IpU/COK7yS6UstXrVlkjekgWPPH
         Ji7kIr9jAxpA3+l2QyQazBz9oM1xTYh+M34ibyViwGJPOdrb7LEinT1s8m1UjSfYO3YS
         ECBlS2AJtyZqLdUaQhl9hpOmnhPOS56O+LNiPtNPSaIHAIvpwD044rnxWtDpoH1X1GL5
         TCjkBuSvq2teFwyyn27oC+wjMVgoKAxqa8b1n1P5CQBjmwJAWnxEstTSdG7zwA8JNDJc
         rTSoZet+TjBd6uWqh2yJ7X5+f8uPl2ebjrJ/qKuU0pOPmf6P/s/FXbJpq5Bg7dACgqgL
         FnwQ==
X-Forwarded-Encrypted: i=1; AKwUvByjkcJfEoCmVjBqhh51IPRryeHN2OnjucjcHGtvDBxl535kmdxKgVk9fo8Ow6JjOye0jRQP2K7t2Ctkdff99MVRSCU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBVXWG5hG7rhPgXZC2EGA98geiDTOV67FI7T8l2PF5DdgFOreF
	qjYeJzAT5tdrZ8JH77GQqixMVEL4DGW5x+irLGqvixsox+najyQVr4aXqsxHofbiXjXzOa9Ftzj
	2ZkGng4U8CLgpYsdSuQ6NQ2O4Y8kOi5ECSmk+tB2EJ1dEmkTKr8SjEV4laayXt+Qw/+f17N84z/
	I/TL9bUA==
X-Gm-Gg: AYBFou2o61R0yWytPm3/ymAs29FXcMTs2cPe4gKYFL2UU0v4BGxZaAv9LgNsSZMTG8l
	gnpVrzXf41TdhvVsgMBaxzAkgrq7CWp5wCCCjtNBH6kxXBucmx8HhR77y05N8U5NMgjlbJRWXz8
	Zr8S09fcxiuOMf85MihMOyU/rpOP+5iOBJRSEWvrWMYoN1GUlUyRla8Cc+fygw9PX2xgfHfDnTi
	XDV9vbdVeABiodCnabVyhn4+DXzcO01zKbvclizJHK5J9+HXhdceVvROAVpQcYYglrsIufVAoDK
	rjDmGpl5u8W4UxT82cJ19K5HxDQTgofu7uSaLVqnYADCbpnRT7UAxEkiohDOG5e/0GIzu5yPSpJ
	XzTx4ON6gQGFCWYQP2dZAI5sMFJnRrEibsQXPOl7wZNb6irhNKE1+ZI8=
X-Received: by 2002:a05:622a:418c:b0:531:1ebe:ac62 with SMTP id d75a77b69052e-5359facf0bamr58266991cf.26.1791599047149;
        Fri, 09 Oct 2026 19:24:07 -0700 (PDT)
X-Received: by 2002:a05:622a:418c:b0:531:1ebe:ac62 with SMTP id d75a77b69052e-5359facf0bamr58266831cf.26.1791599046663;
        Fri, 09 Oct 2026 19:24:06 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7c0214sm31284151cf.25.2026.10.09.19.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:24:05 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 5/9] tracing/osnoise: start_kthread: Always check OSN_WORKLOAD
Date: Fri,  9 Oct 2026 21:23:34 -0500
Message-ID: <20261010022338.2507589-6-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010022338.2507589-1-crwood@redhat.com>
References: <20261010022338.2507589-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DeAGfonLm1LAqN0fpr_nL365EilBM7tMOKP6MP0geiI_1791599047
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
index 51e9b8837d20..92b1216d5740 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2077,16 +2077,17 @@ static int start_kthread(unsigned int cpu)
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

