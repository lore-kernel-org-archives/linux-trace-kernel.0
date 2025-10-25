Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1F314D3C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410469; cv=none; b=pcCYlcY0KPmwePQFCrXXoLXJUUTjFVe6Bf2AOUepBjKTfF0/+vbNiKMMObMya6c2TElNltrJWxYMk/6pttYE6QFwlW9mV/mHpTtgcEmiLt24KmCY+so8IQete8t1HVcD9O0P6GF390yIQ2A/TR6+wTY0P+ms1q5GYngRW7BVvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410469; c=relaxed/simple;
	bh=XhV4d6vVAyK94tJmHv/pzX7uso4PaLhZOAOHlwMKMkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TULMSAl2H/lmEHZTexyhsyxxhm0laoNuHKBYOYC4fbKNJe/mQjXzpidk2exbdVnwwHhe7Tu8e8efwh5unubfXENuYhXxXhF72HGYmwI0CI71ErcjZwHsYQsg54dtHhUebhIHBzG18BUTlEKdtA+mVS/kvWiFbPDmpsnxFakI86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aidmQ6Id; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aidmQ6Id"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-81efcad9c90so37003476d6.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410466; x=1762015266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehiUcUt6iLCen11Ncs28J2yHpJNhGkVkWPyWS3jNXxY=;
        b=aidmQ6Id21oJUCYTKFpnRu/3uu5cLBBKQfFHDg6UqHM+oQ3eIbMTasl4LFPnWNWWtb
         TIaRe7dD6hA5zNu1nztSmKMu/rU3YMMGJgv8b5YD98SHeTOelHmCuQKj7A1M8R5kyYiE
         yQXF2slqIhWD44xiLUEv/rQ023S1+ggrFQ54zucCz4vkMkqAl28fRLxX5urqY8m4ZRbw
         6+qMPY1XoSUrKpBx6Cg7GuEdLBYV6/VsSvynH8BJwRWsI0QMeTzsyy0vCBWLNU3Qz2VT
         lleVdUZyqpmqYsxhidB56+k6+/0FiKvBxcTpwzVqgV5pciVQhF2YmSs8MeW/Lrp5Yler
         FwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410466; x=1762015266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehiUcUt6iLCen11Ncs28J2yHpJNhGkVkWPyWS3jNXxY=;
        b=Psc4cC1hKX+4TrMF0HHQxEuUe+ua91s5xFqjBXwRlfSqPKHkVbAmR5ZDCoLP99ydxp
         d0PsDScvquATakaPJga2aUH+16CCdj8CAJcwpjhX/Y2LeGHHZ2rEEA+Sp8tY/DlqO9R+
         iJrMo3x4dFzbUzh+BAtJWgz/dqm7jg+g8+Re/67YnCXoBd6jv94lwyO0cAkOjZjN8I1d
         jb+KcsWyM9xajMUZUyeHqKY8AMF5QfUUkqbar3h1nfDYXW9WM9C32aAo/WuQgcD8d1NG
         U+1vj0RrbdIsYzAjX06NCw9szrQkZ1WrjhUnIMtpd7yfND38IWTKa8RvEi0bbFKZHZIg
         ZrgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeHMHo3rIqivScvF1cgucAnoFmTPdj8TcXBdyD2wLeAkYcsmkcqzmAqWD5a4oll7Kkj2jbLuDL2zDpOlJRg0U/ZaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9yPx+cWLjFXbO4zZ4Gx9cXjdc32i/2CW/m2qCHSHXKuHqQhFe
	gfeph8Weqa5jK95rLWET+hXmgJkAD7Ob8OeANwqa1zikVm4fCtH4KtPH
X-Gm-Gg: ASbGnctr5X0Ztb5rIuwIWhW7fmgOxLowniWUjgCCAqaoGvoASWcjRIPnhdqsfnz6t2S
	NO8hDiNyFaOn0nInlvl6nR8YoSFiUOVFSjh1vv9mYLryC/qpbS95UFcDdVHh2McdflelYoXWSC3
	c+tqlYfywMKsbaL3ATSipsdU4Y7JS4Fm2fRUQUwWSWHKnrtwvhSMHabfqtunqcZ/ZHyPkT3lZdo
	7sWaz6lZz7NHfSmtx5i/jwDOIw7r/+M8Y3YPU4uw+EYWZeEGBdiRF6dmfqzo9qogYHNfmOQPq5e
	9DWPeac/vJn7kbEMzyRJ8L+osG0tbaRY5bLBxHFlKJuXJ1h2RhCYytXna4z32VWHU6UkRvfbVOu
	cKeWfMo+5NxMoLUEmLJiR5V2MqTBlHddnSPSq2AMqZ6ylymVngvJCs1i7craWgt4S72LJ+mN8ed
	Ro+3bnLB4=
