Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EFF31A7F6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764147178; cv=none; b=SzVEeS+I9Qk8bEq9q4yLvEMSgOs1kVuR3D7/vAWwkx7dZHLFgw4WUhurT37yhGzNV9Vn+L2bzaVzzBXyhHK5F0YwM+XKcyBX8lzg1KtwJLMd2Ii/rXY6UhVlmFxOZM+qq0UN3jNwuHEEnbRs8oEWZr8l6jt3RosVXA+OfGcU7Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764147178; c=relaxed/simple;
	bh=J4BoZTcMCIwSrHMIm1Wg115n46MGz6eizwWMi1v8YGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rgz3SIRujqoO6oO/1I62pz0vbtyVUhK95Vj52ETw0y6Ir4iw1vOWvFzzNdYlRlUBefnbAY7D/jauenz1DKgzezDZBHfCmRuT4FW6NeKtH3DjzLy2VzSLoYtFhnPSALc/6fSRIw343Ha8YiArPU4m14+BJ39pDhZrFS5jBIfBR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5/NUMYY; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5/NUMYY"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-29812589890so75893035ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 00:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764147176; x=1764751976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jgf6QzPNkLnaNG6eo7VvZMmMgNGAzeOfWslTIH6cEEA=;
        b=O5/NUMYYTPeuduAqlaPClPrzDrbfkLKttv/VLV6vTviO5yr7ianENsD/ikOOvxJAj/
         iLlisLfZa5FFqOD0GTgKj2SIIClcdIGJGuBAig/WAqm2139NdTX+mvotQ+Psb6cGQco4
         JzOOlmYI5Z+ZMw+aksufSjk+BCrDUY80c0pi7ryCWYxHNi9eqp63Nu0SWgEESR0vo9yw
         1LO8t/x6bofMI/eokskywivT1ySYSY/9tH4au3xfjCGfOpjiQRnad88MjYFTJrQzTmQm
         d22GkJCYbEzdOs1/hKneuzpx/bZhzRouvTtd2BQSVy2DFebLbgQm1FkEBgKuLqhK9X6P
         KGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764147176; x=1764751976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jgf6QzPNkLnaNG6eo7VvZMmMgNGAzeOfWslTIH6cEEA=;
        b=jWD7mG8ZeeHGs1Qpi/VtKY2Q8V0PMxxOL1Cb2DHn8aGX2WTGfFC10tP142sbIJRF7y
         PZ4sNfAme3ejf3SrAy1cjlsNWZZ9DsOvys3o7RZhC7L2IYc12D+9Erq5VoZW/gQUBnFu
         w0Xyz+n65z495yCxgcJy7mZJZrdNbzZjHwZTXUqojEgOfpJrdxMgQJLNxnGST8Qq0pXK
         /Y8UZi4qSeggogRIA1WEDP3sORVrlqzc2S1+aj64ZTmGYFl+clwgdtMz4Y5a0uqfwGmF
         d4iJsChdeAaPVQxQqTkWGvUafW/Ku99fQBh3QHEAfJM4m2ILmTqCtgSEbpm/mGJZK20A
         dIcw==
X-Forwarded-Encrypted: i=1; AJvYcCXpDCxH6My19883qzuRcNLDwLzLsGITXWGJL46WlJpT+6qLt5Nva6rwq3GabtHH2aowaqEWLUubiGxlcNYO75ipV8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI3CyqHym8HXPWi1nd6jvsCWOSWHPf9eH3yescPRb8JeYujtoi
	zo3WTRf9q9Jw9ptvhNlaou1i5h0t/KCxyezrll2pssIRAYwnTmeJKyGW
