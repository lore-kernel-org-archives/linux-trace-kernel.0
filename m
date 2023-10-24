Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B4262B2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U16Q1nag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CE6C433C7;
	Tue, 24 Oct 2023 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698159179;
	bh=nksVzI2sxDyYwDK77Qh9hxtLz14PivSCoDF4mQ1mj4M=;
	h=From:To:Cc:Subject:Date:From;
	b=U16Q1nagA13WjsyrcYED+UgO0KdXjAHJxAU+n3rpd3ZUpmkIBNkBu3gpqgxL+2XnS
	 QCfnDZMDDr48vspTq6FbzfRkGKiL5iVVJxn7dPKtacOMB3UIYGdNKeMW9zd3NoVf5Y
	 V/BbtVZzMT6VG/GXa0kFIHsDSiQ5Kp8fS+29YN/VyrMTqthZD7upb3D0ly473Oig5L
	 abhyJip2bIy7BvNrl7pJ+nGrVEYaSFq8zciCTTTItv7GQZ2xp1bgbq9QrjJvWDyyU/
	 vaviig+xb8SZlBmHn9g+T8fxT8/gGiRrzU5YTdlWCUdUHfCLnPwGUw+PeRv48tJL1l
	 59OBo/Cb6GHrg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "wuqiang . matt" <wuqiang.matt@bytedance.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	mhiramat@kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] locking/atomic: sh: Use generic_cmpxchg_local for arch_cmpxchg_local()
Date: Tue, 24 Oct 2023 23:52:54 +0900
Message-Id: <169815917362.8695.13904684741526725648.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use generic_cmpxchg_local() for arch_cmpxchg_local() implementation
in SH architecture because it does not implement arch_cmpxchg_local().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/sh/include/asm/cmpxchg.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 288f6f38d98f..e920e61fb817 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -71,4 +71,6 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
 				    (unsigned long)_n_, sizeof(*(ptr))); \
   })
 
+#include <asm-generic/cmpxchg-local.h>
+
 #endif /* __ASM_SH_CMPXCHG_H */

