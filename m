Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D449E2EAB73
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764068; cv=none; b=mwC3UHVZYMnlFdx2jWBMgDRoNLG4WaZndi4+AXgUgorY8Um7oSYl828JmYxl+H7z5oED35IX2C7dvpwyWk0dr2jOY0WUrvmlRGkZta/WDoM6FEHQNdj97WXLDSHuQJZO5BjncbCc5U3DpmUbCW+E7IXL7nme9VzWJMbSGHgxyIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764068; c=relaxed/simple;
	bh=9xXiwmLgPnWsrqQg77YhaqS7pkQvVJu7dXOCGMAPWTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ulTO47wp4mDXxZfsOJ84ypTxHjYJRa0NcLTzlCHXX2ywMQRS9oGxAE1C9Zk202vxG+Y90ypw5mSefzWD7eMRDyKyDC/9BL7hA0DaKh+ooWPYumk4Qg0oupNVwt8WsjZi6oS+CxPQQca/aNAnpHkyGRtexeyfvRtV8w8cCq81gtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykyxvj0n; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykyxvj0n"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45a1b0d0feaso4420175e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755764065; x=1756368865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJcUPeC8ocB5+j9OXdNiMliYvjrJgSIIHWHJsqMgtN8=;
        b=ykyxvj0nLkPJyi5XSwTXTvkOmygp9nYoNT6VBFoip+3M3MId6vUNlGL3nmVpHoX/YE
         A/KDhXbajmlwnEeSwpeW6spkbbbzYnIOeCNVuS7vQ+JSklGFKxTVVkvLwzLdAuUgsS+C
         e26/b7Bx+Hz7fOq1GFO3vRSZ/dpKReYv+0Gl0aVoUMv7TO+GkkY3Z2TbLs87Z0E+YfhL
         c6OA4I0wPXys1CKtCaaK5P6RFpItDHipmBNdFguEGobo467psfJQ95z3D3UQjO/ZpxX/
         J8JTjonyFh7cAdnv3SjLaG//Twg/gDfcYOjBE//dF/Zfv71MYJ+r1//ztA1jVhRNXVKd
         3G+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755764065; x=1756368865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJcUPeC8ocB5+j9OXdNiMliYvjrJgSIIHWHJsqMgtN8=;
        b=J7d7Yvz8ItbmalKUg4JwTdeqE91i3kdyCkPySBEcA2lZcQlB+hFbr+/S2IlUWpRH4y
         ue4U37h4mkBDi4L3bScpLm7FR7gDzxIZ80PKcIs3Zv0cQW4f9s9UbY4LaP29BNKHMQcC
         pmQgqGAO5jwc3F+ww7Xv3XnHYviMV6LCr+dhtS16wI343C4szSAjHc8i0kgSBONNkgB7
         v3RlmzmB59fEEVFhPRXSR2jzYIvBdc/z9oX96fGjyRUNHO8uD5a0HeabChof1+Kdrjns
         aKylSx9ec5n2OJDHlTNI8CAzVxfn+HY+5GASIvG1Nlfkr7T1kJSlUoSp+xyj4qom+d0O
         DlFw==
X-Forwarded-Encrypted: i=1; AJvYcCXhfrZSXXmvgBlYK5ga/PSh62As+SC5LuiICkRYMYi1dait8gdxz/MCxjGdb2NDEnqO8Jk8vpuIwL7kpIulpJH/sSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kscPBdSVxYlzQg3Lr83+TnwTxOh6iOHxFt3LsuhT9/GjN2kT
	LtOUj+j5SSHIrl8ke43ukmlal5xzIjIj/NkrDJcrviYMq8I459YmMA1afYbYrMbACqgLLy0vtGk
	O6r8fnrFIQeWOfTG3EaV8Lw==
