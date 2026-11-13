Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552074;
	b=PMNvqY7VoZ5ffZlskWufZK5soO+yfSlQWbBBuJxdBdMOcpPfK+AWy2v2xgjHbZ5jdOLr
	 nnY6ZQTJriYyX4X64uN8OVeDFeWphmc7RqcSsNp/OM/RlWSkF/jRLmioOefaBVRp1q4IH
	 PvHOrfjDfV2iYond4yxrOeYq5B1MscguIKVCIRszDsvqtSOtcc3A9dsQ0V3SottZ87+qZ
	 sqXbBJA6wV/SonfvHoxq0gnsVoru8u/0Y2yiqP7iC/vTqusaQHWgZp3ReVeQJ0oBL5IwD
	 ZLkhdOus3QNSxfySooXhIhUI32uHsdWilT2xu5871GVWpuYbT8QeYWOgdWXlqjDG4Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552074;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=s/VBD7km5Cmk+gKBpoU0bODC1xhj9yZHHKpWtMFA8XE=;
	b=Ogz7YqAxz5DXbpVMhEQHEHaRP/U/cREE76wMicJmSTrG5eoC/PGpTmKd6eQLJ0Bxyyxd
	 KRSdM6ODzWcRMZ4q4a3xQNinUm3PbuVyvYH1XVB+fpiXowNuHmly4Tn9jmPyGGSJ35Y0t
	 0ziLT/ApPVO65718hG5Aa+anTax0/feZz4hbguhI1h2VKm2wpjSLx/SBmuICdMg1aB4sx
	 obXa6+BKEgXMZy49HgunoZjTIeEFY4QMIBpsGKMlIptpTwsHPO1+CVaxJn0lM+yQIvWjl
	 toUvejJdZ/8HqtcPKKZRKyqbRQj/XEUfRjGUS09Z02EKMn4ydV1XkSAIDcREGEI/sRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IzMOIcBk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEFD606A327
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DEFD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IzMOIcBk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794552073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s/VBD7km5Cmk+gKBpoU0bODC1xhj9yZHHKpWtMFA8XE=;
	b=IzMOIcBkBkDUX2WxgSZyWbFdvw2f6V12JnrQ4QGXs4xAlYBsyxrwB93Xmz96bhjORSGSkZ
	33SXWqxcSnuAKH5TSonQ8+nTJdo+LFsbfT3bHIxjEfW371NV6/NfZhR0plnDyvtG6DKqgH
	9oBSfFXLpdUL4VFiFhW3EeKabCLrrtI=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Ue74epwJO62kySLD9gH8IA-1; Fri, 13 Nov 2026 01:41:11 -0500
X-MC-Unique: Ue74epwJO62kySLD9gH8IA-1
X-Mimecast-MFC-AGG-ID: Ue74epwJO62kySLD9gH8IA_1794552071
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-843cf077bf7so894442a34.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552071; x=1795156871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s/VBD7km5Cmk+gKBpoU0bODC1xhj9yZHHKpWtMFA8XE=;
        b=iyxO4aRjly/VmsAsykW1w5/I5cNusEgIN+kOByBfGOWWPKBIY9JqDmwY5O0l3efaBw
         3kZRwwcJ27o3Oz+Z1481qImWMO2JzGVjw5fxINfrDGWaC8+nJsbROCIgQln1kACvjA7V
         Lve749IC8388jRRZNQ2g0uKZ+AtJlNE3XpS/fW1tifHDJwtlzpUQ/wfRJj91/PsvSvBl
         EwEMxquwZb1CaDyg+UBM+QxG7hJCkWKJS9zKKnGtSiZyBPyP+7zTSPpFjg5OY6i+wPTK
         Cy7AeJA4jOSoo3F3LuX+R3m8jom/aEov5F6ZY70oIH8wYKWpsJVUgXR6ZLkAnQ+z3sV9
         Kvbg==
X-Forwarded-Encrypted: i=1; AL+hErEJHTid4ih/vDwHomug1hoG5MfehsUv05Njmcrntc6VLtW84H16HZM6Zi6p2HZfQeHJamO9yUBGRM+JC0sRu9s/WLk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1TJK5p3atXLs+dK/DfNB9fNFmRUrJYj+TxHfBiASxler+ydCp
	R/tDuC0bz1ViMcnezA1HqfsH0tys1of4xSq6FjpyVmGkRBCvCN05FMT71hBvO9ysbCJXaD/92f/
	Pv4FmYb5q9JMmdRUSGCS2tXiShXZwoFMMIydUlasOceBb0Pzi/nHPnQADqd/qPOLo/8eXA/zZnY
	8EIRm/Ow==
X-Gm-Gg: AYBFou3EJxS8SpL8/rEYrfxZ07A7XXQIbXTJFEoDTFshU0WMJ0jUvGe1Djs+3g77WTX
	cIxXXG6zLibAIVH9pYcU+5vavIr/AEVdo/nKV4E8WNyrXjcHm1csX8WKC+iIj/4SlDXyJn5qA0s
	LmVcMZzRN4adtCfGRdHjeEONAHSXesqbeqb+1kDebhgPFMRXAMLUIlLMb92y0nBClRUOU84iH0d
	JirAZlusVnD2pkIsN3N9yBlCu4S2idEj2xM6EJE/mAECxBFntZiWZoLl880NknEXgITcaEUdwna
	u40j79AWm4bsP2s6O2Czszk90a5KkMd6chBQCvLK1JE2Rwf8l6uZLZ5xa7264olLH1qTPkTDGvi
	FCPwq76ZcvWg/ZYZPZKPS0Yfl/bfIvD+6NAVF6OLjU+yddMnP9qzjrlydwR+OaxHRUdxTjByCyG
	73jTd3MSAJDk1RJ+aHJnCfqcXnWCmW
X-Received: by 2002:a05:6830:6411:b0:85e:f659:3a7 with SMTP id 46e09a7af769-862898e2cf0mr1386855a34.24.1794552070873;
        Thu, 12 Nov 2026 22:41:10 -0800 (PST)
X-Received: by 2002:a05:6830:6411:b0:85e:f659:3a7 with SMTP id 46e09a7af769-862898e2cf0mr1386847a34.24.1794552070483;
        Thu, 12 Nov 2026 22:41:10 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm1643339a34.25.2026.11.12.22.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:41:09 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v7 02/10] tracing/osnoise: start_kthread: Always check OSN_WORKLOAD
Date: Fri, 13 Nov 2026 00:40:55 -0600
Message-ID: <20261113064103.3041704-3-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113064103.3041704-1-crwood@redhat.com>
References: <20261113064103.3041704-1-crwood@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lQ-LhGUv-o1cHv_gcgyqrYDB_0AqwYGK6o6pC8isnqY_1794552071
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
index 2f3cbe71d313..b812a73fa5da 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2048,16 +2048,17 @@ static int start_kthread(unsigned int cpu)
 	if (osn->kthread)
 		return 0;
 
+	/* Can still happen with timerlat via cpu hotplug */
+	if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
+		if (!timerlat_enabled())
+			osn->sampling = true;
+		return 0;
+	}
+
 	if (timerlat_enabled()) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
 	} else {
-		/* if no workload, just return */
-		if (!test_bit(OSN_WORKLOAD, &osnoise_options)) {
-			osn->sampling = true;
-			barrier();
-			return 0;
-		}
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-- 
2.56.0

