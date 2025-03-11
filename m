Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23A1DE894;
	Tue, 11 Mar 2025 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696936; cv=none; b=M/zUgSDatFjrmXHGBGRvkcEtP7ieaqM7FSzchDT/QQeoWi5Ni9Pz5mKxVbj6VE8K3Ikr5tU5yqmnXBLjkAqPNlGX2VDEjzc0HaikFVH8vODYbX03qYneiM2bYDHB+mCmXYLH49eFA6g2vYgvcexcYOukYjNX9ixbPxUX1Efrfwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696936; c=relaxed/simple;
	bh=isFALg6CXqDl8cu7cPP7y6ryoQs71iJg27uKq5QT0gM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WqLMKrabscomzZuJDIN4ZXK8vokLEPR6bDf3byj8ECS54xLEmh/yEyJyhaIM1rzCZrHrAqpAca0ZAJ2L8MjEE6DWVsDVdYxDVHF36zs9wA9DAKYU2d59/vh2Yo3UixVtz/WbmtI1NGyRzy5PxTuJZI4FAJh05D7p17GObgugag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFXar4u7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFXar4u7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223959039f4so106755945ad.3;
        Tue, 11 Mar 2025 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741696934; x=1742301734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKfNUEOjLl/LJnQn1CB92jCGeCH7231aksnRXVNSbLI=;
        b=EFXar4u7FqepL/TdIjlR7Rr1E6ZejB+I+ZMvh0GB6oaJttbRWOO2ZAthqs4W9y2IFR
         VhE4Aj9SLEa5duK1Tp7aZcKNgap7oW53vTiXFPCe6svkgqJqQ4//nDplOk2u8cofBDm0
         7AQiGiRiaFwgS/McIAaeWZJAs6CKQJ0nHyeMeU1wing9FXyC4Ouijw4Kiv61c9By5AGK
         qmoRI5AgRtWCZLPJbImh+4aeOVZcXO89+C62PMc0aKtLhNqV/WBx3tPzb+II9PhIyzg1
         0Zb4jaxGILbf/X5OpaTvNqh4i7igUCnUkAzUuY0YeAQTxCgP4LtBt4HuQW21vSrLRX28
         D1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741696934; x=1742301734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKfNUEOjLl/LJnQn1CB92jCGeCH7231aksnRXVNSbLI=;
        b=mF+VsxL3NSVht9/P0MKFmQKc5mrOHMqnIAh5dLsxIJZ2IKbWlYYkz8zAsuONLBipug
         S3gFPrDfkDQAGxlO56P3lBTCFq3B+0Bu9xjCjzRCb99qBuRvcuG3kLZb+owUX7I48yBo
         Jy6Pb1ocWt42vP8Z+6zCdnm2WsSIu++pTMIDTfcgGS780/eTqKWrBIZCdWtDQL84YlRF
         H2tBs1NZJZb7DbOlR1dXWWzqkHip+zzy+epu+9A+NeuMVv0InGVZSB1NX+l6zWkJx+fI
         J+rpO/+2HdxW6coVV/FCTkSERs2ChFWJ4nvfPPb8/sGBCOnmOcunORf69uVLZN3oN+rJ
         6/eA==
X-Forwarded-Encrypted: i=1; AJvYcCU9M6uV/SPUbjcglWNCQIQE9rw0I01QCfgQ+stEbk7DMP45cU+zQ+bNHe1B6IDT1KRfq/p6Cr3XHYu1ZTCP@vger.kernel.org, AJvYcCUfYL9EdaHIxHuTTStgkw1k/5kEhP4ePMF8H3vqhoiQGMgFprMwrAjuYWWGyW79Fa+rvMymQsYM0vswpRFFoKxkh8hO@vger.kernel.org, AJvYcCVLQWDzB7Gl++zKzoaXMMHZqlmvBBAA2OUu2OGJ/ReQQ9DBSP4oqpNfEpGlZC0tpoZ/aUiiplB8x2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKA9+vDCsvXYwIaM0k0Y+ufzxduNawd5j7OiUlUGQVRhqULBX0
	vYcnQiMXnFKID2XiFMw+5PWu1ev6cXQeGjrPUP0L2Zvjd2fQ5Kwg+x1HByffzKQ=
