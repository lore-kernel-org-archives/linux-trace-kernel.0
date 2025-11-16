Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211C72F90CE;
	Sun, 16 Nov 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763307331; cv=none; b=dMLsbnPJZQajQTCHJKiaLjpv5P80EzFHIzibFouv/0ls9BVfcyngwRdGuKgz4VbUKzhTth/fFPO1X9uBlz770Buphgvm+6hI/EubOmDm11NypGd+roznH/DtvnOMEWOD9MpjHoAtb2RVTfCf4IRChfoLavbfKX0x1HtMtqh6D/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763307331; c=relaxed/simple;
	bh=1AUDK2k6BYXs9Ocop6CTNDxSsPHbU0eFMhJqIPeQSxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HO2wGLrZBaEaQv+5+Yt9IHBED0lehhdcs/N87SYqeHCMmUuGDcpvO6TQOJxDfe4uMPK/E+uA0wFWwocfQQfGajaf44i3+aiU414zeEkypPAS9wFibYZD97vAdFoSj5i2rYfenarcTgICzs6VQ+Ux9U+5pGC1SNaimmljBWZPZa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wLkuAWOy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PfMDTDyl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wLkuAWOy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PfMDTDyl"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763307323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mdj6MrQjodzZlCz5/uyCgL71sBo/Om3/GSK5b71/bpg=;
	b=wLkuAWOywRTeCMTOGwKvcSVEvvNCzJgq5jZf8N/PHrlLmpIfk9PL8lfxXiRNT1Hn9NOFo4
	rbz2IQp0r2ih6IsLoxmBoqPgwYO1jWCkKWJv87WnhlkbnR/k9XLBsOTrxeBUvb3hI6Z86i
	INpyi7yr5PQEpeybO2lmVsGB6mgbQHuplroAOgE0iGtzHGhW4eEu6+6XeAd1XAS9PDtv7z
	w2uKSnvqmOAyd8jsTpXtS3apOoDuvQYYcm4Ih9vTzWzwXLAxGSdGBJzugXpR90m2DFTxuK
	KPqCdOMiob7OGbrHqb1fnZsfx7gkmAxamKK3Gemm2B3moFrwVCkXV6o3yM/hOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763307323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mdj6MrQjodzZlCz5/uyCgL71sBo/Om3/GSK5b71/bpg=;
	b=PfMDTDylppHVWew/70IaWcD05WFwVKvh8HD3iAy1hW3ovwzwCshHCGFMgd0ujHN0fh2zDJ
	92RJGdSRDsf9H1Cw==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/2] rv: Convert to use __free
Date: Sun, 16 Nov 2025 15:35:12 +0000
Message-ID: <6b2a618815b45ac4ac09976ef4fb0bd3635c143d.1763306824.git.namcao@linutronix.de>
In-Reply-To: <cover.1763306824.git.namcao@linutronix.de>
References: <cover.1763306824.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Convert to use __free to tidy up the code.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv.c          | 65 +++++++++++++++--------------------
 kernel/trace/rv/rv.h          |  6 ++--
 kernel/trace/rv/rv_reactors.c | 32 ++++++++---------
 3 files changed, 46 insertions(+), 57 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index b1059a3cf4fa..e83dc9f0c7bb 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -420,35 +420,28 @@ static const struct file_operations interface_desc_fo=
