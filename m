Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8D446A60C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852238; cv=none; b=J7Bu+0qZ5NtMC97jF/qkICGadajC8E4Y5HPspbkalIVvNJtAWBoeEHGApWHKF7UFFmuYwzwoiXL9OtrtEu99hmERhA3pL+U38pM2GncpGAVlLfbGc1yzW3xsaB4pohQfC+TQ94hAKEIe9xLtI7oPVsTzBowPX5AeuL2m+VQFVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852238; c=relaxed/simple;
	bh=poSZ+KVdqDxs2J+N4xmFknrYJs7GOnOl5/f0Ex3BoUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uxIzdWQTgGI8f4kzcJasDLR3OiyCyTmP6x13o0+dqopRQ+o/DtQplvxVuby1XQ08oG/VRvGN5NNYre73C9uMoKhmGy5iStqLRt6Je4RZZZ9AXSpyw7Hq+kP40VNq0eqZrJxWnu/h92FGdIKljQgCsZzlgwSt4sw8RbNmkqPvuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgVv3FpW; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgVv3FpW"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so2490915e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852235; x=1786457035; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JMX2N8WeHJfJVAqgylvS3ARRbyCq935st8+vCw0za1E=;
        b=kgVv3FpWp2NlQa9zXNkbUAdf5goDwz+0pslmsGHtN6+vSWlhHpxQZRjICaoMxEKbQZ
         OPbio0T8TiY4XCIqxx9hrrSdvD/uaBEl5OZRAIEAtsbc3wgZCF3IMdpNmsnE+IoBQgby
         q1auv0ycZ4g+Rz0YVHmfy5WIYBfx0Egv+4exX3BI2oLMDjFoXrY76Jr9Ka2QERUCuYbc
         eqCNI2P+6NfwRx2QMGCzksSm5oRuCFBPxACD5cvFRo4oc96sh+mSEoYaQaaBSegB2mro
         T56O74you0j2PtsqJTnLzUuMzPb7U/w8BEB60D0+Y/yrZR0TSL6PvdD+kM0MHFsA3daA
         bkVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852235; x=1786457035;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JMX2N8WeHJfJVAqgylvS3ARRbyCq935st8+vCw0za1E=;
        b=HIW93gLHtEDljucmM/dN6x/S5Mlv4f6kVGdgRxqWAqE2eZIN+LfwFueqdnSuVndXrR
         I69OVNgehFiWwTvWIkAf/aNqmA92QDZf0jc6QI7xn0cYNszEU+04bZYtC9nTr8umzW6s
         aWZBOxWK/w1obfQ4lKqrBia6MC8Oc8ZF1gZLPwr1iSxJ4C+DSRuTBahlgj2wIFB2sHNw
         Ja44H2LYkYZPbtgSQ7svDhU/ZQRkJsgHDnr3xycgL7QWQPNzDlbxhdCTl1SjRaNj/P7l
         YKZL0mFrb63dDN55E2YFyS91w2WEO3q5o7s915jykfOHMm8WHpBRYKmuJTv1J+iy8fr5
         34rQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro3BkV4N+LVl3XjnXvY7DWiUMq/wuvFcCVd6Of5Nd52UU052UgfI2z2NtTvyY1picW+DJldtBVFVxSTP5jBo2xDC3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw24+wLAnFYfnyTrWUzw+ldQVknQxpS3Xd+yifk5r4sqrEM+TIR
	JTIgfj1ckQXbuyLAZq5mB1TymgYi5Ui6pgP7cMT2wDGMxCBDbhMa4F9nRn3df7JZMnN5As2FWmS
	z7sUditUaUN08lesWswJH/w==
X-Received: from wmsl16.prod.google.com ([2002:a05:600c:1d10:b0:495:48af:c5b4])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3507:b0:496:cb48:5eb8 with SMTP id 5b1f17b1804b1-4980c6747fdmr231145195e9.15.1785852234535;
 Tue, 04 Aug 2026 07:03:54 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:18 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-4-vdonnefort@google.com>
Subject: [PATCH v4 03/18] tracing/remotes: Use kstrtobool for boolean tracefs files
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Use kstrtobool in trace_remote.c where possible. This is more user-friendly
as it allows a better variety of input strings.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 0384277070b9..0e4d41a93a7c 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -235,10 +235,10 @@ tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t
 {
 	struct seq_file *seq = filp->private_data;
 	struct trace_remote *remote = seq->private;
-	unsigned long val;
+	bool val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtobool_from_user(ubuf, cnt, &val);
 	if (ret)
 		return ret;
 
@@ -1147,10 +1147,10 @@ static ssize_t remote_event_enable_write(struct file *filp, const char __user *u
 	struct seq_file *seq = filp->private_data;
 	struct remote_event *evt = seq->private;
 	struct trace_remote *remote = evt->remote;
-	u8 enable;
+	bool enable;
 	int ret;
 
-	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
+	ret = kstrtobool_from_user(ubuf, count, &enable);
 	if (ret)
 		return ret;
 
@@ -1231,10 +1231,10 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
 					      size_t count, loff_t *ppos)
 {
 	struct trace_remote *remote = file_inode(filp)->i_private;
+	bool enable;
 	int i, ret;
-	u8 enable;
 
-	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
+	ret = kstrtobool_from_user(ubuf, count, &enable);
 	if (ret)
 		return ret;
 
-- 
2.55.0.571.g244d577d93-goog

