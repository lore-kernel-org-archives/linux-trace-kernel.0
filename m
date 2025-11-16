Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124530ACFF;
	Sun, 16 Nov 2025 15:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763307331; cv=none; b=bYc7ZojH1XBWpRHLqUg6uCqwFARyfHM2j4VMeiC+kjm2xhSKy5qMMENiPg8ZWw8WHFvFEBd4zGpOAuXTFph5/LMXW02L29jWCacuFqLnXifHfoBRYaig7QsINEDN0zResOBo9nqI0S1ux5YSHjGX56dRn5MSm7GX6AU9NdnEKB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763307331; c=relaxed/simple;
	bh=jE5CLOdngilNCk2xW/6WyHceE/D+Y7M6FypvSBe/dp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNXlKCAOmzTog+fzviTka7TK3LcNYud0k+dnTmyttQclLPjFx91526v4LTgmT05eFEZ2ct6o3hVIqYxKgEHRs3N+W6i+JlzVgCI3qQZghtUD86pAPb/IPZgNtlZeC+bg3jXlFxrH3YnzMnY01glGan3HGSdvn6g0+InBk9jqLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVx1A/uL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VAHh3/bV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVx1A/uL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VAHh3/bV"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763307322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kWrUXN5HQBr7r6r5KX/Cf7xKxvk1/tdF/q9prsBnvI=;
	b=GVx1A/uL4wsMncIeagQm/3+jifiqcVcix7iVh0p4Nxiy91KD4WeSkhshTQO6c8P33EeUEs
	laIGlZKEwuSUU6iMj9Dd/k+o82dUwiXiHzBEt3WOQYt1/YDBBfo1iYYqki+syHTIHSSajR
	ZDfX1dIfo4LSdYRQlH7iOphrK3xqm3dWqEQDM8F+AbS6R0fITHFvh4h/OMa8LzFVT1nt7V
	IM7mj+y97NBdJPCABWM1sk1nqjrsMwSI7VmBpuwLPFBVKb/F1E9xtnhrDtsMZuCCOrlkMf
	25TC4f7u/31OhYg5grwfIXNxxX7GPTaQFi/2X24yVNaRVsspjUGWiY9d0ZMSow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763307322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kWrUXN5HQBr7r6r5KX/Cf7xKxvk1/tdF/q9prsBnvI=;
	b=VAHh3/bV7ceaz/5CSqLCLMVL66vjYtI3vkAJGsgsR3yxkC0EyHHHN5VlkX97WXf+0roAY5
	xEtQ08xUDeYF4rAQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/2] rv: Convert to use lock guard
Date: Sun, 16 Nov 2025 15:35:11 +0000
Message-ID: <dbefeb868093c40d4b29fd6b57294a6aa011b719.1763306824.git.namcao@linutronix.de>
In-Reply-To: <cover.1763306824.git.namcao@linutronix.de>
References: <cover.1763306824.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Convert to use lock guard to tidy up the code.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv.c          | 39 ++++++++++++-----------------------
 kernel/trace/rv/rv_reactors.c | 26 +++++++----------------
 2 files changed, 20 insertions(+), 45 deletions(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 43e9ea473cda..b1059a3cf4fa 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -375,15 +375,13 @@ static ssize_t monitor_enable_write_data(struct file =
*filp, const char __user *u
 	if (retval)
 		return retval;
=20
-	mutex_lock(&rv_interface_lock);
+	guard(mutex)(&rv_interface_lock);
=20
 	if (val)
 		retval =3D rv_enable_monitor(mon);
 	else
 		retval =3D rv_disable_monitor(mon);
=20
-	mutex_unlock(&rv_interface_lock);
-
 	return retval ? : count;
 }
=20
@@ -568,7 +566,7 @@ static void disable_all_monitors(void)
 	struct rv_monitor *mon;
 	int enabled =3D 0;
=20
-	mutex_lock(&rv_interface_lock);
+	guard(mutex)(&rv_interface_lock);
=20
 	list_for_each_entry(mon, &rv_monitors_list, list)
 		enabled +=3D __rv_disable_monitor(mon, false);
@@ -581,8 +579,6 @@ static void disable_all_monitors(void)
 		 */
 		tracepoint_synchronize_unregister();
 	}
-
-	mutex_unlock(&rv_interface_lock);
 }
=20
 static int enabled_monitors_open(struct inode *inode, struct file *file)
@@ -623,7 +619,7 @@ static ssize_t enabled_monitors_write(struct file *filp=
, const char __user *user
 	if (!len)
 		return count;
=20
-	mutex_lock(&rv_interface_lock);
+	guard(mutex)(&rv_interface_lock);
=20
 	retval =3D -EINVAL;
=20
@@ -644,13 +640,11 @@ static ssize_t enabled_monitors_write(struct file *fi=
lp, const char __user *user
 		else
 			retval =3D rv_disable_monitor(mon);
=20
-		if (!retval)
-			retval =3D count;
-
-		break;
+		if (retval)
+			return retval;
+		return count;
 	}
=20
-	mutex_unlock(&rv_interface_lock);
 	return retval;
 }
