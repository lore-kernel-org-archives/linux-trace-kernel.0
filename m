Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED553AC;
	Sat, 19 Apr 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745055192; cv=none; b=iq8fCi8frxHgW99EBghVqKu9/X980igdNNhFalMZtoBfbctfzXNfEwObzMrY3jV6gxik1G02HQddozi4b0NsXG7JNEhi85JLzH3ij/N2ccfImaqDiyMoGvWyQOF2kWrGabK0A9F1+/ljaVeJ/bOKDKxbGpdn7P860DEWCVKh4ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745055192; c=relaxed/simple;
	bh=GJyS5j49HwboXosecKbk01w2vmZBIhpnREZRlsh+SmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RQWquZGWeenoryPaEE0i0yhN3yp6DnOcm76nLyDyM9kfYetOG/K7+0QS9GpDyA3kIPVjOfllrCwfePl+5f0uLh5MIHSf8rXJVUwWLuF1XDa7mLmdextP55GvWy4e6puiTe5IY1ADF1SQqPV9isR/tVSPeAnrMcP0Tm15sC6JJkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCDKMMJB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCDKMMJB"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736a7e126c7so2101702b3a.3;
        Sat, 19 Apr 2025 02:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745055190; x=1745659990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jNBsSgAcJG4HwgrA5SXirxxEQY4MUp9geatSnVOp64U=;
        b=CCDKMMJBvjz2VMa/A6+kNghNY4zZUdZkYXGFXF1xvZA9yR3Z2ybuyeUK9QLVMFR6D9
         3w6+abZSBUWCzSo8pYT+6NcCiyMiv3qExJkdpk+2XLIIohwvk2FrJ1sHOJmUGtYFhxxv
         +CeyQi2lrihMJhud5PCJeSXeRl0AORkbL2JC+effHYbY68A8FE/ioTgAJ+Vs9Vz0TlVx
         kL3K9ngRKrL8YVOIs5hEj0+CDkJP4IxQdJXI0aI+y+wixVwy3Y5LZphagX1+FlPpD0cV
         vDqpMQLyZMwTEZQ0G5iwsloGFQjyezRYvR+KlEgfVr6ZPlcXS3frxh1Q57psJWi2sP6Z
         biNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745055190; x=1745659990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jNBsSgAcJG4HwgrA5SXirxxEQY4MUp9geatSnVOp64U=;
        b=Lxi8WBUo+xHpmY55FsDDs3SaTe8XgZRjbUafAMKBGo4dj9UYfTz6bSNcE//oAj5HS8
         OMR4ZTl88SdWdzJmPP5Bc7s9Bi0gebIkdvGnZkZt8u1U2tfR0f+awBh0GZEvSvm5bOv/
         iy+H9O6V4HQB+IpUDyEF1SGLTwsPU0zb1g/uNyZqgLNVpCDTz2vnfO8dKolGmRHBYWqw
         OqG9oCAOdzBSXrgLdYIXIXr81+U+fV4H+ekHqacktXLaD4hmseHcFH112fL509fgUh9V
         ++DuB7hUsQoEBgXgFbvQ1izvXtsOuvmIcDQS3ejb9SaBR6tmmV5A+aOhEaVqmKynEvW+
         K5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqxIoSMqkz+tZOIHhOJntqnc1xG9UmglyWwh3bxbATAtKcCGdEV1Sfl0pcsGQ36jIur0AmtU37w1cZ7yY=@vger.kernel.org, AJvYcCX7YVbv19Wi0XKUMbI8YmKPcLN6Biwaq7t0Mh+sCM4LViuRbQ5ACiCMjZ0bseJZAtRJKW0ZpVibWO1Or57KWhfQErOK@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhBiil4tCpeVgpkvN+3oO0P99/y1UvpivHp7v6UfUHXk4COvU
	wG72YZbaNjWKt/Xz9FaxcrdpJqBoeutHYU1HcaHlZhb4T+mSMgo+
X-Gm-Gg: ASbGncskUD3SAaLQUTzACl+qI4ughlLkeOc3wSmySFXpp0wH9nU2ENdxcZ/jRDaTY8q
	YnUi1oQEB1sWIVixjAwBpWj0oje5JmiWu+CyDDuDVi/eALG4FQm7Sx2WTJFximVBjOEN+uNt+zU
	vLQioqp/t6slWrQayApyQTsvXBaWSMdNWSeHJ3gVcuL9yuyIE0eIc/lIwN8jQHJW3YHRfk9EhtZ
	BP/NKea0hplnK6kXRMyEFqbo6kR/94dSrttrzk+WRa/zmigo3aHXe3LgA4AAsM6K6ZBGlhj900y
	rv1Vq3JNLN4uSFpbB9nrh1Dv4LE29gCIXP7Zh2t8
X-Google-Smtp-Source: AGHT+IFaHnGJ1Xe8+ZQ76q9t831ngy+tZUUZlxsycSo2CKF753PTc5bk/NuURZDEmhZuDgrZQ/HhWw==
X-Received: by 2002:a05:6a00:2285:b0:736:4d05:2e2e with SMTP id d2e1a72fcca58-73dc149716dmr7054022b3a.6.1745055190509;
        Sat, 19 Apr 2025 02:33:10 -0700 (PDT)
Received: from fedora.nitk.ac.in ([2a09:bac5:3d52:11c3::1c5:d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e46e3sm3056375b3a.59.2025.04.19.02.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 02:33:10 -0700 (PDT)
From: Devaansh Kumar <devaanshk840@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v5] tracing: Replace deprecated strncpy() with strscpy() for stack_trace_filter_buf
Date: Sat, 19 Apr 2025 15:02:59 +0530
Message-ID: <20250419093300.1575072-1-devaanshk840@gmail.com>
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

