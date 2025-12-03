Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ECD2FE06B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 14:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773305; cv=none; b=Cq0t3f78VRe1VHnamzFRTaDVBPTBr82YKV8f7MBG0lr8ABylS1mPf7ukSeRFA778PlCVAsXWQJWikFsuaysQ3Vyo5/sWGPoa2bq8o4CVI/2+p9FVQmtWtx7rtXf3b2NJvOEMgaVeyj+gvyqng9vfYnw8uMNpDNm6Xgp+1M0Gk3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773305; c=relaxed/simple;
	bh=k+c623oOfpzjhwM3pVGRq6IE/EspyvmItaNf7oOse4A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=joGFONH5uM2M+Le1LOsjLYOFk5t/TFs7RntZFAD3sxaYItVEkAB1kAMvxLdGKPDj1yeinNuN2S7P9iIUcXnbKoceH6mgODflu5Lobr3E6aaPPNQ0X4w5OxCJrdb9H4VtgwuYjS/yFV27PckLGwupf1Q2vh89QUoj5ag+4e+9AlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XsyM6BcO; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XsyM6BcO"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42e2d02b528so2801731f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 06:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764773301; x=1765378101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMUyFvrAkX/8ln6edcoAi9LqawQ7vF8i3X7WaIzkFa4=;
        b=XsyM6BcOGs/hl2VvVbId9mvkQz2Xb18pyOwy39HX0A7MaVOQg/IrQhvJbxKvJex063
         Sl5v27SjCE2vQltvc5leC4UHwPUkycYWovr2KuglRaOBWPVFcxLj+sZO923l5ZQMVNz5
         SGaKe7k9XONT9obmdZvWkcNZXn2UzcmO4KKPBG6M0fug30doc/vNHUvreBDlZSgdCn5m
         X328IRpiI/VmT/L++FsfFoKd08a7dOWkjlXv35+HBwf5ynKdp5fi3cP68VDAQwBX1SYv
         izT8OHRC826JAHgY7PBA2eUvQ7shTJbIO0YCBjkNn9uEVzSGevaYYYg3fvYco0TNSLle
         UQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764773301; x=1765378101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMUyFvrAkX/8ln6edcoAi9LqawQ7vF8i3X7WaIzkFa4=;
        b=goZ+bfgT4CF3OgNv5qP2iUfVQR695pg96zlHgICJApGzFVLC5I+Ykwmvd+Z/vpYy6f
         /89DjdZxV8sRLznDv4DzNvq6m89CJRYSQEkblNCnDV+Nlskx5tarIEdF8nqrTIlDiemK
         ZL1cbMOS7Xr7a25GXPGPV/YKWoETizQwlNxOMbxCr/dUjbubJkXs5tWsvkqpnMjEF35j
         qgOMfi1ALYGvLb3DoYG7HL5qsxEeS64jvQR5xarjikTbKfqfkp+ekdo780LoePRBRiXY
         AS5Llsgzub9dHkW5iQWjqZW0wrf/TStPEUJRBsDtnPzPdYW0UHJQgx85bq3bkKtrC+aY
         AFoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCG+ASCqeFL+JbgjMnYF1f3OjlfFjcnrHEp67vBL0EbyE5xN/crjXxLk351yKi+nC6JYHQhnKl6WqE0UWmhJtyy2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLcX8lhcXSUn1jU8LtR+/a2zFD2gvGpX+XYGAewNP74xmg8y7d
	QdlS5QGiM6cB1BNuS4ZwQuWbVp4m3sWitMrxdc++Tg2LQ421wmGwdAkZqpK1B12LoqM781LO2uQ
	xf50X3PFRV9OGkfzzGg==