=20
@@ -737,7 +731,7 @@ static ssize_t monitoring_on_write_data(struct file *fi=
lp, const char __user *us
 	if (retval)
 		return retval;
=20
-	mutex_lock(&rv_interface_lock);
+	guard(mutex)(&rv_interface_lock);
=20
 	if (val)
 		turn_monitoring_on_with_reset();
@@ -750,8 +744,6 @@ static ssize_t monitoring_on_write_data(struct file *fi=
lp, const char __user *us
 	 */
 	tracepoint_synchronize_unregister();
=20
-	mutex_unlock(&rv_interface_lock);
-
 	return count;
 }
=20
@@ -784,28 +776,26 @@ int rv_register_monitor(struct rv_monitor *monitor, s=
truct rv_monitor *parent)
 		return -EINVAL;
 	}
=20
-	mutex_lock(&rv_interface_lock);
+	guard(mutex)(&rv_interface_lock);
=20
 	list_for_each_entry(r, &rv_monitors_list, list) {
 		if (strcmp(monitor->name, r->name) =3D=3D 0) {
 			pr_info("Monitor %s is already registered\n", monitor->name);
-			retval =3D -EEXIST;
-			goto out_unlock;
+			return -EEXIST;
 		}
 	}
=20
 	if (parent && rv_is_nested_monitor(parent)) {
 		pr_info("Parent monitor %s is already nested, cannot nest further\n",
 			parent->name);
-		retval =3D -EINVAL;
-		goto out_unlock;
+		return -EINVAL;
 	}
=20
 	monitor->parent =3D parent;
=20
 	retval =3D create_monitor_dir(monitor, parent);
 	if (retval)
-		goto out_unlock;
+		return retval;
=20
 	/* keep children close to the parent for easier visualisation */
 	if (parent)
@@ -813,9 +803,7 @@ int rv_register_monitor(struct rv_monitor *monitor, str=
uct rv_monitor *parent)
 	else
 		list_add_tail(&monitor->list, &rv_monitors_list);
=20
-out_unlock:
-	mutex_unlock(&rv_interface_lock);
-	return retval;
+	return 0;
 }
=20
 /**
@@ -826,13 +814,12 @@ int rv_register_monitor(struct rv_monitor *monitor, s=
truct rv_monitor *parent)
  */
 int rv_unregister_monitor(struct rv_monitor *monitor)
 {
-	mutex_lock(&rv_interface_lock);
+	guard(mutex)(&rv_interface_lock);
=20
 	rv_disable_monitor(monitor);
 	list_del(&monitor->list);
 	destroy_monitor_dir(monitor);
=20
-	mutex_unlock(&rv_interface_lock);
 	return 0;
 }
=20
diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
index d32859fec238..37d1d37a27a3 100644
--- a/kernel/trace/rv/rv_reactors.c
+++ b/kernel/trace/rv/rv_reactors.c
@@ -232,9 +232,7 @@ monitor_reactors_write(struct file *file, const char __=
user *user_buf,
 	seq_f =3D file->private_data;
 	mon =3D seq_f->private;
=20
-	mutex_lock(&rv_interface_lock);
-
-	retval =3D -EINVAL;
+	guard(mutex)(&rv_interface_lock);
=20
 	list_for_each_entry(reactor, &rv_reactors_list, list) {
 		if (strcmp(ptr, reactor->name) !=3D 0)
@@ -242,13 +240,10 @@ monitor_reactors_write(struct file *file, const char =
__user *user_buf,
=20
 		monitor_swap_reactors(mon, reactor);
=20
-		retval =3D count;
-		break;
+		return count;
 	}
=20
-	mutex_unlock(&rv_interface_lock);
-
-	return retval;
+	return -EINVAL;
 }
=20
 /*
@@ -309,18 +304,14 @@ static int __rv_register_reactor(struct rv_reactor *r=
eactor)
  */
 int rv_register_reactor(struct rv_reactor *reactor)
 {
-	int retval =3D 0;
-
 	if (strlen(reactor->name) >=3D MAX_RV_REACTOR_NAME_SIZE) {
 		pr_info("Reactor %s has a name longer than %d\n",
 			reactor->name, MAX_RV_MONITOR_NAME_SIZE);
 		return -EINVAL;
 	}
=20
-	mutex_lock(&rv_interface_lock);
-	retval =3D __rv_register_reactor(reactor);
-	mutex_unlock(&rv_interface_lock);
-	return retval;
+	guard(mutex)(&rv_interface_lock);
+	return __rv_register_reactor(reactor);
 }
=20
 /**
@@ -331,9 +322,8 @@ int rv_register_reactor(struct rv_reactor *reactor)
  */
 int rv_unregister_reactor(struct rv_reactor *reactor)
 {
-	mutex_lock(&rv_interface_lock);
+	guard(mutex)(&rv_interface_lock);
 	list_del(&reactor->list);
-	mutex_unlock(&rv_interface_lock);
 	return 0;
 }
=20
@@ -389,7 +379,7 @@ static ssize_t reacting_on_write_data(struct file *filp=
, const char __user *user
 	if (retval)
 		return retval;
=20
-	mutex_lock(&rv_interface_lock);
+	guard(mutex)(&rv_interface_lock);
=20
 	if (val)
 		turn_reacting_on();
@@ -402,8 +392,6 @@ static ssize_t reacting_on_write_data(struct file *filp=
, const char __user *user
 	 */
 	tracepoint_synchronize_unregister();
=20
-	mutex_unlock(&rv_interface_lock);
-
 	return count;
 }
=20
--=20
2.51.0

