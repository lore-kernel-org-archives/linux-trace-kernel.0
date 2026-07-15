Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27296381E9E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126174; cv=none; b=GIzV1xQ1yEwtwT2hHc01geEBFm78veFjdtQuVxdheuo02BF6n1lo4DcZ/t4yqBtZvtLGIf1/wpF8554vvBoC/gpY36FC8/a+1fhatw4aUS6HaXo5SwA5ihZ3GPvVYfwdeup2/hCNVcaGrxsZjUSD6DM5sxChnTwg6MjRcgMYBUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126174; c=relaxed/simple;
	bh=/BW9MGEOCrMpHQvNhautBMTcuKauENdAhZ9CjANN+2M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Kvvfnf9QYC6jr/C60AnFBpTvncALMjyZ8mpZJd2BvTvfAE4Pz8jZN4SoqhbIIGzn4whtEyKFdNT0fkKOownWqUYuQCd75P5DeNEBBSsKWN9fN9bXEp9HPHT0i+K7LqkAm5rpY7gF5Zsktz0yJ99t6M750n6KhzXV/mlgmDURG4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcASMi1T; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcASMi1T"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-381ed661712so5972239a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784126172; x=1784730972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MnEys3wW0UkOJWjz3Ha+uANv3CwPWTTT3M2E+EM5pUI=;
        b=DcASMi1TirMs+RNXzKm8CeLYbee7FdelpejtoVQzwaDmTVL5na5k/NsmGcrTYrArog
         HCsewxESdaZtCqSkSclqA0r5RVI21iBrEA2Ne9/QoQNsFMJfKPpMrY8eHioMLgPGzDG+
         cTXrELr+XcNV5YJbktdHEgVvvTztrZtRAuQzShZmSgR6YWTs1+GLxpB/7v4onTNNLWfY
         gN8tKA/Ht0IvLJrTzaWU6dqROzOclk4q1sy3KAmDqnFMNPPs0Ze+YdRn+1j2xk0zBuqO
         VPXN3gAoPTBFBDolZSmoBcYQk8o7gsCq0saTErBNavT0iN3lr63ckhI1qad3A9tL++Uq
         ZTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126172; x=1784730972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MnEys3wW0UkOJWjz3Ha+uANv3CwPWTTT3M2E+EM5pUI=;
        b=PpzH68vtfDNU4qCZa1ZXd2vEJSBS8Aa1OPU7AkEcWttI+cNZ2bYD4zZflLuBSp1oGl
         n5VHIhG2MtK5CJRMahD+/Dxi9SW4BOP1t9znObtC3L726xCLfcWf5YF3xBVCIgXaIDLj
         RPvuxfZZ8tKlWJCJrOudT+7cJ51Ne1vvBofEYdnHo3/1zYU4WHQBMtJZg0rPRGjrpEbP
         SystNaGXyhCYSBv6UF1QoPgcqDLK1zP64R5aOVDopcmzFHsyqCciVsPRuknZyHtGwP1W
         zls75szuBS8Nkyz35rpVjlebX9gD8BTgTzm8el9uQRy2AALtacoD1OThm3cNeqMvssZZ
         gK7A==
X-Forwarded-Encrypted: i=1; AHgh+Rq3WPaInYgb7vesgQ0SovzXsrIR40PCHJZwKwcMJHwjdTJZy+ZspA0y81qqeFGLeehb1ezYu915avU6ms3D8Hu/F0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPdHygHnCVXAJIA5gmrpvW+2whwoyyGBAvLc2KX7rKPvd/77NY
	ksSLYwmZ8wqpDsuwLDVX4imUCuqdZS2PRn5bkaA6L4CBZuRYsAy+JZmG
X-Gm-Gg: AfdE7cmQnyRNCfCyxK2dS/h7rxKTroNfE0Rth1ApFzbm/rsE9rGQf7ygeOVdsccQrin
	BLV25iiMY9FsXoDg4dTvgFDEEsNBpTd9izmZwvNuGyQiIqWF3SxGoq/kUucQi0HYtrQW4i0X2WI
	IgRMzWMq9E83jvAUe/P60xn3OKYKKUDcX2n64GT6hJrF86q642wiSVeybny/DXuYxaMb/bOHqMp
	JEsvp5Ao5C7nAQ2e8Ew4PrwA/QVVqoSXncpvWGyofmjq+h9Bc2FN8yU6OxgN0miQ/ZydVAoI2kH
	fL+vvREt7RLgeMyuKoN4AydfIVnLoNFJubdFDyXXXpUsOA7ynH//PyUmSdHKq0ymZrgho4kQvCV
	bclbKvBpq2Urhn9RbbC8HEHIlZbJADafPDope76dDpvhDZPKHifL6XaLBKLtzBqodl2OcfKSqPb
	s8kDjOuC9NcEolmUcU6QrJXSQJhLeSRpbxt9QT/5MfZesioNJ5WDM=
X-Received: by 2002:a17:90b:3b8b:b0:380:a568:cc4e with SMTP id 98e67ed59e1d1-38e1add8e69mr6031307a91.9.1784126172417;
        Wed, 15 Jul 2026 07:36:12 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:90:2db1:3066:c473:74d2:497d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6c08eesm2510724eec.21.2026.07.15.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:36:11 -0700 (PDT)
Sender: Deepak Rao Gaikwad <deepaksraog@gmail.com>
From: deepakraog <gaikwad.dcg@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/mmiotrace: fix resource leak on trace_pipe close
Date: Wed, 15 Jul 2026 20:06:04 +0530
Message-ID: <20260715143604.14481-1-gaikwad.dcg@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmio_pipe_open() allocates a header_iter and takes a pci_dev reference
when trace_pipe is opened. mmio_close() frees them, but it was only
wired to the tracer's .close callback.

tracing_release_pipe() invokes .pipe_close, not .close, when the
trace_pipe file is released. As a result, closing trace_pipe with the
mmiotrace tracer active leaked the header_iter allocation and left a
stale pci_dev reference.

Set .pipe_close to mmio_close, matching how function_graph wires both
callbacks to the same handler.

Signed-off-by: deepakraog <gaikwad.dcg@gmail.com>
---
 kernel/trace/trace_mmiotrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 226cf66e0..20812e7f9 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -109,7 +109,6 @@ static void mmio_pipe_open(struct trace_iterator *iter)
 	iter->private = hiter;
 }
 
-/* XXX: This is not called when the pipe is closed! */
 static void mmio_close(struct trace_iterator *iter)
 {
 	struct header_iter *hiter = iter->private;
@@ -279,6 +278,7 @@ static struct tracer mmio_tracer __read_mostly =
 	.start		= mmio_trace_start,
 	.pipe_open	= mmio_pipe_open,
 	.close		= mmio_close,
+	.pipe_close	= mmio_close,
 	.read		= mmio_read,
 	.print_line	= mmio_print_line,
 	.noboot		= true,
-- 
Deepak Rao Gaikwad

