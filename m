Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B34218A3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603364; cv=none; b=UAI5lz3uHcCQIzvitrO+KgHreGRwRMHi70T0ar6a14RjrNbhdEgBbfcH0tDhVNFq/AOZIdiEePu18J0l5P5V5IJsq8Js/0igN02UwpbYxhnd2Y0/9ayYJQMGa50HK+Qeam0Qy2BySPYDz+npoEcFOKFBLM9rTTy8tB6lhjIaGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603364; c=relaxed/simple;
	bh=G7aEUL1yCZQ+BSeL7KUdy/tN7v56tErAP6DDzaef5oE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8vJHJSynpc+0jr60av18+qh3rhkcwVQ+E/cNIPCxBrsVmdZGcmWiq1UI2HQbHSo8P7VBjPUsPb/fDB8MtoKMU04yLNz4j48vq7CHigq7kv6LkRrriZtQzPKQaG5AswehNLFxFQPOs8M7e5x9KjcD7LADjX7yURa0asDrviAoF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CcQXN4mT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CcQXN4mT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781603362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XGxphqP/4ePDEyn2+dDy8BXUPWMYV2pS4YiTVj3WQhw=;
	b=CcQXN4mTqj/74Zzh2T73DjGBOL7jf25EePdt5y+wzs6vPFyl5ufHLZMOYgUroFnO2Tn6G1
	VbqPwldpadV7QjXkbGI3HCY4K9EDaQ0dirDvmqVp8SQTmpZOpUOO92M5VPi98vahsTJ6Dp
	bWMwBSPNKToZFqrJX5jXRs6dkHVKKNk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-gkkDgTyqPv68hSpCN_wG6w-1; Tue, 16 Jun 2026 05:49:20 -0400
X-MC-Unique: gkkDgTyqPv68hSpCN_wG6w-1
X-Mimecast-MFC-AGG-ID: gkkDgTyqPv68hSpCN_wG6w_1781603359
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45f3d008865so3490803f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Jun 2026 02:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781603359; x=1782208159;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iuOHnIXU71/pw1LKqPisCjflvP7Lf4r0qiAFUjk7OO8=;
        b=sNSp7Y4yIBwEvfq9rwoxyHMpBD2chNVT0FR2d0tv35s8Bxbz+HxRzMHFQLbnVg1GQP
         /T5cBx+N4tnF4uLdIJf84FJNp41SB5kdkqu55xcaP0lB4hbxbCzX4vbCzuU4FSes+kwW
         LgWAeqaXoK8UQ8snZdJmbhjrc/T/Ahllzy3wNCS0GqQ7A3XCTcrRuqAjA/ui6qAXGhOO
         8O5qGgezvv/JhhsvaxaO5xGYfxl2OU5xOY3gjaIc4DDCnUDlRQrlujWedf2iPhtTxu0/
         c+Iec9oO66eGlxcZXS6QdV56YlWwo4VEIHsOx4Diqr8tqBaB4Jx0CzQc2Xe2ivhlCcyV
         Eeng==
X-Forwarded-Encrypted: i=1; AFNElJ/r7MM22csjWnE/2oAK9bXZuHbJjDav6q/T7a/9xEERBj/droM0ZczktpDcj4xjt0F1MnayWZ8wEvJLy68Q7tVM6Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0iZp6TL+CrvN7cM/1D0BvnF2biabyeDvz0W4OkuQyw0a2k5M
	QQlMcmMvT0b4bjJ76nPoQtxrowKVgANlFynQ1m817qI42tvnz7ymYoIjeC+uusfssvt+LS5VQIT
	AqjjIeTJNezQF92EuG8yhnvz8bKRlTg7eIe2/9ExAV58Dy1vnpZDhi+xAQ0bye2dGvU4pkIehqg
	==
