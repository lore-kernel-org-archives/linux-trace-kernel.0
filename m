Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C465A347BDC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Feb 2026 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770983597; cv=none; b=DUoCXRVScS9k2F5S9SpmfjGaS+SsQ6m9nbmt50sKq4r/XkATB5+hDF7vnU0y/DI8tRvyew126Pt69V7SHNRruMBtgBqHIoW8LgdUDqLmemZ48FqJJHi5sqL/orKiIGJ1yj2v1LuqKojoPcKy1MMTNKtDiAGrlY1imps+VZPgymU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770983597; c=relaxed/simple;
	bh=2ZVTZcJEQvp9j4d2P5a9LlD36iiY34YfpFu/m0+lLq4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=jwXDxYDQ1bVJXgQ1EWravpeFIV7Psleqtc8hhnMR4658MLIk6zQECAi0LuCSqXil/Y9NhdDWdTil82/ZPLFPBHvZXiUo0eEEkst2Gxg02IBa8xs0cKCo6lLXmJBzeizruu8gXvYNUX6bIQkeQbDYKRtG0tXFTvtMF1jMhWLh4nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDn8hjtX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDn8hjtX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770983594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBIaDmc/b8KhOmbhsBz+ARqnHRu5Sb2xsdw5j1dfy9I=;
	b=BDn8hjtXDlqF4bAyVgwlMUgI2FXuERbKJ6KK8Mn/CB+x4CkdmH7Mi+ZS0By6WstYm4Nqnh
	gjHOGAAu1b70OCnaMxoXGY8uE0GvmhEog5W4GThlTvhMM+JGasljI2sfExuqAUYxxi5tA6
	Z8PsVNwCVXeQhU4NgFRy2nxDDB5zwVI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-YH1dYcTWOIK2mJ61uLKFrA-1; Fri, 13 Feb 2026 06:53:13 -0500
X-MC-Unique: YH1dYcTWOIK2mJ61uLKFrA-1
X-Mimecast-MFC-AGG-ID: YH1dYcTWOIK2mJ61uLKFrA_1770983592
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47edf8ba319so10956155e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Feb 2026 03:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770983592; x=1771588392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WBIaDmc/b8KhOmbhsBz+ARqnHRu5Sb2xsdw5j1dfy9I=;
        b=N55g3PUFFMQt1BQ1TdS5xxaX+tIcwYQJeUJkqexJHBAYZu76zQXqP0rpslvb2XjKMm
         ASpYTZpSbeAx/28I9GEH68AoTZcB18FH0pTK6LTMYDeKL3mUcj9rMbrOW5AaiB089ZAu
         2XSokwQ9L6OCdL296bv+UHGHldJy3WH3aqfI0CWYSZbvCBi1r5vwEYzpT9zySmjbcRfv
         jQhdCi7h+mIei9NU+eZnqKnYuoSOvtnVAmGteLz9o2DPtqb/KWTvMYhom/BJCLCBHq21
         FaVBPHnTi54Ls7jGcR81p2Xd8dK+CF5nWekDCPmSxuO3rbcE/3g0wA5rS96H6aGRoSJX
         evJg==
X-Forwarded-Encrypted: i=1; AJvYcCU50B5Nhut19L7RpoXK58ljcbg7PseM/p+xMB7Cf1S/qTmzzzVW+91N8jwcVxocODzZyiDU9iq0f0eagK4nXnzjxZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/fVkCxjyWdFSrKf+LTTwTChMMNJJ/AD/sberCLSqG+ptXiMfd
	3yVj9B+kenAaFsW1CSQ8lMLQRkVsqR8Jm9AZX70MdbTaOSls6rbZal0XyrzOv+c04sSX2bsbkB3
	TM7FtTKGgKpLBZmmiwLAfVOn39Dnm+DVrWMlOAN2zHRyS1CfPYqnffUc3qu0lb7EHNYWSy1BNTA
	==
X-Gm-Gg: AZuq6aIv6EGQQM3O9wxF9AYaMUMdmHs9sc8CMTTAVKwzGaPumvRshHJl03BFqLJojSq
	CY3onTE/2U12U1Iigv/KPaF+YTWpvboSBbuKLKNZgs/KdzLTs2AoQG3aPY3+QYU07NjMLyag9qx
	tGM7TJ9vCGPJuAB6NaRCqTRNZ8ih+lUxUMGv6ukMCy9flURYAcV0lXRzzD2Mmr+Js97rX6zTEau
	uEOEllXi69GHm7xBtdCAQx0df4IoVnZzfIMXi6DIZZR5H+Y/ui6lgaVfQZgU3g8yswIVYUbK17Q
	dOAqJfld6bK5a965ztDVFvPymrhKoTGP5aHP/guxSI9o5ZSHEKLTU3SvYP/2aSQrKx73qVHbvQb
	4AmDRgvav5/HQoWZ+6LjB140XbkoljAsaPIA=
