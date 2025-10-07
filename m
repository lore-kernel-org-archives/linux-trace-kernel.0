Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126802EA178
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863378; cv=none; b=XIm7QmAbVfAUtbTcfsgLGNCHV3ySCoY6hLJzideTu5/gFfrOHbqP9y+FV0tNfIndMUOhpdtuG89TGAmAYBIdgUToHphmEkLQldZflBTkZAP4F2i4AzffzBCE5HhmY3RaW/a6+yGCCx0HgFCMuulWE+WFMUz726LKo425m00zwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863378; c=relaxed/simple;
	bh=CloW7FhMBhnWY7ih3iN8vM0ZFn5kYPF7XeKW8uvATJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/NKxLzJmn1V3c0prjZM7HD3H+9tPrOnUO7oah4b1FNEOFEMONOGxN3XV9qjhz5a6gwRKlPpkBSWYFMX9rBQNGlrQPYuaIRyF9nuGbm8dtDqAz5Z6gwsaujaj3bN7EuSLMSgD7mM5XCg7YkTTN0NLWBLRmKswxjX5gc2o/HYJDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4Ky9h9W; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4Ky9h9W"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26c209802c0so65338805ad.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863376; x=1760468176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMcgMtnQhy1DPy++ljFQ5B7lhaXeK21GW1cVMqM8xVY=;
        b=X4Ky9h9WDcNjF8cSIRN6d5b5X66n0vVJCtcNld6TIPkAjY5biZyMs08YBXlgo5b1a1
         /rc+1U85GP8WerYXsurZGjUBPJ1puo6fxY9HwXvroLUk9js2r/vv1UEICZFgLbDrtZbH
         gxeqJ8usCdp/AMuLjdTztUYmQjd2avCOP3HbXAEol6l1WV++JBnulZb+rEHXio4Zoy+q
         me++zmHBNitE7+nAkjEae1gHG7NEbenTHlZlNQX5twO4df2czDOM38bh/FzoT7Enk+9l
         3zJe2XX8g1pb46blmYti3VxLa6X5N9JaX/qvanXUXFwfA7o7A8rFNI4PEuYXPWh4aWkg
         I6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863376; x=1760468176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMcgMtnQhy1DPy++ljFQ5B7lhaXeK21GW1cVMqM8xVY=;
        b=YkB73N58i/aeftdaeHhd7UcOV79mDVtEV8Q+OdxZDNrFeJVQWplDvnYyoqLkFr7xgt
         t8MAUr31lCijzvBABQvrlcfdwk456d28Cm8LOJMxOfvfUs40GxHsDAeWEbUlfWcLtx+4
         pLYN2M4bGruJsXxuNFjzLp1lV+qxHocwz4qJCA+VRl7tCPPZ8rJLaEhySUFDrAIfqtOk
         xXRpN3AR2ywSoGFMFkc3VipWhcFaFiPVKb8AT/ye61wpfc9lN2XRQPakrLKwh9ylpFVx
         tpkda0xKggBOcQw/aoOUUQXaZ9vRePeTw8MNo4TBBpil0IhdyQn907J5CYnxpYTeYS/U
         EpAA==
X-Forwarded-Encrypted: i=1; AJvYcCXfG2V4ug8sxpAXi8zr0Qkao8R7+W3C5BVpJgFqqcbMquUy/Bvd6ClVIFju766RsFG6U+B16ZGuSXLxpDtQxz8keno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFYkGbWggTNW2aQJ+K+6WmmXizv2ka0cGQwTSF1nvbq2PIA8Ur
	BJ3NH0QgfRbOHeBZKUg3j+yeivTIEy19sfqhTH215UFnX94MaO4sH4+C
X-Gm-Gg: ASbGncsjfEsVWKYplIPAPNaBDCeX+AAPbgow/ZA2Uiimxn97E3iR6P+dwWScXqwjiw8
	OQaNytG+8MMXBqiOxOkAStKtXniJSifzaRWIue2AlF4IAzfIu14tmpeOwX66MpaDdkDpXtlMEI2
	YhLyxl8QN3zN5+1SRhGMP8fv5V4YZZx/MTSTFhvTbuBoH3M8SV8sELAJ03McAsBkPm/eOnfpXQN
	PpBdJBcyhFadNK9KPXee1IgA7m+UyzsiP2jw257t4CtJt5Pqpy6EwAn1N7QOK7AIKo/auWAE9LX
	u9vGShhCU3FpJbh3Xv/I2T07ngNNKGwwu3d1Onikxl9CITNCfDNP2mQhWvFiAJQRxJTvXFquHKA
	TnvpfG6roOzn8k3L5OlyAYe92RpuBMv61gXgM2lP/Jo0XU06mjX1F0slZp1SC872B7w==
X-Google-Smtp-Source: AGHT+IFcXfO6RvhF3YXlYYvUUUIceGO4XmoS0wX/IMzMllJDL9x+dTFS2NyLyCwMy0EW7eslfVVevA==
X-Received: by 2002:a17:903:8cc:b0:27d:69cc:990 with SMTP id d9443c01a7336-29027402f43mr9430955ad.49.1759863376259;
        Tue, 07 Oct 2025 11:56:16 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:56:15 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rostedt@goodmis.org,
	corbet@lwn.net
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	crwood@redhat.com,
	tglozar@redhat.com,
	costa.shul@redhat.com,
	jkacur@redhat.com,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 8/8] Documentation/rtla: rename common_osnoise_options.rst
Date: Wed,  8 Oct 2025 00:24:57 +0530
Message-ID: <20251007185508.40908-9-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007185508.40908-1-krishnagopi487@gmail.com>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

common_osnoise_options.rst is intended to be included by other rtla
documents and is not meant to be built as a standalone document.

Rename common_osnoise_options.rst to common_osnoise_options.txt to
maintain consistency with other common_*.txt files and prevent Sphinx
from building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 .../{common_osnoise_options.rst => common_osnoise_options.txt}  | 0
 Documentation/tools/rtla/rtla-hwnoise.rst                       | 2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst                  | 2 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst                   | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/tools/rtla/{common_osnoise_options.rst => common_osnoise_options.txt} (100%)

diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Documentation/tools/rtla/common_osnoise_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_osnoise_options.rst
rename to Documentation/tools/rtla/common_osnoise_options.txt
diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index 60a237de1e2d..26512b15fe7b 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -29,7 +29,7 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
 .. include:: common_top_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index 55616085275e..007521c865d9 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -24,7 +24,7 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
 .. include:: common_hist_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index 8a852949df21..6ccadae38945 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -26,7 +26,7 @@ collection of the tracer output.
 
 OPTIONS
 =======
-.. include:: common_osnoise_options.rst
+.. include:: common_osnoise_options.txt
 
 .. include:: common_top_options.txt
 
-- 
2.43.0

