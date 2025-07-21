Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED5F28D8EB;
	Mon, 21 Jul 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091255; cv=none; b=DbZoNMcNk6e5gqPhf0VN475uhe1iwYnAu0ZXdGHDotlRD8W0BlORPPb5cb+2lfrERwHgY3NC7m4gPUcn9lMB7aSuWwij1Zsdg1klQ+Kb2SsV9gwUV3S34jRl9k1ryl9L4qBsorADiDxrMy8R89NbpYLa5HKWunuG8ONXYivDQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091255; c=relaxed/simple;
	bh=KmaBjIMBz488nseXbo641XAkic/t7NfHwWGp0q0tZ3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MPN/90fjLaIP7uoP6s3kjEN+/ZwaJSMvjAWyB0abWev40WhbdzjLfSTtYTp01+NWpzoFkn0xbPFF17O6KVWUykBGy2xdZMi1UWhxvP0Tze/p2YhQSqDkwud1JVUMKP4i3qpND316isbjHLdM4qcxIGaqza3+DVc5/SSboONfEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OANk9jPd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sASKuOjg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OANk9jPd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sASKuOjg"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753091251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ob3X3Y1byqxwIhz+EUdnbey/6ypvamIibzX5fTu/udI=;
	b=OANk9jPdPVavx631ovV8haa6+cQwClI3Pesj2zgpUyFFidTKuLz2xZ9cCFJKLCpqIT5gSj
	V6hCuJoBVBMP4iIADPqhf5bf7IJTiodvXyZd4WZPrHXE11EcY/FyTU1AYsZfPYXNqYrozy
	ga2GJiemLYgH+vjS0ELUEeyGAHVz3GIvapwq1YEOgfM6NE0fj9zGGLQejgROPMP5NWS34k
	r/ZHASpCEsoO2ovQFhY9cA42SlnvqyFk7Mofl60+l5+QcukHbZ7zwR8l1O8aihmwzxdvrJ
	VNd5ajKLYpkdRSZUZ4M0zYZ5iFTpy3f8JaO1RXWO5oiLCqKFJi4ZGpJcqXKqAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753091251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ob3X3Y1byqxwIhz+EUdnbey/6ypvamIibzX5fTu/udI=;
	b=sASKuOjgn6rB483okr1a+TQw3BeYNgt79o/IRVfJRXs+BOBoQ/1eh1GZzRth/Gu0ekyuRI
	UWrB1qNMWuUD+NCg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 5/6] rv: Remove the nop reactor
Date: Mon, 21 Jul 2025 11:47:12 +0200
Message-Id: <21a530ffb705887d7aed18255572521e5b880bc0.1753091084.git.namcao@linutronix.de>
In-Reply-To: <cover.1753091084.git.namcao@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As suggested by the name, the nop reactor does not do anything. It is the
default reactor when nothing else is selected.

However, the monitors already null-check the reactor function pointers.
Thus, instead of a nop reactor, just set the react function pointer to
NULL. The nop reactor can then be removed.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv_reactors.c | 63 ++++++-----------------------------
 1 file changed, 11 insertions(+), 52 deletions(-)

diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index a8e849e6cd85..aee622e4b833 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -70,17 +70,6 @@
  */
 static LIST_HEAD(rv_reactors_list);
=20
-static struct rv_reactor *get_reactor_rdef_by_name(char *name)
-{
-	struct rv_reactor *r;
-
-	list_for_each_entry(r, &rv_reactors_list, list) {
-		if (strcmp(name, r->name) =3D=3D 0)
-			return r;
-	}
-	return NULL;
-}
-
 /*
  * Available reactors seq functions.
  */
@@ -174,7 +163,7 @@ static void monitor_swap_reactors_single(struct rv_moni=
tor *mon,
=20
 	mon->reactor =3D reactor;
 	mon->reacting =3D reacting;
-	mon->react =3D reactor->react;
+	mon->react =3D reactor ? reactor->react : NULL;
=20
 	/* enable only once if iterating through a container */
 	if (monitor_enabled && !nested)
@@ -210,10 +199,15 @@ monitor_reactors_write(struct file *file, const char =
__user *user_buf,
 	struct rv_reactor *reactor;
 	struct seq_file *seq_f;
 	int retval =3D -EINVAL;
-	bool enable;
 	char *ptr;
 	int len;
=20
+	/*
+	 * See monitor_reactors_open()
+	 */
+	seq_f =3D file->private_data;
+	mon =3D seq_f->private;
+
 	if (count < 1 || count > MAX_RV_REACTOR_NAME_SIZE + 1)
 		return -EINVAL;
=20
@@ -226,14 +220,10 @@ monitor_reactors_write(struct file *file, const char =
__user *user_buf,
 	ptr =3D strim(buff);
=20
 	len =3D strlen(ptr);
-	if (!len)
+	if (!len) {
+		monitor_swap_reactors(mon, NULL, false);
 		return count;
-
-	/*
-	 * See monitor_reactors_open()
-	 */
-	seq_f =3D file->private_data;
-	mon =3D seq_f->private;
+	}
=20
 	mutex_lock(&rv_interface_lock);
=20
@@ -243,12 +233,7 @@ monitor_reactors_write(struct file *file, const char _=
_user *user_buf,
 		if (strcmp(ptr, reactor->name) !=3D 0)
 			continue;
=20
-		if (strcmp(reactor->name, "nop"))
-			enable =3D false;
-		else
-			enable =3D true;
-
-		monitor_swap_reactors(mon, reactor, enable);
+		monitor_swap_reactors(mon, reactor, true);
=20
 		retval =3D count;
 		break;
@@ -435,32 +420,12 @@ int reactor_populate_monitor(struct rv_monitor *mon)
 	if (!tmp)
 		return -ENOMEM;
=20
-	/*
-	 * Configure as the rv_nop reactor.
-	 */
-	mon->reactor =3D get_reactor_rdef_by_name("nop");
-	mon->reacting =3D false;
-
 	return 0;
 }
=20
-/*
- * Nop reactor register
- */
-__printf(1, 2) static void rv_nop_reaction(const char *msg, ...)
-{
-}
-
-static struct rv_reactor rv_nop =3D {
-	.name =3D "nop",
-	.description =3D "no-operation reactor: do nothing.",
-	.react =3D rv_nop_reaction
-};
-
 int init_rv_reactors(struct dentry *root_dir)
 {
 	struct dentry *available, *reacting;
-	int retval;
=20
 	available =3D rv_create_file("available_reactors", RV_MODE_READ, root_dir=
, NULL,
 				   &available_reactors_ops);
@@ -471,16 +436,10 @@ int init_rv_reactors(struct dentry *root_dir)
 	if (!reacting)
 		goto rm_available;
=20
-	retval =3D __rv_register_reactor(&rv_nop);
-	if (retval)
-		goto rm_reacting;
-
 	turn_reacting_on();
=20
 	return 0;
=20
-rm_reacting:
-	rv_remove(reacting);
 rm_available:
 	rv_remove(available);
 out_err:
--=20
2.39.5

