Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51D637B036
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331544; cv=none; b=DlC0NsqwpsWINgrV7BcsdfCSXcLxVrcokloDF+pJ3aq1/WL3eJ4/pjT0+s9sjKKdOdrWMPrSmlvbLF6o8sLf/JpR/3i0R0eYmgS+LiYSqytaOeEMB3PTz3DVmVQ/jdf4kjGAJoCb5T8TGOHGUU0jb69R6PU4Muf2LMA71g9h7f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331544; c=relaxed/simple;
	bh=WYh/0eZ2LY1uEi1DfAiXRl4XWyBwrmV/GsNZ3OxaaJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOosg0b3qDVYjTb/Tx8T5DQt2PhkDcfEQ8ITdsftEpBRvZT+aGflGEEc+/G9sYIPmti60TOejagoRG5Jpkd+Mzn156U1SeW9DX36NXmtRDNLOfeNdqMfv0PjyoL7Y254fEtZfQSUyOqrhYirNGGrgWIOin6ZfEjC6BNRIrb7zqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSbCKsww; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSbCKsww"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso7340315ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788331543; x=1788936343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hhH8Mo5IKwB8nmCAJcEjBx6yBcTLSZlIEQfHIlsogi4=;
        b=sSbCKsww6aEOJGgKRsPEuoZMgHFSXKlwq/UEtYOktBS8vrgIu+YK0wvOm7amCLO5ZK
         U0Q0LePFMXTiWe5alQgo0Y+xgbenjT365g4E5g3zdos5tuBF16QfasWmSs8twtycFoJU
         +wVsOiQkymIROy9VxrhStXUS92zbfX/6N8jdhtAFja593bhf5SvYJkF6teeFTSMjTOIM
         YDC2HwFTdVNaom8QVw7jB0Pw5P/jnIpGAy+i/Xmc/WYB27j6XRH8xXfgk2G5NCZBk1EK
         1juA6qfV/3okFtqWeb48qu4BsAdVPQNFasCk2fsq3MlllR1/7kaqwJA+0jlUC5zfUgoA
         g+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788331543; x=1788936343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hhH8Mo5IKwB8nmCAJcEjBx6yBcTLSZlIEQfHIlsogi4=;
        b=TgrCpQCOSh+LUXF5N3yUcBtrUyvx5tbHAM0bEGwWAMIMugUpST+wl9TXmQoYI2ePwv
         ymGFvUG+5VDxl5jUmoMJRp/YubcHbjxMTO8HfYP3QXundiP8JuRmgtCOYRrFJPSCgw2d
         7jFI4YTtLovBerZ1TmI7bpL9NfDDuLFTbZZEL5wnbOnpR9aMvpyls07vzJ7jVidtNWPx
         rt0LKt9qcGHuQ7mM6TqrJ04aSzQy5KQlCpx+LFVIfLvRpBiSqW+MUdxrvlxPZ11f1W86
         eu2uvcmusG34/im+EVKc/SYeoYLvMk+gQkxj7+W28T0pqQoGyqbJccOzedvefeQuckgy
         SDDw==
X-Forwarded-Encrypted: i=1; AKwUvBz+cBFcxx+ljtQYrCgJxTgLTj3hzgHc+SExcoKMmbUPzA20cs6FY4A9URlObf5N0UKQ9yW8FDLW+J9kF4hMjupVYDo=@vger.kernel.org
X-Gm-Message-State: AFuF++mKmkYg38LLMReikMMFOgq+2ER9Gfvgaa//EA8EjyblmpIkqUfB
	lzPrDUeGwV1UeolJVc+QK4l0WuTZY29x241bVQJnuBsiQYg5jKE5ym3c
X-Gm-Gg: AYBFou07VXjbHhE16wQ8+KCMNd0OBamSYLWpMiWsFhkfnzTvaL+UNKnqDeVj0du3nAN
	XjY2S1PeJSU0sNxSjeUAY9U4l5ZRYPGBlMIBHGthqZV2nbFRxjq4Eqoe0LwevDmQgQP6lDmVxND
	uayO9Brw0ADNjmkrjCqJVMciQhEAHDaC16Pi2ekZCN5J1ZdANb1/cuP9MnAeC69i9/PRytpgMn+
	Gx8nxapFJaiqxV1a2P9SIhQWHa0ApHzZjaZ9QhaABBS+/EzwVpTBFFa8DlHVqpN2ZP/5Wpq52/i
	UlutDjSt9VMNgTQ6XzKCkMEjvA/84wtJVBSurkG6ctT1E0hkOsJusDM+pBcpgF/UD33eSEqWuaK
	q1EVEXinW1PTi/wrdq53XHcQhxnF7mjisUULNgWlxp71DCx6JGdHIuiWEvSPRtA3BQGviAa4pgA
	/+qgFFpCa9n7Bp79gq5b99p3Lde6jATCUMJvpRoX9gYIQsZY54Pt9ZMCv6VcBWQ47cu1GRdeEye
	0Sl5AIrAyOQy6Wv
X-Received: by 2002:a17:90b:3902:b0:398:9bd1:3215 with SMTP id 98e67ed59e1d1-39aee13c238mr3645191a91.22.1788331542955;
        Tue, 01 Sep 2026 23:45:42 -0700 (PDT)
Received: from PC-2B0BA31200898.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1b395sm11051480a91.1.2026.09.01.23.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:45:41 -0700 (PDT)
From: Meijing Zhao <zhaomeijing100@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Meijing Zhao <zhaomeijing@lixiang.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Wandun Chen <chenwandun@lixiang.com>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mm: trace: decode arm64 and sparc64 VM_ARCH_1 flags
Date: Wed,  2 Sep 2026 14:45:08 +0800
Message-Id: <bcf0fea58240c4b6daa253739683ed7709e42fbb.1788330432.git.zhaomeijing@lixiang.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1788330432.git.zhaomeijing@lixiang.com>
References: <cover.1788330432.git.zhaomeijing@lixiang.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Meijing Zhao <zhaomeijing@lixiang.com>

The VM_ARCH_1 bit has architecture-specific meanings.  show_vma_flags(),
which is used by VMA tracepoints and %pGv, already reports the powerpc,
parisc and no-MMU meanings, but falls back to the generic "arch_1" name
on arm64 and sparc64.

Report VM_ARM64_BTI as "bti" and VM_SPARC_ADI as "adi" so trace output
and %pGv dumps expose the actual architecture-specific state.

Signed-off-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 include/trace/events/mmflags.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 935893e5ea53..02caeaf359ab 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -168,6 +168,10 @@ IF_HAVE_PG_ARCH_3(arch_3)
 #define __VM_ARCH_SPECIFIC_1 {VM_SAO,     "sao"           }
 #elif defined(CONFIG_PARISC)
 #define __VM_ARCH_SPECIFIC_1 {VM_GROWSUP,	"growsup"	}
+#elif defined(CONFIG_SPARC64)
+#define __VM_ARCH_SPECIFIC_1 {VM_SPARC_ADI, "adi"		}
+#elif defined(CONFIG_ARM64)
+#define __VM_ARCH_SPECIFIC_1 {VM_ARM64_BTI, "bti"		}
 #elif !defined(CONFIG_MMU)
 #define __VM_ARCH_SPECIFIC_1 {VM_MAPPED_COPY,"mappedcopy"	}
 #else
-- 
2.25.1