X-Gm-Gg: ASbGncvIst72bqKVEglk7EMXMJQQqY6Pcl+CiAvjYrBSgyoQyCwW+jDQu81CIueaN8v
	nqL3IBfAahT+dbHi6yRKJD6UV2QLuBmqVBZ0nlaMXRXKN2GqZrvRE/7uCn6ugllm0oIGWcpYhiO
	uZzuboSC0ZmW/69GmV2NSWsgbikKGbN6KHVHRoFnzmkFEVPnbfKizaqbpT8S8a8pbnrM9Qs2Xsj
	11GSYiWO2C6sA3p1CAEGt72hyDORpzZYnvy6+3TJJSewwV8IycwK68Mv5uHiHY1/dK7e1X8IGvD
	uBqCJnrcCO65pXz5Q02c0xAI0dWOE2Dg/1TuBvSoSP8CFBqHMxOqVX9cImAp+DANRp/AHRghDO0
	o2OFtmSME4g==
X-Google-Smtp-Source: AGHT+IFksfkPNQwMHiJKY4c3iD+j5d/ZmUsPno28U2muS68dudrD9hC8Ud5qfSRkEDv+fENeBL7Z/w==
X-Received: by 2002:a17:902:d488:b0:215:b9a6:5cb9 with SMTP id d9443c01a7336-2242887eb5cmr282396875ad.5.1741696934361;
        Tue, 11 Mar 2025 05:42:14 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa4a15sm96360125ad.215.2025.03.11.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:42:13 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH 0/3] docs: tracing: Refactor index.rst documentation
Date: Tue, 11 Mar 2025 18:11:58 +0530
Message-Id: <20250311124158.22950-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor Documentation/trace/index.rst to improve clarity, structure,
and organization. Reformat sections and add appropriate headings for
better readability.

Improve section grouping and refine descriptions for better usability.

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
V1 - https://lore.kernel.org/all/20250204133616.27694-1-purvayeshi550@gmail.com/
V2 - https://lore.kernel.org/lkml/20250206141453.139613-1-purvayeshi550@gmail.com/
V3 - Improve section grouping and refine descriptions.

 Documentation/trace/index.rst | 94 +++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 15 deletions(-)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 2c991dc96..6b268194f 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -1,39 +1,103 @@
-==========================
-Linux Tracing Technologies
-==========================
+================================
+Linux Tracing Technologies Guide
+================================
+
+Tracing in the Linux kernel is a powerful mechanism that allows
+developers and system administrators to analyze and debug system
+behavior. This guide provides documentation on various tracing
+frameworks and tools available in the Linux kernel.
+
+Introduction to Tracing
+-----------------------
+
+This section provides an overview of Linux tracing mechanisms
+and debugging approaches.
 
 .. toctree::
    :maxdepth: 2
 
-   ftrace-design
+   debugging
+   tracepoints
    tracepoint-analysis
+   ring-buffer-map
+
+Core Tracing Frameworks
+-----------------------
+
+The following are the primary tracing frameworks integrated into
+the Linux kernel.
+
+.. toctree::
+   :maxdepth: 2
+
    ftrace
+   ftrace-design
    ftrace-uses
-   fprobe
    kprobes
    kprobetrace
    uprobetracer
    fprobetrace
-   tracepoints
+   fprobe
+   ring-buffer-design
+
+Event Tracing and Analysis
+--------------------------
+
+A detailed explanation of event tracing mechanisms and their
+applications.
+
+.. toctree::
+   :maxdepth: 2
+
    events
    events-kmem
    events-power
    events-nmi
    events-msr
-   mmiotrace
+   boottime-trace
    histogram
    histogram-design
-   boottime-trace
-   debugging
-   hwlat_detector
-   osnoise-tracer
-   timerlat-tracer
+
+Hardware and Performance Tracing
+--------------------------------
+
+This section covers tracing features that monitor hardware
+interactions and system performance.
+
+.. toctree::
+   :maxdepth: 2
+
    intel_th
-   ring-buffer-design
-   ring-buffer-map
    stm
    sys-t
    coresight/index
-   user_events
    rv/index
    hisi-ptt
+   mmiotrace
+   hwlat_detector
+   osnoise-tracer
+   timerlat-tracer
+
+User-Space Tracing
+------------------
+
+These tools allow tracing user-space applications and
+interactions.
+
+.. toctree::
+   :maxdepth: 2
+
+   user_events
+
+Additional Resources
+--------------------
+
+For more details, refer to the respective documentation of each
+tracing tool and framework.
+
+.. only:: subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
\ No newline at end of file
-- 
2.34.1