X-Google-Smtp-Source: AGHT+IHdUbKQhz7684jsgoRDJdwRjaQ2Xzm+lx6YWL84J4FmuB+pEZxn/rvpLnFKlTlrkm8ZxkpTCg==
X-Received: by 2002:ad4:5ca9:0:b0:87c:11cb:6d0c with SMTP id 6a1803df08f44-87c20573120mr383057026d6.17.1761410466214;
        Sat, 25 Oct 2025 09:41:06 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49a9d92sm16338826d6.51.2025.10.25.09.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:05 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 13/21] trace: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:12 -0400
Message-ID: <20251025164023.308884-14-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. FIRST_BITS() is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/trace/fgraph.c      | 10 +++++-----
 kernel/trace/trace_probe.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 484ad7a18463..4f21bd837055 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -106,10 +106,10 @@
  *     (RESERVED or BITMAP)
  */
 #define FGRAPH_FRAME_OFFSET_BITS	10
-#define FGRAPH_FRAME_OFFSET_MASK	GENMASK(FGRAPH_FRAME_OFFSET_BITS - 1, 0)
+#define FGRAPH_FRAME_OFFSET_MASK	FIRST_BITS(FGRAPH_FRAME_OFFSET_BITS)
 
 #define FGRAPH_TYPE_BITS	2
-#define FGRAPH_TYPE_MASK	GENMASK(FGRAPH_TYPE_BITS - 1, 0)
+#define FGRAPH_TYPE_MASK	FIRST_BITS(FGRAPH_TYPE_BITS)
 #define FGRAPH_TYPE_SHIFT	FGRAPH_FRAME_OFFSET_BITS
 
 enum {
@@ -123,7 +123,7 @@ enum {
  *   FGRAPH_INDEX (12-27) bits holding the gops index wanting return callback called
  */
 #define FGRAPH_INDEX_BITS	16
-#define FGRAPH_INDEX_MASK	GENMASK(FGRAPH_INDEX_BITS - 1, 0)
+#define FGRAPH_INDEX_MASK	FIRST_BITS(FGRAPH_INDEX_BITS)
 #define FGRAPH_INDEX_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_BITS)
 
 /*
@@ -135,12 +135,12 @@ enum {
  *  data_size == 0 means 1 word, and 31 (=2^5 - 1) means 32 words.
  */
 #define FGRAPH_DATA_BITS	5
-#define FGRAPH_DATA_MASK	GENMASK(FGRAPH_DATA_BITS - 1, 0)
+#define FGRAPH_DATA_MASK	FIRST_BITS(FGRAPH_DATA_BITS)
 #define FGRAPH_DATA_SHIFT	(FGRAPH_TYPE_SHIFT + FGRAPH_TYPE_BITS)
 #define FGRAPH_MAX_DATA_SIZE (sizeof(long) * (1 << FGRAPH_DATA_BITS))
 
 #define FGRAPH_DATA_INDEX_BITS	4
-#define FGRAPH_DATA_INDEX_MASK	GENMASK(FGRAPH_DATA_INDEX_BITS - 1, 0)
+#define FGRAPH_DATA_INDEX_MASK	FIRST_BITS(FGRAPH_DATA_INDEX_BITS)
 #define FGRAPH_DATA_INDEX_SHIFT	(FGRAPH_DATA_SHIFT + FGRAPH_DATA_BITS)
 
 #define FGRAPH_MAX_INDEX	\
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 08b5bda24da2..88de129dcde0 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -401,7 +401,7 @@ static inline int traceprobe_get_entry_data_size(struct trace_probe *tp)
 #define TPARG_FL_USER   BIT(4)
 #define TPARG_FL_FPROBE BIT(5)
 #define TPARG_FL_TPOINT BIT(6)
-#define TPARG_FL_LOC_MASK	GENMASK(4, 0)
+#define TPARG_FL_LOC_MASK	FIRST_BITS(5)
 
 static inline bool tparg_is_function_entry(unsigned int flags)
 {
-- 
2.43.0