X-Gm-Gg: Acq92OGASzIOh3+v5uvvfy7OoRD1KH4Xgg2YEhac7AJzAam6hsq/WhcT4E7ZNGiMpSo
	CCGBHfuv44ay+IRWAQfzN7vupym+hZNmf17j6agAblOT21+TjCjNvTt8UZ3thB7EugxjeA9YmYD
	S5F9UWBMBqhPNhm0wytO7FwFavipH9+0f/cw5blDM8fiBYlNIB4DrYtU9n/LmkvRG3ORrfR81ln
	smwgUj6R9Qmawuan8Dj4lNxfcIBYHB9wabWI1JKHJhilUMzaWMuBezvxqJexUiliwSMnYhq7mDP
	xuX0jyE4zws96VFq7GzOZSDNkd9xhDsee00wMzOnWykd8NMYLQ8+d+VaY5LuNaM0JREPa8p0YVM
	ruVOH+St/gsurXPGYBTjfPlOPew==
X-Received: by 2002:a5d:5d87:0:b0:460:11a7:f82e with SMTP id ffacd0b85a97d-4619f2e609bmr5459047f8f.8.1781603359191;
        Tue, 16 Jun 2026 02:49:19 -0700 (PDT)
X-Received: by 2002:a5d:5d87:0:b0:460:11a7:f82e with SMTP id ffacd0b85a97d-4619f2e609bmr5458996f8f.8.1781603358714;
        Tue, 16 Jun 2026 02:49:18 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm43387398f8f.1.2026.06.16.02.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:49:18 -0700 (PDT)
Message-ID: <a645534b04d9bf32f2c2caa5d2206bb87cfcb3e1.camel@redhat.com>
Subject: Re: [PATCH v3 2/9] rv: add generic uprobe infrastructure for RV
 monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Tue, 16 Jun 2026 11:49:17 +0200
In-Reply-To: <9d1a1d491af16853b2b421f358fd6cca965588ab.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
	 <9d1a1d491af16853b2b421f358fd6cca965588ab.1780847473.git.wen.yang@linux.dev>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GlF-WBbKeyE-5MmisnhJBMGi3rLjeOr4z-kRMQCMAcU_1781603359
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-08 at 00:13 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Introduce rv_uprobe, a thin wrapper around uprobe_consumer providing
> rv_uprobe_attach_path(), rv_uprobe_attach(), and rv_uprobe_detach()
> for RV monitors.=C2=A0 An opaque priv pointer is forwarded unchanged to
> entry/return handlers so monitors can carry per-binding state (e.g. a
> latency threshold) to the hot path without any global lookup.
>=20
> rv_uprobe_detach() is fully synchronous (nosync + sync + path_put +
> kfree), closing the use-after-free window present in open-coded
> patterns where kfree() precedes uprobe_unregister_sync().
>=20
> Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Wen Yang <wen.yang@linux.dev>

I find your implementation solid, but I wonder if it isn't a bit
overdoing it. It's good to have helper functions abstracting away the
common uprobes code, but I find the number of structures used to indirect/h=
ide
the process a bit confusing.

Users of this headers still know they're using uprobes, so we don't
really need to hide it that much, plus the double function pointers are
an additional performance hit we could easily skip.

As I get it, we want to pass a private pointer (essentially to get the
threshold in tlob) and the uprobe infrastructure doesn't allow that
transparently. So let's keep on using struct embedding but a bit more
cut to the bone:

=09struct rv_uprobe {
=09=09struct uprobe_consumer=09uc;
=09=09struct uprobe=09=09*uprobe;
=09=09void=09=09=09*priv;
=09};

Then handlers would use container_of() appropriately to derive the data the=
y
need.

=09static int tlob_uprobe_entry_handler(struct uprobe_consumer *self, struc=
t pt_regs *regs, __u64 *data)
=09{
=09=09struct rv_uprobe *p =3D container_of(self, struct rv_uprobe, uc);
=09=09struct tlob_uprobe_binding *b =3D p->priv;

=09=09...
=09}

You could even define the struct directly inside your private data and save=
 one
step (and no void *):

=09struct rv_uprobe {
=09=09struct uprobe_consumer=09uc;
=09=09struct uprobe=09=09*uprobe;
=09};

