Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7E88BE8;
	Mon, 17 Feb 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790427; cv=none; b=Fp0NPpXbt0blhAXO/5y/BVdwEDtCVFmTY/0/r+78IKbZs3Qva1dWdZffyk58JXfUhfsHjNsL9jYacU9HeRcebfASBleratbnWConoITywQP9tLeRBZIHetKIw6p+8PwDmSEzgcNG3CouxYUqpLUWk7uVO6FXKMo3fiopVOMrHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790427; c=relaxed/simple;
	bh=isFALg6CXqDl8cu7cPP7y6ryoQs71iJg27uKq5QT0gM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hzF1liwLLfowb1h463+DYc8uoVgBQmH4sV5dmkzgI1fUevqTjahlU02DQh4jV8eBdjr/H34qeXBtypIBZ+Wgfan39Eo0QECrKAPcXLXKOR7CoSmWXDiaaAka+THXu2NChmePhJdskJe0AdSLWr4q2iSR3IBlFC7eW14F7haPuy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAZdrRvs; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAZdrRvs"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso7855374a91.3;
        Mon, 17 Feb 2025 03:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739790425; x=1740395225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKfNUEOjLl/LJnQn1CB92jCGeCH7231aksnRXVNSbLI=;
        b=hAZdrRvsI9ZGckTj2v6B/y7q8yIQ+9rj7aorYQDpB+702JAMl2ceDej/E45gJVwB6D
         ktkf7m9T8BQQYY+DGyOSWBkCrugg3gaZeOmUgi2PgXvwxrN/+Ko9yWIrWohNSfs8iA5j
         B5sHxL1SXAINPJLj1Pua+EkqsC3mRAFK3YHf9UZrIzOV/PgNaeEyR5McWY/SGNdso9hl
         T4GXKSLeyj1FUoW8xRB17nvvrmnhZ9Vyul7KKTCvkgCWx1daMUdCITXgGoUbvyRFal14
         K0JldIu5M4lC+V635HCUT20Lgz+D5V/4tWYybHalmeoPzIJy2wgrsx+Ap5r0sxA9SfDz
         E0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739790425; x=1740395225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKfNUEOjLl/LJnQn1CB92jCGeCH7231aksnRXVNSbLI=;
        b=EMBS3w7A+HKbX/1qYZMEtP4/AZaLwzyXYduS6Upp2CzpCJAcqmzh4Uacrcs3EXjHFI
         yDg4PJvGs/zHsgH64CLZfbtM3PoNIz3ADSdrP4g1qzsaEJ7L1YaXJJ6hG+Xu78YCoEge
         rbBB69eiWXYphtXBH88i1mdBXsq6olKJGHUNIRslGNbkK8s7hDeRJnUC8Pw2qLVePtw5
         JYhVG0buytEmtAdJKPO6OShN/U57uwByA2hZ+6KlW4X8eLqYCMgMS2/3b9IyMBQi4WYR
         Ft1eoM4pKFJX7hZeNfaL50Ui9rgnr3PU+fSUYOxhnEDlkXmWuTf3dQKJ/K71843xXADu
         dCiA==
X-Forwarded-Encrypted: i=1; AJvYcCVXyxDRIhEFDY4nTX+g4uCRB61OIzPTfD/yNWMybT6x/VxRSKSQuA+f1uDg3NIKnxHA1m4HxioBC88=@vger.kernel.org, AJvYcCVanH0vFySyBU6Y39zuJTHQfziHPtwSY482EVudWz2ofV7SGIsK1xVVB3/vZPwk3jkwJOaL8Zu+u3Qmu8NfhohhOedU@vger.kernel.org, AJvYcCWl7xp1q6NTeHRI7vyiZWoyLMtxCfa4hcruYHLxzPucjPSZ54dhcki4WXkrpxyumHjTc97yn23dXdvpSOVD@vger.kernel.org
X-Gm-Message-State: AOJu0YwDl2YuvZ/1VZOaF93dbyjO1f8XXDN4RUGITXX07aIGmxT+WgxK
	W9V8yORamX3n3Dyw2jUdsVhSjF+ByAz+rC6VS6R0iau+PrGeE3Oh
X-Gm-Gg: ASbGncsHpJVXXqtzNxZ2fm0f3MG3uKhDtLkrb/Jr0ahkOfDJL79jnOhyybTZIAIt0jT
	kDVZu8S9vMkSTe4Um9o2bUFhaTvsYE3SkgQAiBQGUQZ3bRiZNkZPwWTA6bgoBya2kPVvXmoOemM
	2ps2wDWshNLGKJ49CDPRGzJnEPJBmJxrphkmKbSkmwqLC9DUz0e0ez4Ak3cdKXRR2dzVahAPZ1n
	MF94KtVSRaoK7069awSZ7bfLxnLikeTf/o+OZlSQFIXYBA+803worF39nz9EiAXSBTBkNbYdznC
	tfqGkdFTzQmVqZG/1dRZ8DT/sJS9ksHVuqvIalMuXzaP2QJ5
X-Google-Smtp-Source: AGHT+IG7B4sPeRxfvU839YopNnkapoIY0Cc35bbDmNDyP3vYMcMAmVTKblMiHxI+hpJeWLYL+RCgRw==
X-Received: by 2002:a17:90b:510c:b0:2ee:53b3:3f1c with SMTP id 98e67ed59e1d1-2fc40d14c1emr14088366a91.5.1739790425312;
        Mon, 17 Feb 2025 03:07:05 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:40c0:1035:b6f:a7b9:b8b1:950d:8c7b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fc13ab1ff2sm7840844a91.8.2025.02.17.03.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 03:07:04 -0800 (PST)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: skhan@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>
Subject: [PATCH v3] docs: tracing: Refactor index.rst documentation
Date: Mon, 17 Feb 2025 16:36:37 +0530
Message-Id: <20250217110637.6640-1-purvayeshi550@gmail.com>
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