ps =3D {
 static int create_monitor_dir(struct rv_monitor *mon, struct rv_monitor *p=
arent)
 {
 	struct dentry *root =3D parent ? parent->root_d : get_monitors_root();
-	const char *name =3D mon->name;
+	struct dentry *dir __free(rv_remove) =3D rv_create_dir(mon->name, root);
 	struct dentry *tmp;
 	int retval;
=20
-	mon->root_d =3D rv_create_dir(name, root);
-	if (!mon->root_d)
+	if (!dir)
 		return -ENOMEM;
=20
-	tmp =3D rv_create_file("enable", RV_MODE_WRITE, mon->root_d, mon, &interf=
ace_enable_fops);
-	if (!tmp) {
-		retval =3D -ENOMEM;
-		goto out_remove_root;
-	}
+	tmp =3D rv_create_file("enable", RV_MODE_WRITE, dir, mon, &interface_enab=
le_fops);
+	if (!tmp)
+		return -ENOMEM;
=20
-	tmp =3D rv_create_file("desc", RV_MODE_READ, mon->root_d, mon, &interface=
_desc_fops);
-	if (!tmp) {
-		retval =3D -ENOMEM;
-		goto out_remove_root;
-	}
+	tmp =3D rv_create_file("desc", RV_MODE_READ, dir, mon, &interface_desc_fo=
ps);
+	if (!tmp)
+		return -ENOMEM;
=20
-	retval =3D reactor_populate_monitor(mon);
+	retval =3D reactor_populate_monitor(mon, dir);
 	if (retval)
-		goto out_remove_root;
+		return retval;
=20
+	mon->root_d =3D dir;
+	retain_and_null_ptr(dir);
 	return 0;
-
-out_remove_root:
-	rv_remove(mon->root_d);
-	return retval;
 }
=20
 /*
@@ -827,39 +820,37 @@ int __init rv_init_interface(void)
 {
 	struct dentry *tmp;
 	int retval;
+	struct dentry *root_dir __free(rv_remove) =3D rv_create_dir("rv", NULL);
=20
-	rv_root.root_dir =3D rv_create_dir("rv", NULL);
-	if (!rv_root.root_dir)
-		goto out_err;
+	if (!root_dir)
+		return 1;
=20
-	rv_root.monitors_dir =3D rv_create_dir("monitors", rv_root.root_dir);
+	rv_root.monitors_dir =3D rv_create_dir("monitors", root_dir);
 	if (!rv_root.monitors_dir)
-		goto out_err;
+		return 1;
=20
-	tmp =3D rv_create_file("available_monitors", RV_MODE_READ, rv_root.root_d=
ir, NULL,
+	tmp =3D rv_create_file("available_monitors", RV_MODE_READ, root_dir, NULL,
 			     &available_monitors_ops);
 	if (!tmp)
-		goto out_err;
+		return 1;
=20
-	tmp =3D rv_create_file("enabled_monitors", RV_MODE_WRITE, rv_root.root_di=
r, NULL,
+	tmp =3D rv_create_file("enabled_monitors", RV_MODE_WRITE, root_dir, NULL,
 			     &enabled_monitors_ops);
 	if (!tmp)
-		goto out_err;
+		return 1;
=20
-	tmp =3D rv_create_file("monitoring_on", RV_MODE_WRITE, rv_root.root_dir, =
NULL,
+	tmp =3D rv_create_file("monitoring_on", RV_MODE_WRITE, root_dir, NULL,
 			     &monitoring_on_fops);
 	if (!tmp)
-		goto out_err;
-	retval =3D init_rv_reactors(rv_root.root_dir);
+		return 1;
+	retval =3D init_rv_reactors(root_dir);
 	if (retval)
-		goto out_err;
+		return 1;
=20
 	turn_monitoring_on();
=20
-	return 0;
+	rv_root.root_dir =3D root_dir;
+	retain_and_null_ptr(root_dir);
=20
-out_err:
-	rv_remove(rv_root.root_dir);
-	printk(KERN_ERR "RV: Error while creating the RV interface\n");
-	return 1;
+	return 0;
 }
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 1485a70c1bf4..8661d1b6ede4 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -17,6 +17,8 @@ struct rv_interface {
 #define rv_create_file			tracefs_create_file
 #define rv_remove			tracefs_remove
=20
+DEFINE_FREE(rv_remove, struct dentry *, rv_remove(_T));
+
 #define MAX_RV_MONITOR_NAME_SIZE	32
 #define MAX_RV_REACTOR_NAME_SIZE	32
=20
@@ -30,10 +32,10 @@ bool rv_is_container_monitor(struct rv_monitor *mon);
 bool rv_is_nested_monitor(struct rv_monitor *mon);
=20
 #ifdef CONFIG_RV_REACTORS
-int reactor_populate_monitor(struct rv_monitor *mon);
+int reactor_populate_monitor(struct rv_monitor *mon, struct dentry *root);
 int init_rv_reactors(struct dentry *root_dir);
 #else
-static inline int reactor_populate_monitor(struct rv_monitor *mon)
+static inline int reactor_populate_monitor(struct rv_monitor *mon, struct =
dentry *root)
 {
 	return 0;
 }
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index 37d1d37a27a3..ce7d22cbde57 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -404,14 +404,15 @@ static const struct file_operations reacting_on_fops =
=3D {
 /**
  * reactor_populate_monitor - creates per monitor reactors file
  * @mon:	The monitor.
+ * @root:	The directory of the monitor.
  *
  * Returns 0 if successful, error otherwise.
  */
-int reactor_populate_monitor(struct rv_monitor *mon)
+int reactor_populate_monitor(struct rv_monitor *mon, struct dentry *root)
 {
 	struct dentry *tmp;
=20
-	tmp =3D rv_create_file("reactors", RV_MODE_WRITE, mon->root_d, mon, &moni=
tor_reactors_ops);
+	tmp =3D rv_create_file("reactors", RV_MODE_WRITE, root, mon, &monitor_rea=
ctors_ops);
 	if (!tmp)
 		return -ENOMEM;
=20
@@ -438,30 +439,25 @@ static struct rv_reactor rv_nop =3D {
=20
 int init_rv_reactors(struct dentry *root_dir)
 {
-	struct dentry *available, *reacting;
 	int retval;
=20
-	available =3D rv_create_file("available_reactors", RV_MODE_READ, root_dir=
, NULL,
-				   &available_reactors_ops);
-	if (!available)
-		goto out_err;
+	struct dentry *available __free(rv_remove) =3D
+		rv_create_file("available_reactors", RV_MODE_READ, root_dir,
+				NULL, &available_reactors_ops);
=20
-	reacting =3D rv_create_file("reacting_on", RV_MODE_WRITE, root_dir, NULL,=
 &reacting_on_fops);
-	if (!reacting)
-		goto rm_available;
+	struct dentry *reacting =3D
+		rv_create_file("reacting_on", RV_MODE_WRITE, root_dir, NULL, &reacting_o=
n_fops);
+
+	if (!reacting || !available)
+		return -ENOMEM;
=20
 	retval =3D __rv_register_reactor(&rv_nop);
 	if (retval)
-		goto rm_reacting;
+		return retval;
=20
 	turn_reacting_on();
=20
+	retain_and_null_ptr(available);
+	retain_and_null_ptr(reacting);
 	return 0;
-
-rm_reacting:
-	rv_remove(reacting);
-rm_available:
-	rv_remove(available);
-out_err:
-	return -ENOMEM;
 }
--=20
2.51.0