X-Gm-Gg: ASbGncvXhXm0avAQrmQJMAmfgXzGQ3ZkGpEXF/qE1Q9IWBfY/2+WCOMxWPYDX9r6nJh
	UKUXmlY0wSmGo98Kezprv19ZltCjuUDOD7DjROYdwJvUfvGde0aeN/F+DG5Jw7Hd3cCNvuHK+3j
	hIzggj7aha0C0VSGL7vqVvCYLUcmDWFfc8i0+XtH/1QVKDpE3v6hhjljJkfHrSEKoxNJZUfBXRE
	vnpCT892QJ8EnAPYtrbY0IKun0PhwLDpztX2j36AJG6jdxwMc13vY953ShnGga+7TPs84ACowz9
	ZbcChAflywgDDYKZc2Y8MrtXi7Wwo2vtzigbJzjP/4TS+mv8n6iTkVY94dY+qgpfnKOGnDzEnm5
	hxtqkvCcmy/g1vFlIBIq601oqjT03oBzPlqPOt3Zx7THKZ4uPHfTNe4nDCSXFuKlrxFYuanHkrA
	0rPNmZINI=
X-Google-Smtp-Source: AGHT+IFOTPUQKLezoW1PtOgUH7V/2VHPRcXFHERr2qyquuXGdL9D0nyn1gqUNf+kzQfWgYx9ll5PSw==
X-Received: by 2002:a17:903:110c:b0:298:ea9:5732 with SMTP id d9443c01a7336-29b6bf64a07mr88019525ad.41.1764147175929;
        Wed, 26 Nov 2025 00:52:55 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274d39sm190678305ad.77.2025.11.26.00.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:52:55 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.or,
	jolsa@kernel.org
Cc: kpsingh@kernel.org,
	mattbobrowski@google.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf: make kprobe_multi_link_prog_run always_inline
Date: Wed, 26 Nov 2025 16:52:46 +0800
Message-ID: <20251126085246.309942-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make kprobe_multi_link_prog_run() always inline to obtain better
performance. Before this patch, the bench performance is:

./bench trig-kprobe-multi
Setting up benchmark 'trig-kprobe-multi'...
Benchmark 'trig-kprobe-multi' started.
Iter   0 ( 95.485us): hits   62.462M/s ( 62.462M/prod), [...]
Iter   1 (-80.054us): hits   62.486M/s ( 62.486M/prod), [...]
Iter   2 ( 13.572us): hits   62.287M/s ( 62.287M/prod), [...]
Iter   3 ( 76.961us): hits   62.293M/s ( 62.293M/prod), [...]
Iter   4 (-77.698us): hits   62.394M/s ( 62.394M/prod), [...]
Iter   5 (-13.399us): hits   62.319M/s ( 62.319M/prod), [...]
Iter   6 ( 77.573us): hits   62.250M/s ( 62.250M/prod), [...]
Summary: hits   62.338 ± 0.083M/s ( 62.338M/prod)

And after this patch, the performance is:

Iter   0 (454.148us): hits   66.900M/s ( 66.900M/prod), [...]
Iter   1 (-435.540us): hits   68.925M/s ( 68.925M/prod), [...]
Iter   2 (  8.223us): hits   68.795M/s ( 68.795M/prod), [...]
Iter   3 (-12.347us): hits   68.880M/s ( 68.880M/prod), [...]
Iter   4 (  2.291us): hits   68.767M/s ( 68.767M/prod), [...]
Iter   5 ( -1.446us): hits   68.756M/s ( 68.756M/prod), [...]
Iter   6 ( 13.882us): hits   68.657M/s ( 68.657M/prod), [...]
Summary: hits   68.792 ± 0.087M/s ( 68.792M/prod)

As we can see, the performance of kprobe-multi increase from 62M/s to
68M/s.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a795f7afbf3d..d57727abaade 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2529,7 +2529,7 @@ static u64 bpf_kprobe_multi_entry_ip(struct bpf_run_ctx *ctx)
 	return run_ctx->entry_ip;
 }
 
-static int
+static __always_inline int
 kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 			   unsigned long entry_ip, struct ftrace_regs *fregs,
 			   bool is_return, void *data)
-- 
2.52.0

