Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A519750B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Jun 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686355; cv=none; b=dHtGjkTNYMPE+XBGTshyynDqgQO7eLA7iAlhcG0MOQO+CTL1JdCNifIRBq8TgQiALL5KeTmOi6ASGCsZXqmYDQiyZ333lg0NckRiBoeigsz9sNJGNjsVhWnGe7TFfyVWoh0B7FxZXVT79qotuOcOEO1Bs7A6IcwWcr73svz51Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686355; c=relaxed/simple;
	bh=vEsutBZlhKMnWIsGe05c46SdkM5cY+SQXmb/5CmFXnI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ARNuHWVbRV72n6/b9WG2lvlaAtpSU5jA3TleqQSF8iCP9EYuEDXBb4jUPRo+DX0G/u5ioEaKghECft+bk6pvct/gygNEreP4vKQEEqf2qyKE0ZdkftGAdwW75C/CqPedA25QIXqJbcjVS6Vda/JSjQZt4+XEEecUPgyWq16r5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+AMUMiH; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+AMUMiH"
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2eaa0215594so7930781fa.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Jun 2024 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717686352; x=1718291152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=svRBg3ehYrz5hUxTlJzLKiH5OmJzeQR08XpR/4Jyz1s=;
        b=m+AMUMiH3umfXNwD03HKV2xj6mZbu0qoC2UgW8zcq2SBdQxyp6zLNwlvIcH6v/bWvW
         hle8EHapzd9iQih+DSzSBWrPpHHCCFLGBPgiroJXI2fdq0waU3h7MAzKcBCY//skIOCh
         sIGgb+9Ge+9sa3Qgvz2NAA/yRK7pbFo4jkn18ljQz+ws9KvvfWI2V1CFEl5EXfVF4RU3
         CRG1aBJUCMtNrhzCbr7UbTBxKRjloHls7EBCeQxO75UzBJNMpMxNn3zmTT99j+R9mzGY
         +xIHa4N0WRnxL8jLOvB+9P9x+6tcGR6GMlYHWCIwIxVL2sWxEods25dC9TKfZojPylvv
         04Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717686352; x=1718291152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svRBg3ehYrz5hUxTlJzLKiH5OmJzeQR08XpR/4Jyz1s=;
        b=JkjIZ2W+b88ChXhusFrzgT3FtIvHj1VSYG6WYOxcrS60WTJNPUNnVUaStDU+s2uIxx
         hYXzU5gkm2hxTvhht5bo1vS7kM/nrCM1FD2wZ4lIhetpIZA9LDqhPFVBrFDYvNeT6nRA
         MyRQyGgudSHMLsRpkjObbepOMcrtAMNw+i83XjVJt+R/eDinX6eKWrxhL8TdvzHfLrBY
         Y45VFtvHkXXe5S/Ya7ynqmR5054SCAyGMuum6oNTuQDhVWDPoEdtGJa91A1icl3IpBlG
         FIA7+cXVecvtUmfDrDFHA12gldlldEcCYoAwsMPYryCNsRgTa/mRpaDncNyQGuz02izS
         Bwrg==
X-Gm-Message-State: AOJu0YwUKTFyxz62NchzQuDZ71zg9yHThYnme7Xq4/bPCU7XFKMFBdA+
	GWeOqj/6MGTA3VvrtUJo2WiN8otQSGPNAgMkxEtGyMzC4GVUdxcQEV+A65jmAXypRzCxQk08BM1
	eYhw/q7zVayDD5g==
X-Google-Smtp-Source: AGHT+IEkC4tJkKW66Tm9hAmKtZpBXUx5yLPklB64SQ5u7BYAWEQWIHI0aOMgcj6m1qnJQ7SdqcrAeAA67ifIajI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:800c:0:b0:2e1:d6d5:6354 with SMTP id
 38308e7fff4ca-2eac7a91f91mr64171fa.10.1717686351279; Thu, 06 Jun 2024
 08:05:51 -0700 (PDT)
