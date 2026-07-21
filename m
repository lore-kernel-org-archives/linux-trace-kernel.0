Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B647887E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630187; cv=none; b=ZnrexSOW65Qx1isO+vCV4c4sE3VoVHUIpAsRFmvkNoEvZlyU702ru8aUhi6fhoe2X/bqoMrHxBuyddEJOwfGBJv1WSB3T2Ua41huBoqm0Zp2WN0Vey0D66yV2wjQFiX0GAdglBEmg16AnkHvDNBvCSIiBmGmQUBD3n9sRzwzFnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630187; c=relaxed/simple;
	bh=eX4mN0x9CZ7nv0kkaZ0SXQKSsTEO6YgiP/CbJixu5IY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EDJVrOvQszpDEKLXftpPTBYGcCa8xPrEsS1UUTEX3GZsCIyksjrHNFy9c1a05Wipc3LAPNsNAlbXLNHcD8DbndNXY6+B6v0MkIQnKaJkP4wTUy177LbGmadDPRXnbQfSYt/fr05AO02NxyPlZ/BVg/2LrxOiv5G4iVhhNrDyX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fgx+o7Xx; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fgx+o7Xx"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-495593376bdso17040915e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630184; x=1785234984; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fOM6WB0DPiDsDmPv6r2McbtSqlbzU/lVYT389U1WDGo=;
        b=Fgx+o7XxMeYQGeKMk9Oid+V1xoce9nGY01Cfz0X5/n8QWAzLaH7llRr5H3cs+EBy6e
         57KB3mXGMradL6Nm81kzVTUUIzmYBN6JvpvJU/xGZptMusU09rJ9D/P0FE/UF5579a5w
         4ifeETUxslwa1t9bSNbRLk3mY19Mb1zYsG8XlKhZXQjDqfpoHBWY7dWpBF0cmPVLMb+y
         6Prcru1+CGqWTfamOS6vZrBnWfjQuf73PHwTd32DKUTLhFHs7NtX0TYLNp8nVelE4jqj
         IGsXnHYLjY5rUe0fVCspxrlIo8tlAkQuSGettBVK48VS7wmuO7+M0mLKPqyYOGgjJQrJ
         2c5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630184; x=1785234984;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOM6WB0DPiDsDmPv6r2McbtSqlbzU/lVYT389U1WDGo=;
        b=mPolCzIohvOMGn7wYUZDNxVhNRQsclaHc7zFb//siLQqjCDq4aWBa+3k9wrOJtKthm
         wGS0TsMEZYPW5et63w5O0UDew7xLO+KuLcYrGnEnzIMlIf+3Sv6iDdOghmldKh+E9plq
         WCwc/fQO+WohCyF07EfeaRWRaD8ODYW/dDx+Pvr57CSyr82UtzxmoQf9hP9TvKki5Lxd
         ey55bEtzE4KHvHJ+Oanc9z3Baoj1ocDtcISMERCsPfSNdFgYWkQLC0VGfheRbf9updE9
         hli52KlmYtFIaZcvAZpATrSCTTYpHg74iADy/ytttHBzBsnm2tSuBBYRK//9OSPY98gE
         cg6A==
X-Forwarded-Encrypted: i=1; AHgh+RrOcZKtf0rP0rii7kTI8TJmHmOQpSkChtnog9Yv9oZEl0hZBDR73G21U/OwTmPL33l0jp1zRO3UuAUFbfzNzEollSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGQAX1pnroh42mVNe3lBej72RiborEppxgNwGC+WIWtzyiDZO
	oIAmRoIXGufgtL6GBIlqZ41tgwCYdPnYIiJnyBbHyaKRuMfwO6o3T0mlUg6A32QoFumi8xoII6R
	rNoj02EgsJQGzAJ34mBgLZQ==
X-Received: from wmri27-n2.prod.google.com ([2002:a05:600c:8a1b:20b0:495:5899:6e45])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ec6:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-4954d5c913dmr199192755e9.7.1784630183747;
 Tue, 21 Jul 2026 03:36:23 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:48 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-4-vdonnefort@google.com>
Subject: [PATCH v3 03/18] tracing/remotes: Use kstrtobool for boolean tracefs files
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
index 2bc3afe1204c..94a52445cff9 100644
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
 
@@ -1148,10 +1148,10 @@ static ssize_t remote_event_enable_write(struct file *filp, const char __user *u
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
 
@@ -1232,10 +1232,10 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
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
2.55.0.229.g6434b31f56-goog

