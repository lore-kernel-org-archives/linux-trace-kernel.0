Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5627E38422F;
	Wed, 12 Aug 2026 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564516; cv=none; b=Nb76WWAP4XSWOxlsXJOfzyk3WmgyysIocEuZ3/uJ9Ff7VeJO5RMdWO5Fu17K/wy5h7ogl+PHj6rF4op9h9vdsi+o1s804Uo+vidY0kNdueMAwVOMdSW+vAJbdqrJ7R1smKZu+p7cusvmlbL4y1rcgIrtnQiWz0O95dea9dPrjFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564516; c=relaxed/simple;
	bh=30zi1f6+3Yv5qbVwCaeAXB0W0Kv/e0mcTQnQtHv83Zc=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=uLnnQxz0WEqAl51LH7hdL4n4V+NaLEbMgmfi/rsqDblh394agc8PK4VbQfmYX22VM0eFIEg7+YksIRWsf5yXEMCBMrgZnp2fJAaZIDwh5wY9rOQtuXTFAUxj7JoZN0VhMUuNAf12AQajx2zR60kc82bDNdyJKBf8zPGHw1VVxFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOGF4XxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOGF4XxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9B01F000E9;
	Wed, 12 Aug 2026 19:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786564515;
	bh=sbYnK+7+pDJHMoo1674MURaCmvSFhmYBOep1ki8h/o8=;
	h=From:To:Cc:Subject:Date;
	b=WOGF4XxB46SxBEsX7rKAtTuL2RTDHdqAIjtMsuY03eBUQbZy8hnPmeEgClElQZE1c
	 32Q5C29YNl4YoJtA/KcXzHy0uCcD1elPwMxFGZ+QLY3hczKvcnXDD0V/wuFjczVPAX
	 cv+u0XngpvWUaq8xu+oPeyTM4zGFeFu7ecP0gmFQgdq1cKtW7eC/Ex7HDNMxY/yTiI
	 yE5dHoEWubbJimhFYwWq7Au1r3BydkEnvwu4hq30Fqu3BRbOkGKqacJ5yxcAVpE8mu
	 flnmtfDg9SUp56Nlon3q/i8LD1AGFSGwxhFqF/HHSOE1tfP7xu3JEvL9oKkXiDh7vO
	 PtwSkwcpyJ32A==
From: Tejun Heo <tj@kernel.org>
To: Dennis Zhou <dennis@kernel.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] percpu: Drop CONFIG_DEBUG_FORCE_WEAK_PER_CPU
Message-ID: <178656406317.2437052.7257990869957704195@slm.duckdns.org>
Date: Wed, 12 Aug 2026 09:47:43 -1000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

alpha requires percpu variables in modules to be defined as weak so that the
compiler generates GOT based external references for them. This puts two
extra restrictions on percpu variable definitions. The symbol must be
globally unique even when static and a static percpu variable can't be
defined inside a function. DEBUG_FORCE_WEAK_PER_CPU exists to give generic
code build coverage for these restrictions without building for alpha.

MEM_ALLOC_PROFILING defines a static percpu counter at each allocation call
site and thus can't be built with weak percpu definitions, so it depends on
!DEBUG_FORCE_WEAK_PER_CPU. As allmodconfig enables DEBUG_FORCE_WEAK_PER_CPU,
this knocks MEM_ALLOC_PROFILING out of allmodconfig build coverage.

allmodconfig coverage for MEM_ALLOC_PROFILING is worth more than build
coverage for restrictions which only matter to alpha module builds. Drop
DEBUG_FORCE_WEAK_PER_CPU. Restriction violations will now show up only on
alpha builds.

Reported-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/percpu-defs.h |    7 +------
 include/rv/da_monitor.h     |    2 +-
 lib/Kconfig.debug           |   16 ----------------
 3 files changed, 2 insertions(+), 23 deletions(-)

--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -65,13 +65,8 @@
  *
  * Archs which need weak percpu definitions should set
  * CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU when necessary.
- *
- * To ensure that the generic code observes the above two
- * restrictions, if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is set weak
- * definition is used for all cases.
  */
-#if (defined(CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU) && defined(MODULE)) || \
-	defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
+#if defined(CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU) && defined(MODULE)
 /*
  * __pcpu_scope_* dummy variable is used to enforce scope.  It
  * receives the static modifier when it's used in front of
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -24,7 +24,7 @@
 
 /*
  * Per-cpu variables require a unique name although static in some
- * configurations (e.g. CONFIG_DEBUG_FORCE_WEAK_PER_CPU or alpha modules).
+ * configurations (e.g. alpha modules).
  */
 #define DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
 
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -613,21 +613,6 @@ config BUILTIN_MODULE_RANGES
 	 It also records an anchor symbol to determine the load address of the
 	 section.
 
-config DEBUG_FORCE_WEAK_PER_CPU
-	bool "Force weak per-cpu definitions"
-	depends on DEBUG_KERNEL
-	help
-	  s390 and alpha require percpu variables in modules to be
-	  defined weak to work around addressing range issue which
-	  puts the following two restrictions on percpu variable
-	  definitions.
-
-	  1. percpu symbols must be unique whether static or not
-	  2. percpu variables can't be defined inside a function
-
-	  To ensure that generic code follows the above rules, this
-	  option forces all percpu variables to be defined as weak.
-
 config WARN_CONTEXT_ANALYSIS
 	bool "Compiler context-analysis warnings"
 	depends on CC_IS_CLANG && CLANG_VERSION >= 230000
@@ -1053,7 +1038,6 @@ config MEM_ALLOC_PROFILING
 	default n
 	depends on MMU
 	depends on PROC_FS
-	depends on !DEBUG_FORCE_WEAK_PER_CPU
 	select CODE_TAGGING
 	select PAGE_EXTENSION
 	select SLAB_OBJ_EXT