X-Google-Smtp-Source: AGHT+IGjIuctMNYu6T6APhoJeiZmzbi3ln5p3ZQ3SLPt5BiLm+aFWhJE53huPcjpjt6n4KZUea1DLwBM1mOkQq8=
X-Received: from wrqf1.prod.google.com ([2002:adf:f8c1:0:b0:42c:c2d6:2a0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:588c:0:b0:42b:3825:2ac8 with SMTP id ffacd0b85a97d-42f731cf4a4mr2692514f8f.59.1764773300855;
 Wed, 03 Dec 2025 06:48:20 -0800 (PST)
Date: Wed, 03 Dec 2025 14:48:09 +0000
In-Reply-To: <20251203-binder-trace1-v1-0-22d3ffddb44e@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251203-binder-trace1-v1-0-22d3ffddb44e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=11108; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=k+c623oOfpzjhwM3pVGRq6IE/EspyvmItaNf7oOse4A=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpME2xuGik6iVmZv/mGNaGEB0+1/XH47eCG7gem
 bfLBlIRG5mJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaTBNsQAKCRAEWL7uWMY5
 RhCiD/4xr6a6Veu4bddvttHxzuIY8hKAgH1txQC00x2+mYbwovY8Yu/FsDKKBBd4SUmT65RYY3b
 rBV0+gSZAY1ibOXbMu0IVcJyVQ5PtAZSu1rJFWzB1zVg6S1MRGRlC5/kdoWWRH3IZuTYpLEjNI5
 lC0MPquDIEQPBFoiozDlLcL1sCniiKXGIbzokTqFgFPCydGGXEHETB2HvPap828ToklNovaoT0V
 507ch2AQ9m7lV7IPlMptp1F2twASgZmC64YidB21UbUNaFkIF7YgYEM22EXEMdUzvj9df5JEC9H
 upPmz1dtG67vsTGNR2aaTBl2HuE42Pen6mzvW6C4MnXOC2vBADGtqpDCnIUxpqwi1NR2jmDOiT8
 DhSu0dMAQ7p8ewV+jdfNXC0ma3b3CyOQpfGHSvuu2oXQmQX10Ue7T7aTEz7X7A0Ku5+7KB7fPx+
 k6AR22udlAgxijFEMFbMrZTQco9BV7mb8dC9ptzc/yu48YSr1rKvdAK/QsVtgR0G5Z6eCVuW59X
 4a7+kw/OvDneldF2eUgbJbNetg5md0jq6zcANokLSI0Nur6VI4X+4EtdjGYOC/HZeDaYdfffyoG
 YwlQTrANmcs1DR0XiodsB41WzWqfHWrPCjz1D6uxEcq7AL0SxNxvzqdCazYRRJFmNJNI4yjD+DN COcxoDn/mnWktSw==
X-Mailer: b4 0.14.2
Message-ID: <20251203-binder-trace1-v1-2-22d3ffddb44e@google.com>
Subject: [PATCH 2/2] rust_binder: add binder_transaction tracepoint
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Suren Baghdasaryan <surenb@google.com>, rust-for-linux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This patch adds the binder_transaction tracepoint to Rust Binder. This
was chosen as the next tracepoint to add as it is the most complex
tracepoint. (And it's also an important tracepoint known to perfetto.)

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder/node.rs              |  8 +++
 drivers/android/binder/process.rs           |  7 +++
 drivers/android/binder/rust_binder.h        | 79 +++++++++++++++++++++++++++++
 drivers/android/binder/rust_binder_events.h | 30 +++++++++++
 drivers/android/binder/rust_binder_main.rs  |  8 +++
 drivers/android/binder/thread.rs            |  1 +
 drivers/android/binder/trace.rs             | 21 ++++++++
 drivers/android/binder/transaction.rs       | 14 +++++
 8 files changed, 168 insertions(+)

diff --git a/drivers/android/binder/node.rs b/drivers/android/binder/node.rs
index ade895ef791ec5746f9f5c1bfc15f47d59829455..7e6c94c7c3373461520d52d0b1fe8c1fc871fbd8 100644
--- a/drivers/android/binder/node.rs
+++ b/drivers/android/binder/node.rs
@@ -178,6 +178,14 @@ struct NodeInner {
     refs: List<NodeRefInfo, { NodeRefInfo::LIST_NODE }>,
 }
 
+use kernel::bindings::rb_node_layout;
+use mem::offset_of;
+pub(crate) const NODE_LAYOUT: rb_node_layout = rb_node_layout {
+    arc_offset: Arc::<Node>::DATA_OFFSET + offset_of!(DTRWrap<Node>, wrapped),
+    debug_id: offset_of!(Node, debug_id),
+    ptr: offset_of!(Node, ptr),
+};
+
 #[pin_data]
 pub(crate) struct Node {
     pub(crate) debug_id: usize,
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f13a747e784c84a0fb09cbf47442712106eba07c..c4c8a0ba93366f3e2ec426fb5950f48edb0610ae 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -387,6 +387,13 @@ fn new() -> Self {
     }
 }
 
+use core::mem::offset_of;
+use kernel::bindings::rb_process_layout;
+pub(crate) const PROCESS_LAYOUT: rb_process_layout = rb_process_layout {
+    arc_offset: Arc::<Process>::DATA_OFFSET,
+    task: offset_of!(Process, task),
+};
+
 /// A process using binder.
 ///
 /// Strictly speaking, there can be multiple of these per process. There is one for each binder fd
diff --git a/drivers/android/binder/rust_binder.h b/drivers/android/binder/rust_binder.h
index 31806890ed1a278793ae7178f9d76ca4d591a954..e68ba7a23c34de4688fa7d34341b0585b5dba7e9 100644
--- a/drivers/android/binder/rust_binder.h
+++ b/drivers/android/binder/rust_binder.h
@@ -20,4 +20,83 @@ struct inode;
 struct dentry *rust_binderfs_create_proc_file(struct inode *nodp, int pid);
 void rust_binderfs_remove_file(struct dentry *dentry);
 
+/*
+ * The internal data types in the Rust Binder driver are opaque to C, so we use
+ * void pointer typedefs for these types.
+ */
+
+typedef void *rust_binder_transaction;
+typedef void *rust_binder_process;
+typedef void *rust_binder_node;
+
+struct rb_process_layout {
+	size_t arc_offset;
+	size_t task;
+};
+
+struct rb_transaction_layout {
+	size_t debug_id;
+	size_t code;
+	size_t flags;
+	size_t from_thread;
+	size_t to_proc;
+	size_t target_node;
+};
+
+struct rb_node_layout {
+	size_t arc_offset;
+	size_t debug_id;
+	size_t ptr;
+};
+
+struct rust_binder_layout {
+	struct rb_transaction_layout t;
+	struct rb_process_layout p;
+	struct rb_node_layout n;
+};
+
+extern const struct rust_binder_layout RUST_BINDER_LAYOUT;
+
+static inline size_t rust_binder_transaction_debug_id(rust_binder_transaction t)
+{
+	return *(size_t *) (t + RUST_BINDER_LAYOUT.t.debug_id);
+}
+
+static inline u32 rust_binder_transaction_code(rust_binder_transaction t)
+{
+	return *(u32 *) (t + RUST_BINDER_LAYOUT.t.code);
+}
+
+static inline u32 rust_binder_transaction_flags(rust_binder_transaction t)
+{
+	return *(u32 *) (t + RUST_BINDER_LAYOUT.t.flags);
+}
+
+// Nullable!
+static inline rust_binder_node rust_binder_transaction_target_node(rust_binder_transaction t)
+{
+	void *p = *(void **) (t + RUST_BINDER_LAYOUT.t.target_node);
+
+	if (p)
+		p = p + RUST_BINDER_LAYOUT.n.arc_offset;
+	return NULL;
+}
+
+static inline rust_binder_process rust_binder_transaction_to_proc(rust_binder_transaction t)
+{
+	void *p = *(void **) (t + RUST_BINDER_LAYOUT.t.to_proc);
+
+	return p + RUST_BINDER_LAYOUT.p.arc_offset;
+}
+
+static inline struct task_struct *rust_binder_process_task(rust_binder_process t)
+{
+	return *(struct task_struct **) (t + RUST_BINDER_LAYOUT.p.task);
+}
+
+static inline size_t rust_binder_node_debug_id(rust_binder_node t)
+{
+	return *(size_t *) (t + RUST_BINDER_LAYOUT.n.debug_id);
+}
+
 #endif
diff --git a/drivers/android/binder/rust_binder_events.h b/drivers/android/binder/rust_binder_events.h
index 2f3efbf9dba68e6415f0f09ff5c8255dc5c5bc00..8ad785c6bd0f5783df1e764a8827fed41afbcb00 100644
--- a/drivers/android/binder/rust_binder_events.h
+++ b/drivers/android/binder/rust_binder_events.h
@@ -30,6 +30,36 @@ TRACE_EVENT(rust_binder_ioctl,
 	TP_printk("cmd=0x%x arg=0x%lx", __entry->cmd, __entry->arg)
 );
 
+TRACE_EVENT(rust_binder_transaction,
+	TP_PROTO(bool reply, rust_binder_transaction t, struct task_struct *thread),
+	TP_ARGS(reply, t, thread),
+	TP_STRUCT__entry(
+		__field(int, debug_id)
+		__field(int, target_node)
+		__field(int, to_proc)
+		__field(int, to_thread)
+		__field(int, reply)
+		__field(unsigned int, code)
+		__field(unsigned int, flags)
+	),
+	TP_fast_assign(
+		rust_binder_process to = rust_binder_transaction_to_proc(t);
+		rust_binder_node target_node = rust_binder_transaction_target_node(t);
+
+		__entry->debug_id = rust_binder_transaction_debug_id(t);
+		__entry->target_node = target_node ? rust_binder_node_debug_id(target_node) : 0;
+		__entry->to_proc = rust_binder_process_task(to)->pid;
+		__entry->to_thread = thread ? thread->pid : 0;
+		__entry->reply = reply;
+		__entry->code = rust_binder_transaction_code(t);
+		__entry->flags = rust_binder_transaction_flags(t);
+	),
+	TP_printk("transaction=%d dest_node=%d dest_proc=%d dest_thread=%d reply=%d flags=0x%x code=0x%x",
+		  __entry->debug_id, __entry->target_node,
+		  __entry->to_proc, __entry->to_thread,
+		  __entry->reply, __entry->flags, __entry->code)
+);
+
 #endif /* _RUST_BINDER_TRACE_H */
 
 /* This part must be outside protection */
diff --git a/drivers/android/binder/rust_binder_main.rs b/drivers/android/binder/rust_binder_main.rs
index 6773b7c273ec9634057300954d67b51ca9b54f6f..3799b4707ed4e0505a3d3370e3dd1e74f974b641 100644
--- a/drivers/android/binder/rust_binder_main.rs
+++ b/drivers/android/binder/rust_binder_main.rs
@@ -89,6 +89,14 @@ fn default() -> Self {
     license: "GPL",
 }
 
+use kernel::bindings::rust_binder_layout;
+#[no_mangle]
+static RUST_BINDER_LAYOUT: rust_binder_layout = rust_binder_layout {
+    t: transaction::TRANSACTION_LAYOUT,
+    p: process::PROCESS_LAYOUT,
+    n: node::NODE_LAYOUT,
+};
+
 fn next_debug_id() -> usize {
     static NEXT_DEBUG_ID: AtomicUsize = AtomicUsize::new(0);
 
diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
index 7e34ccd394f8049bab88562ffb4601739aea670a..0874e2793e276e075802d97ea9bb02a4c2fc8c72 100644
--- a/drivers/android/binder/thread.rs
+++ b/drivers/android/binder/thread.rs
@@ -1117,6 +1117,7 @@ fn deliver_single_reply(
         transaction: &DArc<Transaction>,
     ) -> bool {
         if let Ok(transaction) = &reply {
+            crate::trace::trace_transaction(true, transaction, Some(&self.task));
             transaction.set_outstanding(&mut self.process.inner.lock());
         }
 
diff --git a/drivers/android/binder/trace.rs b/drivers/android/binder/trace.rs
index af0e4392805e7ef2a39b7c1e557ea233dcd810ab..9839901c7151590defed297b091f1339603c09df 100644
--- a/drivers/android/binder/trace.rs
+++ b/drivers/android/binder/trace.rs
@@ -2,11 +2,21 @@
 
 // Copyright (C) 2025 Google LLC.
 
+use crate::transaction::Transaction;
+
+use kernel::bindings::{rust_binder_transaction, task_struct};
 use kernel::ffi::{c_uint, c_ulong};
+use kernel::task::Task;
 use kernel::tracepoint::declare_trace;
 
 declare_trace! {
     unsafe fn rust_binder_ioctl(cmd: c_uint, arg: c_ulong);
+    unsafe fn rust_binder_transaction(reply: bool, t: rust_binder_transaction, thread: *mut task_struct);
+}
+
+#[inline]
+fn raw_transaction(t: &Transaction) -> rust_binder_transaction {
+    t as *const Transaction as rust_binder_transaction
 }
 
 #[inline]
@@ -14,3 +24,14 @@ pub(crate) fn trace_ioctl(cmd: u32, arg: usize) {
     // SAFETY: Always safe to call.
     unsafe { rust_binder_ioctl(cmd, arg as c_ulong) }
 }
+
+#[inline]
+pub(crate) fn trace_transaction(reply: bool, t: &Transaction, thread: Option<&Task>) {
+    let thread = match thread {
+        Some(thread) => thread.as_ptr(),
+        None => core::ptr::null_mut(),
+    };
+    // SAFETY: The raw transaction is valid for the duration of this call. The thread pointer is
+    // valid or null.
+    unsafe { rust_binder_transaction(reply, raw_transaction(t), thread) }
+}
diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/transaction.rs
index 02512175d6229535373f2d3e543ba8c91ecd72f0..6a12064a53ad4c477d8b6cb016333f5a10ec399a 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -24,6 +24,17 @@
     BinderReturnWriter, DArc, DLArc, DTRWrap, DeliverToRead,
 };
 
+use core::mem::offset_of;
+use kernel::bindings::rb_transaction_layout;
+pub(crate) const TRANSACTION_LAYOUT: rb_transaction_layout = rb_transaction_layout {
+    debug_id: offset_of!(Transaction, debug_id),
+    code: offset_of!(Transaction, code),
+    flags: offset_of!(Transaction, flags),
+    from_thread: offset_of!(Transaction, from),
+    to_proc: offset_of!(Transaction, to),
+    target_node: offset_of!(Transaction, target_node),
+};
+
 #[pin_data(PinnedDrop)]
 pub(crate) struct Transaction {
     pub(crate) debug_id: usize,
@@ -249,6 +260,7 @@ pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
 
         if oneway {
             if let Some(target_node) = self.target_node.clone() {
+                crate::trace::trace_transaction(false, &self, None);
                 if process_inner.is_frozen {
                     process_inner.async_recv = true;
                     if self.flags & TF_UPDATE_TXN != 0 {
@@ -286,11 +298,13 @@ pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
         }
 
         let res = if let Some(thread) = self.find_target_thread() {
+            crate::trace::trace_transaction(false, &self, Some(&thread.task));
             match thread.push_work(self) {
                 PushWorkRes::Ok => Ok(()),
                 PushWorkRes::FailedDead(me) => Err((BinderError::new_dead(), me)),
             }
         } else {
+            crate::trace::trace_transaction(false, &self, None);
             process_inner.push_work(self)
         };
         drop(process_inner);

-- 
2.52.0.158.g65b55ccf14-goog

