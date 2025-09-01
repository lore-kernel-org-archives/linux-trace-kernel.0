Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47473224B1E;
	Mon,  1 Sep 2025 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710366; cv=none; b=Oq7ICOc69rGix4OXEIJbsCC6VtyCt+ylK8zLOGS9oxEYXq1pstGYKRAKHmp4d5TAd/1pyUEdlz6HElPq0FtcvEXInc4uD6ViHDIeTagOM+d2GFvB+i347hN9lkJjS0fYjvWIcBAMgQtwY8JNj52cuBGth7e6Fl40G0bHrfNh24U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710366; c=relaxed/simple;
	bh=747fK6P72FtpW8Xa07ErmzcnXoqfZK5W40Qvrzm5FMo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DeJvyXb+hlQoGVZqcVkwjnoRH0FRhjm1rFP2IYoFYggE7idlbrf+iw50CqCCLJsB92JCO4zsE0blfDO5H7JcE3+lKKKuxoi3B87LSnqhGHsuq0F1Rt+vDAqhO8UUz7UXWp3UtCgKQq1DuH42Or4+sN7W5nTpi1opiH42mTmYo5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/L9cw0y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/L9cw0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26255C4CEF0;
	Mon,  1 Sep 2025 07:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756710365;
	bh=747fK6P72FtpW8Xa07ErmzcnXoqfZK5W40Qvrzm5FMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f/L9cw0yZrXERHgTOCzGbXDqwwy7Uvc7K/kcexV6d5LQXVulWsdpMLQtbBZgga3ND
	 VX4DTR70FAT7YBwAFyoC9z1JzIJLVqckRKfnYM6sQngd0croia9bMqhenrd6Uk03Zc
	 mOVgY5njS4dfWqvtLhxCQIuVP/Zaid0xZyQ1rbTUGEppp0JjSrEDcyxXjlGQlCWa7U
	 YNCES8giSF7+gPK93wL1CM3GcBLId+FLfXsJulUEmSHbwx0YuRw/J326t5u6LyrhKx
	 hU7ZDNluohqog/jUfmCC3Ewzf+Z4qwUZPYhsGtm+DCr0RNJFXnfY7ZCLdrjUVPY8Zl
	 liVH6jhqhlIHg==
Date: Mon, 1 Sep 2025 16:06:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: akpm@linux-foundation.org, mhiramat@kernel.org, naveen@kernel.org,
 davem@davemloft.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 02/13] x86/HWBP: Add arch_reinstall_hw_breakpoint()
 for atomic updates
Message-Id: <20250901160602.e25f0107e7b0ef4af1078fb7@kernel.org>
In-Reply-To: <20250818122720.434981-3-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
	<20250818122720.434981-2-wangjinchao600@gmail.com>
	<20250818122720.434981-3-wangjinchao600@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jinchao,

On Mon, 18 Aug 2025 20:26:07 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> Add arch_reinstall_hw_breakpoint() to enable atomic context modification
> of hardware breakpoint parameters without deallocating and reallocating
> the breakpoint slot.
> 
> The existing arch_install_hw_breakpoint() allocates a new debug register
> slot, while arch_uninstall_hw_breakpoint() deallocates it. However, some
> use cases require modifying breakpoint parameters (address, length, type)
> atomically without losing the allocated slot, particularly when operating
> in atomic contexts where allocation might fail or be unavailable.
> 
> This is particularly useful for debugging tools like kstackwatch that
> need to dynamically update breakpoint targets in atomic contexts while
> maintaining consistent hardware state.
> 

I'm also trying to find this interface for my wprobe. So the idea is good.
But this looks hacky and only for x86. I think the interface should be
more generic and do not use this arch internal function directly.

It seems that the slot is allocated by "type", thus, if this reinstall
hwbp without deallocate/allocate slot, it must NOT change the type.
See __modify_bp_slot. Also, provide CONFIG_HAVE_... option for checking
whether the architecture support that interface.

Let me share a patch to wrap it.
I'll send my series with this patch.

From 9813e9d003f4691b5fe408094a02bd9e6a5fa249 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Mon, 25 Aug 2025 19:37:24 +0900
Subject: [PATCH] HWBP: Add modify_wide_hw_breakpoint_local() API

