Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E98315D2F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Dec 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767185067; cv=none; b=IoZOe0Rred0cfMnXaHbABGQ1SMkdjO1z7gEIWmvQwIg/hFJIuKhAwROo4pLyQs4nXEdPmHBuLkclcSfoD9Uys63d0dBB1Ki+SbxY/Xc9UMSe6uXVLIniQaWXqnh/gdM3wwbP+kdrH39h+/tZEUj8hMgeZGFz0c/BLR9F1cDhFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767185067; c=relaxed/simple;
	bh=rtQ9YOzpTI1rtYAALDX3LhmxVAFBXeE/3oqvYKuAQ8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BucXlnmXKuH4s6Gv9B0hCjDI/rpderU4XQyQLDx96PESZJJQ/8Q8TWFJbYX/NdzPQGhLDCXznSsF2SdwHlFZZEy3Yo2eDnsPc7aOING8dKST33l1BS8DFCRVqT+by7PA7kSU7tms39+JkTV8IEcHs5sM79bmc5MXZBmE9wPaEmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c78d30649aso7333243a34.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 31 Dec 2025 04:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767185065; x=1767789865;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=doIBT3kveDHefqqmJXIbpBpDJYXHZZ9gY6YG0CQ1W1s=;
        b=RoOjTSx2IcGOIfPjjK76V1mDd/IcveGhSvZ8FscTC6SFSMRYYo41UEBIjHp2UDnCcw
         CrnpMnZTlejjGrRalHC7uqwsJZgeeW0vrBWv8fAzQLheSkjwejKdb47C59awsRQB1BHZ
         f9jEL+vZ/zHRD/HZD0EmkPsKIs+fzcSel+X3YIk06tz2rjI4vIveBmsRMb0X9wt+gWD7
         +h73+oO4CNbHm3D3Hae8O4I1XNz4uPihigwU6ow9JxxymMefovnqTYN9mcau0wrVd/96
         M4GsAR3fKteCUG7h8uVtIUCTB3KbbtZ8GqXq/a5TTgF0oM8rk7fomdyC57MF/NbegV1T
         wYdA==
X-Forwarded-Encrypted: i=1; AJvYcCWpKCsrNjFp5GTXUZSWMQxJGsbLlWQDjbv7zbqQQG5fgsj/I3VYUUe8Tmxe2BbVIccdCBRX3yFlorQXOJQMfVZcqxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4cxLagHmBNwnbBurh6A567ZoMbrXSZwFaUyXDR73nWAlSVbB
	pv8xhIUuPOxA/qOcn+k2waMcbZy2CCYX4kq+cde1PvJWmSkirji6xnGTAMVpzA==
X-Gm-Gg: AY/fxX7KGDtzCHvmBjlGjNZeYLYHbe90uXiruYrD2omxfH9DeR/2cQ4W1y8mZGx+N+N
	wtlqUsZq6WQvpk/HDVl2PeCHDl3Lwy3qeZqSxaBguKgb0BCzdB9AjGNCUZ/sPTOGREyz9bdKsOl
	HogJmBdEwOsSiAVmXzs+KYP8lPKz51CClNSP9+NXz7EK0Pyy3mz3/cusfh0zqbeDzTPbiNpBlVW
	6UWFdZXQ/q5Z/W6O9g71F2biKD7eSQOKvc6qtQX3kky1FV3BFhS1LZ1qfroGU/c+oKzrGIYVhSg
	4Hj6J5SW21rBLu/BdaeKqWLaumbiaeKwGFlX/64iiDa34q0LipgqVUw39BOjDyKfnvngPnDIC8X
	hnnf3d+vdTQd6Ngmd/3Lil7raZGl+oAQGTC8NIgsp4a0fSHmbCYbpEGx0rNRBDW73vZFLKF9tSM
	OCSlVVfzQR4A==
X-Google-Smtp-Source: AGHT+IFVj7a9FUlEf5NH6KpIT/kaUw0oiLWglRHiOzK9tALgQw37NwF6rJUHBW5v0Oj+IkC3OkEsQw==
X-Received: by 2002:a05:6830:3154:b0:7c1:12c5:334e with SMTP id 46e09a7af769-7cc66a023c7mr23119448a34.17.1767185065067;
        Wed, 31 Dec 2025 04:44:25 -0800 (PST)
