Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529383822BE
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 06:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331552; cv=none; b=Qy1cXpej20qPOtfzEbGonP/60ueQMboYuQ5SIcIMlTPub4ZSfYdt03mfiQqcrUlYHnnsATes+ZzQ1zvRCmnm9vlLlIa7EjevI7Z7pnA5AQ3HWrLUTb2NAds19lS8hyvWCvZXP4i2F6/peMRaiaQZZqbH9An8UK0kTlm/IHNjzpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331552; c=relaxed/simple;
	bh=gKTj+wn2ltX7CFM5zaOViDsn11taF/RVYbSwk0Exws8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lnA5vf+Z+9ZXfXALuXLo/wbv/AjdgbfujgQzuhsjh2l9iEO4Ocl6KoiGOvjWTpcVzc3kSycwN2qq9wPFaBhjdvPc0qsLIPC9TJOfZG3bXsw1LxZWZy+VShScA37Hh1Z3UrtldiUlrTAP12UYfkn5BV6OUpa+mQwHjwyT6OG0qhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rsDJW1YO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsDJW1YO"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso788007a91.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 23:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788331551; x=1788936351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sA++nWJofVz/EtAtHtRDwVJVg34ghqqVvTXtizuE6qM=;
        b=rsDJW1YOtxfTLk3jTkWzX5D/F/dn1148VD4LUKiWPe9Pi9hvXvJNzcXzrX5PsTtjXY
         fgV8Cfo0U+6MDj1JJB6GemMkICwIwQmzopIxz6uKycE35RIqMTvLtNE/WzadTNwvZ8Em
         LgytadsC+bzN7QECKQ4x2BrAJnb/5Bwp47rC34TNQwTWVaGA34H9Gv11d1YFGY4XK23z
         yy8tBGk2IcYM1S/9gkKIzz2yPxAyAlOO87VirPZ4BZ8jdKt/wf3Y2bhzJ0EeijTPuw4P
         +E4NaArH4pGA2wxU2puqj3cUjDzV1QkS6KiIlnFGuduygiIER4155e7zOcaBUsDe2d1T
         lxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788331551; x=1788936351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sA++nWJofVz/EtAtHtRDwVJVg34ghqqVvTXtizuE6qM=;
        b=K1BTky75FC5Ul/EjHZN4LcDb0eybzP50IqvJ3Qs7Wj9xutQI+l9s7oiSZ18THNAEOj
         sdE8zUZ9N1On55j1Z2R2ByAHF7Z+FPPB8p0DfqUVoHDAgP9Ac30wzevBr3ObTXnNL1G5
         6ZgaOwh5V5GcDqpb0C21lBMOO/MI6yKqCPC2+PMe2iS56meKJSpDfQUa/AULvKRWTTyK
         KAoDDW+joRQ205zt3eoi2/AvfwT0vVJdRSDVPhyZTmF8M8vv4Y8y8luUj12YHwqIYdQv
         wJgQRKgska7lI72zTgz4PJctBhtLzjJ8AIxgkv6WPbtavSPHJZGtyjJw8f9xRIuDFKUh
         lmpQ==
X-Forwarded-Encrypted: i=1; AKwUvBzv03jEZTIaqv3fpgkBAAWl968qlfQGaE18/tevNRVIJA5+52sdNqZo0UDwyhYt0bFx0dLLz8FdJm7XCZmhmW8BUHM=@vger.kernel.org
X-Gm-Message-State: AFuF++l5Pf0dqqZ9ehf7fwjoY71OpC9zsVpf8J+ZLGCilk1oA+3FZ2OL
	MTgZaPGq3YXq7wVJZx2tOsM3qicGfTPl8ExWsNoB9UrzZ/FAL5Tpg8qv
