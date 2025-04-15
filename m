Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B470D20F08E;
	Tue, 15 Apr 2025 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744688785; cv=none; b=qMY6OEJbCDbWstIBZ27ffeD8tUGR8t7U8moUUMGm13GhYGJYbr7CJubkh/r6Z0IeGeq44hwy50vuQD6R/OZpnB3NQHdhKqkrtqapWUea2mS8btS4FXxCO3lC9cU7XVWoYz3TvHdppJU3p5fruGXqisCN1eFIoCIZXOkVjqzx/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744688785; c=relaxed/simple;
	bh=B+5NV7MLzPQD79AJGUxwB62Ga81xkJ+lY6i3X7fLvz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZC//UVEDGywPE1AduRt+NEJKHV/J5aPSNlIrSk0BxX8S1bls+Uc5Wl+133dHQ5nlyVwbyW+4G+EOevGVGfCMNfnr7IAbxyfZN4QkY0qRA6gFm23ftD0vZrILLyVURZ5q4DdApqKccneu1ifPRxLpUbR9scKtjkLQFKVmska9luU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd2eWiZ4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd2eWiZ4"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2240b4de12bso68578335ad.2;
        Mon, 14 Apr 2025 20:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744688783; x=1745293583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7Rj0eg/IgiCUmBzVG1wlUC8QfjOMeak+7Og18vfRA0=;
        b=Nd2eWiZ4wb6QVTOXOX71+gic0XOULy4LkALDRTVSie4+fNUsXpvOqxwKfybocX57rC
         XedUKtDZyvVP/6Ej/6viWyKFWeN1HS8D7iVTVyeXd5ZbGiGM0NvsqGIalk27duGfB3hR
         OSV0/eVpyu0B0wmNr8rqK+j0RtGe6LueaeqQVaYpX8c5yjmy+OqEPdnX3AJ/H7DSodkI
         d3f3/+kgqkgHbubD1V4NpK3cP/zf05chY29ZzYGQhNqP8eAIrxZDyh0LO+WKyVeci0OX
         M+TXkU8lv7j1yt8attLqP52/3MIOA9IWIs3nHdVUVp2jMM10k8I55t+rARmz9KtYxQpG
         AhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744688783; x=1745293583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7Rj0eg/IgiCUmBzVG1wlUC8QfjOMeak+7Og18vfRA0=;
        b=H85U0V41J3KazU/zlN2B3nMdt0yzK0GSAs8W1L3klrGXBp3uoRoPVSQ6en2093IHHJ
         p8fOTKM9/QsVQ3f/7Y8UAobyZuedJ70qvpW8yKa8R5XOn/ERZXTWTDxU8Rw+sOpfOujb
         9cqdyBAZxiFLeK6siOeE8VmejRZFlSUCBTdSKjZ/J2RKVuErXq/7n7A21lw30gRLxUwh
         49jFHKvw11W1xZHZ0aFZsjcrXFYbrklOVwPBh1ImjZhH2zz8By/xKbdQgJYDsK8KoimI
         eoVIhlFZME8YihvPyX/EuOev/m1xDRXv1rRwpp2LklTQZkaRpxCTi0myTXniodPdeiR1
         VMTw==
X-Forwarded-Encrypted: i=1; AJvYcCUcbyam9JSE9CxoxsezfTSlr60BX1yprM7MqVTxB3qZLZL/t603IiXBA/6G1wTyacnlkMsmLo8/twg8jCIH0poo93O8@vger.kernel.org, AJvYcCUvPp5aFOOEDtvaFdYcD0hOc/RLkFCojGKxJGLdQO+hkD1vh1G4RLNV0jqHptaoR3/FcmG/7GjixuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxykX1J80Z+xNFhII2aScg9TbqpWzlKxydUXDqNnGrORGYgloXW
	CWuc+AUgXGpt7ZEzDjO5qWCae0umcdVDnsk9lajKJd1asGvwCrED
X-Gm-Gg: ASbGnctas+KSef+kplrMfMVCJ8g2g/U+zc+esiCJtyVD9wX9tPlUF0Auycdm7sXc7PT
	3+uifewy/Aym2OcnTLlgfwqgMysMVKZHGy8xjvbN9n4YYnGWlq9uPnP4Z6vflUbM5m9QAV0TAsH
	Ahjc5SIfDheQ+BXip7pRBtKhW9Mh8yWRUhaEBHIrqJRyF+jsUhD5cHF5tqArTj72JmA5gGR+jdT
	gj3Qzd9+Zg1TrpwdaglmGBi9SWZSdkh3ttR9q0JMruMFznnp0tvgJ0wVLcStDugIxvQsWxU9UFe
	a04IMPKgySyT2MpA54N21vXlnIymr5LHp6KhJAQn
X-Google-Smtp-Source: AGHT+IGRzKH8R1ktNZ7aJ4RIT/GnrqFfl05RBO/gEqNLT/JrgTdwbkIvf3bLtdfdepI9Q2Drtd04lw==
X-Received: by 2002:a17:902:c947:b0:223:517a:d2e2 with SMTP id d9443c01a7336-22bea50e2edmr230723345ad.53.1744688782676;
        Mon, 14 Apr 2025 20:46:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8c7d9sm107517435ad.96.2025.04.14.20.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 20:46:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D45F14209E49; Tue, 15 Apr 2025 10:46:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH 2/2] Documentation: trace: Refactor toctree
Date: Tue, 15 Apr 2025 10:46:13 +0700
Message-ID: <20250415034613.21305-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415034613.21305-1-bagasdotme@gmail.com>
References: <20250415034613.21305-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3467; i=bagasdotme@gmail.com; h=from:subject; bh=y8R0W3TqNDOBpqsuxx1xK6yOe3uKwGDrA0WnFxOhRXc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOl/r7FtXjnJNfGkbOTUvyLMCqLB531vd5t4aArYeYiIX jxy5J5pRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZiVsnwv0rCdOHxxStSRS7o bFu8rJR1vXhniOi7I6xLQrZPjuq14WBkuCces3IN+wt/tm/6u+9uEtu2bJkSo8oDu7Pz+6bvn5f gygAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

From: Purva Yeshi <purvayeshi550@gmail.com>

Refactor table of contents of kernel tracing subsystem docs to improve
clarity, structure, and organization:

- Reformat sections and add appropriate headings
- Improve section grouping and refine descriptions for each group
- Add docs intro paragraph

Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20250318113230.24950-2-purvayeshi550@gmail.com
[Bagas: massage commit message]
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

Hi Steven,

I remove your Acked-by: since I massage the patch description. Would you mind
to re-add yours?

Thanks.

 Documentation/trace/index.rst | 94 +++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 15 deletions(-)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index fecc4adf70a830..5ddd47ee781211 100644
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
    :maxdepth: 1
 
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
+   :maxdepth: 1
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
+   :maxdepth: 1
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
+   :maxdepth: 1
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
+   :maxdepth: 1
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
An old man doll... just what I always wanted! - Clara