Received: from localhost ([2a03:2880:10ff::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667d6b04sm24557658a34.16.2025.12.31.04.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 04:44:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 31 Dec 2025 04:44:05 -0800
Subject: [PATCH] arm64/mm: Fix annotated branch unbootable kernel
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251231-annotated-v1-1-9db1c0d03062@debian.org>
X-B4-Tracking: v=1; b=H4sIAJUaVWkC/yXMwQqEIBQF0F953HVCKhH4KzEL01e9FjaoxUD07
 0O1PJtzonAWLnB0IvMhRbYER7ohhMWnmZVEOIJpTaeN1cqntFVfOaq+i2wna0PsRzSEb+ZJfs8
 1fF6XfVw51DvAdf0Be9PcO20AAAA=
X-Change-ID: 20251231-annotated-75de3f33cd7b
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Laura Abbott <labbott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, puranjay@kernel.org, 
 usamaarif642@gmail.com, kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=leitao@debian.org;
 h=from:subject:message-id; bh=rtQ9YOzpTI1rtYAALDX3LhmxVAFBXeE/3oqvYKuAQ8c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpVRqoMlyZ1wZ3Pzr1vXtCo85272KEY4xVGFmrE
 b2oMh6CVkmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVUaqAAKCRA1o5Of/Hh3
 bQZwEACnPfBsC/ChcFSyk6SAwxKoOvb1ERUF80rfaNxXBJiaA1VgbqM7C/wBw+YbXrQmhzVqY/e
 zB/ndUjEg1Qw/f1EkWqLpRYykPjwyQ/nZsHL8RUh+lvvsu2vH83B4FgCIL991+rvhDFZW75ecWY
 Wx27xdC7xpaYRNPR/lCGRyKw9GRdkZybGZhUqed7Tu0UwVGNJkdEonPSWzsyXQhxdAKqPkaTXwP
 yI+5HdfEAuA8nCB56AYgRaMxUUmY+Gg0JtwVD5CS/lsrFAcsngfXp0I0h2TMFDOYF1Hlwo5ZZ/z
 w8qA3nMwS0murcRCerIFfvy/jgPPx+OW9JE1WcwbAEDqZjXSQ/Po0ENzua7Nu8JciG9+Xf46Ikv
 xH/PK9ICIZQsNLJszbbllCh6smeoREyPb7MLH7utDd9lbPy0K7ALIeJJJOM77UoSBmIX3yJlEl8
 8FLJGGRpDH2/y2YbFkzWthRAgG9qFm3dVwpY8HtXJsFRnxAb2lQW3w99ahtwb5b+WzXzGXSaks4
 csHXIdZitAVmfvtZvoZc2hJ9fpfI2ggf5vrK2Z+gT7SN4VIA6agvZWESHTh3BpTcabZIWqPxwIl
 7GUbaPEl3NeaOpCjDiB438p2p4W5UwQstGYeLrTvFjKj8PLdWHg5liU52jhLlKSvVXXC2iAk+iL
 +BJxQOoAcO2C7tA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The arm64 kernel doesn't boot with annotated branches
(PROFILE_ANNOTATED_BRANCHES) enabled and CONFIG_DEBUG_VIRTUAL together.

Bisecting it, I found that disabling branch profiling in arch/arm64/mm
solved the problem. Narrowing down a bit further, I found that
physaddr.c is the file that needs to have branch profiling disabled to
get the machine to boot.

I suspect that it might invoke some ftrace helper very early in the boot
process and ftrace is still not enabled(!?).

Disable branch profiling for physaddr.o to allow booting an arm64
machine with CONFIG_PROFILE_ANNOTATED_BRANCHES and
CONFIG_DEBUG_VIRTUAL together.

Cc: stable@vger.kernel.org
Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Another approach is to disable profiling on all arch/arm64 code, similarly to
x86, where DISABLE_BRANCH_PROFILING is called for all arch/x86 code. See
commit 2cbb20b008dba ("tracing: Disable branch profiling in noinstr
code").
---
 arch/arm64/mm/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index c26489cf96cd..8bfe2451ea26 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -14,5 +14,10 @@ obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
 obj-$(CONFIG_ARM64_GCS)		+= gcs.o
 KASAN_SANITIZE_physaddr.o	+= n
 
+# Branch profiling isn't noinstr-safe
+ifdef CONFIG_TRACE_BRANCH_PROFILING
+CFLAGS_physaddr.o += -DDISABLE_BRANCH_PROFILING
+endif
+
 obj-$(CONFIG_KASAN)		+= kasan_init.o
 KASAN_SANITIZE_kasan_init.o	:= n

---
base-commit: c8ebd433459bcbf068682b09544e830acd7ed222
change-id: 20251231-annotated-75de3f33cd7b

Best regards,
--  
Breno Leitao <leitao@debian.org>

