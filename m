Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF747140F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 22:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015708; cv=none; b=Lns6vfLz6uI/G8e/ec+f1/QGhAmAQOt17mWTcLJ5I4ypMHeSAYmoHCbhN2KQeyPnHxaIDb1wy+sDkBuBlFSsk4yFjX9BERoDvao6eSBTPzRs2WT2moS9gBcYVpKPRrvQkOTk6NJujVVDkMeNnC3Sx6ILTAi8QDxFOu1i2bWdqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015708; c=relaxed/simple;
	bh=oe/UO8GGtDpya4+3mRar9ZfkX+/tXMWHSrwYPI+jwuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fU68ecFXjAyKJ/sKaCAXE4QHyzjqjDyjjk7gmeaZCYb+87UG19h100qRyi6Y3L6n+URLdA4XyKXwIx+62O7vkH07HEKiRfef/BXutE+PJu1hocbcRHwDLN96hmRdTQYKOlLVZp3ekacKTQfwWZMuweXrJvRvXdp5B8H7nvT6Zls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwh+l+cR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwh+l+cR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792015706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TimRmNKOkQ1F6g37GhjNUNKKWhyBuOl3kK7cgXzh/ak=;
	b=iwh+l+cRiX4QM/rxpPiirEoLRgGgXQdhBrMbQVVaVinfkgp/mMTYtW2IABUET3MjTAjplZ
	+kg6f4mwW5FiK41N4zBYAXNMTFOwIniLkbDGIrlnyikNmIIokAbfkN/3faPfZ7YP6jw2R/
	OQkGhtVGHZPP8Jhw55y/z6IY8GSon6I=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-VcAmmONCOE-yd0zIYv_Pag-1; Wed, 14 Oct 2026 22:08:24 +0000
X-MC-Unique: VcAmmONCOE-yd0zIYv_Pag-1
X-Mimecast-MFC-AGG-ID: VcAmmONCOE-yd0zIYv_Pag_1792015704
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5339732335dso74402491cf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 15:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015704; x=1792620504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TimRmNKOkQ1F6g37GhjNUNKKWhyBuOl3kK7cgXzh/ak=;
        b=2znB6y+O2J1b3TLt3aUVw4apa1vqmOL9MYkz2bszcaIi/VlZu6i4HKQQyLZ35RFvjr
         24SMNt5i3F8xXRVPN9SX7vvhu+G6Bfn1Oi4MB41R5J5ZaP2JpBFQDmFG8JOYq3aTyJLU
         VTdNCCXLWICfyeYWSbYK7Qv/RqWTCg7pSEvPIkcOy78f2tL8SSG23G24kZXM+vwwm17U
         xZD/4G+eok6Gxnju5heGHrRNmcP8WG88897N4Ps3KUuxYNpJXvLMmDLzhvDGOr7Z8k/o
         Wp2U5cm87/AYrTcYk6hh0soZLV1B8jZTTiYy257FxaZ+nexPc49smH/VHzCBPPsAlX/l
         wwQA==
X-Forwarded-Encrypted: i=1; AKwUvBz2+zG+bMiY8j38r1Eub9N4YZ0s6KTM/s6v1I91fMe3x6BelrlkW5cAlSb6+N23x18MsV7yIdOYM5KHzFNyJE+Oim8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHaDewAjBEGXrIpzbTZ+AT6j3OdBQy/mIZnmJsBMH5ooFMQXV/
	09EmVJFFfA8MI3pSl2E16BUTPVai/bo9C0t4+M0UHNLBnQaE4c9qVKzKgfbrbE4l4mmwMkapzJN
	614zFvEc3mxUfFIMH80WZuiyaku5Fi93ylcL4ieXP+EDqRYZKmg9oBh1JuCtTVwLHrO+Ano4KmQ
	==
X-Gm-Gg: AYBFou0HufsdcURu53sKtcD34O9MYbwjQxnQ7jn73gnVSVSCDs6NUGXU35dgjzQXjHr
	jCyEDQrhZ/1shsrH2ZDflshnUSIVoxp6eN3k1fx6W4COl7+5AZLUOxtMKiONbaGM+Id7N5FR2rE
	oS4kUXvPWHvluDkNcqJj8izSYndiGZyV3MNryLK0vWecVjBRRLx835XM8GwU5hdlf+BQ7+W7lQZ
	Ux7dwkBq/xLgBZVF/B/+xLR3OtASZemst0XUp5lwh0Bnxr5a7IrezJgUmNTn7GLgmEwR6+R1/TC
	KZW92aQNWduiO29zcmaVQ/Lih7DW8U3sDtale867dE8A2tz10K/gXfMeuRi4bejp5BhVIImM3XW
	9/TiBYxpTR43J2WjJRDHs1NxkxFlMfh5PhgqSMbsur5sVXdOJwqkU5L4=
X-Received: by 2002:a05:622a:447:b0:535:8559:f0f5 with SMTP id d75a77b69052e-5359facb683mr274213681cf.12.1792015703954;
        Wed, 14 Oct 2026 15:08:23 -0700 (PDT)
X-Received: by 2002:a05:622a:447:b0:535:8559:f0f5 with SMTP id d75a77b69052e-5359facb683mr274213251cf.12.1792015703456;
        Wed, 14 Oct 2026 15:08:23 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127b5567sm8224761cf.12.2026.10.14.15.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:08:22 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v4 8/9] tracing/osnoise: Print taint message for timerlat
Date: Wed, 14 Oct 2026 17:07:58 -0500
Message-ID: <20261014220759.908839-9-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014220759.908839-1-crwood@redhat.com>
References: <20261014220759.908839-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iY2_KQBkurOnjAffEUP624QkCg1bU94gtspo45V9nPE_1792015704
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
index 36088b30f4ed..40b6f3df8a20 100644
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

