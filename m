Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0312EA72C
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863361; cv=none; b=uftrWzFzkQYSzNY2nQZnVbZooX6djEeM7UnDmH1/FCoVY9au4EkBtD1yCZX9R6FQdBs4lNulZ7LzmRcS7zpUK3bPMdkptHThQzr2wiMe2jnB3L2hQl99oklYDZrtWiGKj/lFBCQliPXJL0I++lhMjXHmu7FUh/JCjiPPaQwDKb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863361; c=relaxed/simple;
	bh=7qc17epEtnYxEg2yWgO7/TgP9PveePfwhICF8dRD2Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGFe+9ipX/S8NJT+HPvb9WGkr3CxLNbbdtsjkxxJd6A9wIz89lD6XRWFf7FIpfIaGD18HBmDX+ZLRqlfplpIJqztfJuuPHUR/n2jGRCTzpf6dmwQ3zf1hCsdWGcPYzMCwgzWqHysCwWGci9Tq3k9QXV2Gtc1UMi7wBMA8KyfXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ/uvhZV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ/uvhZV"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b632a6b9effso268472a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759863359; x=1760468159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Th+qgyzrC6DFJ5YiHB/fxAmD0CanOMB/q/4DLPRUk/0=;
        b=mQ/uvhZV+AdtR+oQV+jbVkQ+WsfV6+zC0sQWLBFaimZAgMYfmD9H++mliz7BUqf8w0
         vKTepmfgRjqbbmvbiouA61QdqVwPkESWzhTCLZw/iUWju0AR7Jbj/nBcRLdUHlWolVD5
         OlYVCH/jhykaCz2ymcZhcZ0Cgo/qedlpOay+YzjbuNksZEt6RK3SOjiLA1HNqSyTqTE2
         S5XxdAVlS0fvdLllDU/xAKwwSPchwBwGfQoWjMt5B6nqqpd9Eb3v4sJK2xvIvUDd5OvW
         9CnPgf25BegxrslYLLzMruaLWU+bPmKXZuugIwTN7k4m2yazXXWLWV5p7Onr/RkhEV5J
         bH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863359; x=1760468159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Th+qgyzrC6DFJ5YiHB/fxAmD0CanOMB/q/4DLPRUk/0=;
        b=OojUn2XXr1y4kCBrKN2h2nUHNRA6J2SLdKiI8Fm9VsD0k0X6dB95cpTdYw9ObJIo+0
         SsrNZCLKvrcyc12BTY/7rIr/ouxeKlIUh6lunX6IQtbHNHlIcOcHOXRQ3eRYe+WyITCW
         l8nvS6CWtUwUxZcIEXz5tW8oFGZ1lncU4ynX1LTtjKjmxk21MSFVAv4y+HoIiaxQTzC6
         mSy7vOnDUrPVLb8gafEGjW6drGPmmBddTUFxvpa+s6OG3/5ebeOKAII6x/UxUEasc8w4
         ZV4MZnzRsJkuHw4cF2KA2dBHvLkISHmPepfeh0dOil5WVHsFElpBK4uJNvrsdcKmOkM2
         042A==
X-Forwarded-Encrypted: i=1; AJvYcCWjpj8TJCnw96PevPApHMDgUJk/2k6ZywHog/NPe2O0YNT09T+nv/Vk9XBqZPZbP52LCbBfa7F91HMk/KXP7oKKP98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/onyYA/ELxgAaLAaZFAm+X4wWM7dBhZZbE4veEkDzTuF1iRti
	3fldc3qYYk2/adYkVWZX2wt3XKDv1ccamnl9j8+tUPCa6/vVbrkGzjCm
X-Gm-Gg: ASbGncvBBCkR6Bujk/f06OJsvtFakc2KsCNyelFyW10XSHqL578riiY4o+nmVPVdyzk
	sM95Zhz0LB+oVflLo11oyMuz5Cot1FTtcKTZMZIE3iBtWyhuGIHLFhC/SQFA9fJp24alz37J+l0
	E3FDDBXo2qWuaIwyoTLUmLgaktZKfpzOuvOBG6R+R8sYlw3GaxGTj9yt9wnSFr8sTuQBBI00Cds
	k4+3vo3beVgwN+jr88jpD5OpqlxMwRKhZSqp2/11zaFzLcaVwpJrFUWYUIxkRjB6aoNPfJfQUv9
	lPkMqsacmRBGK8zRiQNMRm3Qhtt2ZyVeZ4p3lHZMoDrR1q6WKcwKwSyMTLJ0Q55JFF3lSsFCqNY
	z6awweUnHqlXs79qiRhUqmP02SpZyslrh/4oQvq/4szjXFnN9ohTxOoWU5w2rMx1UvQ==
X-Google-Smtp-Source: AGHT+IGVJBbirPc9aOMKvG+rVBGZMOOpzMCZyulcVVdBkwZg3df1u62SnhBExhwRgvHQnIuMqy2w6w==
X-Received: by 2002:a17:903:1aa5:b0:269:96db:94f with SMTP id d9443c01a7336-290273ffec4mr9774255ad.49.1759863358733;
        Tue, 07 Oct 2025 11:55:58 -0700 (PDT)
Received: from kforge.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110cdfsm173529655ad.13.2025.10.07.11.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:55:58 -0700 (PDT)
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
Subject: [PATCH 5/8] Documentation/rtla: rename common_timerlat_description.rst
Date: Wed,  8 Oct 2025 00:24:54 +0530
Message-ID: <20251007185508.40908-6-krishnagopi487@gmail.com>
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

common_timerlat_description.rst is intended to be included by other rtla
documents and is not meant to be built as a standalone document.

Rename common_timerlat_description.rst to
common_timerlat_description.txt to maintain consistency with other
common_*.txt files and prevent Sphinx from building it as a standalone
document. Update all include references accordingly.

Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
 ...timerlat_description.rst => common_timerlat_description.txt} | 0
 Documentation/tools/rtla/rtla-timerlat-hist.rst                 | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst                  | 2 +-
 Documentation/tools/rtla/rtla-timerlat.rst                      | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename Documentation/tools/rtla/{common_timerlat_description.rst => common_timerlat_description.txt} (100%)

diff --git a/Documentation/tools/rtla/common_timerlat_description.rst b/Documentation/tools/rtla/common_timerlat_description.txt
similarity index 100%
rename from Documentation/tools/rtla/common_timerlat_description.rst
rename to Documentation/tools/rtla/common_timerlat_description.txt
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index ae1638bb9a99..61b5b55be96e 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat hist** displays a histogram of each tracer event
 occurrence. This tool uses the periodic information, and the
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 19cb5d203845..6f09f30c74f0 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -16,7 +16,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat top** displays a summary of the periodic output
 from the *timerlat* tracer. It also provides information for each
diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
index e66d2588a416..ce9f57e038c3 100644
--- a/Documentation/tools/rtla/rtla-timerlat.rst
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -14,7 +14,7 @@ SYNOPSIS
 DESCRIPTION
 ===========
 
-.. include:: common_timerlat_description.rst
+.. include:: common_timerlat_description.txt
 
 The **rtla timerlat top** mode displays a summary of the periodic output
 from the *timerlat* tracer. The **rtla timerlat hist** mode displays
-- 
2.43.0

