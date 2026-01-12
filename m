Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0819332254E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246030; cv=none; b=KcjBX46UVlpSGpJV99SspwkX41SqLi10DxulCtGTBQmeV9rnPeY//+bXYDnycTQEs5TwG/Y1km7xCeJ/T5j0PGW9eKrMgCWRLr7nUgvBUhjT++R47NNrAaC7fIecF8tIWxB0lB8LEy9K999rLr6+TLGupcGYNgsjtvqhHop3eHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246030; c=relaxed/simple;
	bh=R7JwleE/Tson4DuHsVL+MShFRymRWsCSXRCJB49Z1g0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=GVUv+KtFz7TVWQSkU/9yf4+nDChB8eioF5i2iostujA6gUlfXlnmzF+QAOfO9XGH3TYfV/9nfZHW+rlJbrLeSZEcdKjE18eTSZfgsBiJB+G0Q3yWeTz84DYlf8iVoLf/f5uVxcWUd3Ut4gA3wEdXkksYfg/O872M5WvgUaAnw88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f2NQI0Aq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f2NQI0Aq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768246028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DvjD/UNgideSUYT1rmAsSZG3Nca8X070zkLBGlqFUZE=;
	b=f2NQI0AqoaRPUtGtMzEozjEVQ8HB2vz9utjBrnW3xnFr+RqDUjtUQ9pH3TCUCKovaRSCRk
	223lylYNSwY1ixz7IFZSCKmLRsnT1N1bvoT2yXB9M0FWn7PfLbUZ+9aDoznRTChqRSh9L2
	gkFNcePDZgFKptnQdzZRbcL8GGIfVKA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-ErvOARppMm-OUE1JCtR2sg-1; Mon, 12 Jan 2026 14:27:04 -0500
X-MC-Unique: ErvOARppMm-OUE1JCtR2sg-1
X-Mimecast-MFC-AGG-ID: ErvOARppMm-OUE1JCtR2sg_1768246024
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477bf8c1413so45527205e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 11:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768246023; x=1768850823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvjD/UNgideSUYT1rmAsSZG3Nca8X070zkLBGlqFUZE=;
        b=oWxHTMDhuyXxzRV6tMa2FZuqwgUkB1OmDCbimXpoQYRJD6eUAuoOiilPwbv9kidOE4
         2/Yhqs8DAvKZRiGbfGbB77jvzoXRcqYV3190sXHBu9glNyH/0P6bulh1Xmo0E3bKD5ti
         Ldq2y5K4lrxeG57ZFbtbh1+HTqMJXNCnpVaspcrjODjLK8slY1I58hi9SOW8e9ALAhbo
         eunE1gi9YmlwHk37TXMzijcbUDHB/lAne+HKSZxFNUSw31MH7tcjtlZVe9txZ4KOZBCd
         M4IkGb8a/ZBN2GaBGbz8cOkkrW09zMVr1LLvCujuQuwPeiscelU/vUsVswkOC1n6jP1k
         yH3w==
X-Forwarded-Encrypted: i=1; AJvYcCVVpPP1dX49aWIBrba+RJazEP1zN2BvEcCzbTPe88gn4fuA+aPGxVWQ7KMqxHLLe7LMD0fgK9cEj64Stt5xxsZF/MI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7s61cQRCtvLH2afBnpSA27Hnc0lmKlCRUjTCRV3bkBFBqNY33
	oCO43ElGTd0v7vMlt655NHGXRXvHtRV4yb5I6MEm0FOP4GDs1WvQQSnMorDUMN/0OmXY3kVZxhX
	OdRx3CULvoXYwu3FWxlzLG4eqEREMDdy9rNLOYWWVM+7ZYW0eLVsPwbX4TJFRcvxJPnzrmE5Rag
	==
X-Gm-Gg: AY/fxX5MRvGLEhjfaYRImi1kxPeXzz7UqqzcE4sg/tyXSoLOG6Y1SJHLXxL9+BjIuGb
	GcxZvfZ7mBlyBgfBGJVljwo7zEbatgB/kEbgfZ3aPdW2Jt20VKCELuymxL+A0eR34VdCbygQpzP
	V9LtnM5ICb2csI9cOfsSG+0wIC/TNlRlrdMOfSeulLhc60U7SAFmzulESJiHrEO8oAUdqsZKW3z
	wjhGyRr3O4tIApeISIEWMszJ9Q6NQBxQ9egsaCEG/xdEz5Gy4iZMdxNJkexuYKQS85J5rd6rJwY
	SrW25DHo0d0DTO9QFFngqkSu0acYw3/LUuwu4rfQ93qVy6gxNtpN8Cki9CQWfhxfm5WmmLH2Tqy
	+TGdo8wQW3KlOLFM//QyiBP01
X-Received: by 2002:a05:600c:1c28:b0:477:632c:5b91 with SMTP id 5b1f17b1804b1-47d84b1a2e7mr240922025e9.16.1768246023557;
        Mon, 12 Jan 2026 11:27:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt0jLiXlNtdXOUnceerwpsmguRccrH0dPl2CJPtvOxDYVUlY4lHWrFkVDs+bgfSs838J1kSg==
X-Received: by 2002:a05:600c:1c28:b0:477:632c:5b91 with SMTP id 5b1f17b1804b1-47d84b1a2e7mr240921815e9.16.1768246023183;
        Mon, 12 Jan 2026 11:27:03 -0800 (PST)
Received: from costa-tp.redhat.com ([2a00:a041:e23c:600:cadf:120:2b7f:a706])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ed8ae8a86sm2646465e9.4.2026.01.12.11.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 11:27:02 -0800 (PST)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Ivan Pravdin <ipravdin.official@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] rtla: Fix parse_cpu_set() bug introduced by strtoi()
Date: Mon, 12 Jan 2026 21:26:41 +0200
Message-ID: <20260112192642.212848-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _G2GVoaQC2Fyo978k7T3W5PNBIjuhbsXOQxx3uuBS6A_1768246024
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The patch 'Replace atoi() with a robust strtoi()' introduced a bug
in parse_cpu_set(), which relies on partial parsing of the input string.

The function parses CPU specifications like '0-3,5' by incrementing
a pointer through the string. strtoi() rejects strings with trailing
characters, causing parse_cpu_set() to fail on any CPU list with
multiple entries.

Restore the original use of atoi() in parse_cpu_set().

Fixes: 7e9dfccf8f11 ("rtla: Replace atoi() with a robust strtoi()")
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---

v2:
- Split the patch.

---
 tools/tracing/rtla/src/utils.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 18986a5aed3c..0da3b2470c31 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -128,18 +128,16 @@ int parse_cpu_set(char *cpu_list, cpu_set_t *set)
 	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
 
 	for (p = cpu_list; *p; ) {
-		if (strtoi(p, &cpu))
-			goto err;
-		if (cpu < 0 || cpu >= nr_cpus)
+		cpu = atoi(p);
+		if (cpu < 0 || (!cpu && *p != '0') || cpu >= nr_cpus)
 			goto err;
 
 		while (isdigit(*p))
 			p++;
 		if (*p == '-') {
 			p++;
-			if (strtoi(p, &end_cpu))
-				goto err;
-			if (end_cpu < cpu || end_cpu >= nr_cpus)
+			end_cpu = atoi(p);
+			if (end_cpu < cpu || (!end_cpu && *p != '0') || end_cpu >= nr_cpus)
 				goto err;
 			while (isdigit(*p))
 				p++;
-- 
2.52.0

