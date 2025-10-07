Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D792EA157
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863367; cv=none; b=CjnoJtxlSMdWka+2w+JmEA7vgae8bcFxsbGi8TrYDplp1HgqhsdKwEOx2SLg4eqXCZidIGvJDCZ68uzCFqO5/nJWg3/pPbnTdImShMXLkSqvGgTC6yGqb/kmp6Rwt4uudE2OitkJ7FfyeIv64nk2SmSpmFQ05gnCnnLQuryua1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863367; c=relaxed/simple;
	bh=pSc7gPSIF4Ju9Vbb1RvH3FU3+BzuQdiE/nwuOb/8DcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRqq02uwWkGaGDyQsEeyLY4eGFlgErwt7GCsQ7npEivwh18YEkwBMtYctyh6yLTfqNVGhnEQtwgLcqmLT4Ed2eEcJzU1Sqrq8lmDFcgS/IJuH483cE2BeXZJsDJChS20wODxhqElzLtrm0bMkj19X/lNs7VtyOIZekJuqPXoHTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHxmo1xV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHxmo1xV"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-28e7cd34047so55504395ad.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863365; x=1760468165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWXmB+0eRU50OqdMozBO7Gp94A6Xe9er0qbuUMERDjM=;
        b=LHxmo1xVA7D/dIEE5rrb4+dUV+uU2OoocMEPzeNdE/WbjmeOW0KP9POgp+9E/aaHAE
         pnlvzoAYLF6DCNnkiRC5LIpcZzO/axt1ZGKmuCSvPcgnfAsiQPFTKzqfwBiVU1+j4aKf
         voAtXpVaoZFEf6xI9SJvvfTivMERMVn0uNi95IExgttkdGfjs9Mka0dJrkEoIU9yb6tb
         Y2ixev7OKy5yzOF416PK0NAdJ91dsS5nA4WFt57kCmleiQgzKUTV/HBe0gn1eGOtOK3q
         hOsD07mm9MYJ0qmCjMj+NtSKvxaZMHHdRKWwj7Ds63YfrpqW4hWhLizgruEliBj7RvL1
         XlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863365; x=1760468165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWXmB+0eRU50OqdMozBO7Gp94A6Xe9er0qbuUMERDjM=;
        b=Dfj5T89hh+4SVc8gHOq393JwYac3wIRiC9aM4hoZZ/i3dLAlrOrMN8xRFY39kMQhNT
         yEkVbPs7OzzvFfhhRLjdedavqeQntK0YFCC9RCEKPKM+yuDLW24lo828YaJP5swaZ1i6
         38GAhZWN3iJnqU3B20SFqfuYqYGXmDnK11Qc/K5nZbvqTHSbMKUum8G1c64Fwq3iGywL
         2dI3YBS2+qe7K75D5zBagjfuq44Obx2v/c5QnLpO9sFKPjDH0O/CECpL9JfzouA0qAGE
         h4/uwX3QxaMPcmsePt/083pMzR0eKwgXvp4iP2OQnuVPmiZDTe6Bt8qGw8ZruLx8QZBQ
         pkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpkUJhJZii1bwpE9PCB6SiZkXs3ick5IOrw6dlidfxIe8maHZyHYvz8cpMU8T5fIr7w3TozxSXq08Dd9haUaydlxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCU0QZUl1hOqWClFSy36E0YbUxcRkbj9d0o/z1qF8dSPJlMcrc
	dC2CdFZmJR+8BB/mAfGqMGIiPg+FFO0k0iSsWq1GOTTSVXinv7nWWLIY
X-Gm-Gg: ASbGncue33htyr+w7IEUFrsXh+8Qw983cHymEFoHqF5z7D4+uEiuGja77Z7HmsePEA2
	TQIDfrtyrrvbERWfzCsyrUnQ2ECZuD9TYTStSbZKOABPt5y6qUjDnTA9WEuYdMY6UbfJVXv7YTV
	GUnq6pPzrYADFFx/AH+UIfJ2q4mQRyw1VKoociEMYXHSyBapE4Rvy5OpUx8ckwo/P0YWq7YUYwu
	p7ihm5/vhn+B7nNsHUzQU9eeq0QAZHnnbsUgpvphYPQjabvqQu3+VW0S5pobJsaGie9zfSqq/0c
	1ChmfFF7g2HT0jrjm4taLsQt42E8pJHNSpYD0xyxMz0r8mnbHD1mEo9xRJcLQ9gVjZNpl3TJLcq
	a3ZOb9SIsj0D2H7Sc59FCQ5S9d1yRNt51JfAyOWptSYtVx296XC1K70qrZMasvzeSYA==
X-Google-Smtp-Source: AGHT+IGvYA4pseNCxAD0k16xn0xkIZT6WBhqKdCmXY+O/CgWIym5mkyzdw8u5N3F8B4gY3vtazxjYQ==
X-Received: by 2002:a17:902:d545:b0:28e:cc3a:371b with SMTP id d9443c01a7336-290272f8534mr9092315ad.57.1759863364543;
        Tue, 07 Oct 2025 11:56:04 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:56:04 -0700 (PDT)
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
Subject: [PATCH 6/8] Documentation/rtla: rename common_timerlat_options.rst
Date: Wed,  8 Oct 2025 00:24:55 +0530
Message-ID: <20251007185508.40908-7-krishnagopi487@gmail.com>
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

common_timerlat_options.rst is intended to be included by other rtla
documents and is not meant to be built as a standalone document.

Rename common_timerlat_options.rst to common_timerlat_options.txt to
maintain consistency with other common_*.txt files and prevent Sphinx
from building it as a standalone document. Update all include references
accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 ...{common_timerlat_options.rst => common_timerlat_options.txt} | 0
 Documentation/tools/rtla/rtla-timerlat-hist.rst                 | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst                  | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/tools/rtla/{common_timerlat_options.rst => common_timerlat_options.txt} (100%)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.txt
similarity index 100%
rename from Documentation/tools/rtla/common_timerlat_options.rst
rename to Documentation/tools/rtla/common_timerlat_options.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index 61b5b55be96e..f56fe546411b 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -25,7 +25,7 @@ occurrence. This tool uses the periodic information, and the
 OPTIONS
 =======
 
-.. include:: common_timerlat_options.rst
+.. include:: common_timerlat_options.txt
 
 .. include:: common_hist_options.txt
 
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 6f09f30c74f0..32d33c792dcb 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -26,7 +26,7 @@ seem with the option **-T**.
 OPTIONS
 =======
 
-.. include:: common_timerlat_options.rst
+.. include:: common_timerlat_options.txt
 
 .. include:: common_top_options.rst
 
-- 
2.43.0

