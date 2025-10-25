Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6730AACE
	for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410004; cv=none; b=YL/2jIvTyWuKfITZ8354xOW1txjG/ZVanPmrHHnpBYBhSnUuTcH1UxSZUIAbte9oYdmu9BI/2p6SWqnvztaI9Ioi68mL/UT6yMFak8un3k4OzVFPsI0NpE3ZWwRO6RBkhaTA+03/Gm/C/PLu2R0MzcHf9o7w5nyXEJqqlDbhXV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410004; c=relaxed/simple;
	bh=XhV4d6vVAyK94tJmHv/pzX7uso4PaLhZOAOHlwMKMkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7xJRRCAFz812ogmrxdAPr8Oyei2fQTkapsf8KYHyZrbZgjv37BOkAd9c5jDD1/8OmTSJYxj+u9gMK4UdbM7qf230lgD4wltkCex52cIcQGo5prBKfew+EYHGKYpSts59yxY7G4EzhZxn9FEDoKMkC22PxxoUCyMtQADVMQMyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THIp+Tct; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THIp+Tct"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4e88ed3a132so38170961cf.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410002; x=1762014802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehiUcUt6iLCen11Ncs28J2yHpJNhGkVkWPyWS3jNXxY=;
        b=THIp+TctYck+HX5Byp5ZPzTzj5Sg8X2gcojiJOtbOEIYmT24sPfsm3qZ1pSbF/4fXl
         8sqLi+qUSzaUgf69MUNmLz+mZpp6f253cH2n+x/QF4j2vvyUJ3cY1FBNs8HqeH/ECDUx
         OAV1gxrjRZM9pPU0StleSU/uTsDhAGvHjdYoQHcCjIRJd01DtdKqWXhvYjvlYHPeGlwg
         ObV49OEQh/CLsodFyrJYcYb/U3ckEC/YcEYnnIhIYjEA8Z/xdStHSx/QxRZQdHG/502I
         cQ4/svw9Mto42wUDFJvktG1T7q4aWSYJ5mRTPkf0ragBR9KuwfIkQdaVGDrlN0BZX49r
         k7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410002; x=1762014802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehiUcUt6iLCen11Ncs28J2yHpJNhGkVkWPyWS3jNXxY=;
        b=dTPhwZARBrnN7i3nApFU+nP+94PEnVwaXKGUABMBcZ+Uy/cfWAGrKomR3Qk/bLUSYB
         rjf72m0NklgYEo0BDaztr0ICZprAYljnGnwKPMce2P66wKbYul5jjA/NVzvLxCqdLNDr
         c/+zdmx45aKBIbmlBsQQ6YPRIjL9Vs0rbJNcFv+LhG4gyD1FDIiZ7g2It0FEv8TcjoIW
         5a9dVl7WlY87K9aJQNamPwoiSkPdw1L68tVdu46FUIc+Yg6TJbto829/qEioJytKqbBG
         AnVoWIbXdqGXLdOADqMbaJ35YLT5w1lUKxNrcsB9gJuCQIMEyi5YXswo62GksisFh5bK
         FDtw==
X-Forwarded-Encrypted: i=1; AJvYcCVnUBMtQ5iotViDIHqAbZna2g2oZj8EVgcDQ7uZ9CXtIzBxVLfHVviial0BXYLkVtDXC2NQ8KrZJsD0V8McUz9Zq4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkhVq7caHf+7G2mj23Bm/c3YqFuxoTUg13f6NTzXuKz1cWY766
	PuF8csn+d3JYNyq5i9txN1xo0AxrToWWF9Rt1xxg2U61k76xRI8IeaAT
X-Gm-Gg: ASbGncsOPvaaNCFuIXzp0zD9fY3SwXRpXcQg5LKbgvcYc/93FWrUSb/vzuIdRlXEwp7
	qwxAZyiKVXSVUG9hQDpmYKL6nlEtlhgy773KhW8k1IIdzmuMtcgrqxUIIAp2cI43iVCWF0O9zPY
	7bf5p8zuWjXJjHmvjtC8l+SbSD6LqaApXpa16aPBOXM5+ReqV+5oXOsz2GRHz6U+X6OuljU0osY
	VV1eHQ7oTGHBl7zteuvDeDtOBiUV8lNnBcYLT0OOZk5/+lE4/O/x7H7IJNOkjlcu/Q/Z/nxSuk1
	elxs7TQl0Mn9XKvwfWtnDexF0MjWi9FpuwbBHM8uVSQSBGy1ZYEkcXSmM2hEVQAq3KrWhbrylzG
	GHa7tHPjVIcGQuZiMJQE2C0nVGVAtD7Ic82GtLfnKoam6BZNOMRshua6nSgCr+TWvQLAS6Cy1pv
	oaQBlGYUI=
X-Google-Smtp-Source: AGHT+IHHeWoXJKdNINlOiRKJ3a2nDIiOuVj8p9HhufLAzf+qZUQhC2Mssatfy2OZ9T8hXqauxRLp9w==
X-Received: by 2002:ac8:58c9:0:b0:4ec:ee54:b141 with SMTP id d75a77b69052e-4ecee54b1f4mr8454481cf.26.1761410002057;
        Sat, 25 Oct 2025 09:33:22 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f262716efsm171531585a.59.2025.10.25.09.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:21 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 13/21] trace: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:32:55 -0400
Message-ID: <20251025163305.306787-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
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

