Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224894;
	b=HM6Xy7w8UTEnQGTBIRMA++eeHfjHxP+4OT8lQ0QmCaiRzdcsLRk9YTRCWvPzQfSAys6c
	 hFowdalg/gFc6qWT6nBx8ncBXMgdMPyi9HHUzEv0E/DU4hyPzD4ybFYgkbQY1rtMyhlwA
	 JMmWH5Dc7u3ZlwkOEoxeefS4nUdSGiDaE5QzH2iywUXTP5jMkwAfkVJRogw5V1OoOPngA
	 WWG8E5omUouNH4EKcndaLE6jLJiN6K+eBNsZHtCShl43kyxGMOfystmCB1bJBARXmpNg4
	 geEMoqBPg5gqkv0ThHlzmJnK0VNSGsTNYBNdyEKVa0smGUn/m+2yrluSkb7gf7pizhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224894;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=VWzgWe7so1/w5elUDs3i9Jppu2aJWy/A5Sh6fITp5dI=;
	b=4fjnN0kV1v6bSDcUhTVrAq8rZ2xYIjuvxbyIjra9NPp42kUT/rQaypfnftzKhhRICf17
	 eczVF1M/RcUobxKxBzw8CgtxmYZHSk/GVTMsvlwkP89GION7LG2kEcfxCW2zTQQrSAfai
	 zJykEmerhFmkGumnkpnX5Ks8WgTPzSetjcNTJvXC0eAfRJ89sL/VHei3K2OO44z91ykPG
	 OneshXXjie0TUmuZvNcAg+xEghrVnVGVJtfLEatmpOJYIQZ++RAqCIjK+MxDHYaRGRoTd
	 u9SiJEbN9Udxr6bCPWuS9MM0wxw0lcX+p1Iwcy7U2l0pJK1VkGlkfW1YeztlRHAIN5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HiGPbTkq;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD94606A31F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD94606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HiGPbTkq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793224892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VWzgWe7so1/w5elUDs3i9Jppu2aJWy/A5Sh6fITp5dI=;
	b=HiGPbTkqDxPikmNSLNlNDU+wxAznEAiygVv0AZiY7yjTziEAqwi9rrkXxQTmuhnO2Jdxfe
	yWs1JKw5aFI+qNg/5X/CJUcm6Bm8P3tlfbKmAHF94dTu+ZFfyI7jiW8QYQaXSbLD5FVlOm
	szcmiHIHgL2NsB4hEM2Il/gjLYB7Z4k=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-2V5gESeCNGuyMn42CU9uNQ-1; Wed, 28 Oct 2026 18:01:31 -0400
X-MC-Unique: 2V5gESeCNGuyMn42CU9uNQ-1
X-Mimecast-MFC-AGG-ID: 2V5gESeCNGuyMn42CU9uNQ_1793224891
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5338c215ed2so25600011cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 15:01:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224890; x=1793829690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VWzgWe7so1/w5elUDs3i9Jppu2aJWy/A5Sh6fITp5dI=;
        b=kCLzkoqLNo2iZcnAmn+E9OcvsQMKp43p/SOFDjmLhIVBC4gmpHAtXwXD6SjO1D588Y
         JvoKrD5xmlDO3QOGwVUGqiy66D9NWU52IdD6TR9xEnqw7O+BUzd3jItEWz99EMr64NbO
         5sT9Vy27J1GPZmVH9myiLNMYMvs3GZ6+W58H1tdZZkG1qViS+xQZPYuxd33UPO/mHQLl
         Ak2V9znhhaR1M4yjkMtwNXjSEESsSL5g63RX7/sCudRQ2BSonz9aED4W1xCzgIhGUG2R
         9VZSa6udaWFBFFJTpnGK18YpIDROVmyoEF541CcpR2Sf/22xl+QiUEkNk2aAej+7Ofng
         LtSA==
X-Forwarded-Encrypted: i=1; AKwUvBz961Dri4aRS9rsKcVcUVdM4eZSseeB1UjJD05YLaab/pbaLXhkzNkKkNrVpPbkFAfF1pdlqjbuxhalT9EKwrwnpkw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyHKIfinoMWHF+jqQoG1HISt7txGd/KRJKiQCVGT8O06HIvOLi
	bqqT+nUvYUOreipVxSRSqGFT69pcw49lx5ILn+UO6apa+PFBecx+8eRJA9Xyb6cpypEn2IXTDML
	mGjEuhUvomlQayuOG2SETsf4/n6qHV88dYlzm3Cmp/bnHs3qXeks3mNkklM45XpfUKGPlg3baAA
	==