=09#define DECLARE_RV_UPROBE(name) struct rv_uprobe name

=09// And then

=09struct tlob_uprobe_binding {
=09=09u64 threshold_ns;
=09=09...
=09=09DECLARE_RV_UPROBE(start);
=09=09DECLARE_RV_UPROBE(stop);
=09}

=09static int tlob_uprobe_entry_handler(struct uprobe_consumer *self, struc=
t pt_regs *regs, __u64 *data)
=09{
=09=09struct tlob_uprobe_binding *b =3D container_of(self, struct tlob_upro=
be_binding, start.uc);

=09=09...
=09}


Now I intentionally skipped offset, as I don't really see why carry it arou=
nd,
and path, as we could live without it by relying on inodes (uprobes
reference-track them but you'd need to save them somewhere).

Mind, I only build tested this idea (appended after). This was supported by=
 an
LLM which did a few more changes like standardising names and return values=
 of
registration functions (a bit more consistent with other stuff, you don't h=
ave
to commit with that though).

By the way, do we really need the duplicate check? Would it break if a user
defines it twice? If not, we could simplify the tlob_add_uprobe() even furt=
her
and doing all path related checks in the library, since those aren't quite =
tlob
specific.

Thoughts?

Thanks,
Gabriele

**Suggested simplification:**

---
diff --git a/include/rv/rv_uprobe.h b/include/rv/rv_uprobe.h
index 9106c5c927..4fb3f50a63 100644
--- a/include/rv/rv_uprobe.h
+++ b/include/rv/rv_uprobe.h
@@ -7,83 +7,56 @@
 #ifndef _RV_UPROBE_H
 #define _RV_UPROBE_H
=20
-#include <linux/path.h>
 #include <linux/types.h>
+#include <linux/uprobes.h>
=20
 struct pt_regs;
+struct inode;
=20
 /**
  * struct rv_uprobe - a single uprobe registered on behalf of an RV monito=
r
  *
- * @offset:   byte offset within the ELF binary where the probe is install=
ed
- * @priv:     monitor-private pointer; set at attach time, never touched b=
y
- *            this layer; passed unchanged to entry_fn / ret_fn
- * @path:     resolved path of the probed binary (read-only after attach);
- *            callers may use path.dentry for identity comparisons
- *
- * The implementation fields (uprobe_consumer, uprobe handle, callbacks) a=
re
- * private to rv_uprobe.c and are not exposed here; monitors must not acce=
ss
- * them directly.
+ * @uc:       underlying uprobe consumer (publicly visible)
+ * @uprobe:   active uprobe structure handle
+ * @inode:    inode of the target binary (read-only after registration)
  */
 struct rv_uprobe {
-=09/* public: read-only after rv_uprobe_attach*() */
-=09loff_t=09=09 offset;
-=09void=09=09*priv;
-=09struct path=09 path;
+=09struct uprobe_consumer=09uc;
+=09struct uprobe=09=09*uprobe;
+=09struct inode=09=09*inode;
 };
=20
-/**
- * rv_uprobe_attach_path - register an uprobe given an already-resolved pa=
th
- * @path:     path of the target binary; rv_uprobe takes its own reference
- * @offset:   byte offset within the binary
- * @entry_fn: called on probe hit (entry); may be NULL
- * @ret_fn:   called on function return (uretprobe); may be NULL
- * @priv:     opaque pointer forwarded to callbacks unchanged
- *
- * Use this variant when the caller has already resolved the path (e.g. to
- * register multiple probes on the same binary with a single kern_path cal=
l).
- * The inode is derived internally via d_real_inode(), so inode and path a=
re
- * always consistent.
- *
- * Returns a pointer to the new rv_uprobe on success, ERR_PTR on failure.
- */
-struct rv_uprobe *rv_uprobe_attach_path(struct path *path, loff_t offset,
-=09int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data)=
,
-=09int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
-=09=09=09struct pt_regs *regs, __u64 *data),
-=09void *priv);
+/* Seamless inline declaration of a named uprobe inside user structs */
+#define DECLARE_RV_UPROBE(name) \
+=09struct rv_uprobe name
=20
 /**
- * rv_uprobe_attach - resolve binpath and register an uprobe
- * @binpath:  absolute path to the target binary
- * @offset:   byte offset within the binary
- * @entry_fn: called on probe hit (entry); may be NULL
- * @ret_fn:   called on function return (uretprobe); may be NULL
- * @priv:     opaque pointer forwarded to callbacks unchanged
+ * rv_uprobe_register - resolve binpath and register an uprobe
+ * @binpath:     absolute path to the target binary
+ * @offset:      byte offset within the binary
+ * @p:           pointer to the allocated/embedded rv_uprobe structure
+ * @handler:     called on probe hit (entry); may be NULL
+ * @ret_handler: called on function return (uretprobe); may be NULL
  *
- * Resolves binpath via kern_path(), then delegates to rv_uprobe_attach_pa=
th().
+ * Resolves binpath via kern_path(), registers the uprobe directly using t=
he
+ * embedded `uprobe_consumer`, and immediately releases the path reference=
.
  *
- * Returns a pointer to the new rv_uprobe on success, ERR_PTR on failure.
+ * Returns 0 on success, or a negative error code on failure.
  */
