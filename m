Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795587409;
	b=av1qOnwgbKJ/MDK4tfAV1JOyhecUxqy0qhselt6HdcKIzUNicD6e0TsBk76sJ87rvIBg
	 4k6Raqxy3ESidwNt6en3nyw04aRJeBYsQ/PAS7HMtr52EQttAJMF+U49ndv01LXsdKZjd
	 EJYFPFu3swqrBMC30Wp9BvlYSP7INkKtBqH/2YyKUa2RJvYPGJnMvgKTH/oQyYaB3OqH0
	 zODKdNinq72KXML/6YAfOJRlSHG3mDYveC2Oc73gN1IJe7YcWRe1KQXps8/3j4n0a1nqy
	 wy8S7kJ2wAW1216U6WUszj1c+0/JUjnAbC9cU2bdb1jrGuaYfh6fzfa9toG/NQRgWWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795587409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=XJ5Bj2HUeqnSIN+0jmezTl4ea1LIGCfrIoPbd+y7XVY=;
	b=4MhVg77D+MLCTWkTvs5FrFcmpAmAbcSIy4tIck1CSmhG90MSZh5chA8klGyJTHIIfqnb
	 kLfR9vie2HE+EjL1TV+xUJ+enF1+SVHaPHR2d+UA4zqnC98wArY4QJ19B7g5yvw8/A+0x
	 oA4fGjyick4jhKQn/YE0fuuoaf7BQ/GrZfj6sRCz3vLu7CxbqzKNCSiRPwVNq++gt/H2B
	 OELCLQD/+odHJGS8H8ExESQczt6NQ4TdzFbvhZUrig28pmcSK7zCPO8iOH6TchE4YGapP
	 b4peDFpN6Zad9/7gCYlNyfSfPNrhlgzLDbZorkBb+l4LgwUU0UlWZomfmu7oR6rgFzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gsUjsxJz;
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BD607AC03
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 06:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A7BD607AC03
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=gsUjsxJz
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso5633008c88.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 22:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795587407; x=1796192207; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJ5Bj2HUeqnSIN+0jmezTl4ea1LIGCfrIoPbd+y7XVY=;
        b=gsUjsxJzxqbgYYkDSx9uXucgzZ5AeLgCj1D+KrrG5svWAHGAA4GODKnBkdm2Tiv0gw
         IiEI8E4vsnQ8k65vGaOpqpaPHJU2pdFcUZ+qRJJkHZMcQqdZrL/aHRGUTQByUqNhq3iT
         1Qd8suAqAONYzmciLD0Mk+aC8VP5TFpaUhgE+sA4LrXZhYf+MBCiCmdLf29PGauN2aOE
         GCUoHTMbh4CM0Nmm6dR/fHc2oH5cc2tfVHxQL2eg6dFmMAl+tMcuL88x9zhB+mXBHqkm
         wCKYstkzIyLefoBkh8OJrGXanJDHjoZT3IVpJHybG1NAjyBmGwy+nPKPqVhFeRJzMK4I
         3pMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795587407; x=1796192207;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJ5Bj2HUeqnSIN+0jmezTl4ea1LIGCfrIoPbd+y7XVY=;
        b=UIo9Xpb625hHWUoEVZw/HzmwusBnVcOTozCGjrDjRYPvNMUjgXJL889SldEQ3Ud3hU
         HXxXdlK3kOeIB99JaRtw9Z+jysmmkUYGqf9475f+FRs8he1QYUW3QrZKWCYH1fp+b5mH
         k8n3mktwq6cmaMcPDQvnZP3WbXoviuNYdkAEoadiBmzP9rgvAgg3rKx8bLIKKhH0X2Uo
         oYDbq95XJDon+X4eFacenP43KOQGSOvlZQAlejUPtP0GGH/EdptXKEr75zmKoFnRLdIh
         jM4BfYq/oeLLq0OxNYU9s+qDvdflOfhWCmBKsLBlpPe1fmHiqpymunDCdtNvuumOV1Tr
         gekg==
X-Forwarded-Encrypted: i=1; AL+hErG2SFNhA+aGduutOJAZ9X2XtKFu1ZQArZ0dtTys/CWl7wv+Dfc5WkgGccsjj+L8cBBbDKwOVdac8TuD9tzvfKQw918=@vger.kernel.org
X-Gm-Message-State: APuU4Z8NpexYL5yE7fIo8NoRcJt2xo/4L6TpTSGlc0aNyQf9+EUT/xOi
	9OrypSLGlBYC/e2w2rIPTk27qE8FotvUHkqY1duBPvkD146NWI1M43Uw5UOxuF89sjfxKNUpTsd
	1ClWXUyqt9A==
X-Received: from dlar8.prod.google.com ([2002:a05:701b:21c8:b0:1b5:345d:ed30])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:cc88:10b0:151:6e80:ba7e
 with SMTP id a92af1059eb24-1b5567dcec1mr15970822c88.4.1795587407220; Tue, 24
 Nov 2026 22:16:47 -0800 (PST)
Date: Tue, 24 Nov 2026 22:15:18 -0800
In-Reply-To: <20261125061523.1540234-1-irogers@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125061523.1540234-26-irogers@google.com>
Subject: [RFC PATCH v2 25/30] tools include: Add linux/uaccess.h stub for
 userspace tools
From: Ian Rogers <irogers@google.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org
Cc: jpoimboe@kernel.org, rostedt@goodmis.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a minimal tools/include/linux/uaccess.h providing a no-op
might_fault() stub so userspace tools under tools/ can compile shared
kernel code that includes <linux/uaccess.h>.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/uaccess.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 tools/include/linux/uaccess.h

diff --git a/tools/include/linux/uaccess.h b/tools/include/linux/uaccess.h
new file mode 100644
index 000000000000..5a9e6bf4cfb5
--- /dev/null
+++ b/tools/include/linux/uaccess.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+#ifndef _TOOLS_INCLUDE_LINUX_UACCESS_H
+#define _TOOLS_INCLUDE_LINUX_UACCESS_H
+
+#ifndef might_fault
+#define might_fault() do { } while (0)
+#endif
+
+#endif /* _TOOLS_INCLUDE_LINUX_UACCESS_H */
-- 
2.56.1.831.g720f3f5937-goog

