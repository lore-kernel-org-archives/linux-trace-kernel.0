Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAD6217F24
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748712; cv=none; b=oDGdVzTGXUCt6wGUqaL/6Uc/HNyJIUywcR7WA8zbKofdY2yRtVOKapHcrUIlPo+ah2P90fhH+pqm+MKso970pCLSohUEfdJ7oKBqmwasDgTGTs/H2CHdhTYTMsoAHOiaQQlau1Z7OLvolJ2q2QcdTgZt/dt5hM6vfJL6JLBe0w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748712; c=relaxed/simple;
	bh=TPC4wRYsaxi6AWXH0E9cFPhp6S7d0DZ8kt7AIz1cNCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=o0CKHdHItgHdRBu9Ui1i2O50DN42YEgAv6D3bRWybOkgfVnbWwCmwAj72qomTCQJ+Vvxc7UqQ+P7wWla3YImVqIOQ2RVCVoU6r5jQNGdad89jSkXekU/UhDC1DJP3dMNK/sfYwKPu3sdSKFx0QoZ6NMcyPSNJxGObBBFZAB3tK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gyAvB7H2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gyAvB7H2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755748709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1IbJziTtRNJ3iQ6x9gNxWr6y3Z+80I5BRaRuQOIJqg=;
	b=gyAvB7H2r2rTzaZ7cqlq3Vh7Mw6k7jLJVFBWNk3afk1+lu4/AD2uCmI+MizbJovNu7aHVv
	HHYtejDhOwmMLNhJSBXQ7uT2kMop833yNsofG4wnvQzFDNKuSEg5L+/lvWzgTABndvt8ib
	VsbJmHn+JuH91ahU/zNkTred6Ay38jo=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-VQakmGckMw-MRoN23ugREQ-1; Wed, 20 Aug 2025 23:58:28 -0400
X-MC-Unique: VQakmGckMw-MRoN23ugREQ-1
X-Mimecast-MFC-AGG-ID: VQakmGckMw-MRoN23ugREQ_1755748707
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71e8366e9c6so6876727b3.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755748707; x=1756353507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1IbJziTtRNJ3iQ6x9gNxWr6y3Z+80I5BRaRuQOIJqg=;
        b=RlSEVYIFtsCUad297dma9v6UY4jyFWeQgYP9v7F7CKCVNXWoSuvZQLLuRuZIn6450a
         rhSH4paPBnM3mhZq9ie8kaUm9XMh8l6yzg2HM80Go2dz+7w7fDBNDBKhijyZ81z5SMrl
         wIKAPwRtjFiIyWFhObyYUyjomLbeUzixF0nOxwW9w2FtPxDhQU+93R3NZC++TRYdN1EO
         +eJ0JGizxqsvuHVnnUU11sMpjV5yTegKQeYwAhUATcHznEECFIsj9ehGekmBnalHAJyw
         oqKV2YLsfZNvl6RJd2sKBFTazOH7nv7LQ+O2vU7PW8J8jSg9uhgAPuD/wWOP4sHKGUhu
         A6nw==
X-Gm-Message-State: AOJu0YyQL9jFBsa/Sw/BtLcZVujIOws0n6p4Q0e+4nQoJAl7GLj8wylz
	zi/rWSimjZftMnko4r9foC9p8D18x9sj4YFyoGiy1DaLrxkkXUuRKLnQ3lmDurGtmYK1GRm6AvW
	/maxcekbAGtn84O+RIoLjUnaM0qI+Pw2VboLuqPOU6ZCdS8fqzKF+Alf6DQIZftOMxkEsQGlByg
	==
X-Gm-Gg: ASbGnct1nHuqLLmHCaorBXiNffJQZ1m786p+DUbg9V2rGlTXEO5GqDM8Gpl374vtuPM
	EXqLdMUZvvjV5Yxy8scxEHC2ueeRmNXfQVX/Ipb0M0fqpm6cj+Zl5T+LeIzvtWTv2UF5dFg7Jod
	qqx6U07XwYigxNqI9ydvyYL43anrmPVoXdna7LjPTxgO27g6d7Ro/mAlLxhHFnzf4Txjv7YPFAA
	WldcePCAIqWg1GvwnnWYrpQ4KRb+Fw/1FOcglTtub5WiIXfz2mS49XkZ0kYHzJ2Kjg/dE8tuaHG
	sKtWw36LP4rHCxM0KGLx6VQuYpDFe2t/Sh3NQvnuZqJ1Pjw6+WKWZSWRILhsHXNwbw1fTEo=
X-Received: by 2002:a05:6902:1107:b0:e93:4575:4d51 with SMTP id 3f1490d57ef6-e9509c644e7mr1263907276.46.1755748707447;
        Wed, 20 Aug 2025 20:58:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+fbveOrwWH8SxeVaTpIWwicTPeLBAVLCacRqtJrj5QStFOosR3ksXUr4Sw00V2Oz2Bs2Zsw==
X-Received: by 2002:a05:6902:1107:b0:e93:4575:4d51 with SMTP id 3f1490d57ef6-e9509c644e7mr1263897276.46.1755748707143;
        Wed, 20 Aug 2025 20:58:27 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e95078a1bdasm385457276.34.2025.08.20.20.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:58:26 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 5/7] tools/rtla: Fix -A option name in test comment
Date: Wed, 20 Aug 2025 22:57:17 -0500
Message-ID: <20250821035719.137161-6-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250821035719.137161-1-crwood@redhat.com>
References: <20250821035719.137161-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _WcaQXTn1zb0dI13O0KnSyw_n3McqoqoeCznbGK61sM_1755748707
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

