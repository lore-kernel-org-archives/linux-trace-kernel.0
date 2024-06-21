Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840316D33A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966140; cv=none; b=T6bmt5lZAUoFSq2/+Zrk28fbM7bigwO5dT1VQHe8pDwf5PDOHbSQNER2NJVkniFL8uLY8TrBky5hQJ77NHwb5H3BdjHsq3NX1nSDl4iHFfIsO+2UlGtQe9F/FXV7dq2N3jfb80ztpWjS6LKv6cDLFX9654aPD9RbinBiT8x/6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966140; c=relaxed/simple;
	bh=IyJYxPljI7iFl5u4Sih+kt1htjoHEPPM9Rn03F/wALY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q6C1I6kawCDloMfrSxK0gBorPNTp9FjELShst+QumT2/5OjgCZwVmyJ+CZY2FzEDi4dyitwRp9v/R/gzEFptjA5VPUcVfLv++uYTPhxkk4w+IsVYJo9Vd7w7l3BgxZonswmFAf97zaPF7xYD7uLapPdFBBqLDXbetKxN+YOrj7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T6LNg8sY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6LNg8sY"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62d032a07a9so31660937b3.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Jun 2024 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718966138; x=1719570938; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPfiWV/WIDacLf3rDcewrodB4jCLD8RHBJ9128vNrBo=;
        b=T6LNg8sYXT0B6ZfmVsDAslYELbynxDq2/npLkMLRUmAbrEt6oSYMVW/gzir4seetSg
         MIi7+RKgaR+xCtyAN3U1B8B34et0Qcj+/D/piq+8ZsrVVmU3yZmYlD3p4TWtIUYxd9Zx
         +bJs3oTBUGwla9LWTbPKRrzqfEDqrGrso5txnDDEnJQw5NkVdJjNnOEvxFQGUTMl1kp5
         YvfBDzZXyJD/sWT2a1gbi3cTaJasI1/3+2PFokqH4WujndANvHaw6UcXNsOm4V0ks8dB
         H2bMwLO72lgM09yuq0s5jQaJZ5R/gRokHyXv2ULNgDg9VKNNTrQ2aYZXOAxOqIev2NQI
         117A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718966138; x=1719570938;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPfiWV/WIDacLf3rDcewrodB4jCLD8RHBJ9128vNrBo=;
        b=ahnTNPazQ2OkLqn8CwEMOV6PQQMBu7eUqFH9VX1A+kFcfbS8wAp8ymqTNJ+u2Hfl8J
         8FDrFDf5Ofq7lGUAOE5dKd42OATbmY1YBpYYIClSLShU2n3rR06cOa5lt3uvBJlXPopB
         id/UNsG6SxeDt7iPUR7gBNvRLdE9SGaqvad9h1gJRGbpBQ54NZcIJBemXQj+Nq8o4Ul6
         NvJ0WElBw8DaONy8u8Unw6bAEkWZA19cBVDKbvFSFACD2hSNJCa1K3aCMY6aAWs6BllV
         LRLN08c44bXWH7cJXce7GpqdZRsB1ZkR5SK5Q5M4KD5nTYJOvJKsgikpdPlsL50xUf3G
         HVkg==
X-Gm-Message-State: AOJu0YwTOaWZuxnYLxLtLTpDJj4QMD8eKXcawc4uW0N1ZzIma/a8VI0T
	1XUjhuYk4rHw/QDRE2/0VbzIFSsUDFOvtJhEfnxHzvr4fAGC/aIvAMmLVNzjB3EE0wJnEeYrdot
	v6xXlwkb5kEpigA==
X-Google-Smtp-Source: AGHT+IEIDTsMkz3eJ+kNm6sUuA+LJREhP07E+V4i0dphDRkHWr5SOOvLH7WwR2zXCO6wCAOIFvMK2RsUDDwSB9c=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:338a:b0:61b:ebab:ce9b with SMTP
 id 00721157ae682-63a8e1d8effmr12105287b3.3.1718966137658; Fri, 21 Jun 2024
 03:35:37 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:35:27 +0000
In-Reply-To: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621-tracepoint-v3-0-9e44eeea2b85@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5679; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=IyJYxPljI7iFl5u4Sih+kt1htjoHEPPM9Rn03F/wALY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmdVdwr7eAzVR1TABESJh6WnzNzHO+UsGRmHWB7
 zZQ2rdVQmOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZnVXcAAKCRAEWL7uWMY5
 RktPEACMeNTuMAZDjkYKloCPhZmi/TrriD3pmJ316f5tfvrNF25GNmXjTU+QxgELUvMydx9PjHa
 t099GbcRYhqhUB8MGL5mR54izLApuwlSax7utmXsZBSWwzFgODS6RB1E5CmmVaVa/43CIeWl/9F
 AAZLhJFvj/s1OYYL1o2e1C1ie6ynkT9l+Pz/Pxx+zj9eDrlkjNILOtIYgDVgPnXjm2fAwATTXdo
 5x12jjPdngbCzcDzdqtBypT4onSGG5U0d3R4PCuDmk+7KOiVr9gnp5bDCgo4rQ0IPdD/5iYLTrx
 CECGf1VGPx2ixM8dLNbKZ/U1lm9pc7rtQXwjHIKNCJo+X9lJBWf7oCa7sRdt9sGzHsE/odgyMEq
 q/zDj6peeHzYeGTBOZfCDfH8vp2kypI45V9Gx3agh1mc5g1df8bvOM/YDYt5+AW4ThZ3ycew9bf
 6X81xruz0jYrfBQtnxu3z3lnAAjRJ0Frf3Yc0ysqZeIuvY0fPhoeAJoTUwwRqR8gxYftkw0fCP4
 f5860Ud/7QQ4OZZRLJmTMG70HNWpqm4gOjCYT4jYlF+91EGJBJ08bbUlBz7uKAkq/+85UdT68tS
 AcoT9PdzOJ9OPTmJxOWypTYt3rU7EJR+1a+BxCD4oEJCC5DV61M2meTCfg9uv7CyFyNdzgE+A/m GGK2ylrDOUL+AjA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240621-tracepoint-v3-2-9e44eeea2b85@google.com>
