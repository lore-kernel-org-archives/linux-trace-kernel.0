Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0733E1A9F91
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768184169; cv=none; b=GD8YGTEO3QvxnPyEnErd5o7VTqtvfCl2c3GpfIebokXr2BU73ZrJqEE5pRBZ3CjEPI9IvVFZklhuU0sO7Et9l6qglHp3fegtkQKgn3BW3rya5Lm587wogDvv4aD8QI9a+8jgm/Zy6iQP1SqDWe2h+N0EaN5KMGlFGfCquASUhjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768184169; c=relaxed/simple;
	bh=B5FfKozUW0NcIj5zt5YFL5fVXpavwUO2OUM+5DwC5mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vCLpCj2ox6/5Omj+X/AcL9/lKs00PA159tvIAq/H0twh82cGH7UsOIOpezBxaaAwSSC7fm23aYn9uQPeFzHcwTv3FjZhEWbwZyhjGk4StozMQElAbSpWnnimY3n3YLzeu6RkP6hI/hFq7kvpDfalhYPfCQVwmhM/ClMYu37ydSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPkTkZJ3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPkTkZJ3"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a1388cdac3so42330095ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Jan 2026 18:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768184167; x=1768788967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0uAkNpDPiVFicZcGdNzE7rrmCZO2YKCotnRT3KoGY8=;
        b=kPkTkZJ3XvdSg4b8EBu2dZIu1SimS/8UqEBhdu33rIGtZX2uDUeCR6LbWHVmFf2L4N
         rNHGOwLYBam5+ZeGagaR0Ox8suJWyRHIOQwvH3KwbrA4LS7JNdEI326AGqHHhNnqkvwQ
         SKe3ZCXVUVvxGwfP7cjpg44XrJoLfnbKg4453Ryd9wlhPOZdC9CytF2VGiGAWCsIKeRw
         tjfCr/MBIJOwZRSfWLnf+WBWXtU2JJlp5oOUG0gBNcaw1QAzwSvdoqZnoRWv4Fs3ZXuA
         QuTaGDIhnXq4wNfsOBFdD7eCmujVQc1j7U24L1ZhEgHnhLImA+tG902XBVA1b9mNuZFT
         qaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768184167; x=1768788967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0uAkNpDPiVFicZcGdNzE7rrmCZO2YKCotnRT3KoGY8=;
        b=GUrFTF1YyffGm2E0wyn5xXyabp4Ymk2zcm6aceykB84YkwTy8PnatPSbh6UhIRVgmv
         GxT8NwElSBn+55n43A2YIIEoFsqhZdAWQrWDRx4pf+Ln+mSW2wZinxAgf+hMd0JnKcWN
         PEFHVX8EdQ25TP6LgRhcKEb8TEnsHzzOzFDQGYAft+SgaMnfIaQjxyUTVXRn/YnyB+J0
         gZqcDQQF0BbzL/Vdmi0h1PJ8CLSFCa2prGrrAXdLNAptZcQvC7WIjb2MQNP6RJZyfdVp
         rswzo28VC8OqCVxXk+cYA7WeYt6xmXQGu/H/4UA4WGyIdAUjm7Ok/ZR+oTbHQimq3S+s
         z9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU9+Tylqb+64bhfUWgGc3DGOYm/MgVOsuCkv4W69mn3fEjc11T5RU3LWP2/Vr0lSBH1laI5yi12Ihn2jjPluNUCKNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGH3IDc1WlZxBEl5xr+E7Q2UMbCLejFG30H+Kr6s8hjBH9K0YD
	UActeiO/MFyoqXU09kH15lK01POITKpXDBvjxV8c451pNQDvD08/+6qt
X-Gm-Gg: AY/fxX4WN4y4WxMKwuu7yAB6ziUkTXw0TRg1ANmsnUeeURdtctAYCEuUzkRVukODq4c
	VUBbEd3kZXA/wiJwoPrjsP6jVB6K7VW9H9s52WqlvDBffT95EVR4iUfTlqtiX6VtGcP8A4HPsAI
	TfgyM/IweP31dXJ9yPI2nPvOgOS0A42S1e5cJCyzK5UgX6s31UJNLh9IpHTu4R+XMSqcIDVS11U
	++K9ZtIVsgZnoJ95e4AVMIK14PnUhMS9tp05dujUHHrU8vZQjx3bc0GU4u7OHFQsk2BrfOmUipG
	EvShQmX1cwrQ9Eis05nxRf9UbFufUvWPleXvOY/7DqIOQQZo3Ao6CaFTQ7eWo5rCfjQd19Oai3x
	a9wrZ3c3ecrPnjEoi2plgIuq6NYrEiP0iaQxjwKbOYJfv0tTNGZ9k8v5v0+E9aXSHBNYF73EreX
	RV1fa730I497L05AZ79nwNNNB9iAA=
X-Google-Smtp-Source: AGHT+IEwEYcAJq1cetdUP3i6jeooEmEtD3UhltjnVGz/MnuEVRILp5YdBihUyYh2+SQByOom0O2QxQ==
X-Received: by 2002:a17:903:2f4e:b0:2a1:deb:c460 with SMTP id d9443c01a7336-2a3ee48ab74mr179903165ad.33.1768184167282;
        Sun, 11 Jan 2026 18:16:07 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c5ce06sm156208185ad.44.2026.01.11.18.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 18:16:06 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH v2] function_graph: Fix args pointer mismatch in print_graph_retval()
Date: Mon, 12 Jan 2026 10:16:01 +0800
Message-Id: <20260112021601.1300479-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

When funcgraph-args and funcgraph-retaddr are both enabled, many kernel
functions display invalid parameters in trace logs[1].

The issue occurs because print_graph_retval() passes a mismatched args
pointer to print_function_args(). Fix this by retrieving the correct
args pointer using the FGRAPH_ENTRY_ARGS() macro.

[1] https://gitee.com/pengdonglin137/funcgraph_visualization/raw/master/samples/error_args.png
Fixes: f83ac7544fbf ("function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously")
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 kernel/trace/trace_functions_graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index b1e9c9913309..1de6f1573621 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -901,7 +901,7 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 		trace_seq_printf(s, "%ps", func);
 
 		if (args_size >= FTRACE_REGS_MAX_ARGS * sizeof(long)) {
-			print_function_args(s, entry->args, (unsigned long)func);
+			print_function_args(s, FGRAPH_ENTRY_ARGS(entry), (unsigned long)func);
 			trace_seq_putc(s, ';');
 		} else
 			trace_seq_puts(s, "();");
-- 
2.34.1