Add modify_wide_hw_breakpoint_local() arch-wide interface which allows
hwbp users to update watch address on-line. This is available if the
arch supports CONFIG_HAVE_REINSTALL_HW_BREAKPOINT.
Note that this can not change the type because it does not release and
reserve the hwbp slot based on type.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/Kconfig                         | 10 ++++++++
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/hw_breakpoint.h |  2 ++
 arch/x86/kernel/hw_breakpoint.c      | 11 +++++++++
 include/linux/hw_breakpoint.h        |  6 +++++
 kernel/events/hw_breakpoint.c        | 36 ++++++++++++++++++++++++++++
 6 files changed, 66 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8e3fd723bd74..bec164bea0ec 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -409,6 +409,16 @@ config HAVE_MIXED_BREAKPOINTS_REGS
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
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ad7a6d139006..ca8331522c07 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -249,6 +249,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_REINSTALL_HW_BREAKPOINT
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index bb7c70ad22fe..b3db25eb613f 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -64,6 +64,8 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
 
+bool hw_breakpoint_arch_same_type(struct arch_hw_breakpoint *hw,
+				  struct perf_event_attr *attr);
 extern void
 arch_fill_perf_breakpoint(struct perf_event *bp);
 
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 89135229ed21..7dfc88ff6cd9 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -278,6 +278,17 @@ int arch_bp_generic_fields(int x86_len, int x86_type,
 	return 0;
 }
 
+bool hw_breakpoint_arch_same_type(struct arch_hw_breakpoint *hw,
+				  struct perf_event_attr *attr)
+{
+	int glen, gtype;
+
+	if (arch_bp_generic_fields(hw->len, hw->type, &glen, &gtype) < 0)
+		return false;
+
+	return gtype == attr->bp_type;
+}
+
 /*
  * Check for virtual address in kernel space.
  */
diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
index db199d653dd1..eb14f9ab5bdb 100644
--- a/include/linux/hw_breakpoint.h
+++ b/include/linux/hw_breakpoint.h
@@ -81,6 +81,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context);
 
+extern int update_wide_hw_breakpoint_local(struct perf_event *bp,
+					   struct perf_event_attr *attr);
+
 extern int register_perf_hw_breakpoint(struct perf_event *bp);
 extern void unregister_hw_breakpoint(struct perf_event *bp);
 extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
@@ -124,6 +127,9 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
 			    perf_overflow_handler_t triggered,
 			    void *context)		{ return NULL; }
 static inline int
+update_wide_hw_breakpoint_local(struct perf_event *bp,
+				struct perf_event_attr *attr) { return -ENOSYS; }
+static inline int
 register_perf_hw_breakpoint(struct perf_event *bp)	{ return -ENOSYS; }
 static inline void unregister_hw_breakpoint(struct perf_event *bp)	{ }
 static inline void
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 8ec2cb688903..473a5b76941d 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -887,6 +887,42 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
 }
 EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
 
+/**
+ * modify_wide_hw_breakpoint_local - update breakpoint config for local cpu
+ * @bp: the hwbp perf event for this cpu
+ * @attr: the new attribute for @bp
+ *
+ * This does not release and reserve the slot of HWBP, just reuse the current
+ * slot on local CPU. So the users must update the other CPUs by themselves.
+ * Also, since this does not release/reserve the slot, this can not change the
+ * type of the HWBP.
+ * Return err if attr is invalid or the cpu fails to update debug register
+ * for new @attr.
+ */
+#ifdef CONFIG_HAVE_REINSTALL_HW_BREAKPOINT
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	int ret;
+
+	if (!hw_breakpoint_arch_same_type(counter_arch_bp(bp), attr))
+		return -EINVAL;
+
+	ret = hw_breakpoint_arch_parse(bp, attr, counter_arch_bp(bp));
+	if (ret)
+		return ret;
+
+	return arch_reinstall_hw_breakpoint(bp);
+}
+#else
+int modify_wide_hw_breakpoint_local(struct perf_event *bp,
+				    struct perf_event_attr *attr)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+EXPORT_SYMBOL_GPL(modify_wide_hw_breakpoint_local);
+
 /**
  * hw_breakpoint_is_used - check if breakpoints are currently used
  *
-- 
2.43.0


Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
