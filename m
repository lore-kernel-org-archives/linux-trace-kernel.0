Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801454EDCA2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680256; cv=none; b=YJLAH5oeCVIQjqpKk2vrd9VP3XMdfvgX9GE/U2+r02I3ElBoY+cVCNvv658zuX6O0Hr05XpH4U3xP5rPSTRTx9dCKvO4boDnWFXzjiGdUoWKGWne5GwDXaZvb4wQpCgOGyFZCLaDV4naxaQOrXvoPC3Gkzv/qQubJVrtn3N81Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680256; c=relaxed/simple;
	bh=JQwsMoeEs+CNvmeMuWW13D3vM2WUci5TzpK0FCUtx8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5gL+vYk+UNSemul57muKRaeSIBmVicEKykgqGJfGP+od05TrPgwz6xGRWL8jtZlyzf/llJZheKxR240KuDOLQ1h5k8TWFzZU4ti9cPrf58KHlcWGJhS1JTfucDnP5MmMCQoMX/ncMAyyFv7QwNaQw6dV2+Uhha3rs1TP9p6VwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHaaweRB; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHaaweRB"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55efe7so9534866b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Sep 2026 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789680252; x=1790285052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y3yXwVGjA/NLuu/ViMF+woKwPwB53HNXmf8EmdCK+hI=;
        b=EHaaweRBE9eOZEozJ02TsHeYR7Jb5omQJ/nQqF6gWLgafq7JlfqgflLDuKocRynEAc
         OKaWkLedUm9gbIZrJ045xhFxeTbVLmg+f+m6hqRh0ovwJTGbNdczj0rVrfHekt/Y3BUN
         RbkXGf+f+G5hr5l4R3fRT3qnomrwcpLly4Ey3oi0Uxh7jupJw7GUBeJXHz3zlRqOv2uO
         49l2oQobtNPVeqQIt4vXulYosXjCHgqLCQ9mBx38nZx9NLyV+qU4sx44kmzjupQTQ66m
         CmkEdR8KZ+4630WtQ7ZBUyYSkr4wqDkOO6DVEe8t0SdvG5yrpNsB5UPyguTXoYqvtGdV
         3AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789680252; x=1790285052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y3yXwVGjA/NLuu/ViMF+woKwPwB53HNXmf8EmdCK+hI=;
        b=kTKDKvi6ZsoIUWuLPVGhU8H1YjH7VBFpTYIkQWDiGP1OrhBDTa2HmRAvwcIDyBf0By
         rDG280g2IlBnaVG3Iqx556hYGFv+pxBFPCdhRTGL2ylNJCmoAZ3dwmLSHrzGRBnrhfOr
         fLFxehXmg+7Rd3vTC0oeAIKYuzMb0GK+NHxTZ9tqInUPH+IdoquO6u8JAIIjGYIV1gX0
         iga+A6WeQqYtrGh0mg459fhw13Fvtcmk2InIfMBKOvLmFEw0GI6ZcwqWzcrJHroPXmDA
         a20SAwtyGB1kaxRM+JzLPVCYilwYaV4ztV+rXVQ+FlNQl3X4n64DNS+gZsICEcOJUqEX
         RqTw==
X-Forwarded-Encrypted: i=1; AKwUvBwhNAQjN221w1XcR7wn8HG8pOm9MXsnDaEgZ4BhWzov/A9V6dV9oI7rXGfy5AOt0CKH36EOCFcaH0VTF0de2U6hCa4=@vger.kernel.org
X-Gm-Message-State: AFuF++km/JVTVdO5QuPIyKZ2z2y7ZF6cdPGhoO1esgu6JfTbzwkxgfyK
	+svSxJ9y1v+WN45jVQDPq0H5/32i/uXnrde+93bwyJiq5bTj4oUG40AI
