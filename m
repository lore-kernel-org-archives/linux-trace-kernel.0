Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42404B1468
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978543; cv=none; b=hEmUSE8xhuYm4YJMxAVJacrkI7TRTilTStbzxur80PmXj52++87CacWef718pFOy+pZtsiapYVn3N1oGuXMOFEqoECZkfDWAdoMGEODUO6EQ14IgB90s4SVmqBFT6oDFnNm9U6Gv/Y2BooEaOTq6xwBO2JA/rsQ5m51cStR8wd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978543; c=relaxed/simple;
	bh=B1BhwiUQ+2SbiJJEjS1Q2I5bIuXz3H0WSmOK6XPLouA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpM/1zZFb5L7otizCliNjzdp/uHbGeo8/2Ya6LscGuvXCC9wg/Tsd9p9bIvxmRPa8aQpJsnIKrHZh2sNY+ySQiASwiyhaX7I6nJFS1+bWmH9KFoekeP3NIA2e0YYlc5VsaAk+ntmcMrjdJKdE90t3EKasgRzsA/+XM386eBRVow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkO6vnHL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkO6vnHL"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e831e86ebfso4750075ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791978526; x=1792583326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dGZ7lXpMwGCCG5sKGnDsUSjI7naLKPxMxGZfTR/Ppl0=;
        b=WkO6vnHLG8rh8axtsSiZ6Zpi8d4xPyZwiRb+wvEFD1+Z7+GkDLnDkjHb00XlwnK53K
         00GYkM93cCWcp3BUmU+OaEu3F5ZNeszi36X8r0A2KXYxM6YXYyjgI1CPqX+5/nHtB87A
         e9ejM1IGkSZD1rBPRGEuVi82VsiEBu3qowdMr4Nr+lO6eVwm4MzYn9v0tWpS3lzBl5gD
         o8ihNLi0JdgRwmr63tV99BEM77TF5VwOZF6lx40pYDfanmwkkV6O9yfXGqNN1eAJBZTB
         nMexuEI5zThzMkFm7hsX3h7AOSwJHlvaH76UGgKYw0LKtTD9/qAVRBEYPsE3w4BbLzBx
         cEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791978526; x=1792583326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dGZ7lXpMwGCCG5sKGnDsUSjI7naLKPxMxGZfTR/Ppl0=;
        b=u60nbRQ2oA9V4XCv11KpXdrnAKK8NsiWevSe3F6IwTg7jlnTWt7pgD6F5jQeGzrEJ+
         EjNdv/njnuK1K5PaySvnN6e8JkEYT/Clo6gCQq3pV3ohdVAAe6pWOeL96sGFkpKKxBsp
         XP8Twz2/+trYLaAFUcalBG9zytKiM93p2qiySFO2SmjtgpZv2FMvgcXNnOKfhm7OwyEL
         ZD/xF/b1avYGtVwfo95Eiep6/Cy+kdwkgX0a5olyBViLRuAGA5ksK7cTTSH66BQeDklL
         4We2B9u4Q0OXzwVnP4rTEuFVgUeaGqCblAZCffr7+XWcORawfm0YpOn0NlBsIr9yXreG
         7CFg==
X-Forwarded-Encrypted: i=1; AKwUvBx2qu594r4NnVOhbe10EzYYDvQgxEj8+MCtYXQtui+DydLCwGXa2xGm/jenn66nHsGt+l145nn4zZt/lNJnkzZY6Qo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKY8gGj/UynzgUFIZJyhUatzw4/RvhBFYVZmeNdwAFV8WenGZKP
	CqPrIetgX221TYvhR92+u7Am1LTr8nbBrCdVvtr72eYCYr6sjimA9SCo
X-Gm-Gg: AYBFou2geL4yRF77xAUJrh6+pNaimMpvrkSLJK2EljstyBXkCtkrQf1wqrXV2FIpYIQ
	vQP4BjTaVEqCP+oigmdTk3AHk7SSlJf0pjDScGMZwjer+8daEYCzhc6LnOgWV0yfVMbmJm8/MDv
	ZVo3umNQrttvqUsX7hZAerSW33WADP2A0dpZQms/DeuBu8nhfy+fwOCPaUJQbjZpJ+83HhfIKzY
	ojCOuOU0Yb8QNjktQuxfOJ9Hn+XVtsaAwEW1YSDW9qbo6akcrK9pm2Ij7cfpvSQi3jj7qnhiope
	2zpo3RWsMqBDRXrh5Rclzg35H3YthNCivuFHS9ruCqm+VFDCybqrPH+Lrz/sjmcD13thb7+tNwH
	5era+qWAmYU3lJXSRH79O53RjubrKUtr2ZDcIE1mM5SHpdNTRFUB5sy6l4//JSgjIUf787P2Oe5
	h2M4lcBHyYv5AqgPRmSqq5uP8QWDn6zo6K3MhqOYOr+TyjF/Jwc1E5xOHBz523uDkgftRjEg3T1
	C7pNAYi
X-Received: by 2002:a17:903:46c8:b0:2e5:6158:b9c1 with SMTP id d9443c01a7336-2e842cfcf11mr131739435ad.47.1791978525818;
        Wed, 14 Oct 2026 04:48:45 -0700 (PDT)
Received: from localhost ([182.216.53.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422da9b1sm68643175ad.66.2026.10.14.04.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:48:45 -0700 (PDT)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Avoid unlink error on first run
Date: Wed, 14 Oct 2026 20:48:25 +0900
Message-ID: <20261014114839.6258-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the first run, ftracetest tries to unlink a symlink that does not
exist.
Use rm -f to avoid the "No such file or directory" error.

Fixes: 7dc1e125f07a ("ftrace/selftests: Add softlink to latest log directory")
Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
---
 tools/testing/selftests/ftrace/ftracetest | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 246d7e1d015c..95804610e079 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -243,7 +243,7 @@ else
   mkdir -p $LOG_DIR || errexit "Failed to make a log directory: $LOG_DIR"
   date > $LOG_FILE
   if [ "x-$LINK_PTR" != "x-" ]; then
-    unlink $LINK_PTR
+    rm -f $LINK_PTR
     ln -fs $LOG_DATE $LINK_PTR
   fi
 fi
-- 
2.43.0

