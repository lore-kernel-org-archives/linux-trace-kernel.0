Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56422882C5;
	Thu, 28 Aug 2025 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413441; cv=none; b=SWdDfwnA8X0DRvPZoYY8tbAl4AakDIkf7nzSSmrMZC7WYjiQVnrfl+Te3NYzCG9wg5Qn8UJMnK6Cc1H/vL3rlytLxi3ho/x8lstfvZqz2zDvidxXdkYef2rYvGV6KyAyqDj6qqs6fYYr+su0KEZLeKUQEtbUtD31j46oBuCmjk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413441; c=relaxed/simple;
	bh=6peswoOhdw7dXI0cwkW9pPp7bgdjqqT10/tl3qs06UY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eiOTuTFBWPHRVPUmXJ7zdK3c3I3CRgsc2kE2Rj7Bdy6ymwtJmjczgp9XQD4wTySZZNa4xU09YaXrUb+rU90GCAs9qf2X7d9O8g31PptZty7GdUPrd7hQPsmEqQBKRWQhTJyYf/aeaAqnbnsBf0Qg53jPB8gtSestIajemmi6sPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCFdQEt2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCFdQEt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78220C4CEFA;
	Thu, 28 Aug 2025 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756413440;
	bh=6peswoOhdw7dXI0cwkW9pPp7bgdjqqT10/tl3qs06UY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=vCFdQEt2fAjKXh9vIK+lJTWXS/p72u6+hE2OqBO5ccAYuseJC+nxE/bohoa0t5GY8
	 hSSZH5i4luo+NfXXUrKRIMTdOS0KbQ0tvP5Ga11Nl9ARzpjfQSFFUwF2ECmtWECQQG
	 JfuSQxD2N+/RFM5x2O+tIG1wBuvv64oavaoK/fKZ6Ubkcy7i0tJ5jsu9vaZ+H38/Rn
	 smgvYv9+nQh/gn68hnufhIoU8T/axbjTF/Ij/uyRJzS+FpwUdR6Ct8pEFE7ycvQV1G
	 sh8sm6ZuM8DSJkkM+R+i75ieSVSLiYgCI12VWfEggqGzTL5VOUzQqf86CFgJZj+5Ic
	 ljDWLHGCe01TA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1urjNN-00000004JTH-30eM;
	Thu, 28 Aug 2025 16:37:41 -0400
Message-ID: <20250828203741.571495248@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 28 Aug 2025 16:35:58 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v8 3/3] tracepoint: Do not warn for unused event that is exported
References: <20250828203555.783399758@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There are a few generic events that may only be used by modules. They are
defined and then set with EXPORT_TRACEPOINT*(). Mark events that are
exported as being used, even though they still waste memory in the kernel
proper.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 71d2e085c49e..ec6827d00d79 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -223,8 +223,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 
 #ifdef CONFIG_TRACEPOINT_WARN_ON_UNUSED
 # define TRACEPOINT_CHECK(name)						\
-	static const char __used __section("__tracepoint_check") __trace_check[] = \
-		#name;
+	static const char __used __section("__tracepoint_check")	\
+	__trace_check_##name[] = #name;
 #else
 # define TRACEPOINT_CHECK(tname)
 #endif
@@ -381,10 +381,12 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	__DEFINE_TRACE_EXT(_name, NULL, PARAMS(_proto), PARAMS(_args));
 
 #define EXPORT_TRACEPOINT_SYMBOL_GPL(name)				\
+	TRACEPOINT_CHECK(name)						\
 	EXPORT_SYMBOL_GPL(__tracepoint_##name);				\
 	EXPORT_SYMBOL_GPL(__traceiter_##name);				\
 	EXPORT_STATIC_CALL_GPL(tp_func_##name)
 #define EXPORT_TRACEPOINT_SYMBOL(name)					\
+	TRACEPOINT_CHECK(name)						\
 	EXPORT_SYMBOL(__tracepoint_##name);				\
 	EXPORT_SYMBOL(__traceiter_##name);				\
 	EXPORT_STATIC_CALL(tp_func_##name)
-- 
2.50.1


