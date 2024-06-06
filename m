Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAEF19CD0C
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686363; cv=none; b=EF5k9A67TsVZi2CfWNOOCZ8AWLyO7jEYdALTO9fYjBrF3LDJjbQ30redL3xN8ABXDxZ9LIsFnn1qAEOlW2dig7doA7t+3HiczUvAw5iXmmkRny59wmeXB38JOcQdcIV0z92VX9TQWcR1ept3OTxMXhq8kn0+kY78J6kFXxRaT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686363; c=relaxed/simple;
	bh=xxnCkS/98mK/H9Sz+c63sGlDPQKDxAYAQZLVvfkC5Lc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eIUEmeC39XAGAUG6BNXKnuzuSVr8RQGSsoWTw41++TdeZtmkCGBuJtnADMazMM8NkfTzvhWfmDPQbnHGnDYkNtuV/fp3XkfV7PyJuoplSlhSbws640CDeksLn3OKk0aIFTSPqFNiPRxJJd+pd1UgN8j7xrGwYwpGQIFeVnF+akk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nD1Mkbwp; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nD1Mkbwp"
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-52b890339d9so885494e87.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717686360; x=1718291160; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtYQY0bIVsBsFhO8mlkrQxri1pzuLKr+k7DZn7Q0yvI=;
        b=nD1MkbwphI/G60UdeNnNsl/dGxA+/mGRee3KdoMRifhE7ZsV9PiFnZCISxOsLia3DE
         Fa0SG+vr6jZNS0fp6+9j5GKGuUSV4z54a1G/pGs9mCshNqhthHfwgj4W2VKVsXANzwo5
         xwWjj7Wxn1SVsPwUbfsnyvMVHGKyw1kaapxDtwM7J1/+fYEyPIpzkuzOHJAQUuqTf2Dd
         A0E9VnsY7TVSW98Rit+gHvx0TDF4ZvrG6/4gXzdftNc8Mdp7uaaQP1/WakDTushXdXsQ
         K/oGg3OVfZtxNSvSn1oWV0HjPc5iOF1wuZ2uM58cZOyrZ/+aLlVPXYKlq/KA9/hcJz97
         4Y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717686360; x=1718291160;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtYQY0bIVsBsFhO8mlkrQxri1pzuLKr+k7DZn7Q0yvI=;
        b=eTltMCe2WoJ87jun2kwANy3oJ9RiP24JwzgwOLnUzSWlkXxo9I5pQ/wgrfNtbrE0F5
         Q3KrNVSL4BvX00w75A73xZxRwSIw9VrZwZSw5DhEB/vya0adD+ghrSgyVmG0uY7cJsGP
         wBTOBgWFpl6UNMxIc0wE0nHZc2DwejSasG6R78BWJYw2ZxqznpkczUUb3w1UZoviH7LB
         BxKL/FCnk8Pa8r2Thhk2p5U4WQGFTW9HbWdbmK+ZiAJOgpJs+4JM5JpbZBpvWPr5bOoa
         0Lh1lTQBn41x6QC6szckeBcIEXDNA4Z8Q5qrlL6Js1AzNIuXQJtPxH356TFCJLt8XSXq
         Dswg==
X-Gm-Message-State: AOJu0YzBVP/9ISjc2WEgC4EQxqkTQP3ylmkdNrZlsXXtx5I7wg7VYn3e
	Xd7XJ7+MRIm3HxhNALM82wYrsSiuA1VkOGIPUG6B03l4gFqF4Sj0Kqih9lc2RIuaT3inT6rb7D+
	3VuZBa6p06eyn+g==
X-Google-Smtp-Source: AGHT+IE9ZAzKt5UqrFi1ej+90Nb7hUWgketJ9SlKdTM+irVsqHe00KvF/rNPKaJv0vNPmhAXSajuowviVyVSB/0=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:4f09:0:b0:52b:9d7f:8517 with SMTP id
 2adb3069b0e04-52bab263d38mr7361e87.0.1717686360110; Thu, 06 Jun 2024 08:06:00
 -0700 (PDT)
Date: Thu, 06 Jun 2024 15:05:26 +0000
In-Reply-To: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6676; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=xxnCkS/98mK/H9Sz+c63sGlDPQKDxAYAQZLVvfkC5Lc=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmYdBL2CIIJl2CpYfykmTKCky6PbMRvEedW7O7S
 MZG3XbAIxuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZmHQSwAKCRAEWL7uWMY5
 RhtMD/49T1do6ynz2d0b63kf8ow7WWy0FfOSHhGjzIGqd5oYTDDT1T/mtiNYwioMn/WFLHxIBq7
 /O7XVNSQHtiv0FnEuV91hRRPE3Ni6G9WHPXttZ/F9l+yA1HcGbAxGe3GV6RjrSZboh0qrudTFZu
 b6797/0YeBO7ZBwrjoyS3Be3BZR0Aa4PhHt3ZnMIx+K9PJ7dRdd24mLC2e6Qkga5Ph2O2osbRJG
 YCR6aGk1VvrlQiFWeMZHEBpNtgiI0L29GOZZbnu9YUORwXNPcUacHdztBboFPma6rQ9AiYrspV5
 oeCr6LGBqUiRiZ73SAY3umK+AUlDCcHH9hNvf5G7CMRcYJtHly8r92KeMpv//ZTx2AnpfnE3V3K
 fgn8AIbfoHzlMy48j6LU/o4KoVYeyNbC7He042Ep/C0NsAc5Fxls8MqqcpkWhHOHbRFn/aY0yGX
 B4REuSZOMHNRvRO46QCgJBYj+nkxeFinxKlTJJhxiewYwwbAa37s0uL4L77eLts4W2H+XOe4Owe
 iMYKrYPnjc3p5TXGExNU33X4fr6XX2nJW5cEilQddtDIVPlyG7r35w2x5fk/omzbaN28enIVmOW
 iTXEens9LAYAueMMU7/WuJ/UPanksI2+atmsCOfRoH55E8NVhposB/c7dUYk0N2ltu4VeLgnU7e 4Sof8vQag3PuaJA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240606-tracepoint-v1-3-6551627bf51b@google.com>
