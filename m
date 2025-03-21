Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A61D5AC0;
	Fri, 21 Mar 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742579505; cv=none; b=mvhXeaTzyNPZ84R5BpsITrSwZ5706Fzd1AZSAQNOVT4aFoyupTP8g2DdQJIslS9LGmawwJYUFiSb5fCZngAxeCwBCqq22EjMb9xAbQu6GAuo4LYbNyKwdL1VZg6UdFhg1fUkQdxRwnepDKgGSGhnKX9ydsxOrMelnRCfYaCmgnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742579505; c=relaxed/simple;
	bh=tD2ZR9D7QvqsfkSfAe1yCGUMId49srQfFGxm2Jl0rPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUnMIz4+SMpcI6eX8pNChPXWwyQXDCGfV3B1g9nCnKB7dGIqgUOqHkLUgtIos8kWPd7vPQpSDr3aeW/jMbhiXoiODdKUdo+OvTbKOSAzjO2B+G30n2NxtA6XfcmwPTjGiwmhGaRwnaKn/NGgGGwIGvyjldJEVfGRn3hXBBBZvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hflQxNdn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hflQxNdn"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476a720e806so20252011cf.0;
        Fri, 21 Mar 2025 10:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742579503; x=1743184303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RiGKE4wQb5jTm9v2pVb8bGo+XwD3946juIP+VJ/KZVM=;
        b=hflQxNdnitxJyrsHHgKGTAzkG3Ycp7Fv5u+RicZ6tU5G8ryMwWn/Y5Ln/WuLKJNh1G
         80claCf8UkRSql5o+SgvqhHuG1HmwF1WJl67Vw6v9lDsSGKD6+Z+zTw1NRtGaMqmj4vh
         dDQxCVLkhFj88I1UM0Z6rjX3b4hRD+QPdgdZHhMx889xar3ApkDq1lieWtzkiUnC6Zaq
         rjbQONHTHo2hyFG0Qnt7h2zPyAcpWPy93ERrjxhuFxHXJyT1YOv7yGJQX6pv9AqsRlfK
         gI1j5uRc8LNL7fAWm4dsJan+cBAsTGTsE2JwA9ANJFnwzDt+6scCnLd5SRbyVZDVO5/j
         c53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742579503; x=1743184303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiGKE4wQb5jTm9v2pVb8bGo+XwD3946juIP+VJ/KZVM=;
        b=nlnUl7RRLjiq+bZCqfVIzdIVv3z9rqUXCbtzGj/3WaHabZnHPkiRuj0MkSFVGi6NWV
         SesUcLFGx0Vm5TIKYdh2euN3QPQdG+XQxK6br2d4f96Tz04nrDLyrPjwqdlYNwSw3mlL
         lQX8+04S1VCWL2NtKMnzvjB4KF+BqArPsnwRcuSmez7kowKo6Lje1rmY08H0KIWXKAQf
         WjEgAJMBHtWn4AZXClfXt6alkD92U5yGHIbckknau1+gVxOTTyJfby8xcoETLEl+vvmg
         orS8ldioqR08elFBgyL6PyjbVqW/YPFJGEGkHAcs1ZQN+MKqc7whyxFPS+8VPJWgcaYN
         hdHA==
X-Forwarded-Encrypted: i=1; AJvYcCU0jz+/uLKZS4UprtoEgXQENBLbb0S82AS/hqwh9vpU2dV9EbTXHPI33GhfgS3H14IvXcHx1Ji1XIVKSuM=@vger.kernel.org, AJvYcCUmvLGoibge9vQu4044wIAckc929VoVecBiR3LNlTjdpEteJ/qfc42MJV0+eMH215ZS/IVSbuGDMj1+n+0pxMssLzrF@vger.kernel.org
X-Gm-Message-State: AOJu0YwG727W9JUCDkQ9OKwPMMH7pVO++wjoioqZSUGPfrLVuXiBFpwU
	6Tq7Evao75afUiUAqRhrbkhIGQjv9WnEoF8v5YjHc6zTn361rDuT
X-Gm-Gg: ASbGncs9HsEuKcQEIIpnSc90hWedhHQ/JfLLOYmvyZ/GyyDzLKmX+CBHSPoSFte9Ww4
	la1s1xPKSqFn2X3whRj1x+gm9q2gCzqvmael7Is1FqiIbIfUgKsnyWOfN2v837FtsyhduaLuXzV
	OoCDyo4rnI8O1Wwm2LP5GKob5nv3OY34f6WmnRn1FLU8JM3/9C3YI0LMRmf+OeVt+K7GWZoZ836
	CS9rGItUGwZZOBdVEkEOaw1C2fSkTuDW3ZajphnlApMluvOC0fN5t5oOS/HbJJe2WxHoZYJvEyG
	SXwtZDwqaVV6cV/Kf4ch+YVIbMIA0CfCj57ygPuvEctc
X-Google-Smtp-Source: AGHT+IGZphiRhRmT2hmnZJwCfrZavv5AvU6vIoQevJb9rGGFWGDfEZQbs0ZWBz+gV1sr5zZ5mEg30w==
X-Received: by 2002:a05:622a:17cd:b0:476:8825:99bf with SMTP id d75a77b69052e-4771dda676cmr67435841cf.27.1742579502768;
        Fri, 21 Mar 2025 10:51:42 -0700 (PDT)
Received: from fionn.redhat.com ([76.69.33.37])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92b2beasm157777085a.3.2025.03.21.10.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:51:42 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	"Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] rtla: Add the ability to create ctags and etags
Date: Fri, 21 Mar 2025 13:50:53 -0400
Message-ID: <20250321175053.29048-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Add the ability to create and remove ctags and etags, using the following
make tags
make TAGS
make tags_clean

- fix a comment in Makefile.rtla with the correct spelling and don't
  imply that the ability to create an rtla tarball will be removed

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tools/tracing/rtla/Makefile.rtla | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/Makefile.rtla b/tools/tracing/rtla/Makefile.rtla
index cc1d6b615475..08c1b40883d3 100644
--- a/tools/tracing/rtla/Makefile.rtla
+++ b/tools/tracing/rtla/Makefile.rtla
@@ -34,6 +34,8 @@ INSTALL		:= install
 MKDIR		:= mkdir
 STRIP		:= strip
 BINDIR		:= /usr/bin
+CTAGS		:= ctags
+ETAGS		:= ctags -e
 
 .PHONY: install
 install: doc_install
@@ -47,6 +49,18 @@ install: doc_install
 	@test ! -f $(DESTDIR)$(BINDIR)/timerlat || $(RM) $(DESTDIR)$(BINDIR)/timerlat
 	@$(LN) -s rtla $(DESTDIR)$(BINDIR)/timerlat
 
+.PHONY: tags
+tags:
+	$(CTAGS) -R --extras=+f --c-kinds=+p src
+
+.PHONY: TAGS
+TAGS:
+	$(ETAGS) -R --extras=+f --c-kinds=+p src
+
+.PHONY: tags_clean
+tags_clean:
+	$(RM) tags TAGS
+
 .PHONY: doc doc_clean doc_install
 doc:
 	$(MAKE) -C $(DOCSRC)
@@ -57,8 +71,7 @@ doc_clean:
 doc_install:
 	$(MAKE) -C $(DOCSRC) install
 
-# This section is neesary for the tarball, when the tarball
-# support is removed, we can delete these entries.
+# This section is necessary to make the rtla tarball
 NAME		:= rtla
 DIRS		:= src
 FILES		:= Makefile README.txt
-- 
2.48.1