Date: Thu, 06 Jun 2024 15:05:23 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADTQYWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwMz3ZKixOTUgvzMvBJdY8NUQ9MkS4NUE3NDJaCGgqLUtMwKsGHRsbW 1ACjAlRpcAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4496; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=vEsutBZlhKMnWIsGe05c46SdkM5cY+SQXmb/5CmFXnI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmYdBGVbbcpYhdO8um73PzslTL3fQK3Vilrqkzy
 t6ldQtbPNSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZmHQRgAKCRAEWL7uWMY5
 Rg+0D/0Rl5tPOn6qzNZdHaMCN8arml0tdRNBaach4+YmnFtkE7sIs6FDMeZgUbVQ7c0A8Ev+BeR
 GqOiq6UfLhtOiZ19IZdPdlTmhitNhWoFdRy/GNJ3rgSlgu/694F/MC00UjONOeubNLUjxmtzzqM
 sLH9C4AtkTMjo2xT+Htse/rE3gjQlJTTRl9cSB7lQoBA5WZnHIR/kTgtxqZZvUSyT7/l7dpes6u
 5ouWuOQoaLmkossg+WKUrUyxkYgd4tIHeAfjn/zjjBIgliEzPWCf6VOq9teK1QV88oNj4L/4DSx
 B20Pi6iMuXKEAC8WuT3HVRfM2fNqRl8BBieHTfI2k3dnXhht8CEFpHKBWsy/X7URXuEJM7ZPTCE
 W0iXC4v2r+SvazJr27qRpIYCyVoQ1TvkNn/P0nDg4Qz7pgX0V1reEf8dMpplI+EQrzks8bZN5Cn
 cF44cx94L26FBCdLoE+z796w/ZWmFpajVWznmILSSXl4t85YF1I/OGXD5M+ELpW9vrGB9S2csaC
 GBeH0lCrhIvtO2JK2aODg7vM0lewHkoMadQoHgwnyQ+TOwVN1VDcDbpqHVXWHczVeCV9wfU25QM
 bYS3A8XMyG9B8KAuRYL8CynH3crBivglxTsVI7jZOOGYX47gW+wayFPYuw4mbYnBygER/m0I39E Nmf1vxRfsI6oWsg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240606-tracepoint-v1-0-6551627bf51b@google.com>
Subject: [PATCH 0/3] Tracepoints and static branch/call in Rust
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
2. Make sure that the header file is visible to bindgen so that Rust
   bindings are generated for the symbols that the tracepoint macro
   emits.
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

To call the above tracepoint from Rust code, you would add the relevant
header file to rust/bindings/bindings_helper.h and add the following
invocation somewhere in your Rust code:

	declare_trace! {
	    fn sched_kthread_stop(task: *mut task_struct);
	}

This will define a Rust function of the given name that you can call
like any other Rust function. Since these tracepoints often take raw
pointers as arguments, it may be convenient to wrap it in a safe
wrapper:

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
the actual static branch will end up in the Rust object file. However,
it would also be possible to just wrap the trace_##name generated by
__DECLARE_TRACE in an extern C function and then call that from Rust.
This will simplify the Rust code by removing the need for static
branches and calls, but it places the static branch behind an external
call, which has performance implications.

A possible middle ground would be to place just the __DO_TRACE body in
an extern C function and to implement the Rust wrapper by doing the
static branch in Rust, and then calling into C the code that contains
__DO_TRACE when the tracepoint is active. However, this would need some
changes to include/linux/tracepoint.h to generate and export a function
containing the body of __DO_TRACE when the tracepoint should be callable
from Rust.

So in general, there is a tradeoff between placing parts of the
tracepoint (which is perf sensitive) behind an external call, and having
code duplicated in both C and Rust (which must be kept in sync when
changes are made). This is an important point that I would like feedback
on from the C maintainers.

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://r.android.com/3110088 [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (3):
      rust: add static_call support
      rust: add static_key_false
      rust: add tracepoint support

 rust/bindings/bindings_helper.h |  1 +
 rust/bindings/lib.rs            | 15 +++++++
 rust/helpers.c                  | 24 +++++++++++
 rust/kernel/lib.rs              |  3 ++
 rust/kernel/static_call.rs      | 92 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/static_key.rs       | 87 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/tracepoint.rs       | 92 +++++++++++++++++++++++++++++++++++++++++
 scripts/Makefile.build          |  2 +-
 8 files changed, 315 insertions(+), 1 deletion(-)
---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240606-tracepoint-31e15b90e471

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