-struct rv_uprobe *rv_uprobe_attach(const char *binpath, loff_t offset,
-=09int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data)=
,
-=09int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
-=09=09=09struct pt_regs *regs, __u64 *data),
-=09void *priv);
+int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_uprob=
e *p,
+=09int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u6=
4 *data),
+=09int (*ret_handler)(struct uprobe_consumer *self, unsigned long func,
+=09=09=09   struct pt_regs *regs, __u64 *data));
=20
 /**
- * rv_uprobe_detach - synchronously unregister an uprobe and free it
- * @p:  probe to detach; may be NULL (no-op)
- *
- * Calls uprobe_unregister_nosync(), then uprobe_unregister_sync() to wait
- * for any in-progress handler to finish, then releases the path reference
- * and frees the rv_uprobe struct.  The caller's priv data is NOT freed.
+ * rv_uprobe_unregister - synchronously unregister a uprobe
+ * @p:  probe to unregister; may be NULL (no-op)
  *
- * When removing a single probe, prefer this over the three-phase API.
- * Safe to call from process context only (uprobe_unregister_sync() may
- * schedule).
+ * Dequeues the uprobe and waits synchronously for all in-flight handlers
+ * to complete.
  */
-void rv_uprobe_detach(struct rv_uprobe *p);
+void rv_uprobe_unregister(struct rv_uprobe *p);
=20
 /**
  * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
@@ -91,9 +64,7 @@ void rv_uprobe_detach(struct rv_uprobe *p);
  *
  * Removes the uprobe from the uprobe subsystem but does NOT wait for
  * in-flight handlers to complete.  The caller must call rv_uprobe_sync()
- * before calling rv_uprobe_free() on the same probe.
- *
- * Use this to batch multiple deregistrations before a single rv_uprobe_sy=
nc().
+ * before freeing any container holding this probe.
  */
 void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
=20
@@ -101,19 +72,8 @@ void rv_uprobe_unregister_nosync(struct rv_uprobe *p);
  * rv_uprobe_sync - wait for all in-flight uprobe handlers to complete
  *
  * Global barrier: waits for every in-flight uprobe handler across the sys=
tem
- * to finish.  Call once after a batch of rv_uprobe_unregister_nosync() ca=
lls
- * and before any rv_uprobe_free() call.
+ * to finish.
  */
 void rv_uprobe_sync(void);
=20
-/**
- * rv_uprobe_free - release resources of a previously deregistered probe
- * @p:  probe to free; may be NULL (no-op)
- *
- * Releases the path reference and frees the rv_uprobe struct.  Must only
- * be called after rv_uprobe_sync() has returned.  The caller's priv data
- * is NOT freed.
- */
-void rv_uprobe_free(struct rv_uprobe *p);
-
 #endif /* _RV_UPROBE_H */
