Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224900;
	b=DE0QLO57k8v1dCTP3jR0kQ5tCmP/iai8s5fO0WZ0W9jJ28hfRKn3xINbZEWMG05pvjs7
	 cJcOV7L6ijipCOH4nzwohZ6ctO074DL8EDtSa5l6oOPkTbjB15QvX2HkWGqBpNFtJj3mb
	 1aBcoi9M2ZZorlXXOH7c/Qs7LiKqKureraGm86PjJYFOJwXZckpal00YGz9Ii3EBPq3TV
	 Ayog8d0ff37MLB9jG+AU2iqojc4E3ONRBdtXqMQriK0OIDpSpYr1E9U5/fmWS/beEDjYU
	 voSM68uoiV52IJXm+134FvUKVU9iSX6OtK5R0K5kfHQK0bDel2tRW9bE4Z0eLrLpaHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224900;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=RKp/3M0iS7re8x5LR9Ok74AY4kzetWwP06CN5KGokeA=;
	b=XRQ6eqt1Y17xpWpA0hp1ikZlsILVO7Am5VZlVWOlK5GgIoHqMF3Yz2O53R1A3CCWgU4w
	 paSF/LXK7lm+dHW5XFLD/vbmh1wElofXar1QEy2cp3KNgvnMYJQZf9vqy28/F6jGzP+1g
	 DZSsYIXNP6Dmyf1XOurC6O6uZN8DVPtkxKua4YawWfHD5WTXmmhkSSVdnTUluBUbbCZer
	 0wsiLPJJC3ixRhMB/foG/U+39AIW/5+H6irqPHAOm7HbKZCa12dKPPPWGLdq81Rmg/3AG
	 SOLPVYV0vVVorGCXqx0i75sSZLd+4EiwtPTHV95uxtI9GcXOqvEsSbMOrhWDt1EkqJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+6ckgJb;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA350606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 22:01:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA350606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+6ckgJb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793224899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKp/3M0iS7re8x5LR9Ok74AY4kzetWwP06CN5KGokeA=;
	b=h+6ckgJbKRcBOMTsarSy3u40HVlV2yr9i4LuHjG8RWhVH2OSsitzRJz4QjC9U6YU+vUQ7q
	b1sc9ogA1GFXpHX9weXUE//sMv4Uuc0ryIoH3TqMJlAeuSKeyuP8gTCExd6Qb03s1Ni88v
	GjQ/LkEndP2a+CU0NVQnlKn4gg6tHkw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-5lbrXoOPN7ShNYs4a8hT3A-1; Wed, 28 Oct 2026 18:01:38 -0400
X-MC-Unique: 5lbrXoOPN7ShNYs4a8hT3A-1
X-Mimecast-MFC-AGG-ID: 5lbrXoOPN7ShNYs4a8hT3A_1793224897
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5338ff2cf14so30379391cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 15:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224897; x=1793829697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RKp/3M0iS7re8x5LR9Ok74AY4kzetWwP06CN5KGokeA=;
        b=uXshZ0ip05sXLTFvkui93L6DWG1mnRi+JjAQLil/CCqp8d3P5x63ojOOgZJgBCPnlw
         ydAOWm1NKo+2yzu7M9wPfY+bJiueHVC64cnpXFWY34kVkE9Mqv3FVfGGjEXLRnU11a3u
         iiikH0mkiWsMei4S/0oKlz2SoCvOH5pmZvIfqLSONEZIGKxNRbyXqi6EH/0rkfnoBmbd
         X6fpzPTvI3jSuEHNk+Vu8h5cv6M7uYf4ILBLBp03j0P+1FurOnZorwWRbTA1EBzvKTDf
         Me4cmS5/HIgL2019yF9n+ILIc003Xo2K0zqNYtcQGgyKPEjUSid8VAS5ikQDKbj3dla9
         QLwA==
X-Forwarded-Encrypted: i=1; AKwUvBzMjTZbFqKTIy/Hg8v4joBWDFFsg3LqxEZBL10qIVhNFl9C0b8XxLsVvDzkdoWSqBEpAnk7zmZ6DC74A1vfIk7UD5s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKjjCirNcngG407QPiol0cAfyPsb2KZwLGX408S9AselmLROWj
	3tUsSPofFTA4JoGNiN2yW+6G+P1nzXezfqIvCdBFI1pCeTxT77ehYIq1fXSZKjtgXGz3al/nArG
	W26a20cf+bTZVpSmLkW7n/j9tt7EBvYE7jXGwlztcTOnOzZRuy8anhy1l3mC1ChfTw1pGZ3Fs2E
	5PpVCjKQ==
X-Gm-Gg: AYBFou0P9HaMMIDMWoN8MWv1qygozWsNbYxXqjuO8uOBsd9bwGU59SLpfuJbtPVQg9w
	HZYnx978KUhnbSgnLWRM01PJAWQ6v/F1W2J/dMR4eWpf68WraJBw4hhXa0umsJLjhA+8d7kGEkC
	/jLoImBvtM0POVAdJp5Y0wrR/meaGmcejR7tUCHIrkCamNwfNdSXeOBmKU0IdBKxnnU+l3+mfri
	Q4AuUYc6H+h02dbaAcAWSYvszBoAOw2JfbqndrZcGPr8tdZQZ9vLdeP2j/q59PHlWm2rZA4z67x
	On6rS/uT8f8tXNfTTnU743NbT4Qo1RnH2VM1+epGt95bVNYw8TSQtSo5kuAZf9YVOZrXynQgTW/
	NL+5tkZYT5zOzBHjEvt0HsqWXsCjYwIRX91TpvxCMhBIw2G84l6FWGRJ+tpbb8VZpqxoELInRpm
	jzuB4Q0t/R/5w311Nx7w4+NwNqKJ4Q
X-Received: by 2002:a05:622a:40c:b0:535:33a:c75d with SMTP id d75a77b69052e-53fcb6faccemr62816931cf.32.1793224897155;
        Wed, 28 Oct 2026 15:01:37 -0700 (PDT)
X-Received: by 2002:a05:622a:40c:b0:535:33a:c75d with SMTP id d75a77b69052e-53fcb6faccemr62816421cf.32.1793224896672;
        Wed, 28 Oct 2026 15:01:36 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-538394f7e49sm114884001cf.15.2026.10.28.15.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:01:36 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v6 09/10] tracing/osnoise: Print taint message for timerlat
Date: Wed, 28 Oct 2026 17:01:19 -0500
Message-ID: <20261028220120.4005187-10-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: j3nkaG5JjkqRVlaohrjzbn9ZuIKz2E1jAUsCk1G-JPs_1793224897
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
index 9e37733f7395..ff4744c0701e 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -576,6 +576,9 @@ static void record_osnoise_sample(struct osnoise_sample *sample)
 #ifdef CONFIG_PREEMPT_RT
 static void print_timerlat_headers(struct seq_file *s)
 {
+	if (osnoise_data.tainted)
+		seq_puts(s, "# timerlat is tainted!\n");
+
 	seq_puts(s, "#                                _-------=> irqs-off\n");
 	seq_puts(s, "#                               / _------=> need-resched\n");
 	seq_puts(s, "#                              | / _-----=> need-resched-lazy\n");
@@ -593,6 +596,9 @@ static void print_timerlat_headers(struct seq_file *s)
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

