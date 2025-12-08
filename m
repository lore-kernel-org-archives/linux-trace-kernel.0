Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56AF1F75A6
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Dec 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765199965; cv=none; b=meWbhol911o07IFSZzdgrF//+jZimlKiIfcEYwLpkLYSf0U6j7ShGITtdH0Pw9We6XVJcjUhIpVSNggQC3tN4FYuMQ73RaYp/uErZfJKnY8Ijibrjqa8xzlKtRAnnpC1T7UKWjfXUxvKRIx/W3zgMdlWQvNeO6lq23emLTO0mrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765199965; c=relaxed/simple;
	bh=nV/mnejD1Urwuhxxd0Q6OO4wDo/8s6Y/DdnRVNaa6e4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JkMX+pIdPLGVdC1qcfkFCxEBs+VQttC79j1WPFSKwOf6el30n+/jlME/BfwPHL4lwnUwc6icrNZ9EOEJlwWl5MKOYKkNgsQfkUITMLUyZPpLtxmlNa+DpmUy3U/mq2/6hF1UbwhnhkKsii3ZPDjDorMmT4vbmMkaYvI1CddeUJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGLiPFoz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGLiPFoz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-298456bb53aso59416925ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Dec 2025 05:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765199963; x=1765804763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpqT/PJvioY+NKSh2DmC5qT0+A1ogKkqikHGgDn/B+c=;
        b=LGLiPFoz+wEZQksFp1H27KSM+p4+F0rmM0yWcb9MrPeoHCzSjs7++vYPWhkesehuO/
         0wU8nmIO2xJH5n7LajWshuIXB7lz4u5Iyp+Kq3BH83b9lFJ3C+Qxgu3A2/NLCs6tNXrn
         LvDglP9F37d/uJM4sv1vfga7JjFKdriTKZL5au+7Knc4MAwnDI2L21kvqWXyAMPeXPej
         HFVOUQQidtPbh60c5PM5GL982cVcAcg6jaRb5PQf9yp0AhpAdXMM4C7j/isejLikMmO+
         keH/GoyH0HrVbBfe5FPxYUlTJsrFJSUiIEYL1fvcZ+eyCmNIDXdR4ui9/MEf5o2Yoaj4
         CM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765199963; x=1765804763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpqT/PJvioY+NKSh2DmC5qT0+A1ogKkqikHGgDn/B+c=;
        b=vGNzYcHre8czUrTdkLIJsXFjX4QuyInmggPFO0GHC/tWmQnJIVXCw+FNLYFjvv9fu9
         94jaKJdFLwb7wyWFKmfnCdcMKNwUJxJx4Mc23xn0EkGfrG5UA6jXp1SUNTTHx3yTbsaY
         LfrY0fHfHFJH9IKWLQqARFZ0/yc/POfP5zEFJMHY6AjWsbnscR5Gamk1JYm/SVpfqdfL
         F+h2w7rrRI50TDAJ9gXaroUv7U4Ll5uMB2Xzo3ZWaEVqAcPO78gma41OwRaAz7eNjwsh
         Ey8Exkkuq+l1N/xuc+4IT2g15dwUNLbvHTdEXCuPnKl8e1qg2+eGZDlfLAmc6xZZCmS5
         TqrA==
X-Gm-Message-State: AOJu0YzwwyA/Js731u5D7uTTFnjiZpQRDEIZbeJvjQAf2VhyzsE8LMmR
	y8KvKVdb2vGBmkvmDEZl2/fYhw/ucNSaUkgG3ZERkdeBf+JbNBTAjKRR
