Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678E21CC48;
	Wed,  7 May 2025 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625134; cv=none; b=eLewTMKIf9SvLcxfZF2xLjilvviOmUsQTRuv/UOt+NSi7Q9Hy2VO3KF+q8x86gLkRLCjwga6Fv3y+1Ud10UCwzjYz+zJme55grrRRDEx4Fr3fB3hHOvM5sDfWZ+fpVbmfStPeO8VM5FAlm9xrm23aIkYJ/XckjQIj1+80OYUd08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625134; c=relaxed/simple;
	bh=LfNP7WJnwi+phkB8AdTkI2n6mePHkoApep398h3RGrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DU745Qr8wDB+dA0VCrFVnttOFqleOctSskhloh6RECsCAn4eY4RFjscVntXgt+l8Hm+P39YtL1GmEz2/nlr67v9AxKLLJsmuBhTH3QuYgBHrw/YFy/e5QCpWwXMtvgK/lG+4s7toTIi9lV6ngRhIbfQqQ+f9VrUIg3v0EwUfels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsQwQ9oM; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsQwQ9oM"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54e816aeca6so9076908e87.2;
        Wed, 07 May 2025 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746625130; x=1747229930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OD/yxQNBXIGY/VHqYV6OisAoQh685n5/Owltr5spKgw=;
        b=XsQwQ9oMyu+dE6S3eYEMOiWaUH7Of106bt6dI00jGSbemygX5DcHozSA93/l1qiz15
         swFTF9NfL57wjux45f5Ba3a7FsmlBQjeIUe10wxQGW0pyFZn9vYO/y5xNkBIG5k6TUft
         Lq8wbgqKlkjfyp05Fz8bMG2RJWUIRpq3J0/4t4JWCMppXJK8KEqydM3HViL8HhH7KowC
         t7ETv+g975cWD30CiZGRCHFj6Wn8qIwYADt6h+tXVFnl4k1SBT7XTLwJQVEEvmlORPRW
         9repqNVNTbXulVF8BLPZxHqLw/Gy59HZZI9oY3B9ANlSmQ1Ib0ljagcNX6krsRu+SdT2
         LStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746625130; x=1747229930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OD/yxQNBXIGY/VHqYV6OisAoQh685n5/Owltr5spKgw=;
        b=TX7dtKHMzJY4uiCkdwXT8GOywQ7/vyg97vKZH0c+4Ol/33Q8gZQZFyRvTEqHBgHvLu
         TbFAymV2fHTYgg6LNsuj1LKPFecZiZIzzSe8ZlWzP+5Z8IuXRH758CxSW2o4SdmkF7mo
         jozCaOS9ee/40TBCU50SQlq5z6Da+/LPNUJrQwEQRHWhzwPWBkN9pUqGOJxMwWEru3+t
         NgC8nA9qDHQwg8li9t1b3uFUbPbBgvNeJVfSSFjOE/zz0xf+MscC6u6Rq1kgTPSx8rlp
         qzPtyg8Rt+u0KXy5jeX/N1v6Z5Le4dv9bNszTfsbuWf6TgzgIjkxwBUydnf/kSZNtqSu
         i4Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWC+w4Aoyh+UjJHUSQp4uc5uZ4M32xbNssnEWKgrGEkwGShkaIGjHLFTIECE9QG9xDKwbBSOzO0OL3aWkk=@vger.kernel.org, AJvYcCWJF9gpYQLPxQ1su5J5qcU+RWuYOxEVXXeM1ccLdFIvVy4D6DInehVSh6+Cpa1JwrARL0FVffY9+7rcEErbVOB+rxOs@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWlyKWIvVxGybKf2oYfOd782Hu29lOgP8Jay3IBDdE4F5NCWb
	E0aS0fhjKPMn+kjH+DIEbanfa2bo50pA7rRIYa8gN7VEm8BIwnqJ
X-Gm-Gg: ASbGncvQYBc1LCElSNInd0kX5sJSNfBswX9B3qhr+Is9tRZFEOWKW40vEYm62xd4iPD
	P0pHCYUPP5nlxkBgKZe+zWD+LYTBENh1Ocv4fP7H5jyab6o0SYNXeqkxDkzKuZ0mC1bXz08ciHw
	O38eOqFruOYxxh5M26osfq0a5DCvUwlI8VTC5cFxT1xiZllY8ouRbgRS2asV2NHmLQGYjETZavT
	e6LEMzVnkCZcBrP3IH91HhZa3GkVUg8eEfA0vY7SrJ8G68EXxssAtP0q9cJXA3PDBCT6ramwQMH
	KndlDr/d/7t1xtWjxyHzzYQyFHet2xi74rHHBsI=
X-Google-Smtp-Source: AGHT+IE7OuUNY21KuuPCZDuP+BcZV7oI8FYP8VyCZ4PN2pl4RI2QdeBd+BN8VNJT1RoUI1Io7w0QGw==
X-Received: by 2002:ac2:5693:0:b0:54a:cc07:4091 with SMTP id 2adb3069b0e04-54fb928f00emr1141623e87.2.1746625130185;
        Wed, 07 May 2025 06:38:50 -0700 (PDT)
Received: from fedora.. ([37.131.106.85])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94bf0cesm2348836e87.57.2025.05.07.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:38:49 -0700 (PDT)
From: Devaansh Kumar <devaanshk840@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RESEND PATCH v5] tracing: Replace deprecated strncpy() with strscpy() for stack_trace_filter_buf
Date: Wed,  7 May 2025 19:08:36 +0530
Message-ID: <20250507133837.19640-1-devaanshk840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strncpy() is deprecated for NUL-terminated destination buffers and must
be replaced by strscpy().

See issue: https://github.com/KSPP/linux/issues/90

Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
---

Changes since v4:
- Removed unnecessary sizeof(stack_trace_filter_buf) in strscpy

Changes since v3:
- Refactored code to compare length with str_has_prefix in a single line

Changes since v2;
- Removed unnecessary string.h header file inclusion

Changes since v1:
- Moved from memcpy() to strscpy()


 kernel/trace/trace_stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 14c6f272c4d8..4c349db381cb 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -542,7 +542,7 @@ static __init int enable_stacktrace(char *str)
 	int len;
 
 	if ((len = str_has_prefix(str, "_filter=")))
-		strncpy(stack_trace_filter_buf, str + len, COMMAND_LINE_SIZE);
+		strscpy(stack_trace_filter_buf, str + len);
 
 	stack_tracer_enabled = 1;
 	return 1;
-- 
2.49.0

