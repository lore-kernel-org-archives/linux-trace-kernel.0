Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2BF1A9FAE
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Sep 2025 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757211834; cv=none; b=oC0Snji6qJYSlfZVJOdPb8XwoL5pGZ1F7dNhVbszPBtrFlTrEmzIKL204AplN0Ek39CiEbNJN1VGUp99/SJ+0I29RB17UG9nU1fyPQvscdTQzHQREp/ZPuvj17zZwq8Wx8AOg/8mFviCbKJ3KMBXQhLfthFJzCXsmXARapDnMsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757211834; c=relaxed/simple;
	bh=TPC4wRYsaxi6AWXH0E9cFPhp6S7d0DZ8kt7AIz1cNCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=dot6C+1YtJoj0jhtiJPYHokgnF0AYcIIGxygAuHbmNjHwdFNc8Rl7obcQ+8SZytg2weO/Oi3Ow2mjjvqki6G0WmddxW88I6Ww/RSfxvj476yKGBMvdDdG7XfAzdAFB6HfAwklpPrc+TE9qVn/1h1tmrwywhnJTzNvLJ/QQ4q0yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALYUgASi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALYUgASi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757211831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1IbJziTtRNJ3iQ6x9gNxWr6y3Z+80I5BRaRuQOIJqg=;
	b=ALYUgASiB5sPUxvkTgj0zuPTHHwS2o88cGKdHoG8UTQRsxvd9KuQQXAxmPv2ol5XAfx1RB
	RdhGoH3j+4yK0PM9nnK/zV+FvzSHK4DHuiB8z62APymqdIPmsBwJkF6uhFWNdHauC/xZVj
	dnV57L3tCJhwV+58Ia/hkUVUqSsiiyQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-YEhJRxCjOIi2xmdkDVnHpw-1; Sat, 06 Sep 2025 22:23:50 -0400
X-MC-Unique: YEhJRxCjOIi2xmdkDVnHpw-1
X-Mimecast-MFC-AGG-ID: YEhJRxCjOIi2xmdkDVnHpw_1757211830
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5eb7b2c05so60817811cf.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 06 Sep 2025 19:23:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757211830; x=1757816630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1IbJziTtRNJ3iQ6x9gNxWr6y3Z+80I5BRaRuQOIJqg=;
        b=sKXl57v8ohQYcYNu5XCa31LjYhkEk07EZ4UPD7nSIvK1ofsp31YCojxgLuPY2eKUn7
         U3T6JBJpZjDGHdnlVIlF+PcfRkqf9Te0ziTN9tjf5QoxDV4pIOVSrPyrpEbS4qCnFQPD
         1ji7VyXdkoubyzWvIsvtmVlRxTaDILrGVXKiX2yC2hH9OkkU94V3dISiegWZYqfaxeIr
         GQy14uL2TiyXis6qCCmMmgzLl2FtHuyt//isrw520TzBgDUBG3Bo/hzV4KAoAlNSCUp0
         mJ1jXFhNdeX6qxYqMeymNRG67K0U2PaqaL8zcTI3j/nLWbwj/JCjsSXtM5sHdy4uVd7I
         r/LQ==
X-Gm-Message-State: AOJu0YzJa7qYkY7Gsq/6F2rDooUbMOyOnYJXmxCRQjVjLKpFNRNHUBfF
	f02I45HphHy0MXt2cAklngMjAwgYyP+x+jQdfU60sP/vM4uWBKhAMAyqDXEZkJcPCkpLnJpdLty
	fR3UZT5GCdy7TKKRFEiEa/+Jbv+41NVxlTSzC77gSr7Mo9Y+qvs4Owrf4wwwcvgHFbUxNA4wIRQ
	==
X-Gm-Gg: ASbGncuAv1ZYPp1pUUVpPf8v27dmVu701qWTka/0/7W8h5Mi2WPXyWQyyFZr/GQBin0
	cX0lO+9CWsIxQp2spG0bX7eUNkBXYfzI6pcdt7xN831FG/cQsIwpTMptNf3tn1BrcomD4zxjRHR
	r9Yp0uC/Fnp67F9bJtcjjKv+G4rkRxueT1Z3oM0LgoGUydh70GM56w1+lNKgznF5kZviAlqPUt+
	ZlNMGDoMQFqDqVWAckau9L9on5r+CZtu8ucv7rsIemVJbnA/chCB1+91WatGvuka4ZuFTsDdLit
	O2+7WyVJNB1eAnJB7aWm7GkjviVo6YyOs7iRL2o2D5Cci3htsXJSskRWsSaBF3Eebve1Hss=
X-Received: by 2002:a05:622a:138f:b0:4b2:89c9:1568 with SMTP id d75a77b69052e-4b5f8393c18mr32529831cf.10.1757211829926;
        Sat, 06 Sep 2025 19:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzRqJtapLMSb4yIpZ4eLvDvPGI3ucIzFFjmINRRM8EWc/dIHG1BGeEG2L+apaiNBv65WC3mg==
X-Received: by 2002:a05:622a:138f:b0:4b2:89c9:1568 with SMTP id d75a77b69052e-4b5f8393c18mr32529721cf.10.1757211829547;
        Sat, 06 Sep 2025 19:23:49 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f673fecsm71105401cf.21.2025.09.06.19.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 19:23:49 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 5/7] tools/rtla: Fix -A option name in test comment
Date: Sat,  6 Sep 2025 21:23:23 -0500
Message-ID: <20250907022325.243930-6-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250907022325.243930-1-crwood@redhat.com>
References: <20250907022325.243930-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WMz4DmgdSJQgO_KKbHdULNez4L0ZuDhxLi4azSPmd6s_1757211830
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This was changed to --on-threshold when the patches were applied.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 tools/tracing/rtla/tests/timerlat.t | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index c71aed5534bf..b5d1e7260a9b 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -47,9 +47,9 @@ check "trace output through -t" \
 	"timerlat hist -T 2 -t" 2 "^  Saving trace to timerlat_trace.txt$"
 check "trace output through -t with custom filename" \
 	"timerlat hist -T 2 -t custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
-check "trace output through -A trace" \
+check "trace output through --on-threshold trace" \
 	"timerlat hist -T 2 --on-threshold trace" 2 "^  Saving trace to timerlat_trace.txt$"
-check "trace output through -A trace with custom filename" \
+check "trace output through --on-threshold trace with custom filename" \
 	"timerlat hist -T 2 --on-threshold trace,file=custom_filename.txt" 2 "^  Saving trace to custom_filename.txt$"
 check "exec command" \
 	"timerlat hist -T 2 --on-threshold shell,command='echo TestOutput'" 2 "^TestOutput$"
-- 
2.48.1

