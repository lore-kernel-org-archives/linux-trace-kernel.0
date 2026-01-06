Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410D31E0EF
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 10:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694612; cv=none; b=i5QMwSDClPr496wnRWjkMVbJ45k5Or11cMBzHNzpO8eabtE9EFc7Rb2UrXr0m8o37yIwVZyUk+EBZJKV+dGN0eDM+RMDdDst0ooO4b//ol2w5mYEW6SBcCJwNeO4cg+W6iGXhEEuXO4uQONnCPez+8JhR8QEXstkT0Vfguemx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694612; c=relaxed/simple;
	bh=R0brKy11lWk9rG1Hszq3cr5excGuzAybyASfH2xcz9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aT1E1AiH0SLNQBfqSVLiAmC18QPbZpXdpCHlNT4U3wI9MoZaxzRe+d/zKoT5W5eGOF5wkhzomzx4abt/Y80h07g9Pk2rQ3Xxkw6bAtPq2wsRC9dTtgAeseegNGaut/9RARcu46lck85IGRCOpAzv5c8bSHVNLQOjCn1uKWni8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7c6cc366884so493294a34.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 02:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767694608; x=1768299408;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNNcUB7lgyIwf3R57Px+ObUOuuqMHsgwS/LskqhZlIo=;
        b=gl3a990HVmCevcTIemXzcoU7wjz1a/Q6QxMTS1DVxQfsz+S4gpENcKF5beGycvDHZ6
         t5Zp8MgsglWDbeR4/QgDY+pzI8xFDSeZD8jodZ86FjFDBL97JynuBsnzXaNKkrHuzIJz
         QQHj1Hc+sozxUg+41t+ghWw4iKJx/dc25vjiuk3lfnaowIFx56t8wUdpR1Wx4F0QbLEN
         LArGR70l/M5yx3fppQh7lre+xORxqKdMTDthF2Dci0GfILF1tIkIgrHR2ibSnBdxOT7w
         wv5LHdSaaj6xY66PclLcVGQo8wAcXyHqsJjkWAAVB9fP0AvzXsf1eHGZqSJb1gkdkGSm
         Lf8g==
X-Forwarded-Encrypted: i=1; AJvYcCVqPHDt7R/+jmOCfpT2Ybk/lvjGd2XGngli6beEFaCTV0NGC2X1Mr+fWgQvJfZ98ke7zoWfFzraDgZFfiNBGeR+xlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEw7LLyQEeob8X96gm3atHem7BBd7/u5hjHzMDUv+1o6Peibmt
	X+O61UXH0fbbww0FfCgyviaItG+qdorDhCfNgktKCAVe7i+DhnDoc5jG
X-Gm-Gg: AY/fxX7ScKLTmUuZh0Q3HMnuqkFl5ksJduxITAl9krZkUIQJA425DvHfbRnVyy4084o
	arvCLGamZAH4OkKcv/v8zO7J7M4Pr2xbKwvJ+iaLX4cdxlVYMYSFCJbOyX65UL/6YLQ3p/zG6ZP
	vbWShe0TgEA5Lza2nLWEmKPqpfBUTeiEw0qeSWSXTItqYFMFs1iuoz2oVJvJgnTy54NzsL1Il6m
	HuRbUj8viqCpsex6+rGVD2OSPCWkce6YbY+4g/bJEUGTEbPqgTFsNTI1sLygwOz6tNs1G9NW+w4
	nJLn8UtXEuhNMITuyMAkQed1UPQ0RPZjt8+u/jY7rr6sK+e1iIgvk/ah0b5jEpYM7xYTZqMB6+1
	jIcWUl1RdvZxZ9fx5BYpeivfp1xUPfMg+zLaMGXZaVAXZrs3esBEUK4Gmqxd6zL8P6/WbP3Npn2
	b5HvrppzH3bl97TQ==
X-Google-Smtp-Source: AGHT+IHpik8hWyPXo+y5CoXoGZNP7a5BRxyJotM7yoa4j2oD5Z6LvXpzD97F1AyaKuGImA/76c6nUQ==
X-Received: by 2002:a05:6830:314e:b0:7c7:b28:227c with SMTP id 46e09a7af769-7ce4663ba8dmr1405642a34.4.1767694607636;
        Tue, 06 Jan 2026 02:16:47 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:59::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47832780sm1149346a34.12.2026.01.06.02.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:16:47 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 06 Jan 2026 02:16:35 -0800
