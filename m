Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C23824A7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028108; cv=none; b=LbPuBaTpGnsrGTro2oN8isUOUzAsL0o9ye46cHMu3aOx9AxpaJf4OUbMNCi2bq1mVqv/eT7jM++gqAFxmhoy7SNI2j2L1P4HJ1UcP6Yt54dzeqDPXl86YM7Ez8RdCBCMCJFaM7Sl2/x93ILZO0CuxVbggUHvhO+vB9MCvsWHuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028108; c=relaxed/simple;
	bh=Z2r4JGubuZTdUYkcXudmGtwYZDpyKW4PXLdrjsGb33s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fs81NvCLAwJb+RFxuNJDnRGBhIdMfONjMTrJlx+j4W4H2viCmY8m7/x56gKcpUq1/a5HQkaXuHFwuKKsgi9/rjeYNksJGze2EtbavD9r8rPhyVspDcFoBF9qXYGgJjx7U8A/7mIfStykrNtjl23bW3f3BtMcJNppAF4d8o8Ax9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lF1te1Dz; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lF1te1Dz"
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-52b998cb52eso3471616e87.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718028105; x=1718632905; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1qygvqO2cQy0oabdJmPrTdFKpbyXplDOUqD4kgYMJj0=;
        b=lF1te1Dz4uyzmS2JtsWP/mcnwnIzjvl8KrntdEIgG6qmL2NiOsvuXtjkT/fipdM/56
         THYJbCTVF23rle6lMQxWvCDAPsJ33+m3hTP37ikzmsP7MoFrVrpLWYank2Woff80Wg+r
         /OJ2uvskQzd2ciu6hs7gd8JGljpzgcHMGoNO6P/ezYJOVlWUxx0ixnxoAJrP8wtFdXmj
         7uKVrR2xqPdk0/muqqv2AXaXlCOBeTJVCLhPIotMKAD2qPf/jaQiupIozpSLKSaMh45N
         Kj36OEqMwTey6hnYIRf4Fra82biSjKd+eFDrnlv3jQCgabOW1T08TczPbtSuio2yeYda
         o+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718028105; x=1718632905;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1qygvqO2cQy0oabdJmPrTdFKpbyXplDOUqD4kgYMJj0=;
        b=Z+yvvaTCTfhbB+fGanBe46Zv+pkEyA2Zz3ix6m+3zRYttgXfzUyXf5bExw5hFP42Vh
         7I0Vhe9ec/S2w+M9y1VtvHuMJIK17G20f+o2NleSp0kkg4wCkqlOXsUbhBIzxOs6DDCz
         yTDTrUtkUo/qoJz6eGWqc4hlioZmrXpXdKhz5BvwByuQRupRmB5QFDi0tFZ+uggT2+TF
         8er4GZLV5JvMz5ZtVYsUpe+348yLPN1e+kx1qApHsoUOcY0Pdo9oD9vkr0CjEecqDauj
         BWbVsDEWZyGvqlw0758lQs05WXfZExNrSDOC9Tiu+9hQVxbBeCFX4UVpr4wKHzHs60hz
         HS4g==
X-Gm-Message-State: AOJu0Yw5I/k+armPFt2usiWfxopEUxkc6OvxdwRz/xRSFSZcmqYR+8OC
	QY0kc1Zo+Hv/fVR2hkqmf1bQNZg/NX1EQfl7/ZebIIgYPYLcD8JdVvNUaHKMArsqqhlq1bP8bGW
	a6FHvCoZ5iGYBJg==
