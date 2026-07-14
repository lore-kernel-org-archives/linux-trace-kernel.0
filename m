Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1F3CFF62
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053393; cv=none; b=TegtsjGunxNlXKTBlF6eKSxuxSh3a9J6EWNCHQZoaPrVsLajoAVW+csVFKRDW5y3VrMOQ3KjKHI9T/vhM7Q/FA2treL5a5AKD6rzvNrnScluOfFrG5Y+3G08yerdeMnTgO9Ch0Ghm3S8WFcbuzzhGyja/3HjtyptzAtRGJkT+Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053393; c=relaxed/simple;
	bh=PlLf3uatOB4V7qqPGolTM2wzfx6QOLYYVgfstlgW/F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+g1f5VdLvLigQM315M6rXu6vkxLMbs+deqHg77gP7LCah31X/xo3RAyjiW4exFz3BLGvYoElry/dRz48SDUpcVwddIL68OF6c9IprkXdnHwHc5wgxPa44BZ8/IOLpuOz8xBJTSRrb0RzTS9ePuSnXWKnWICYQgsNB6Qy3e6GTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtxUn+nj; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtxUn+nj"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c1805b8a7so46527581cf.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 11:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053391; x=1784658191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/HcjDBHsn65ZCZzOohF40VNQnTu2vZZX71z4vh7Fe7A=;
        b=qtxUn+nj2yOaLXO2zhqCCEQWZOcuK2JwB81wvo5O9JN/UkLt2LrJ5W256pSWcbnBJ7
         uuMGNjFYVbHUM9xe4CRaJiXjDwpF6rz5R1QjXPvnUsDcFa3zDhzPaHMH/20h8R94hRxI
         2q2u3868r17JVddrGy9Vht2HRenX/AZj8kpAW3GXJVDkG+zlWSkvA4/ldKtm103PxlnV
         6KaPj5WZuO9uFUdCKndgqLMDdaGH4GjhufT0hdEJ5b60+vWRj/jh/1hVQzypv8V2D69Q
         9/g3FqGjODqs3X4UkD3dJJk1Gb9PYGLWDLuDw7OvsuNQnupk28RB0UfiG/JopIBHzFkp
         YrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053391; x=1784658191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/HcjDBHsn65ZCZzOohF40VNQnTu2vZZX71z4vh7Fe7A=;
        b=sRR5jMGWuY+KGt7BmE2fyXCHdVCJXuHb8r/4w2F7fJSTPKXkJsjnxwKhbZbazza0IL
         oISav2E0ISOAUIdrLq3Kei1SN22yvzD3KtU1dkNHEvRwHXWan49olmBRfHhbOwYZoyhK
         U9ZM06kFMTZ9+7jJgKzUBXrpiDmxY/hYLTKB1pCDk00zkh00xNr8zagxfo4G7M4Xs9ci
         j8PkbtzG31HM+s/mz3lO7dPkQRZrxxQHNnb5dRygHcIzbVv5ehi7Rv0lkHfDZawjhnL0
         CfqxqXnvl3WVhyl1wMHWTcuoMHamV8YSrMzJiUzJz3iaZSDFgVXZujIJk5MLhTd3fOC6
         phzA==
X-Forwarded-Encrypted: i=1; AHgh+RoMtxQtec5LHSEgmQ+jgINLd0KcCU2MkCKuWqfB5hlmfRnfl1LLtnpCrUtlreH12rLZPc0G16+D5215C2C10Id9LO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxJyjYeDmGdlTJ/CsY7Pnyzwpo290NVav995M0r/rvd6pTvh+a
	7AXv2fvtDvkRd1PudI89pVHD0AJnLizsQ7odEESjG39kxNWhH3VkBE3c
X-Gm-Gg: AfdE7clZBXsZJw7a5oOyy8Uh9Ze/oMiz8gtqqMkXqZQetK6ADUAKw9tFCJFpHGa/kil
	tBxdYmBEy8GkS2TqepNS0m8x/2Mu5zkb+wZvrtizQef6VxUjifZDBU/7BTOqCGVcYCwK4Ip43pE
	pzFPCEcO9NWrlDK9prqzMal27IDRranWONTAH7kVGexvhsc1NYlPgv91AOZBJqZ5oWlupy8U3GY
	cM9qd0eBra/P/qNleGtlWuDG5dYkgU2/qVJAvAz+oLneI9BJdHBeCltzDPGXsbsXhXmz1amoawl
	M/Q/RN8WeT1EQouWGq1xJi4SxsAcgwSN0rYAGULRgo0JLOuDgmooxZZUGxswDsbHQjK2hk5x1tr
	9POqA2grxvX4cFhjQPibMRkwyykx4UCAGHHrRFtpX1CVJQNcFhGwCwwCwFN/pU69B99Op2mrlbb
	1pZnMERbXs0cNn43laMOZsI6qq3+K3CQX/YIXmkxqrrGQGS4zZfI8=
X-Received: by 2002:ac8:5cd4:0:b0:51c:7b12:5fce with SMTP id d75a77b69052e-51cbf311623mr144967821cf.74.1784053390733;
        Tue, 14 Jul 2026 11:23:10 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6ed34sm116210141cf.4.2026.07.14.11.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:23:10 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 01/13] arch: add HAVE_REINSTALL_HW_BREAKPOINT
Date: Wed, 15 Jul 2026 02:22:31 +0800
Message-ID: <20260714182243.10687-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714182243.10687-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some architectures can update the address, length or type of an
installed hardware breakpoint in place, without releasing and
re-reserving its slot. Add an opt-in Kconfig symbol so generic code
can offer such an operation on architectures that implement
arch_reinstall_hw_breakpoint().

This is a prerequisite for KWatch, which re-points preallocated
per-CPU breakpoints from atomic context, where the register/release
path (which may sleep and rebalances slot constraints) cannot be
used.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/Kconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index fa7507ac8e13..41b3784e0ddd 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -457,6 +457,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
 	  Select this option if your arch implements breakpoints under the
 	  latter fashion.
 
+config HAVE_REINSTALL_HW_BREAKPOINT
+	bool
+	depends on HAVE_HW_BREAKPOINT
+	help
+	  Depending on the arch implementation of hardware breakpoints,
+	  some of them are able to update the breakpoint configuration
+	  without release and reserve the hardware breakpoint register.
+	  What configuration is able to update depends on hardware and
+	  software implementation.
+
 config HAVE_USER_RETURN_NOTIFIER
 	bool
 
-- 
2.53.0

