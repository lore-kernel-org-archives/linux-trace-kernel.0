Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224893;
	b=I/w2XO13iBn4X3vmkrBH+ZrWOj+hhU/Ob2O1/xKs/jWiQ2Hm3VsgWaJmNBY1EiCv6EqQ
	 pzZgyGxR2O2eeVL3dCNWXVCDRNC5Bkh13LP1FesJATo4eY5XoyEjW2S2hVhQISnfaaWeK
	 +wOOil66OQzSUOLYlE8XnutYn5mIVQERiu1SjHGf1aE0dq+78oe1aEnz9Aw93MKRoq9WO
	 ehIZ70izmrd+75ur7LsPKT/VFXPOjFhNBo2itsgBTpxm3pOhEe4rHi7+DujF6X3rRQdFg
	 kL7MFm2DgKqb5DkiAEct6ZY3O/88Q7KslgUVi/m85cti/LYfBBsQosBgFrIDrbzds4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224893;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=2Q/Lv8flJxDOYj48HncXbVpeyyXzjoqjQgTfdlr6Bcc=;
	b=ZQ+kPPVswrUjMtXuzQwqizRzjRcdUhXwsdnDZPzceXuv17dyzHxU+vWrrCa+LiehIvC3
	 EPJY9dznLoiEFDkLLAXG7QVdMEG9g8+tAwvV4mfjKW+0/C/Z1a4UxQyKI59qefdA4XVWe
	 QXEQ6CXJn+a8SwO2zId7ZjVm24JKAT6dZsmWnok2tlaYLyW5Q83yaYezthMWHAWRZD7Yk
	 asZjwJnoZFCnSgNgzFfxsi3ZGLpLWPkpCHXVwjD4+wl6OlOsdtMxijJkYPk/TNGm1cj+6
	 +/4f6O8pjJDViYncOEHqKKPC0raBvdTIdI8OVOyn9zXnmDh+vHKjfroFecK7jw1sqHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J97Ft8dP;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB29606A31A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAB29606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J97Ft8dP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793224891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2Q/Lv8flJxDOYj48HncXbVpeyyXzjoqjQgTfdlr6Bcc=;
	b=J97Ft8dP1lyEnitnqgfbnhahOCrzvznNkmdtTepbqfaKw4BeH6XkMadDVigA8txhaIhUsA
	DvH+D7LBCvYjxn16B2tkHqz07RSB/nvEP7ucr8qRikPi9ojC7jwMxzw1VrselB98uDuCkH
	uYw6tbBjhpv2MeFjOkP7g0x188ZS7a8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-Nu5s_6GQOy2WGxt87LobCw-1; Wed, 28 Oct 2026 18:01:30 -0400
X-MC-Unique: Nu5s_6GQOy2WGxt87LobCw-1
X-Mimecast-MFC-AGG-ID: Nu5s_6GQOy2WGxt87LobCw_1793224889
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5376f1853bfso32257741cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 15:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224889; x=1793829689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Q/Lv8flJxDOYj48HncXbVpeyyXzjoqjQgTfdlr6Bcc=;
        b=QNy64S7Rgvs6jFM21INSJ6sZQeFJdmH7BWT28Nq8TUoxNNxCtzPN+IJ6faOQpy/kHy
         4to+uo2810N5KkuuSruJ282+/Itlp9v8ejqUXXPc3ZKkJZfkU7Ly4+oc7K2BXXK5VbZh
         5dp+GPUf20hc3NV+GdKHh/1bZf32OXr3gIzBS+XGcOqjSnFVzLo9Fp0B45EDnGC4VGWm
         LRzOOgsvJYUYfiQPIdrJp/ynH56zLt6/eMGQmSjsczyRBYlt+bZzdyOiNedF45LWE9IR
         C16oHC4hNOhyOyvzU0yosXwi82T1n80hmElIv+aB2e+vcb79H0eoDYkg2EaVoFAXina4
         t6cA==
X-Forwarded-Encrypted: i=1; AKwUvBzTsdYPqIcZyQiIR8x2sD/iWc/KqzPFX6XJ4Dhck8NYzcRoe5xIFSSfX1fKtUBWws5Tr0mtm8hqIg1H6a1TQQd74d8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDvfaJRSV+mJugaiqnhSql2684VMOErHRDxd+46mEnRaKaTogm
	C8FvY6zq1W3z+AROPYAv18JUeOo0YjHldb6CPoPcM3bCLb57wVfKqLbaj58LEr6u4IUxZa/hs5i
	Ezcc6wArdm6ipsJQBqisFBMgeDtNBQZzbwhic+6qTdJFsPSaJVKAIy5JkM1NicHbTTE/MULTxFM
	PNhbVAfA==
X-Gm-Gg: AYBFou0H7aiHshPKPskGVLvypoznpnvGQfCuApRB8dueV0Rep/ha7YVKfrG3k3pv112
	nhLWt4qlpzdbkBZZlc3oK6vx1FP6Obk2rdFYzoxml9eNO1MXmsR1xVe+henImdhoN306OVeu32/
	0DPHXJB+X1uRT8fabkLh2do0rBgDDPZPs+JRNBCMpm7ulgk+NvFaRMuAvpg4MRol1VhFockgFW2
	Z/5lK2yorbbqoH1ZusfAPNO1J6/18gJq+QsrZxvWL9U9yC8ePuj27e5kiDhrJ86zAK0uxUHoo8+
	CBYR+qIKFfySejuuSbRwQA7SGBY+Nbvt/u6DDmSGNqYclYOKuRQ9mQniLyg8xBDFJmCVm0f+nrq
	zX3HbtVmGbLvSSdnm5BiSmzJ8mutuidOrOBi/DqnyQzciaU+6SKArD55jkC+PSBkxvRScK6cVsl
	cQ1OlgYEOWqqeupbFLOm3llkHutyzo
X-Received: by 2002:ac8:570b:0:b0:536:77d1:a5dd with SMTP id d75a77b69052e-53fc8db6defmr68605831cf.1.1793224889404;
        Wed, 28 Oct 2026 15:01:29 -0700 (PDT)
X-Received: by 2002:ac8:570b:0:b0:536:77d1:a5dd with SMTP id d75a77b69052e-53fc8db6defmr68605211cf.1.1793224888822;
        Wed, 28 Oct 2026 15:01:28 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e49sm114884001cf.15.2026.10.28.15.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:01:28 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v6 02/10] tracing/osnoise: start_kthread: Always check OSN_WORKLOAD
Date: Wed, 28 Oct 2026 17:01:12 -0500
Message-ID: <20261028220120.4005187-3-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: qJhBS6Vn1L5GhxuNsJazoCWpnC2xXjkRT8332_dGqd4_1793224889
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
v6: revive patch
---
 kernel/trace/trace_osnoise.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 953936bd5eec..a6f7fbb342b6 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2046,16 +2046,17 @@ static int start_kthread(unsigned int cpu)
 	if (cpu_osn_var(cpu)->kthread)
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
-			cpu_osn_var(cpu)->sampling = true;
-			barrier();
-			return 0;
-		}
 		snprintf(comm, 24, "osnoise/%d", cpu);
 	}
 
-- 
2.54.0