X-Gm-Gg: AYBFou3f2GXTsa1PP8S3kXW4dqs9nsiKm3351JJDQK54+faDtnbaPvU30l1erP9lthl
	/s2e28zBTLBvunDwBafH9oYyo0TkOQ8yFxFvtPfDQ4I1YVxIXH8dnbt3jHyEtueWHs1F+UUKtLG
	v3BYbE93C8nS+Vl9iiQzQ8KkahnBejJVySCI1NUWji6w7H/cyqW18eVpepPzMSvxwmANi03i/IW
	AtI9gAIsUOZNZ2+rVEte8CgTYwvS9GGi1b3CYlDRK8ACx3KCCGca0AAbLlfzAkANIwXHLaoPOBG
	1fhWZ29iykO8hnInbpGTuBM15jjIhav2kuWjkfYUiOwFL3RCkIC+7gVVXlAkM5ZjRlFPRWGtt9t
	g8Onj9i88WbSBZ+g8AJfSO72uBagKcp4GvWI6DBVRMjI2h1p94q6yzYZ8i7YOyskZ/SLojG+Bbg
	MmGjfiZ3YEFgtY0u4guOYfepQLvaWzx8uw34688DiolQEVvQfoYxoTA35MqQvVvFe829Y3nQYkP
	/X8r2qkuaaRcKN8TMP7c4NXonUgY/zwBN650zoZcWbkWL1mgL9aFjc61pE=
X-Received: by 2002:a17:906:99c9:b0:c29:61b9:7b3b with SMTP id a640c23a62f3a-c2a15829440mr43455866b.49.1789680252094;
        Thu, 17 Sep 2026 14:24:12 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1d2b0899sm4203118a12.31.2026.09.17.14.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 14:24:10 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mhiramat@kernel.org,
	rostedt@goodmis.org
Cc: mathieu.desnoyers@efficios.com,
	martin@kaiser.cx,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v2] fprobe: Terminate the fgraph_data list when the reservation is not filled
Date: Thu, 17 Sep 2026 22:24:07 +0100
Message-ID: <20260917212407.384468-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fprobe_fgraph_entry() reserves shadow stack space for every fprobe with
an exit handler, but only fills it for those whose entry handler returns
0. fgraph_reserve_data() does not clear the area, so fprobe_return()
parses the unused tail as headers left over from an earlier call, and an
exit handler can run twice or despite its entry handler asking to skip
it.

Write a zero word after the last entry to terminate the walk. A zeroed
slot does not decode to a NULL fprobe on the arches that encode the
header into one unsigned long, since arch_decode_fprobe_header_fp() ORs
in FPROBE_HEADER_MSB_PATTERN, so make read_fprobe_header() return NULL
for a zeroed slot.

Fixes: e0a384434ae1 ("tracing: fprobe: do not zero out unused fgraph_data")
Cc: stable@vger.kernel.org
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/fprobe.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 1e9b00997ff2..9f2d98181779 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -171,6 +171,11 @@ static inline bool write_fprobe_header(unsigned long *stack,
 static inline void read_fprobe_header(unsigned long *stack,
 					struct fprobe **fp, unsigned int *size_words)
 {
+	if (!*stack) {
+		*fp = NULL;
+		*size_words = 0;
+		return;
+	}
 	*fp = arch_decode_fprobe_header_fp(*stack);
 	*size_words = arch_decode_fprobe_header_size(*stack);
 }
@@ -203,6 +208,12 @@ static inline void read_fprobe_header(unsigned long *stack,
 {
 	struct __fprobe_header *fph = (struct __fprobe_header *)stack;
 
+	if (!*stack) {
+		*fp = NULL;
+		*size_words = 0;
+		return;
+	}
+
 	*fp = fph->fp;
 	*size_words = fph->size_words;
 }
@@ -635,6 +646,10 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 		}
 	}
 
+	/* Terminate the list, fgraph_reserve_data() does not clear it. */
+	if (used && used < reserved_words)
+		fgraph_data[used] = 0;
+
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
 }
-- 
2.55.0

