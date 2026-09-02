Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78037F307
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 06:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331565; cv=none; b=AZ1DMI9pdWEnM1kzSM+8BWkw2Zwh3pYJtoMVWdpQHTQFXvi/J7F/BYWRvvbaZ+qE7KBwVNAqmEZzznNtqVubm3RIDkjlTXLJwHf9aRsKi+D0jmeU4uxCfDNu9sN5DbZwRD60yZNm+S57j2C78Sn6MqJTktVRFXEmbWuy4d4rZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331565; c=relaxed/simple;
	bh=Pl/F4A+WNHxObov5QpjRxwRqXFSTazG/CwcNf54O7UU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kUIqIkluv2LrKWSOtuIq+AOPn/hOEkeZMS4NNrX6FXkqXa/CRENEGpx5lBbmO17owBJHm+H0Sh/sxEAS/iiIzrmWh/FfKSKLxneiRyWwYKqHrb9ebhi91C+GnV1SDZjB8nzATstklP69Pq0Uxnlv/FW7UvMGz4adA6URlM1+ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNNFd5l3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNNFd5l3"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39266382df6so605731a91.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 23:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788331562; x=1788936362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4yy14lSjlqIlp7/ZhnEryZaSDgqy5+mYft8l+OckZzk=;
        b=aNNFd5l3OlKVXwn9pPJChYdWPvi0y9AfysUAd9EMc85EMxIsL1CfB5+2P0+KOnuP3r
         ef5oNoPqlHZmecEZXl1uoh7HAM85siEmrWNIUFbf871vlI1GcxroUZ7V+6KWAD7F41fz
         nzCveLfwO5vW7drQNOa8XSfl3J2pThOkep4qvHlUpzaZ/Dq3JHZicEYvD4LrReiv5DgX
         Gu7PaD5X44R+k4NUnLUp9C7yrZaRAoIOrfU1p7Y0grwhkHoylAyQcXaEbBxzK0j5LPxj
         qQ774HiFS9KL9FLycONrg0GVlOPDfL1deASKyQdlNFW6gh566j77RmR3xUAdOWW8pUrJ
         JBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788331562; x=1788936362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4yy14lSjlqIlp7/ZhnEryZaSDgqy5+mYft8l+OckZzk=;
        b=msM5j8sYHGU7XVdBUWl51N2hVodlEUEsD2+PVgUvG2JBWX2vnZKWocsun7Li9F5meH
         IVd98KrTMEnnmMH29pDEaq7evGb80ATVWPMGv9Pg9nVWPXHt0h9n/rdh/TbZsolxhmP/
         qfpE/U4yIsEpCskwRBalD3Fax7m1RaWzU+Ervk41iwXftfkHDmbvIKDNmpfNQXZArTMz
         u1uh0DCHGBDFwpImz/tcYsgg9IKzrW4KWk6utj5Fk+NNPleGDG9abmUY/bqoMn8CJwNJ
         27rVVNf0/diSHCFth/k/9uA5lLFgJ7wi6QPpV5rSGbugAHPqacTBCpQFUc+qLlN1yLz6
         20qQ==
X-Forwarded-Encrypted: i=1; AKwUvBx/LSasA2m0c8kYZJVh9FM2UEQwGMbn6X3PouwK8pLPZfiUdautWz0W3bIxxy0Q0GEjYXQiaHoJNktkLQYN80WA5MM=@vger.kernel.org
X-Gm-Message-State: AFuF++kQPbHI6NCXQZPTiyYlEZ+GUUozm+ZW5UFjNi9LJMRn+UvmP149
	L7QGqOgzabofGIKpbBZf9RCKRWEEb9Ege3IBjdcZQtPuBLN93agtMdqj
