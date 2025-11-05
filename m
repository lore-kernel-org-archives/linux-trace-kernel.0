Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFEC2FB612
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334699; cv=none; b=oUpmbjbiV2lysJkFlZh2sMp5YvEJes1n+OgKUGeiyx3bIHjeZBM8v+TSZCuOOAkaE8vPk7rV8g6sm43f6frzEkI+sM+41f0pVnm2G76fvSnRmMtcQzj7Mw4BdPXBEeilBEPibPFLBB25ak/pYiEfDKke5uc1t/l8Ag/yow6oFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334699; c=relaxed/simple;
	bh=WauXXc4vq9dc4m2YhCPTip3cxluiOfELkNgUqBfMKh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=OytjBNu5Ip+kvbaehv88axMPBuP4/qoA9Tg6qhfyPE06sRoPGvnHmmzu1xkHcHQYBU0Wa0qJYvc0ZCnXdAaNPr6ZWaeyeLzUmaWOY+5JyltwT0/o6AT906DoC4K8htbO8t2SrqVmv4d/aEanb4vsjyPEG+K38nh0AtOkmeAgpWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Oa6NZEp+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oa6NZEp+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762334697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g2LtK1WnukuglRDzUwFbcjJQDJY3v+csn/jdcjcqmx4=;
	b=Oa6NZEp+0mhKR7ajFhmFsn36ZEjWk9sp/dniZECGKghB9B5P0tRTwAMl39NTYBlzWdkepc
	yir0/vRP0rpPS1KuXg+1KcLv/zIzeHR+YTwh3clnlKPAzE73AJ8OGxsDN2AxG9/ukn0zSS
	SKe9S/jFUoWXmSjCUQa90GuRsZk93ps=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-OpijB0HZOWSxb5yDc9UjqQ-1; Wed, 05 Nov 2025 04:24:34 -0500
X-MC-Unique: OpijB0HZOWSxb5yDc9UjqQ-1
X-Mimecast-MFC-AGG-ID: OpijB0HZOWSxb5yDc9UjqQ_1762334673
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477212937eeso44184125e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Nov 2025 01:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334673; x=1762939473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2LtK1WnukuglRDzUwFbcjJQDJY3v+csn/jdcjcqmx4=;
        b=BGqzoi5R1XqxFW6ZYGGW4SslUovmVuza9GBT/Ja3au4quM5jBq+8OWv47ySWQHqwD9
         gkoCfATkzYPj5UUHKi7U1FAK8zQ580QhCEg+QwqqhWr2x+t0IvgTuI0u42WFWZ4jWRqc
         Y9tgNtqRDnqEdxlx+C1FEM0Fpay3xqqsCl5jDhjTZosnCwOyAPVcM1pLBq73vt2boBVj
         Z1RsG9z4kf0FqXpgtt7daNxlYTydbcRJ+cBDFwTMnzYavCjPDuLHej64txJGH3RGY7bJ
         +KM16K21TgeVDk2jG2DabhO22bOFw81uHyn6chh/uRPmgAC/siSZ4+Pw/vgyNKrBPsC3
         sZtg==
X-Forwarded-Encrypted: i=1; AJvYcCUcMJDpoxsqa2IeuRiY4da96XlJEOQFZjx7Lw8BWwwSAr0Zo02qlC+uJvkU3tOlCjP7iKltR5KiCJNwG4OukN0p0iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkFbN/W3mUt5xSfE2nCP2Nu+uDL/z90bw0GXTxhHDNxuKsfUV4
	bjXxNYo54Ykd4vn2u0gL1cLB24Et50SYfOPB8cwhjYnSoOo4QS1VQdJFwieBCxrkRQgb3suvBuO
	RtlJyXfkLCwjKInwVIZFN/WDC7vyjGUHxOiK9Zq9gMvlt0Ab41Nq/5/VjGAZz09wakE6SHRYqkt
	DIPLekLg==
X-Gm-Gg: ASbGncsZTLsFjEmiQVg5U0lWyqxbw6pVyhonK0s7459zRuKGOOe1Cief/MUEPusWU1v
	+knSRJb9tLw3S7ty1NMOc7z8+yrkQsWqmQBs64AP9CbyJBKSw+F5KnKzZYVvVfm9h6UPQtaP/9C
	sGeaHnV9YYvltroWZaG/3pg0wl4a6f8zf5h2DU568m6FO/kffINZ4AIzNFShx+66u2KzQF01NXq
	jjMEMUQUH2mF500ZJlBTNLENS0Z3iC77HW2LXsvL2hVt8bTYdH7q+MScnVgYZKpIGDanE7Q2Xa6
	fExJFFVw/nrIkZzbje8B715E1lX7XCmmmx0/EDqm62F6yDC761AKoA9LGYd8IOpJ1CBV+EhTUWv
	9lxYmK82n4UQfiZVFR7g06NHCJok5g+Ii3uNjGZqv5bBo5D6x
X-Received: by 2002:a05:600c:458d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4775ce2b680mr18306645e9.28.1762334672790;
        Wed, 05 Nov 2025 01:24:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESJSYhewgGd1RuRz8Lw12CRAo4lDeH14xio5/jvFe4PBjGaxuU2eK1GZT9oVztYInMcPwNfA==
X-Received: by 2002:a05:600c:458d:b0:45d:f81d:eae7 with SMTP id 5b1f17b1804b1-4775ce2b680mr18306425e9.28.1762334672276;
        Wed, 05 Nov 2025 01:24:32 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc2007afsm9389164f8f.44.2025.11.05.01.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 01:24:31 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: add tracepoint core-api doc files to TRACING
Date: Wed,  5 Nov 2025 10:24:28 +0100
Message-ID: <20251105092428.153378-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HO3wDF9tsmYsf0HRojNPj-da2g-JXWS-b7OgZGFzs3o_1762334673
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

The files in Documentation/core-api/ are by virtue of their top-level
directory part of the Documentation section in MAINTAINERS. Each file in
Documentation/core-api/ should however also have a further section in
MAINTAINERS it belongs to, which fits to the technical area of the
documented API in that file.

The tracepoint.rst provides some explanation to tracepoints defined in
selected files under include/trace/events/, which itself is part of the
TRACING section.

So, add this core-api document to TRACING.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 499b52d7793f..297358d26bbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26197,6 +26197,7 @@ L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
 Q:	https://patchwork.kernel.org/project/linux-trace-kernel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
+F:	Documentation/core-api/tracepoint.rst
 F:	Documentation/trace/*
 F:	fs/tracefs/
 F:	include/linux/trace*.h
-- 
2.51.1