diff --git a/kernel/trace/rv/monitors/tlob/tlob.c b/kernel/trace/rv/monitor=
s/tlob/tlob.c
index d8e0c47947..28a6c740c7 100644
--- a/kernel/trace/rv/monitors/tlob/tlob.c
+++ b/kernel/trace/rv/monitors/tlob/tlob.c
@@ -252,8 +252,8 @@ struct tlob_uprobe_binding {
 =09char=09=09=09binpath[TLOB_MAX_PATH];
 =09loff_t=09=09=09offset_start;
 =09loff_t=09=09=09offset_stop;
-=09struct rv_uprobe=09*start_probe;
-=09struct rv_uprobe=09*stop_probe;
+=09DECLARE_RV_UPROBE(start_probe);
+=09DECLARE_RV_UPROBE(stop_probe);
 };
=20
 /* RCU callback: free the slab once no readers remain. */
@@ -512,16 +512,16 @@ int tlob_stop_task(struct task_struct *task)
 EXPORT_SYMBOL_GPL(tlob_stop_task);
=20
=20
-static int tlob_uprobe_entry_handler(struct rv_uprobe *p, struct pt_regs *=
regs,
+static int tlob_uprobe_entry_handler(struct uprobe_consumer *self, struct =
pt_regs *regs,
 =09=09=09=09     __u64 *data)
 {
-=09struct tlob_uprobe_binding *b =3D p->priv;
+=09struct tlob_uprobe_binding *b =3D container_of(self, struct tlob_uprobe=
_binding, start_probe.uc);
=20
 =09tlob_start_task(current, b->threshold_ns);
 =09return 0;
 }
=20
-static int tlob_uprobe_stop_handler(struct rv_uprobe *p, struct pt_regs *r=
egs,
+static int tlob_uprobe_stop_handler(struct uprobe_consumer *self, struct p=
t_regs *regs,
 =09=09=09=09    __u64 *data)
 {
 =09tlob_stop_task(current);
@@ -537,6 +537,7 @@ static int tlob_add_uprobe(u64 threshold_ns, const char=
 *binpath,
 {
 =09struct tlob_uprobe_binding *b, *tmp_b;
 =09char pathbuf[TLOB_MAX_PATH];
+=09struct inode *inode;
 =09struct path path;
 =09char *canon;
 =09int ret;
@@ -561,10 +562,12 @@ static int tlob_add_uprobe(u64 threshold_ns, const ch=
ar *binpath,
 =09=09goto err_path;
 =09}
=20
-=09/* Reject duplicate start offset for the same binary. */
+=09inode =3D d_real_inode(path.dentry);
+
+=09/* Reject duplicate start offset for the same binary inode. */
 =09list_for_each_entry(tmp_b, &tlob_uprobe_list, list) {
 =09=09if (tmp_b->offset_start =3D=3D offset_start &&
-=09=09    tmp_b->start_probe->path.dentry =3D=3D path.dentry) {
+=09=09    tmp_b->start_probe.inode =3D=3D inode) {
 =09=09=09ret =3D -EEXIST;
 =09=09=09goto err_path;
 =09=09}
@@ -577,29 +580,25 @@ static int tlob_add_uprobe(u64 threshold_ns, const ch=
ar *binpath,
 =09}
 =09strscpy(b->binpath, canon, sizeof(b->binpath));
=20
-=09/* Both probes share b (priv) and path; attach_path refs path itself. *=
/
-=09b->start_probe =3D rv_uprobe_attach_path(&path, offset_start,
-=09=09=09=09=09       tlob_uprobe_entry_handler, NULL, b);
-=09if (IS_ERR(b->start_probe)) {
-=09=09ret =3D PTR_ERR(b->start_probe);
-=09=09b->start_probe =3D NULL;
-=09=09goto err_path;
-=09}
+=09path_put(&path);
+
+=09/* Both probes are registered directly on the embedded fields */
+=09ret =3D rv_uprobe_register(b->binpath, offset_start, &b->start_probe,
+=09=09=09=09 tlob_uprobe_entry_handler, NULL);
+=09if (ret)
+=09=09goto err_free;
=20
-=09b->stop_probe =3D rv_uprobe_attach_path(&path, offset_stop,
-=09=09=09=09=09      tlob_uprobe_stop_handler, NULL, b);
-=09if (IS_ERR(b->stop_probe)) {
-=09=09ret =3D PTR_ERR(b->stop_probe);
-=09=09b->stop_probe =3D NULL;
+=09ret =3D rv_uprobe_register(b->binpath, offset_stop, &b->stop_probe,
+=09=09=09=09 tlob_uprobe_stop_handler, NULL);
+=09if (ret)
 =09=09goto err_start;
-=09}
=20
-=09path_put(&path);
 =09list_add_tail(&b->list, &tlob_uprobe_list);
 =09return 0;
=20
 err_start:
-=09rv_uprobe_detach(b->start_probe);
+=09rv_uprobe_unregister(&b->start_probe);
+=09goto err_free;
 err_path:
 =09path_put(&path);
 err_free:
@@ -611,21 +610,24 @@ static int tlob_remove_uprobe_by_key(loff_t offset_st=
art, const char *binpath)
 {
 =09struct tlob_uprobe_binding *b, *tmp;
 =09struct path remove_path;
+=09struct inode *inode;
 =09int ret;
=20
 =09ret =3D kern_path(binpath, LOOKUP_FOLLOW, &remove_path);
 =09if (ret)
 =09=09return ret;
=20
+=09inode =3D d_real_inode(remove_path.dentry);
+
 =09ret =3D -ENOENT;
 =09list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
 =09=09if (b->offset_start !=3D offset_start)
 =09=09=09continue;
-=09=09if (b->start_probe->path.dentry !=3D remove_path.dentry)
+=09=09if (b->start_probe.inode !=3D inode)
 =09=09=09continue;
 =09=09list_del(&b->list);
-=09=09rv_uprobe_detach(b->start_probe);
-=09=09rv_uprobe_detach(b->stop_probe);
+=09=09rv_uprobe_unregister(&b->start_probe);
+=09=09rv_uprobe_unregister(&b->stop_probe);
 =09=09kfree(b);
 =09=09ret =3D 0;
 =09=09break;
@@ -643,8 +645,8 @@ static void tlob_remove_all_uprobes(void)
 =09mutex_lock(&tlob_uprobe_mutex);
 =09list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
 =09=09list_move(&b->list, &pending);
-=09=09rv_uprobe_unregister_nosync(b->start_probe);
-=09=09rv_uprobe_unregister_nosync(b->stop_probe);
+=09=09rv_uprobe_unregister_nosync(&b->start_probe);
+=09=09rv_uprobe_unregister_nosync(&b->stop_probe);
 =09}
 =09mutex_unlock(&tlob_uprobe_mutex);
=20
@@ -658,8 +660,6 @@ static void tlob_remove_all_uprobes(void)
 =09rv_uprobe_sync();
=20
 =09list_for_each_entry_safe(b, tmp, &pending, list) {
-=09=09rv_uprobe_free(b->start_probe);
-=09=09rv_uprobe_free(b->stop_probe);
 =09=09kfree(b);
 =09}
 }
diff --git a/kernel/trace/rv/rv_uprobe.c b/kernel/trace/rv/rv_uprobe.c
index 3d8b764dde..69b8b0c27e 100644
--- a/kernel/trace/rv/rv_uprobe.c
+++ b/kernel/trace/rv/rv_uprobe.c
@@ -10,149 +10,74 @@
 #include <linux/uprobes.h>
 #include <rv/rv_uprobe.h>
=20
-/*
- * Private extension of struct rv_uprobe.  Allocated by rv_uprobe_attach*(=
)
- * and returned to callers as &impl->pub.
- */
-struct rv_uprobe_impl {
-=09struct rv_uprobe=09pub;=09/* must be first; callers hold &pub */
-=09struct uprobe_consumer=09uc;
-=09struct uprobe=09=09*uprobe;
-=09int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data)=
;
-=09int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
-=09=09=09struct pt_regs *regs, __u64 *data);
-};
-
-static int rv_uprobe_handler(struct uprobe_consumer *uc,
-=09=09=09     struct pt_regs *regs, __u64 *data)
-{
-=09struct rv_uprobe_impl *impl =3D container_of(uc, struct rv_uprobe_impl,=
 uc);
-
-=09if (impl->entry_fn)
-=09=09return impl->entry_fn(&impl->pub, regs, data);
-=09return 0;
-}
-
-static int rv_uprobe_ret_handler(struct uprobe_consumer *uc,
-=09=09=09=09 unsigned long func,
-=09=09=09=09 struct pt_regs *regs, __u64 *data)
-{
-=09struct rv_uprobe_impl *impl =3D container_of(uc, struct rv_uprobe_impl,=
 uc);
-
-=09if (impl->ret_fn)
-=09=09return impl->ret_fn(&impl->pub, func, regs, data);
-=09return 0;
-}
-
-static struct rv_uprobe *
-__rv_uprobe_attach(struct inode *inode, struct path *path, loff_t offset,
-=09=09   int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 =
*data),
-=09=09   int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
-=09=09=09=09   struct pt_regs *regs, __u64 *data),
-=09=09   void *priv)
-{
-=09struct rv_uprobe_impl *impl;
-=09int ret;
-
-=09if (!entry_fn && !ret_fn)
-=09=09return ERR_PTR(-EINVAL);
-
-=09impl =3D kzalloc_obj(*impl, GFP_KERNEL);
-=09if (!impl)
-=09=09return ERR_PTR(-ENOMEM);
-
-=09impl->pub.offset =3D offset;
-=09impl->pub.priv   =3D priv;
-=09impl->entry_fn   =3D entry_fn;
-=09impl->ret_fn     =3D ret_fn;
-=09path_get(path);
-=09impl->pub.path   =3D *path;
-
-=09if (entry_fn)
-=09=09impl->uc.handler     =3D rv_uprobe_handler;
-=09if (ret_fn)
-=09=09impl->uc.ret_handler =3D rv_uprobe_ret_handler;
-
-=09impl->uprobe =3D uprobe_register(inode, offset, 0, &impl->uc);
-=09if (IS_ERR(impl->uprobe)) {
-=09=09ret =3D PTR_ERR(impl->uprobe);
-=09=09path_put(&impl->pub.path);
-=09=09kfree(impl);
-=09=09return ERR_PTR(ret);
-=09}
-
-=09return &impl->pub;
-}
-
-/**
- * rv_uprobe_attach_path - register an uprobe given an already-resolved pa=
th
- */
-struct rv_uprobe *rv_uprobe_attach_path(struct path *path, loff_t offset,
-=09int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data)=
,
-=09int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
-=09=09=09struct pt_regs *regs, __u64 *data),
-=09void *priv)
-{
-=09struct inode *inode =3D d_real_inode(path->dentry);
-
-=09return __rv_uprobe_attach(inode, path, offset, entry_fn, ret_fn, priv);
-}
-EXPORT_SYMBOL_GPL(rv_uprobe_attach_path);
-
 /**
- * rv_uprobe_attach - resolve binpath and register an uprobe
+ * rv_uprobe_register - resolve binpath and register an uprobe
  */