X-Gm-Gg: AYBFou3KhTicSQok/YOWXZoq2xFmUqxoofRk542SCnS7Ram6yY/FUaPrm02TAUfosfq
	gwVixZEZ2d0miLolFlpKpK+f79qCKciQeqED8TjVHlocUFuFb3z3gNFzwpaZqN1a+YJn/jSa7Ul
	hfEU+wZDIhK6IEyz3tRI6sbxk1/WOljRe+TmxKle6TOON/YZ7B743DxkElA+hvl82f4GT1jwftz
	J/azbeIJF3veblQU/plqjeOMjRnuaeE4kaNuwup1GLGvUbdQe0Tvw7t13qJ7k8KwiimQfCvWuqL
	lbylB/Cif81iM2KE4XtP4cAxL4yaD/gM9meC8VybjkC+Slg8BEwWZpnlHmWbCGRRJf6FKVA5/qC
	VuLTpoo1G1b05oIlHslziZoJYY8VHKoyAT2Bpg3Qs5zl+s6Rs5+RPJ/vb8TJsegmumv9/pbYQKQ
	LWuqD0LYZQzFAj8V+qgWwJ8royDsmaXzhB9DU3p5Ud535HT5M0aVV2vkrodyenVNK5MzCTxH+8q
	yYPzIiZ8yHAH/1M
X-Received: by 2002:a17:90b:2808:b0:398:9be5:b417 with SMTP id 98e67ed59e1d1-39aee1c63b1mr4243684a91.18.1788331550609;
        Tue, 01 Sep 2026 23:45:50 -0700 (PDT)
Received: from PC-2B0BA31200898.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1b395sm11051480a91.1.2026.09.01.23.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:45:50 -0700 (PDT)
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
Subject: [PATCH v2 2/3] mm: trace: decode MTE and shadow stack VMA flags
Date: Wed,  2 Sep 2026 14:45:09 +0800
Message-Id: <1c7f7003cff8d00209baa8498f1efee113f5b5a4.1788330432.git.zhaomeijing@lixiang.com>
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

show_vma_flags(), which is used by VMA tracepoints and %pGv, leaves
architecture-specific HIGH_ARCH_* bits unnamed.  Arm64 MTE flags and
user shadow stack flags are therefore printed as raw hexadecimal values.

These bit positions are shared between architectures.  For example, bit
37 represents VM_MTE_ALLOWED on arm64 but VM_SHADOW_STACK on x86, so a
shared HIGH_ARCH_* bit cannot be given an unconditional name.

Add conditionally compiled names for VM_MTE, VM_MTE_ALLOWED and
VM_SHADOW_STACK.  Keep the configuration guards aligned with the
definitions of these aliases so each shared bit position is decoded
according to the target architecture.

For example, an arm64 VMA containing VM_MTE_ALLOWED is now printed as:

  ...|account|mte_allowed|...

instead of:

  ...|account|0x2000000000

Signed-off-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 include/trace/events/mmflags.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 02caeaf359ab..2f980d20a9f6 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -202,6 +202,19 @@ IF_HAVE_PG_ARCH_3(arch_3)
 # define IF_HAVE_VM_DROPPABLE(flag, name)
 #endif
 
+#ifdef CONFIG_ARM64_MTE
+# define IF_HAVE_VM_MTE(flag, name) {flag, name},
+#else
+# define IF_HAVE_VM_MTE(flag, name)
+#endif
+
+#if defined(CONFIG_X86_USER_SHADOW_STACK) || defined(CONFIG_RISCV_USER_CFI) || \
+	defined(CONFIG_ARM64_GCS)
+# define IF_HAVE_VM_SHADOW_STACK(flag, name) {flag, name},
+#else
+# define IF_HAVE_VM_SHADOW_STACK(flag, name)
+#endif
+
 #define __def_vmaflag_names						\
 	{VM_READ,			"read"		},		\
 	{VM_WRITE,			"write"		},		\
@@ -237,6 +250,9 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
 IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,	"droppable"	)		\
+IF_HAVE_VM_MTE(VM_MTE,			"mte")			\
+IF_HAVE_VM_MTE(VM_MTE_ALLOWED,		"mte_allowed")		\
+IF_HAVE_VM_SHADOW_STACK(VM_SHADOW_STACK, "shadow_stack")	\
 	{VM_MERGEABLE,			"mergeable"	}		\
 
 #define show_vma_flags(flags)						\
-- 
2.25.1
