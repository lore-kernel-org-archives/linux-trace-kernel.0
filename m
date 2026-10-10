Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB50383994
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599054; cv=none; b=kko8/TRWDJxnGbTvWXU+f85Cwjy2XbHyzMwRAxVKZSHPreZ42ZbwBzxYfX4xkQqnmtPCWf/9v4brx09UiA+d2Ylohr2kRIQEfMaODJZkgn19BzUVaQ3Q5IL77lLNSIfGZqFFL5UJe45h7ULI6XV5mWbeFHQVLE6GK8X/60UpG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599054; c=relaxed/simple;
	bh=0sVu4e1Zkj4J1L1PrGHAbaNBjUScVYTJ1nObSzWEqpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=DRaqeDkviVGesjOGZUSQieO4bOzJiLrVYnicSqKG/qJ8pmmkoJhaAbZddVEQm+TRgMph+PV0YTxjzMFa2In9EkbOUKBok8JkUeb+jVOaXq0vcOdu/FU/RkDmWwT5bFCs5pN/zHw/5Au9pRQCwvDiga08jLEn7XvNjF0AhnUMyqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q8WtmKiL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8WtmKiL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791599052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufAsXIkwOE2A10wlgEjxaskCSta8NjKK/3pVMIgAKAQ=;
	b=Q8WtmKiLcoE10GDpWvXgi4zFAryrFpcdQut1WReaZZ6E2P0Bb89Hh9P14RnBhCAz4Vek91
	cdkuWyf+2DOHzrzjQWQhR+45wH0poH5x9BXNgB3xoOMLF3NNjvdf7v8wo6t/WyXK5r7vqb
	ZJzj72qfkR1vtB74tRzrok0gjRlaxDw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-n8ZZO1bAMNaG0D62q2IzPA-1; Sat, 10 Oct 2026 02:24:11 +0000
X-MC-Unique: n8ZZO1bAMNaG0D62q2IzPA-1
X-Mimecast-MFC-AGG-ID: n8ZZO1bAMNaG0D62q2IzPA_1791599050
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5339739b343so6888991cf.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 19:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599050; x=1792203850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ufAsXIkwOE2A10wlgEjxaskCSta8NjKK/3pVMIgAKAQ=;
        b=GlDmE44RSbqLG1u4xh2QhzUuGUuR1vbjJjYEGrenrWBZwtGb3zdTxDG9TFxeZZq5Nz
         yzKWYQGyHM8zblSCmEbD71rBqx8XmhiQNWr8wwOG35ZA9y2OIeQ8ocmB+U2QwfEzdH2b
         fHrtICQiHnOSlL/wYlHGor6lUs89OWa8lRFZCtH7g2dn56PKeIjHgH7dCmTnDb7+eW4/
         0+uOYA3R/lg2RQl2n3QS0RAjWUzuL/nSOXIlOFLrbHGqR6S/cnxiG11KeSFSLvRStOnb
         nWyZPweij3s9FWJbr2QkIQqK2KxMIZt+KhQycz7RkMK6rTqSuCqpW7ti8bcZbY45Cww/
         49NQ==
X-Forwarded-Encrypted: i=1; AKwUvBzIcvmS3iANHbKQ9f06wLbQZPaNnvIJwz5tWjCXoJ1hej8vLD/z+GQ7k+3LpUGycV8yBfQ8sg7qYEI/LJ/AFL68544=@vger.kernel.org
X-Gm-Message-State: AFq9FYLhusA0t738s62c386mD6MADNbxNSlsKHVaFOY0L71XD+cxQpsB
	QiwCpbMFEkurQMLYiXeW4fsXkx8HvNF3L3OKtD3BvZvbKdFaUcm+ojN5PF1kjlEqrYJ2pniGeGL
	sgB2gjqIt3oMoUeQMJtHbLNM/lAY+HszMrUnjOO3ffl+1/U2KhQSGaoi5xVUfZePQE5iwuKw/nQ
	==
X-Gm-Gg: AYBFou3BGo+5YtUH3abuJRSj2tSfSCpKFPVE1PWPaToBoXFP7zroZm2pX2IgmBl2OZk
	9rY7NaskgdpPEIzQ97YtfnImSTh7mDHCjH8CwxtzpWEejjXjFD+C9anwJ1nh3CMqJLpULFsTduU
	CHapzcPHgIiztw8s5KvPfRApSRN/KmlGhVGvBMhTNaF6e/YOQIRH4i5Yd0krX8sDPBtfSTWiUvJ
	Lm5jHXxzx7FvzFryzsHhYiEB61DXfTEP8z1cC6BvbtTX91n0aA7kcW1ARv5ZwAG6HEDj6xopU4a
	Bar6Dq0A7NfIZaR8y44MyVWjDBopwD0TLATb7VahbGqjYv3uZIFLHrnW2GOAkBK4EFlTk8zmUD0
	L0x7MNPUTQmdGklHxdg6uzN1bwQDbkihUyLI8Bdj5Un0ND6dMc6h3LnY=
X-Received: by 2002:a05:622a:588:b0:533:4b39:4e28 with SMTP id d75a77b69052e-5359fb6f710mr62199561cf.33.1791599050451;
        Fri, 09 Oct 2026 19:24:10 -0700 (PDT)
X-Received: by 2002:a05:622a:588:b0:533:4b39:4e28 with SMTP id d75a77b69052e-5359fb6f710mr62199361cf.33.1791599050017;
        Fri, 09 Oct 2026 19:24:10 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7c0214sm31284151cf.25.2026.10.09.19.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:24:09 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 8/9] tracing/osnoise: Print taint message for timerlat
Date: Fri,  9 Oct 2026 21:23:37 -0500
Message-ID: <20261010022338.2507589-9-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Hw3p9zGrFMV6meP2ekKoqVax5vWg8Q1frQ4UZyPs0d8_1791599050
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
index ccd717db9a51..912ff5f5e490 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -577,6 +577,9 @@ static void record_osnoise_sample(struct osnoise_sample *sample)
 #ifdef CONFIG_PREEMPT_RT
 static void print_timerlat_headers(struct seq_file *s)
 {
+	if (osnoise_data.tainted)
+		seq_puts(s, "# timerlat is tainted!\n");
+
 	seq_puts(s, "#                                _-------=> irqs-off\n");
 	seq_puts(s, "#                               / _------=> need-resched\n");
 	seq_puts(s, "#                              | / _-----=> need-resched-lazy\n");
@@ -594,6 +597,9 @@ static void print_timerlat_headers(struct seq_file *s)
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
2.54.0