X-Received: by 2002:a05:600c:1d89:b0:480:3bba:1ca9 with SMTP id 5b1f17b1804b1-48373a083c8mr27812985e9.4.1770983591682;
        Fri, 13 Feb 2026 03:53:11 -0800 (PST)
X-Received: by 2002:a05:600c:1d89:b0:480:3bba:1ca9 with SMTP id 5b1f17b1804b1-48373a083c8mr27812615e9.4.1770983591263;
        Fri, 13 Feb 2026 03:53:11 -0800 (PST)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d835f6bsm234671275e9.14.2026.02.13.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 03:53:10 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	John Kacur <jkacur@redhat.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 5/5] tools/rtla: Remove unneeded cpus parameter from timerlat BPF functions
Date: Fri, 13 Feb 2026 13:52:34 +0200
Message-ID: <20260213115234.430232-6-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260213115234.430232-1-costa.shul@redhat.com>
References: <20260213115234.430232-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4KoeAOtQe_9wrfS8s0AjB3-zjAxCKpR-lkckQVAaT8g_1770983592
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

nr_cpus is a global variable available throughout the codebase, so
passing it as a function parameter is unnecessary.

Remove the cpus parameter from timerlat_bpf_get_hist_value() and
get_value(), using the global nr_cpus directly.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/timerlat_bpf.c  | 16 +++++++---------
 tools/tracing/rtla/src/timerlat_bpf.h  |  6 ++----
 tools/tracing/rtla/src/timerlat_hist.c |  2 +-
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 8d5c3a095e41..dd3cf71d74e5 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -147,24 +147,23 @@ static int get_value(struct bpf_map *map_irq,
 		     int key,
 		     long long *value_irq,
 		     long long *value_thread,
-		     long long *value_user,
-		     int cpus)
+		     long long *value_user)
 {
 	int err;
 
 	err = bpf_map__lookup_elem(map_irq, &key,
 				   sizeof(unsigned int), value_irq,
-				   sizeof(long long) * cpus, 0);
+				   sizeof(long long) * nr_cpus, 0);
 	if (err)
 		return err;
 	err = bpf_map__lookup_elem(map_thread, &key,
 				   sizeof(unsigned int), value_thread,
-				   sizeof(long long) * cpus, 0);
+				   sizeof(long long) * nr_cpus, 0);
 	if (err)
 		return err;
 	err = bpf_map__lookup_elem(map_user, &key,
 				   sizeof(unsigned int), value_user,
-				   sizeof(long long) * cpus, 0);
+				   sizeof(long long) * nr_cpus, 0);
 	if (err)
 		return err;
 	return 0;
@@ -176,13 +175,12 @@ static int get_value(struct bpf_map *map_irq,
 int timerlat_bpf_get_hist_value(int key,
 				long long *value_irq,
 				long long *value_thread,
-				long long *value_user,
-				int cpus)
+				long long *value_user)
 {
 	return get_value(bpf->maps.hist_irq,
 			 bpf->maps.hist_thread,
 			 bpf->maps.hist_user,
-			 key, value_irq, value_thread, value_user, cpus);
+			 key, value_irq, value_thread, value_user);
 }
 
 /*
@@ -196,7 +194,7 @@ int timerlat_bpf_get_summary_value(enum summary_field key,
 	return get_value(bpf->maps.summary_irq,
 			 bpf->maps.summary_thread,
 			 bpf->maps.summary_user,
-			 key, value_irq, value_thread, value_user, nr_cpus);
+			 key, value_irq, value_thread, value_user);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index f4a5476f2abb..531c9ef16f51 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -23,8 +23,7 @@ int timerlat_bpf_restart_tracing(void);
 int timerlat_bpf_get_hist_value(int key,
 				long long *value_irq,
 				long long *value_thread,
-				long long *value_user,
-				int cpus);
+				long long *value_user);
 int timerlat_bpf_get_summary_value(enum summary_field key,
 				   long long *value_irq,
 				   long long *value_thread,
@@ -44,8 +43,7 @@ static inline int timerlat_bpf_restart_tracing(void) { return -1; };
 static inline int timerlat_bpf_get_hist_value(int key,
 					      long long *value_irq,
 					      long long *value_thread,
-					      long long *value_user,
-					      int cpus)
+					      long long *value_user)
 {
 	return -1;
 }
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index db66312ec966..1c4702948532 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -209,7 +209,7 @@ static int timerlat_hist_bpf_pull_data(struct osnoise_tool *tool)
 	/* Pull histogram */
 	for (i = 0; i < data->entries; i++) {
 		err = timerlat_bpf_get_hist_value(i, value_irq, value_thread,
-						  value_user, nr_cpus);
+						  value_user);
 		if (err)
 			return err;
 		for (j = 0; j < nr_cpus; j++) {
-- 
2.52.0

