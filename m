Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A71C1F0D;
	Wed, 16 Apr 2025 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744771273; cv=none; b=Tgs+f7zLdTrmSuDKu8ueEv/d4b6RBGaRW81srqSZdCH63WB0cQDO3klOoA/yXWDBSdxZmWN6AQXp4OziXu6x76OBuS3QI+E8SavJbnvuB8wHy9CYMkKhtw/BymfnMRJzi8tLmJTuWiGzGML4uqu8wS0g+Y1gQKuhWG9fwr9BapM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744771273; c=relaxed/simple;
	bh=Xc8xw3hxV3CDZ5ujZguWo4EmICMiDPARXFyRwwCsA08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUnBxvbd+1BmKHz0gknT0ojqt4ZGAP8e56Mmw4dld0AXRtffPsec6hZoEWAQwc5NZC0AUUZqKOD0jBhCZN6BBqKTq5C0DH4ntSI3SBef7bq9nimF52E5Wz/1Tv4uCRje6pZMbRUUPvHBszuNg5nX29qy+GhLR5VTa8ELyeuLihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQmqAkuN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQmqAkuN"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225477548e1so60955235ad.0;
        Tue, 15 Apr 2025 19:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744771271; x=1745376071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXkqo6TKSX6t7ZAXZKIH5ShAea/hHXshLCL5Qq7EMDA=;
        b=AQmqAkuN7DRmfKxEOvVFir5NFG4iU9SMrDn3wTMpkCytSVaQ1kVlBHDtwd0bfmn9D7
         rNkXuYM9A39qriuFLzoT09lJ/NzrejOEJ6RVOKths0vILejIVwUuj0yU4wuXVmuofZ8F
         75XwTSoJwxbOfLTV+2YRoLVhIn2aCHUWKPjzwgG5AL61ZpzWTz+Yuan77Ru3p0a5CcOe
         7RAltdbTWsgGwO29xou6CNBJE7BrxOWTnTJKKomozjJ66AQGElj6/vNw3fmakY22shwF
         4IJPHVdcapIV2MomaBzzd+eBcWzbsJpIfi3c4rHgD5za0U3xgEF4NGJGezXV8SDM4rej
         FBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744771271; x=1745376071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXkqo6TKSX6t7ZAXZKIH5ShAea/hHXshLCL5Qq7EMDA=;
        b=MkxtlgAJaUiJufTmvoQKWGSm6k3t8kB/LRitdKgcEX8JaAx0zPE6meN+v1Qh1wQY0I
         03oYExLjkfVNrf0rIIxNalKiMXtD73jTnUGSTNdPnkKDQWLQGOPB6NG+zuy5qx+JLXqU
         lOz48aGVlKY7aAh1vZaL/7S9XXRvfu2cYaZ+NxF6NSgpQr5sfJ6AJSRb7L6aaCDWKLWT
         r0ko4wf/O+jCujoMhw1G7emBUuwUPadzIjajxdt0ju+xOeL0unGyq9Hyz56zpa6U52nx
         QtI+fJTwxGcuIHHnREo5V9FOfrTChBwiJZuvohtPVOTYJK1Z6zhw67hVCI2utNbWSJb2
         nq+A==
X-Forwarded-Encrypted: i=1; AJvYcCVDUm4HZHAUpphyJS/sXYC0PSHCZz++sb+BOwkjnMgcwVB7SYNGGK/9LUIcBd6nq4qT3kvgKBY2yLirBQgYi78yqJDD@vger.kernel.org, AJvYcCXLZAw5YSXmGpJ4ZlZSJHZ8n8Os54fB7m9W9K2pDI1ZzMrMl/tF0jqUGyiPul98+rCuXF6FPAK7+lQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLEslAR4sLYw3cfbtrt5Q2EAz0sBQKNv7Wo9nWmARgzsqN6FDj
	OTVrTfzTY8xyksmFejVVSZYBe8MIUL6XYOQJaECQJAFAvuTXIZOv
X-Gm-Gg: ASbGncv8j2DExYkf6LAsqvA1f/pYuwp/20BTk28RglKh6PQSWLJl8vQrBR334mq5oNc
	ID6MLy06iGspitGNAlPcvXW6G25AdCLtFPbAyxiQnhuZnGWm/gHINpxXHBASMEOiVo/lk3pXvj/
	bohDMZyWXp2uzx7IpkhY2nOpqYIoylbPYNEjaMSVcWthjHOjiTU9sbngZBu2byie6HpysKkStfu
	IFGE0CBs/oPaRzJFpVBwoKz98om9lkgzSFH9IPBuXdurhTv1b2KwZxBQ4q3jcWLzD81z6rxmiHf
	pJe7yQZkgoFbfrIHCcFpxRBzYlPspz5n3wAaSGyR3GXLYbJJlUo=
X-Google-Smtp-Source: AGHT+IGhQPQTZvgj5JfOoamRE+JyVGmk6X9+B6/t/4sctUG9QWja+swZGEjVn046cUZhAIitUoUOiQ==
X-Received: by 2002:a17:902:f70d:b0:224:1781:a950 with SMTP id d9443c01a7336-22c358d67abmr2412205ad.14.1744771271029;
        Tue, 15 Apr 2025 19:41:11 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33faacc3sm2719765ad.143.2025.04.15.19.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 19:41:10 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 694AE4209E48; Wed, 16 Apr 2025 09:41:08 +0700 (WIB)
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
Subject: [PATCH v2 2/2] Documentation: trace: Refactor toctree
Date: Wed, 16 Apr 2025 09:40:50 +0700
Message-ID: <20250416024050.19735-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416024050.19735-1-bagasdotme@gmail.com>
References: <20250416024050.19735-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3405; i=bagasdotme@gmail.com; h=from:subject; bh=a0TtvdIBmqsYsTZpArUeSZwUiXWSFs372vAVFVbqzU0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDOn/xX+zNDb9+B2mzWgrs+Xb5VtFTRVdSnMfTdzZyDfRe PmSt7PFO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjAR0VqG/yX7XFatLopZ9DDs WPUF3f9W7TPq1xzds8iuQ0nMmfNO3FuG/xX7Hy2rcRLYfsPwJMOG7CmO4bfZPx0S3Pjd1sJ3zqa AdF4A
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
[Bagas: massage commit message and address reviews]
Co-developed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/index.rst | 96 +++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 16 deletions(-)

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index fecc4adf70a830..cc1dc5a087e8b1 100644
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
-   uprobetracer
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
+   uprobetracer
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
-- 
An old man doll... just what I always wanted! - Clara