-struct rv_uprobe *rv_uprobe_attach(const char *binpath, loff_t offset,
-=09int (*entry_fn)(struct rv_uprobe *p, struct pt_regs *regs, __u64 *data)=
,
-=09int (*ret_fn)(struct rv_uprobe *p, unsigned long func,
-=09=09=09struct pt_regs *regs, __u64 *data),
-=09void *priv)
+int rv_uprobe_register(const char *binpath, loff_t offset, struct rv_uprob=
e *p,
+=09int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u6=
4 *data),
+=09int (*ret_handler)(struct uprobe_consumer *self, unsigned long func,
+=09=09=09   struct pt_regs *regs, __u64 *data))
 {
-=09struct rv_uprobe *p;
+=09struct inode *inode;
 =09struct path path;
 =09int ret;
=20
+=09if (!handler && !ret_handler)
+=09=09return -EINVAL;
+
 =09ret =3D kern_path(binpath, LOOKUP_FOLLOW, &path);
 =09if (ret)
-=09=09return ERR_PTR(ret);
+=09=09return ret;
=20
 =09if (!d_is_reg(path.dentry)) {
 =09=09path_put(&path);
-=09=09return ERR_PTR(-EINVAL);
+=09=09return -EINVAL;
 =09}
=20
-=09p =3D rv_uprobe_attach_path(&path, offset, entry_fn, ret_fn, priv);
+=09inode =3D d_real_inode(path.dentry);
+
+=09p->uc.handler     =3D handler;
+=09p->uc.ret_handler =3D ret_handler;
+=09p->inode          =3D inode;
+
+=09p->uprobe =3D uprobe_register(inode, offset, 0, &p->uc);
 =09path_put(&path);
-=09return p;
+
+=09if (IS_ERR(p->uprobe)) {
+=09=09ret =3D PTR_ERR(p->uprobe);
+=09=09p->uprobe =3D NULL;
+=09=09p->inode  =3D NULL;
+=09=09return ret;
+=09}
+
+=09return 0;
 }