Subject: [PATCH 3/3] rust: add tracepoint support
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
 rust/bindings/bindings_helper.h |  1 +
 rust/bindings/lib.rs            | 15 +++++++
 rust/helpers.c                  | 24 +++++++++++
 rust/kernel/lib.rs              |  1 +
 rust/kernel/tracepoint.rs       | 92 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 133 insertions(+)

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
 
diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
index 40ddaee50d8b..48856761d682 100644
--- a/rust/bindings/lib.rs
+++ b/rust/bindings/lib.rs
@@ -48,3 +48,18 @@ mod bindings_helper {
 }
 
 pub use bindings_raw::*;
+
+/// Rust version of the C macro `rcu_dereference_raw`.
+///
+/// The rust helper only works with void pointers, but this wrapper method makes it work with any
+/// pointer type using pointer casts.
+///
+/// # Safety
+///
+/// This method has the same safety requirements as the C macro of the same name.
+#[inline(always)]
+pub unsafe fn rcu_dereference_raw<T>(p: *const *mut T) -> *mut T {
+    // SAFETY: This helper calls into the C macro, so the caller promises to uphold the safety
+    // requirements.
+    unsafe { __rcu_dereference_raw(p as *mut *mut _) as *mut T }
+}
diff --git a/rust/helpers.c b/rust/helpers.c
index 2c37a0f5d7a8..0560cc2a512a 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -165,6 +165,30 @@ rust_helper_krealloc(const void *objp, size_t new_size, gfp_t flags)
 }
 EXPORT_SYMBOL_GPL(rust_helper_krealloc);
 
+void rust_helper_preempt_enable_notrace(void)
+{
+	preempt_enable_notrace();
+}
+EXPORT_SYMBOL_GPL(rust_helper_preempt_enable_notrace);
+
+void rust_helper_preempt_disable_notrace(void)
+{
+	preempt_disable_notrace();
+}
+EXPORT_SYMBOL_GPL(rust_helper_preempt_disable_notrace);
+
+bool rust_helper_current_cpu_online(void)
+{
+	return cpu_online(raw_smp_processor_id());
+}
+EXPORT_SYMBOL_GPL(rust_helper_current_cpu_online);
+
+void *rust_helper___rcu_dereference_raw(void **p)
+{
+	return rcu_dereference_raw(p);
+}
+EXPORT_SYMBOL_GPL(rust_helper___rcu_dereference_raw);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 22e1fedd0774..3f3b280bb437 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -46,6 +46,7 @@
 pub mod sync;
 pub mod task;
 pub mod time;
+pub mod tracepoint;
 pub mod types;
 pub mod workqueue;
 
diff --git a/rust/kernel/tracepoint.rs b/rust/kernel/tracepoint.rs
new file mode 100644
index 000000000000..d628ae71fc58
--- /dev/null
+++ b/rust/kernel/tracepoint.rs
@@ -0,0 +1,92 @@
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
+                // SAFETY: This macro only compiles if $name is a real tracepoint, and if it is a
+                // real tracepoint, then it is okay to query the static key.
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
+                    $crate::tracepoint::do_trace!($name($($argname : $argtyp),*), cond);
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
+#[doc(hidden)]
+#[macro_export]
+macro_rules! do_trace {
+    ($name:ident($($argname:ident : $argtyp:ty),* $(,)?), $cond:expr) => {{
+        if !$crate::bindings::current_cpu_online() {
+            return;
+        }
+
+        // SAFETY: This call is balanced with the call below.
+        unsafe { $crate::bindings::preempt_disable_notrace() };
+
+        // SAFETY: This calls the tracepoint with the provided arguments. The caller of the Rust
+        // wrapper guarantees that this is okay.
+        #[cfg(CONFIG_HAVE_STATIC_CALL)]
+        unsafe {
+            let it_func_ptr: *mut $crate::bindings::tracepoint_func =
+                $crate::bindings::rcu_dereference_raw(
+                    ::core::ptr::addr_of!(
+                        $crate::macros::concat_idents!(__tracepoint_, $name).funcs
+                    )
+                );
+
+            if !it_func_ptr.is_null() {
+                let __data = (*it_func_ptr).data;
+                $crate::macros::paste! {
+                    $crate::static_call::static_call! {
+                        [< tp_func_ $name >] (__data, $($argname),*)
+                    };
+                }
+            }
+        }
+
+        // SAFETY: This calls the tracepoint with the provided arguments. The caller of the Rust
+        // wrapper guarantees that this is okay.
+        #[cfg(not(CONFIG_HAVE_STATIC_CALL))]
+        unsafe {
+            $crate::macros::concat_idents!(__traceiter_, $name)(
+                ::core::ptr::null_mut(),
+                $($argname),*
+            );
+        }
+
+        // SAFETY: This call is balanced with the call above.
+        unsafe { $crate::bindings::preempt_enable_notrace() };
+    }}
+}
+
+pub use {declare_trace, do_trace};

-- 
2.45.2.505.gda0bf45e8d-goog