X-Gm-Gg: AYBFou0KfFSbWi5VZKPEk4p+wPPHoyernqmeWBwaL+Q2jqCrkBP+Cz3DvBuw8rzvzx4
	mjR/cgpyCC08rKv9Fc9FMjnQSYxz86Mz7heQkx7F0szy0eNWQoS/b8ywdks1YdHolWef8Tabn0P
	D42PGC68JnLzEnpEmHWEDCEiKp7XOvnORa07SxcH1PWmWCh8lTDYoXGXIVeA2ZncbiCPoHowujL
	3vV77LpVvw2xV4gS92Lrmugpsfskk59CUGshS2u4quMAl+5nYoUVvPjWrvJdLD2Y3VrRhkyYK5w
	cR4pz6FmO+1WjDFe1hCTvhcCqgSdciO0MsUtqm5RTjrLLMIMQGQQk8Y4lK4DPswwtbMajrGAUTc
	uNKLNMeiYXV+/WVlKVdqDT/WereG6X2OTig3pmjJNdQsgXNZ0wnP0GvOGEEvAMNAH+33/7RhWBL
	0/XWCo/QTj6/O5D4zxdX/q/vMl5/DK+Vuw55EZ8dX0V/IUKyry9Nf3oeD148rLbTRbXW/0CTJEQ
	fY6JsxkprbxMYD1
X-Received: by 2002:a17:90b:380d:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-39aedc217demr3311370a91.0.1788331562371;
        Tue, 01 Sep 2026 23:46:02 -0700 (PDT)
Received: from PC-2B0BA31200898.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1b395sm11051480a91.1.2026.09.01.23.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:46:01 -0700 (PDT)
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
Subject: [PATCH v2 3/3] mm: trace: name protection key encoding bits
Date: Wed,  2 Sep 2026 14:45:10 +0800
Message-Id: <1871da32001243b37147bac5af02d2f2ec64304e.1788330432.git.zhaomeijing@lixiang.com>
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

Protection keys are encoded in architecture-specific HIGH_ARCH_* VMA
flag bits.  show_vma_flags(), which is used by VMA tracepoints and %pGv,
does not name those bits, leaving them as raw hexadecimal values.

Name the protection-key encoding bits pkey_bit0 through pkey_bit4 under
CONFIG_ARCH_HAS_PKEYS.  The names make clear that these are bits of one
protection-key value rather than independent protection keys.  For
example, protection key 3 is represented as:

  pkey_bit0|pkey_bit1

Honor CONFIG_ARCH_PKEY_BITS when exposing bit 3 and bit 4 so only bits
provided by the architecture are included.

Signed-off-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 include/trace/events/mmflags.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 2f980d20a9f6..ef9aa388b84f 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -202,6 +202,24 @@ IF_HAVE_PG_ARCH_3(arch_3)
 # define IF_HAVE_VM_DROPPABLE(flag, name)
 #endif
 
+#ifdef CONFIG_ARCH_HAS_PKEYS
+# define IF_HAVE_VM_PKEY(flag, name) {flag, name},
+#if CONFIG_ARCH_PKEY_BITS > 3
+# define IF_HAVE_VM_PKEY3(flag, name) {flag, name},
+#else
+# define IF_HAVE_VM_PKEY3(flag, name)
+#endif
+#if CONFIG_ARCH_PKEY_BITS > 4
+# define IF_HAVE_VM_PKEY4(flag, name) {flag, name},
+#else
+# define IF_HAVE_VM_PKEY4(flag, name)
+#endif
+#else
+# define IF_HAVE_VM_PKEY(flag, name)
+# define IF_HAVE_VM_PKEY3(flag, name)
+# define IF_HAVE_VM_PKEY4(flag, name)
+#endif
+
 #ifdef CONFIG_ARM64_MTE
 # define IF_HAVE_VM_MTE(flag, name) {flag, name},
 #else
@@ -250,6 +268,11 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
 IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,	"droppable"	)		\
+IF_HAVE_VM_PKEY(VM_PKEY_BIT0,		"pkey_bit0")		\
+IF_HAVE_VM_PKEY(VM_PKEY_BIT1,		"pkey_bit1")		\
+IF_HAVE_VM_PKEY(VM_PKEY_BIT2,		"pkey_bit2")		\
+IF_HAVE_VM_PKEY3(VM_PKEY_BIT3,		"pkey_bit3")		\
+IF_HAVE_VM_PKEY4(VM_PKEY_BIT4,		"pkey_bit4")		\
 IF_HAVE_VM_MTE(VM_MTE,			"mte")			\
 IF_HAVE_VM_MTE(VM_MTE_ALLOWED,		"mte_allowed")		\
 IF_HAVE_VM_SHADOW_STACK(VM_SHADOW_STACK, "shadow_stack")	\
-- 
2.25.1
