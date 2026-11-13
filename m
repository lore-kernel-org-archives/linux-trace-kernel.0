Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552084;
	b=jTd2Smtd3E2Qa5p+l7j7PI9xYkxPov/rnEyx1npju7zm+B2HVkOPu0wfsp8BwDo+8vq0
	 vTiSLR6FYmbgjBF3b6ZSVn5mspAsSmAXA9bnLRe87L4IC/gUxx//MYrpjIPvRLqVV98G6
	 5gKu2qWlKLlJuhwnle/alF4i8ZWvvVc2w2I7EgpfEiNw7WLrawtdJ+a0nQk70QsNGgnuz
	 UVdkNQfH9pgMbaT1+tg8HMRD/UqewU+ZUR+tyRFoHFcR3Iovntyl/REqjiAnKNAl5dxKG
	 SRe/lMesaCpcMx9QZij2h+Y7jZLYmMS1fk2OzQJXkw/OoXLFZ1wbs1/jVXdPJrnMNig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552084;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=ln2ousBgfTUt4jSGi1IJp1BMxTw2akx3m4UBYYiOhoM=;
	b=K66CkdBKpb9D7E2W7mkyGbbSuQMG+TWnbIBSgUoZqQ7j6pn0CJ9NZG0MrnXCxUFzeqvh
	 Exb9v+5ovmSl+7ZS2F4ri8BsS9/w2jXBK8nfhAajRfylLtTLgQtX/B1Y4+o3RC7fTGTnC
	 VpgVJodwGknq1TJGkCqN1GtwZLYYoJjpwnIu4YJWvb23TarnYFCSIhxQ6NNemyWVnt+Hb
	 z0CYTqoOSnZrCySNufluF61vmCJlOMtjW5lpZoc/QegysZp4q308T5CenT7nJHZc0ZmNC
	 V/PRuUcHK2AeYRZ8ZUsvWk2bXZTlgdcn+bKPG6JyPqXx7L+lBj1o3om/odhzOqoRbDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OupSLrvn;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872C606A32E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4872C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OupSLrvn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794552083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ln2ousBgfTUt4jSGi1IJp1BMxTw2akx3m4UBYYiOhoM=;
	b=OupSLrvnunCBYqEeJ2tx2hrzo+dn/ydmwL2zh+UI+xfpUFw98IaiGOflkipzZXZxkCUh6J
	ySUIQU7SB6kD6roATRayAVUwSyszdd1tTTSgm/Yoq1raC0hbLEZ5e2mBj2R+nfK5uGMsEG
	7umNS0SqlZ/N95K8uDo2G7DmJc+lMQE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-qI5NzEnTOpq4eAeEp28ytg-1; Fri, 13 Nov 2026 01:41:20 -0500
X-MC-Unique: qI5NzEnTOpq4eAeEp28ytg-1
X-Mimecast-MFC-AGG-ID: qI5NzEnTOpq4eAeEp28ytg_1794552080
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-85d630e451aso804299a34.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552080; x=1795156880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ln2ousBgfTUt4jSGi1IJp1BMxTw2akx3m4UBYYiOhoM=;
        b=e+yAYDNi8gOi5Uk8xHbCiZFPW0+qEUCYgkEw+az8Cus8N3NuAtL31ShtzokKehfmZp
         KqhXJHxFAC1xf5blnPyOlq2cmkrlebeJD5d2Eft1dT5xS38HMyBU8ZHu6OqVEUdrZtbM
         8qKmmH9DWLVhJ+FIEiVzIZ2Of4krBjLgmBgEgcGBNTa9+V3d+pBg7BTpi88gEE5F5GO/
         L8Wdzsceki5OVXEOVlhFktt/Umr/VJACQZLncoMOuus+Zp01aP1PsTTtpY0q3pyGgrng
         5wb2SGCAVtPMuqZeuJeHwoTeRGkO7+XcGc6JBz2/ypDIiKIrhQxPGUrk8JKRZjRyDYzJ
         KKqw==
X-Forwarded-Encrypted: i=1; AL+hErGT7j7kn3jZ9aH34MaC+OJDepxdHTkQqL3pyVaiO+B1VR29iCwFeLIFR866uUEpgmlY+1n5DT4tQl35F1S/Y+A5YTY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Wk+T0oqaI4eKBqrzY1fBSllfxQjZILfNF6Id6MPKevnWi5BNi
	awbdGPlClaqgDCJb7NQXsVqIQfHsDBhcvyU6XslfDMyUiFDDFADWS+tVpMWTOz28tBqqrhSBgRj
	CIFZpo2AIEC82/G1MjO7jAWLnMFxE5qRCFXHs+jyJ+PhIVd0352gMOguB0dc+qR8nyig8CacywA
	==
X-Gm-Gg: AYBFou0V24tgcBbWpiOeMxy/8Mi3WmOUwQNmAhxww6oFuberPCmtLgjuBvpx/LklyvO
	wlQc77TP1uc+5pR1lsgNmt4Hak5SLciRQ419IbFeDr07jBKLJdcu9ECZ6yoFWtWBeLSgiSNaSoK
	VTgajovL/G2BuLUT7BCiUIQGWmdLnlbDvQAJpjL3VPVCqt/HfiREQ6cyp1U4mgCb6IWcD6aq5Np
	3hoyPVn3D5Bhn02/H1srF+igGgAJ5e6MOSSAvRPBuPyJ1suACkWdSpx2KgLJULuu8VYh8yrmXDT
	uGvK0Z00fF5edgelZumyTmoloxN255m2zg5tmW5Cc2Ssmyp7gHljLS6MMu9G4I6pZkO9z5qLEqo
	WyhTBdq27MGB9n1RCyNI0PIWNcgunz6193jtmhR3TvK21uf276zlMjWVU5XkfFPF4WWODfK/E72
	I7XawauohnnCuhoMj1WpcVZ0k8b6+l
X-Received: by 2002:a05:6830:2b20:b0:822:ce5a:4ab with SMTP id 46e09a7af769-862899054f1mr1432228a34.26.1794552079533;
        Thu, 12 Nov 2026 22:41:19 -0800 (PST)
X-Received: by 2002:a05:6830:2b20:b0:822:ce5a:4ab with SMTP id 46e09a7af769-862899054f1mr1432214a34.26.1794552079037;
        Thu, 12 Nov 2026 22:41:19 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm1643339a34.25.2026.11.12.22.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:41:18 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v7 09/10] tracing/osnoise: Print taint message for timerlat
Date: Fri, 13 Nov 2026 00:41:02 -0600
Message-ID: <20261113064103.3041704-10-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: b4XqHZeZmu-82vzc1Kl7VEvBhZEBpHSDbUc96M6VsaY_1794552080
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
index b2b9db69692d..4fbad6ab2adf 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -582,6 +582,9 @@ static void record_osnoise_sample(struct osnoise_sample *sample)
 #ifdef CONFIG_PREEMPT_RT
 static void print_timerlat_headers(struct seq_file *s)
 {
+	if (osnoise_data.tainted)
+		seq_puts(s, "# timerlat is tainted!\n");
+
 	seq_puts(s, "#                                _-------=> irqs-off\n");
 	seq_puts(s, "#                               / _------=> need-resched\n");
 	seq_puts(s, "#                              | / _-----=> need-resched-lazy\n");
@@ -599,6 +602,9 @@ static void print_timerlat_headers(struct seq_file *s)
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
2.56.0