Subject: [PATCH v2] arm64: Disable branch profiling for all arm64 code
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-annotated-v2-1-fb7600ebd47f@debian.org>
X-B4-Tracking: v=1; b=H4sIAAPhXGkC/yXMwQqFIBAF0F8Z7jqhlAj8lWhhOtW0sFCLB9G/P
 6rl2ZwLmZNwhqULiU/JskVY0hXBLy7OrCTAEnSt20abRrkYt+IKB9W1gc1kjA/diIqwJ57k917
 98Dkf48q+PAHu+w/4tl4nbQAAAA==
X-Change-ID: 20251231-annotated-75de3f33cd7b
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Laura Abbott <labbott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@meta.com, 
 puranjay@kernel.org, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1627; i=leitao@debian.org;
 h=from:subject:message-id; bh=R0brKy11lWk9rG1Hszq3cr5excGuzAybyASfH2xcz9g=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpXOEOE3XW9TBI5+gt0t62QrPhBcRn/qigH4pDn
 4gtfXOidi6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaVzhDgAKCRA1o5Of/Hh3
 bUDDD/9rIz9FUmTyftcZ2SiYxTdKVB+boYTZiBL/TZMurMwpO/5crdYad5bRGL5PnmNRnAeXZjf
 4bJExaoMmBMiuWAyvQvis+Kgdu+xYgXT0mYC9e+ofnCp05M+Yv5GS5f5vATolKFIjKTnu/Xl6cG
 DPkerSX2xPxChN78jd88Nf/ckcBu3vOkDA4cAtYIRrpN/m3yM6qoukboZHnxNKVOoLV1FQHepcu
 K5wMSl7Tl/DNZwbD/rvR1VKmO39xdu64RTE9kWrmZ9CQRY6OdsEsNhFeCrTTRO8ELUkVvKf1bVY
 ImufebVYkB7WsBLoG8pQ9Nvnw1QknNczA8BbYtGKz0EboKTFJauoROuLtb3QLUaycljbGbK8y/W
 tJUssGjN9WA24lPTVxmN3vmb9gv0/OqmVsrHwt0wF7UvJbUKTr0SqCSZrbXchU8kVyiGUw7K0Y4
 oLR1uNKGJYHlOxO0fAJZH3QEW3JLiJ3kuN/pbIw5aKZi+WLDgZ37YiRQS66jDV26TfYKdP40ply
 ERVMouE96PDsf9EjIYu4xRE1dyOhITnjRaPhNThdNXkgm54dBgEkQSx7LGlbeV7Us9pbVThNkV3
 /9sSDLDoLxAVm6uTFXtDXG/F6GHzX11cLaNJCkS9QIXeLC4NLaACGOLvz2bDIEohjUxyUGPc0jr
 Pp5K+kknoJuxX8Q==
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

Rather than playing whack-a-mole with individual files, disable branch
profiling for the entire arch/arm64 tree, similar to what x86 already
does in arch/x86/Kbuild.

Cc: stable@vger.kernel.org
Fixes: ec6d06efb0bac ("arm64: Add support for CONFIG_DEBUG_VIRTUAL")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Expand the scope to arch/arm64 instead of just physaddr.c
- Link to v1: https://lore.kernel.org/all/20251231-annotated-v1-1-9db1c0d03062@debian.org/
---
 arch/arm64/Kbuild | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
index 5bfbf7d79c99..d876bc0e5421 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -1,4 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+# Branch profiling isn't noinstr-safe
+subdir-ccflags-$(CONFIG_TRACE_BRANCH_PROFILING) += -DDISABLE_BRANCH_PROFILING
+
 obj-y			+= kernel/ mm/ net/
 obj-$(CONFIG_KVM)	+= kvm/
 obj-$(CONFIG_XEN)	+= xen/

---
base-commit: c8ebd433459bcbf068682b09544e830acd7ed222
change-id: 20251231-annotated-75de3f33cd7b

Best regards,
--  
Breno Leitao <leitao@debian.org>