X-Google-Smtp-Source: AGHT+IE3oyPTDwzBRUl31ISxKFd5SP+5KjGC35K0N8YgEZhRl1PRtia8nuPf234Gj4w9EYUSFy4dsMH58dUYuUc=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:2585:b0:52b:c144:e468 with SMTP
 id 2adb3069b0e04-52bc144e533mr8081e87.12.1718028104780; Mon, 10 Jun 2024
 07:01:44 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:01:03 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAB8HZ2YC/23MQQ6CMBCF4auQWVvTqbREV9zDsKA4wCTaIS0hG
 tK7W1m7/F/yvh0SRaYEt2qHSBsnllDCnCoY5j5MpPhRGow2tXbaqTX2Ay3CYVUXJLT+qqluEMp hiTTy+8DuXemZ0yrxc9gb/ta/zIZKK2ctOtP40aJvJ5HpSedBXtDlnL++tXQupQAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3857; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=Z2r4JGubuZTdUYkcXudmGtwYZDpyKW4PXLdrjsGb33s=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmZwdBku1FOE07yPTtExdpN1rE7NwQnHNcBc5EI
 bh/9uXuo06JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZmcHQQAKCRAEWL7uWMY5
 RghED/4rGHdK4QubKiyb+i/JzXCwO9XIfI+7lmns/phyrQIIsRdoEUTUlLePjrnSKkvO6GEbXoh
 Yli9S8zNwM9FWMPrPzYLVji94iqbXPO6yjuFERsOtjBSqDE19koGm9dXWKwZxmWOTaYSIpuTMsi
 6WH9KiQlgVZZe+QGRV6jShoBDE7qxDWTsq+VgPV+xzoGhg064yt+FZwLZvYWOvwVafxyg+g2FGa
 6yMj1dJ76Z3OcAH73zyTUURNghMnDO5w38qZRId7CnwFFGRxUmuHXQvMHdkOZ5N6d+5YN73m0Z7
 fk/POM8pEYaMpv53EqpeJwuXw13+NVM3uQhw42VY8XJqdn7IbMBjsiw6O9fDHwiuPUEiPbiJONC
 UcQV9F7YvKSN6b7L54mNmE6qbqbBR1PaRPOMcJqKS3CjO1BW1lBM5OQrJjXDp0nGOhG49nwq5uM
 xLrjxwrByR157stAxN6o2ds40TPqzcQ5TnC5ek3C+kAvuv64C6Xi1wNE5Nfwi/zwNrBKRugsM9y
 PHDZGH6T/5nBbsG81q/0P7c2Tlq12xKhhWi7dc0jIOKN92lD/YEkT0h/WgaJ/BX4KVzYyoA/JKR
 k55u5mDGlxLzyzXDSgu+x7phpBkFn/QsmqN5Ouz94z/vk+wIVRkFmrM83Xq5ZglvcFGA3K5wRfn BaUqmvDYIrVxckA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240610-tracepoint-v2-0-faebad81b355@google.com>
Subject: [PATCH v2 0/2] Tracepoints and static branch in Rust
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

An important part of a production ready Linux kernel driver is
tracepoints. So to write production ready Linux kernel drivers in Rust,
we must be able to call tracepoints from Rust code. This patch series
adds support for calling tracepoints declared in C from Rust.

To use the tracepoint support, you must:

1. Declare the tracepoint in a C header file as usual.

2. Add #define CREATE_RUST_TRACE_POINTS next to your
   #define CREATE_TRACE_POINTS.

2. Make sure that the header file is visible to bindgen.

3. Use the declare_trace! macro in your Rust code to generate Rust
   functions that call into the tracepoint.

For example, the kernel has a tracepoint called `sched_kthread_stop`. It
is declared like this:

	TRACE_EVENT(sched_kthread_stop,
		TP_PROTO(struct task_struct *t),
		TP_ARGS(t),
		TP_STRUCT__entry(
			__array(	char,	comm,	TASK_COMM_LEN	)
			__field(	pid_t,	pid			)
		),
		TP_fast_assign(
			memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
			__entry->pid	= t->pid;
		),
		TP_printk("comm=%s pid=%d", __entry->comm, __entry->pid)
	);

To call the above tracepoint from Rust code, you must first ensure that
the Rust helper for the tracepoint is generated. To do this, you would
modify kernel/sched/core.c by adding #define CREATE_RUST_TRACE_POINTS.

Next, you would include include/trace/events/sched.h in
rust/bindings/bindings_helper.h so that the exported C functions are
visible to Rust, and then you would declare the tracepoint in Rust:

	declare_trace! {
	    fn sched_kthread_stop(task: *mut task_struct);
	}

This will define an inline Rust function that checks the static key,
calling into rust_do_trace_##name if the tracepoint is active. Since
these tracepoints often take raw pointers as arguments, it may be
convenient to wrap it in a safe wrapper:

	mod raw {
	    declare_trace! {
	        fn sched_kthread_stop(task: *mut task_struct);
	    }
	}
	
	#[inline]
	pub fn trace_sched_kthread_stop(task: &Task) {
	    // SAFETY: The pointer to `task` is valid.
	    unsafe { raw::sched_kthread_stop(task.as_raw()) }
	}

A future expansion of the tracepoint support could generate these safe
versions automatically, but that is left as future work for now.

This is intended for use in the Rust Binder driver, which was originally
sent as an RFC [1]. The RFC did not include tracepoint support, but you
can see how it will be used in Rust Binder at [2]. The author has
verified that the tracepoint support works on Android devices.

This implementation implements support for static keys in Rust so that
the actual static branch happens in the Rust object file. However, the
__DO_TRACE body remains in C code. See v1 for an implementation where
__DO_TRACE is also implemented in Rust.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://r.android.com/3119993 [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Call into C code for __DO_TRACE.
- Drop static_call patch, as it is no longer needed.
- Link to v1: https://lore.kernel.org/r/20240606-tracepoint-v1-0-6551627bf51b@google.com

---
Alice Ryhl (2):
      rust: add static_key_false
      rust: add tracepoint support

 include/linux/tracepoint.h      | 18 ++++++++-
 include/trace/define_trace.h    |  7 ++++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  2 +
 rust/kernel/static_key.rs       | 87 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/tracepoint.rs       | 47 ++++++++++++++++++++++
 scripts/Makefile.build          |  2 +-
 7 files changed, 162 insertions(+), 2 deletions(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

