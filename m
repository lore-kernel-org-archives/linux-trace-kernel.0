Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8B23C8719
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327944; cv=none; b=VtJjbOUDBTwd3pJJQYSkHKPm0frc5ZaeUOcbM3wYSk58QKb8rvAXP+lkSqljBmj0cUhJvQ4OCKkE3UqVXYlbNzqL/hvqim3n3xkNgJ+3HVPQ4hfP7KvzuiW5GMxSPD2FyCxu5ArSIXdV8Y6m9koaqTPQTmgX6N72Gdh49mq1dZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327944; c=relaxed/simple;
	bh=eh50Hy8M+m9+5Jqswyj21q+5Jzog77dKdB0pPNWXKPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbfjf9fw5rtP4IgMGPyNaOdf4ojLuR5KMDvPTML+ppJtieC5+jDtjwFR3YUZuoBiNE62oG/Lq31VA7eCqu4Z8HgRo9YQ7+RtATMtGZQrfMTep5ZAMpoKZAhSISxhzIBCIu01KdIRQVhXasQ6vS8EezI9PN3mDxHYJY+XcLj8Cb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=U+XxDu3c; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="U+XxDu3c"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7412cfb9eso1077182a34.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327942; x=1773932742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlI+FZk7B/0fQd8imwIG2KMJsSApC3YjCod1ZriPdzE=;
        b=U+XxDu3cvyGfrRxFJUdjYMWyhbuFzENXF75qbCYug0NSEp4aMj949kW1vt2NoFmFY4
         SKrq55BXv+IPS/xj9MQwMB01efUh1kWxT3ZyIw19NkFq8A+TgBbrWybEPTA/Kc0/+U6Q
         GLMfDy91CgDmuKgThkoC+bsdLCnIq7uaUiAcMQnEXfxWY7hobEWN7TNcaiTXsNRL92sX
         OXbwnOet549YoY/fkG9dLKl5CAzhJkz9CDuTcsDbbfYNGMdhUm7jcT6XelQionM/A0CD
         GUbKMfRpMbpdATFZVPwm5QfLo2KP89jeVsqW+gVJA6Iyi6T7rLYJWj1e1v4qIhxU5DOi
         m+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327942; x=1773932742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KlI+FZk7B/0fQd8imwIG2KMJsSApC3YjCod1ZriPdzE=;
        b=KnaACVNiSn4UXpOWdT6fxoCpag+5ziU/yNDgbCHmtQbvIiefApO2Ueosg4Z/TAkHaw
         PSFDRtN/O8weIsC0KxtCEhzmC25xoZJZKt3P/GMlMzlque1kBGE6zUpPsnPNCHnHfqqL
         lx/8DgOT94wmG63PQsWdn5XSKp1CdwC2zQ3sx9DMUBEQJKKQCfRQ2Q1VNzVH+EMagers
         IXB0VEJEZ7nTBrTmXkrmp/hO9G9I9CBl5yd7162YU9eGdkrZ0z/BTcd1lx9abu2/00m4
         dFHvxLl+Hyn3Idlak9UJs96MHtnd9Svhbh6DPLEe9jjZ+5ib0VD+K/zCG8EkCscaU+OY
         irrw==
X-Forwarded-Encrypted: i=1; AJvYcCWBYSCVFG29fjN8Xh62ZgwcEVSHXsY7d+lbkHe6F2VDlm24UUdi61GDomsBbEjze0xL7FEu0+aYtE86NqkqCI1Afuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMH4QPBDQdohlmNxybo+BZVBua74v3Y3tJemkwjjtkIWluLSMN
	77zhTwOTNEkTraEQ/0XgGcZKZLJpo4wgowNHVdyCL5NcWAUlkUBT7UmfxXlYllk+Tdg=
X-Gm-Gg: ATEYQzxyTWKZpEdA+KAdEnMeep/7/d28noHdU1cEjyIj31dD2vxs4zMvM7FbviQMHY0
	SkB2WeMsogrm2210azTTypnpjbxN6Sbj6PBs0fr9xq+qU3S5antW00ZXylgOG1yEL1/GvKW0vDb
	8u5h1vYtFErW1B+DLOA1PgGSfpSt04GGhYhKKqH7wmTwoyVp9CsPOgVzRnlbUEQC9XFG8RA7vmG
	TmJIQdzIkDxzc2of9EEQ0SKTMGLY3HX+RnZicFOPor0WoO1djRt/pTSMwpqFWFR9X5r+hwcB3hJ
	/yaTuL0k2HdKYkUj7yAP4TsJIe8J6Pe2l2+YsS6w8tWrOuLaf6LviDuEvBsEZOKyUjamd66nqpb
	JACTLBOES3XTra1+D2A1CNoEGf/KEZLWPs9iFOuMt+8cSIxEmvJmZvELcYbxNmC1Y1z3cBhSzqW
	oofwh9EDM1JcmnP8ntr1vzb7Htrf5sqwFY1PGQ+j9MDgtE20zoBApWbzKkZUjLt7Ttcg==
X-Received: by 2002:a05:6830:4392:b0:7d7:619c:a655 with SMTP id 46e09a7af769-7d76a84419bmr4749580a34.22.1773327942528;
        Thu, 12 Mar 2026 08:05:42 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:42 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 03/15] io_uring: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:04:58 -0400
Message-ID: <20260312150523.2054552-4-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 io_uring/io_uring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 0fa844faf2871..68b7656e1547a 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -299,7 +299,7 @@ static __always_inline bool io_fill_cqe_req(struct io_ring_ctx *ctx,
 	}
 
 	if (trace_io_uring_complete_enabled())
-		trace_io_uring_complete(req->ctx, req, cqe);
+		trace_invoke_io_uring_complete(req->ctx, req, cqe);
 	return true;
 }
 
-- 
2.53.0