-EXPORT_SYMBOL_GPL(rv_uprobe_attach);
+EXPORT_SYMBOL_GPL(rv_uprobe_register);
=20
 /**
- * rv_uprobe_detach - synchronously unregister an uprobe and free it
+ * rv_uprobe_unregister - synchronously unregister a uprobe
  */
-void rv_uprobe_detach(struct rv_uprobe *p)
+void rv_uprobe_unregister(struct rv_uprobe *p)
 {
-=09if (!p)
+=09if (!p || IS_ERR_OR_NULL(p->uprobe))
 =09=09return;
=20
 =09rv_uprobe_unregister_nosync(p);
 =09rv_uprobe_sync();
-=09rv_uprobe_free(p);
 }
-EXPORT_SYMBOL_GPL(rv_uprobe_detach);
+EXPORT_SYMBOL_GPL(rv_uprobe_unregister);
=20
 /**
  * rv_uprobe_unregister_nosync - dequeue an uprobe without waiting
  */
 void rv_uprobe_unregister_nosync(struct rv_uprobe *p)
 {
-=09struct rv_uprobe_impl *impl;
-
-=09if (!p)
+=09if (!p || IS_ERR_OR_NULL(p->uprobe))
 =09=09return;
=20
-=09impl =3D container_of(p, struct rv_uprobe_impl, pub);
-=09uprobe_unregister_nosync(impl->uprobe, &impl->uc);
+=09uprobe_unregister_nosync(p->uprobe, &p->uc);
+=09p->uprobe =3D NULL;
+=09p->inode  =3D NULL;
 }
 EXPORT_SYMBOL_GPL(rv_uprobe_unregister_nosync);
=20
@@ -164,19 +89,3 @@ void rv_uprobe_sync(void)
 =09uprobe_unregister_sync();
 }
 EXPORT_SYMBOL_GPL(rv_uprobe_sync);
-
-/**
- * rv_uprobe_free - release resources of a previously deregistered probe
- */
-void rv_uprobe_free(struct rv_uprobe *p)
-{
-=09struct rv_uprobe_impl *impl;
-
-=09if (!p)
-=09=09return;
-
-=09impl =3D container_of(p, struct rv_uprobe_impl, pub);
-=09path_put(&p->path);
-=09kfree(impl);
-}
-EXPORT_SYMBOL_GPL(rv_uprobe_free);