Subject: [PATCH v3 2/2] rust: add tracepoint support
From: Alice Ryhl <aliceryhl@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Make it possible to have Rust code call into tracepoints defined by C
code. It is still required that the tracepoint is declared in a C
header, and that this header is included in the input to bindgen.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/tracepoint.h      | 18 +++++++++++++++-
 include/trace/define_trace.h    |  7 ++++++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/tracepoint.rs       | 47 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 689b6d71590e..d82af4d77c9f 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -238,6 +238,20 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 #define __DECLARE_TRACE_RCU(name, proto, args, cond)
 #endif
 
+/*
+ * Declare an exported function that Rust code can call to trigger this
+ * tracepoint. This function does not include the static branch; that is done
+ * in Rust to avoid a function call when the tracepoint is disabled.
+ */
+#define DEFINE_RUST_DO_TRACE(name, proto, args)
+#define DEFINE_RUST_DO_TRACE_REAL(name, proto, args)			\
+	notrace void rust_do_trace_##name(proto)			\
+	{								\
+		__DO_TRACE(name,					\
+			TP_ARGS(args),					\
+			cpu_online(raw_smp_processor_id()), 0);		\
+	}
+
 /*
  * Make sure the alignment of the structure in the __tracepoints section will
  * not add unwanted padding between the beginning of the section and the
@@ -253,6 +267,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	extern int __traceiter_##name(data_proto);			\
 	DECLARE_STATIC_CALL(tp_func_##name, __traceiter_##name);	\
 	extern struct tracepoint __tracepoint_##name;			\
+	extern void rust_do_trace_##name(proto);			\
 	static inline void trace_##name(proto)				\
 	{								\
 		if (static_key_false(&__tracepoint_##name.key))		\
@@ -337,7 +352,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 	void __probestub_##_name(void *__data, proto)			\
 	{								\
 	}								\
-	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
+	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);	\
+	DEFINE_RUST_DO_TRACE(_name, TP_PROTO(proto), TP_ARGS(args))
 
 #define DEFINE_TRACE(name, proto, args)		\
 	DEFINE_TRACE_FN(name, NULL, NULL, PARAMS(proto), PARAMS(args));
diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
index 00723935dcc7..b47cc036acba 100644
--- a/include/trace/define_trace.h
+++ b/include/trace/define_trace.h
@@ -72,6 +72,13 @@
 #define DECLARE_TRACE(name, proto, args)	\
 	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
 
+/* If requested, create helpers for calling these tracepoints from Rust. */
+#ifdef CREATE_RUST_TRACE_POINTS
+#undef DEFINE_RUST_DO_TRACE
+#define DEFINE_RUST_DO_TRACE(name, proto, args)	\
+	DEFINE_RUST_DO_TRACE_REAL(name, PARAMS(proto), PARAMS(args))
+#endif
+
 #undef TRACE_INCLUDE
 #undef __TRACE_INCLUDE
 
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ddb5644d4fd9..d442f9ccfc2c 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/refcount.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/tracepoint.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index a0be9544996d..96f8f11c51f2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -45,6 +45,7 @@
 pub mod sync;
 pub mod task;
 pub mod time;
+pub mod tracepoint;
 pub mod types;
 pub mod workqueue;
 
diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
new file mode 100644
index 000000000000..1005f09e0330
--- /dev/null
+++ b/rust/kernel/tracepoint.rs
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2024 Google LLC.
+
+//! Logic for tracepoints.
+
+/// Declare the Rust entry point for a tracepoint.
+#[macro_export]
+macro_rules! declare_trace {
+    ($($(#[$attr:meta])* $pub:vis fn $name:ident($($argname:ident : $argtyp:ty),* $(,)?);)*) => {$(
+        $( #[$attr] )*
+        #[inline(always)]
+        $pub unsafe fn $name($($argname : $argtyp),*) {
+            #[cfg(CONFIG_TRACEPOINTS)]
+            {
+                use $crate::bindings::*;
+
+                // SAFETY: It's always okay to query the static key for a tracepoint.
+                let should_trace = unsafe {
+                    $crate::macros::paste! {
+                        $crate::static_key::static_key_false!(
+                            [< __tracepoint_ $name >],
+                            $crate::bindings::tracepoint,
+                            key
+                        )
+                    }
+                };
+
+                if should_trace {
+                    $crate::macros::paste! {
+                        // SAFETY: The caller guarantees that it is okay to call this tracepoint.
+                        unsafe { [< rust_do_trace_ $name >]($($argname),*) };
+                    }
+                }
+            }
+
+            #[cfg(not(CONFIG_TRACEPOINTS))]
+            {
+                // If tracepoints are disabled, insert a trivial use of each argument
+                // to avoid unused argument warnings.
+                $( let _unused = $argname; )*
+            }
+        }
+    )*}
+}
+
+pub use declare_trace;

-- 
2.45.2.741.gdbec12cfda-goog