X-Gm-Gg: ASbGncvPukfzAQ4aL+qA9G9DoqDhHqPYSSwQguauMZVYZtN/PfKddhOI7L/tu+zPjxI
	SRtPXD5DX4UsogYPSeHkP6i1D3fncYBkiRFzQU6fwSrvSjnzBpJtBrz4YC/nHiItz5Hb0DOczEG
	Ogb9aS8khgs/T5SZWOlnZ+VcXp+XF0Oc1jyNk0zoN8EsgKgsZD7pe6Df2sYUokkv/PGvO9Alz2S
	N6EWIqTIDtCifm3PANFb4eSf49OKGhew+eij2QzCFgKiwU+SWpxC0RR38UIuLZo2tl7KHbN6Mba
	UhIejrQkfvK+sF/uetEse+ZxTw/SgKY4Im05soy8odxQC/04A623YbxVZ8ZcgvnnBkN4w9iUYIU
	dlpZPKobUkz9h0bLdy6Mtg55B3uRZql3H1tjkw+8pI4/Abt7vhbtRpwZC0/ZxSqxjZG1B1fUNG5
	l7eOC+CHLI6CgnoBEq5GR35kXNYNA=
X-Google-Smtp-Source: AGHT+IHif9jIoGV5a2xxUQIy9VL29LFtOsQnFyu/VMjR9x4ghHzim6wsCFRN1z6RFrIA6H9Ep+FGmA==
X-Received: by 2002:a17:902:d4ce:b0:299:bdaa:a886 with SMTP id d9443c01a7336-29df54722eamr68793415ad.12.1765199962905;
        Mon, 08 Dec 2025 05:19:22 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaaba21sm126848595ad.70.2025.12.08.05.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 05:19:21 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v2 0/2] Use BTF to trim return values
Date: Mon,  8 Dec 2025 21:19:15 +0800
Message-Id: <20251208131917.2444620-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

This patch series addresses two limitations of the funcgraph-retval feature:

1. Previously, return values were printed even for void functions.
2. For return types narrower than a register, high-bit corruption could
   lead to incorrect values.

By leveraging BTF to obtain precise return type information, we now:

1. Suppress output for void functions (eliminating noise)
2. Properly truncate values to match the actual return type width (ensuring
  correctness)

These improvements make funcgraph-retval more accurate and useful.

Before:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 1)               |    _raw_spin_unlock() {
 1)   0.074 us    |      do_raw_spin_unlock(); /* ret=0x1 */
 1)   0.072 us    |      preempt_count_sub(); /* ret=0x0 */
 1)   0.373 us    |    } /* _raw_spin_unlock ret=0x80000000 */
 1)               |    down_read() {
 1)   0.070 us    |      __cond_resched(); /* ret=0x0 */
 1)   0.069 us    |      preempt_count_add(); /* ret=0x0 */
 1)   0.071 us    |      preempt_count_sub(); /* ret=0x0 */
 1)   0.612 us    |    } /* down_read ret=0x80000000 */
 1)               |    down_write() {
 1)   0.070 us    |      __cond_resched(); /* ret=0x0 */
 1)   0.071 us    |      preempt_count_add(); /* ret=0x0 */
 1)   0.070 us    |      preempt_count_sub(); /* ret=0x0 */
 1)   0.605 us    |    } /* down_write ret=0x80000000 */

After:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 0)               |    _raw_spin_unlock() {
 0)   0.075 us    |      do_raw_spin_unlock();
 0)   0.075 us    |      preempt_count_sub();
 0)   0.380 us    |    } /* _raw_spin_unlock */
 0)               |    down_read() {
 0)   0.070 us    |      __cond_resched(); /* ret=0x0 */
 0)   0.073 us    |      preempt_count_add();
 0)   0.072 us    |      preempt_count_sub();
 0)   0.586 us    |    } /* down_read */
 0)               |    down_write() {
 0)   0.070 us    |      __cond_resched(); /* ret=0x0 */
 0)   0.072 us    |      preempt_count_add();
 0)   0.072 us    |      preempt_count_sub();
 0)   0.676 us    |    } /* down_write */

Changelog:
v2:
- Update the funcgraph-retval documentation
- Revise the cover letter

v1:
- Link: https://lore.kernel.org/all/20251207142742.229924-1-dolinux.peng@gmail.com/

pengdonglin (2):
  fgraph: Use BTF to trim and filter return values
  tracing: Update funcgraph-retval documentation

 Documentation/trace/ftrace.rst       | 76 ++++++++++++++++------------
 kernel/trace/trace_functions_graph.c | 64 +++++++++++++++++++----
 2 files changed, 97 insertions(+), 43 deletions(-)

-- 
2.34.1