X-Google-Smtp-Source: AGHT+IHxHGYd1KeGVGM3iasiEuHwtuNNyEruew1KNtvROKmeBVTKi8SlkdS/376itCy6PY0wJZqfEhcdRnlQxCNH
X-Received: from wmbez8.prod.google.com ([2002:a05:600c:83c8:b0:459:e17c:3572])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f0e:b0:45b:47e1:ef76 with SMTP id 5b1f17b1804b1-45b4d86c5d6mr9909145e9.37.1755764065317;
 Thu, 21 Aug 2025 01:14:25 -0700 (PDT)
Date: Thu, 21 Aug 2025 09:13:52 +0100
In-Reply-To: <20250821081412.1008261-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821081412.1008261-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821081412.1008261-5-vdonnefort@google.com>
Subject: [PATCH v6 04/24] tracing: Add reset to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

For standard trace instance, "trace" files allow to do non-consuming
read of the ring-buffers. This is however not applicable to ring-buffer
remotes due to the lack of support in the meta-page. Nonetheless this
file is still useful to reset a ring-buffer so let's add a write-only
version.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
index de043a6f2fe0..1aa99da3c96a 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -11,6 +11,7 @@ struct trace_remote_callbacks {
 	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
 	int	(*enable_tracing)(bool enable, void *priv);
 	int	(*swap_reader_page)(unsigned int cpu, void *priv);
+	int	(*reset)(unsigned int cpu, void *priv);
 };
 
 int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 1a4786b7970c..18b2930186cc 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -63,6 +63,7 @@ static int trace_remote_load(struct trace_remote *remote)
 	rb_remote->desc = remote->trace_buffer_desc;
 	rb_remote->swap_reader_page = remote->cbs->swap_reader_page;
 	rb_remote->priv = remote->priv;
+	rb_remote->reset = remote->cbs->reset;
 	remote->trace_buffer = ring_buffer_remote(rb_remote);
 	if (!remote->trace_buffer) {
 		remote->cbs->unload_trace_buffer(remote->trace_buffer_desc, remote->priv);
@@ -136,6 +137,21 @@ static int trace_remote_disable_tracing(struct trace_remote *remote)
 	return 0;
 }
 
+static void trace_remote_reset(struct trace_remote *remote, int cpu)
+{
+	lockdep_assert_held(&remote->lock);
+
+	if (!trace_remote_loaded(remote))
+		return;
+
+	if (cpu == RING_BUFFER_ALL_CPUS)
+		ring_buffer_reset(remote->trace_buffer);
+	else
+		ring_buffer_reset_cpu(remote->trace_buffer, cpu);
+
+	trace_remote_try_unload(remote);
+}
+
 static ssize_t
 tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -370,6 +386,26 @@ static const struct file_operations trace_pipe_fops = {
 	.release	= trace_pipe_release,
 };
 
+static ssize_t trace_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct inode *inode = file_inode(filp);
+	struct trace_remote *remote = inode->i_private;
+	int cpu = RING_BUFFER_ALL_CPUS;
+
+	if (inode->i_cdev)
+		cpu = (long)inode->i_cdev - 1;
+
+	guard(mutex)(&remote->lock);
+
+	trace_remote_reset(remote, cpu);
+
+	return cnt;
+}
+
+static const struct file_operations trace_fops = {
+	.write		= trace_write,
+};
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d;
@@ -400,7 +436,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	    !trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
 			       &buffer_size_kb_fops) ||
 	    !trace_create_file("trace_pipe", TRACEFS_MODE_READ, remote_d, remote,
-			       &trace_pipe_fops))
+			       &trace_pipe_fops) ||
+	    !trace_create_file("trace", 0200, remote_d, remote,
+			       &trace_fops))
 		goto err;
 
 	percpu_d = tracefs_create_dir("per_cpu", remote_d);
@@ -422,7 +460,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 		}
 
 		if (!trace_create_cpu_file("trace_pipe", TRACEFS_MODE_READ, cpu_d, remote, cpu,
-					   &trace_pipe_fops))
+					   &trace_pipe_fops) ||
+		    !trace_create_cpu_file("trace", 0200, cpu_d, remote, cpu,
+					   &trace_fops))
 			goto err;
 	}
 
-- 
2.51.0.rc2.233.g662b1ed5c5-goog

