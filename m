Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527531DED59
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Mar 2025 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743187159; cv=none; b=sWePLkwK0FaX8zjCagyMfC7RP4nzTJICMEyjHULP5PxulImqcLZaibv1oeepcWK+B9ob0DRB+vdmxEzytwS6qfcVDUr34PIut1RVhzgavFzE91qQPf7AQtdatIUM8O0pGeB9V1BeUJk+3VZQpEJeIrk0eduLi3/s6k1vz6XkB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743187159; c=relaxed/simple;
	bh=1zdodyMlrFORk+ZHUT/WMS+Bgi1OHksWmLDQfkjhwG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=VPGvItcrW1HXKnk2W/nRxGv+xApHHKkIAUHqWx9c93XZ75m9RxqtIuTzxK8+9PVhO7o1QukN9gC4gdUok1C61tIZA/55okCQtxPksXDvG9rATsoWJidTMYlos8IeNhcn8seJDLAD0+irlw3J7u0F2S9I5jNwztg4j2eKkIWSBro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VL4BvtP4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VL4BvtP4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743187155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UZXtYcY2hkO3QOI4CXVGceWuHO84yTnOursddEVHNyA=;
	b=VL4BvtP4iE/8h5sguR/mduGUczS0Y9ulh3NLkFLLFjANLIzZyipy6tQgTRS3lHNoEGe1VT
	zkAyz50t//+6MN6AF+/KTI/K90f7G/YD7DAXWxrCTiS8lPAu3ZIT5Vr0Rqnco6xYW9VOJg
	ridGcOlJq9JpYg8Qwh27Yk66heXg8c4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-t1TAs6ztNHmXdaGfIk-kYA-1; Fri, 28 Mar 2025 14:39:13 -0400
X-MC-Unique: t1TAs6ztNHmXdaGfIk-kYA-1
X-Mimecast-MFC-AGG-ID: t1TAs6ztNHmXdaGfIk-kYA_1743187153
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ed16cc6e39so46827166d6.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Mar 2025 11:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743187153; x=1743791953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZXtYcY2hkO3QOI4CXVGceWuHO84yTnOursddEVHNyA=;
        b=wcOH2aQnTahgqqi9GE1ji9EZghD1g2SfPmR/I6PNQ+PSPDeTjSC2p+wUmj3mjJ65Y1
         GcWunRtW2hA7y5y3sp+hMY43x69Im3vrpKy1Ho8T95LhqjIdckZikh3sDU1nesE883je
         OnAoMzjinI4q5O8MJCcnyrCkL6X6zu+cGZIkg0W+SdbFGm80yxcXEFOctubx+VgTTmHq
         JeYkgU4G1GaPsLtmAyYSq/51c01Q3VP1FfBqE4OIqxi4C2Qc91JW7ZGza0RnGEnNzSbD
         jRSpiz1WrEfozK9H/pgMFKya5TbUunmJqngIBhiLIj9lRHX+ndhpqmBbhOR86dpcBiLC
         kd/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNOn03GWD5NppxoOwEsrD6+sxcKXckMTp8kHCQej7CntbfDkbOz80RV3F44NSJgzDFzH/Vv1AW9cB6pkTxA8wNtCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6c4XyF1Ohuwq9yCjMRKtvPynFLkI0LvwmOE++QTiTOgHD+Wn
	3/CLV1JdcAShhXDR4Tf+zUOZSnN1skXvgNyPyy+Q2NhWGHWcxxvuLP7hsDr3M5YpHodnxsvXYvI
	hnLcVrIfD7izxrLP0fOMmx9AyXMP674FESjlacGpCFMq7NvGBvjYmqgb1o2Jq224wnJIIew==
X-Gm-Gg: ASbGncui13ZPkN016fAKIqBXtsAwYdRKLzVhcozUDccbodENh0Ip4g+cQEzkWyR47nr
	3UUrWtRkhLgNC1edvXskhURpq02+rCf8qj44StBpCjR3WjrVrGtgBXWkHxelTU6D2u0vjx2LjCk
	C7bZ4hpU50z9C7PRb79rXdJz+GCxCcwdCT4gAqSggg80O+IKXAwrwM+k1kzzBw/r8dKvoz5xv6w
	if4kfFQc/fucH7kMa5Uz1BquMiCnaIKhu0cseKbBsSbQxi0nVN9kp8O4lRyVhxzjpb1Sdec0663
	ardXtEz+79l0d6TmZ4VOJfto1DGsY+eUD564vzzZvQ==
X-Received: by 2002:a05:6214:2507:b0:6e6:6c7c:984a with SMTP id 6a1803df08f44-6eed629b621mr1059186d6.29.1743187153288;
        Fri, 28 Mar 2025 11:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmaGUFo3C+EWgEgC2Qjw1O8SLn5UyR5+uhBzYEK+WvHlqvjwgDG2/+08yH13LN7hZFfbo2iw==
X-Received: by 2002:a05:6214:2507:b0:6e6:6c7c:984a with SMTP id 6a1803df08f44-6eed629b621mr1058826d6.29.1743187152801;
        Fri, 28 Mar 2025 11:39:12 -0700 (PDT)
Received: from x1.. (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec964649fsm14276836d6.40.2025.03.28.11.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 11:39:12 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	aruiz@redhat.com
Subject: [PATCH 1/2] tools/bootconfig: allow overriding CFLAGS assignment
Date: Fri, 28 Mar 2025 14:38:57 -0400
Message-ID: <20250328183858.1417835-2-bmasney@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328183858.1417835-1-bmasney@redhat.com>
References: <20250328183858.1417835-1-bmasney@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PQt83EQnX8iBF8rCHOfStfWD4uOiykPpRdu0ooSXMWg_1743187153
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Allow overriding the CFLAGS assignment so that the user can pass in
an outside value.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 tools/bootconfig/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
index 566c3e0ee561..d2713902ca5c 100644
--- a/tools/bootconfig/Makefile
+++ b/tools/bootconfig/Makefile
@@ -10,7 +10,7 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
 LIBSRC = $(srctree)/lib/bootconfig.c $(srctree)/include/linux/bootconfig.h
-CFLAGS = -Wall -g -I$(CURDIR)/include
+override CFLAGS += -Wall -g -I$(CURDIR)/include
 
 ALL_TARGETS := bootconfig
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
-- 
2.47.0