X-Gm-Gg: AYBFou0dlkvJLgIfwl9J09hdqN/VH3sG2GJPIqwPIkGt2pe8Z9oIEOoy3eCtUy6Pwyq
	VMpq2AMHAXGs4OSJyXgK15IUfO03139RlOm7mxXunlVw8UjqNYChhBnc5ZFkwWT0EJuGgjC4zlH
	VoUcvKCso6xA8yFvlvtkHzSeVeAvPDysSn02FtIyIHokkgSL54X7aFDpLg0tQpBCcfFi/05mc0C
	gq/kVCh/wGYgc4JeCE+fAeY6+uSGJvOpLw/2HwOk3h3oiJoCO9xRdiDfS1FbxNhwkeOkimdYWEI
	eO+pwdUJLZQbFcoz2qF+waJCOMNiscbxUWwkhloW2p2rr69qNNcMEoyf47p+jNY1TuPKbC+Tcuw
	DsTs5guVJjFIX6LxVUF++6dW9Lpy0WKWoHZEzYOMqN938BNgWuY85VWdo10KgmENVJcQwF+3nUe
	vj66Cch5jpZEkSIVN+0ZkAfGn94XKW
X-Received: by 2002:a05:622a:2996:b0:533:33ed:c39d with SMTP id d75a77b69052e-53fc8fab5b7mr57996051cf.7.1793224890457;
        Wed, 28 Oct 2026 15:01:30 -0700 (PDT)
X-Received: by 2002:a05:622a:2996:b0:533:33ed:c39d with SMTP id d75a77b69052e-53fc8fab5b7mr57995251cf.7.1793224889649;
        Wed, 28 Oct 2026 15:01:29 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e49sm114884001cf.15.2026.10.28.15.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:01:29 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v6 03/10] tracing/osnoise: Start all eligible cpus from hotplug workfn
Date: Wed, 28 Oct 2026 17:01:13 -0500
Message-ID: <20261028220120.4005187-4-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028220120.4005187-1-crwood@redhat.com>
References: <20261028220120.4005187-1-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 1wFFEuQ9ZbYbcU0ULBt9hwYKQEUIdu6_re00zBQrKiU_1793224891
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Previously, a start could be lost if multiple cpus get onlined
before the workqueue has a chance to run.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
v5: new patch

I have this in my notes as being a Sashiko comment, though I can't
find the source now.  I wasn't able to reproduce the race given how
slow and serialized cpu hotplug operations are, but it's possible.

On the other hand, user threads detach on cpu offline with no mechanism
for reattaching (other than userspace figuring it out and reopening the
fd), and you really probably shouldn't be offlining cpus that you're
measuring with tools like this, so you could make an argument for removing
the restart mechanism entirely... it'd certainly shrink the potential bug
surface.

This also eliminates the need for the "Always check OSN_WORKLOAD" patch.

v6:

Removed the OSN_WORKLOAD check from this function, and revived the
"Always check OSN_WORKLOAD", so that start_kthread() can set osn->sampling
in the NO_OSN_WORKLOAD osnoise case
---
 kernel/trace/trace_osnoise.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index a6f7fbb342b6..ff7277052af2 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2123,7 +2123,7 @@ static int start_per_cpu_kthreads(void)
 #ifdef CONFIG_HOTPLUG_CPU
 static void osnoise_hotplug_workfn(struct work_struct *dummy)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu;
 
 	guard(mutex)(&trace_types_lock);
 
@@ -2133,13 +2133,10 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 	guard(cpus_read_lock)();
 	guard(mutex)(&interface_lock);
 
-	if (!cpu_online(cpu))
-		return;
-
-	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
-		return;
-
-	start_kthread(cpu);
+	for_each_online_cpu(cpu) {
+		if (cpumask_test_cpu(cpu, &osnoise_cpumask))
+			start_kthread(cpu);
+	}
 }
 
 static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
@@ -2149,7 +2146,7 @@ static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
  */
 static int osnoise_cpu_init(unsigned int cpu)
 {
-	schedule_work_on(cpu, &osnoise_hotplug_work);
+	schedule_work(&osnoise_hotplug_work);
 	return 0;
 }
 
-- 
2.54.0

