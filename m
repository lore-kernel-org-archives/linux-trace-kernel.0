Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E7200BA1
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498746; cv=none; b=CFFjnxp/VtM84wsnmk7g4i30tfXm+DD3dSRoKl2BnVqjUK4geuk5OlI1ABbu8tzDztN1OnuWNcxaPtXL+YN91n7X7NVqkLY/UJL/xGm8Rj2rLInkz4DBj1IofEg8zT9uX+xNk5G0vDSwbJyfZMYlA4vaq/ctfqlTr4GRDd2+RnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498746; c=relaxed/simple;
	bh=zT74DeXMaKIG/3fbrwAf0icnHo/7anzc8q2SBfDJcnY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RrfMPWoZDj1WOXcEf8KfrSaayHcmEh7fkrduwibtOzji0iQzoxmOBEHFxo6yXt+YlxbNEGMSXxVTFIRwo+WpBrpXr1jDPauwj6VkrkD7/XRXnvIx/7Zen+YkQR2x6NGZ33/RTKiwXAifnahnHS2lFX5W24WC0HTxpoOq5JbUeRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=232FwJFj; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="232FwJFj"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3f3787688b0so1360120f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498743; x=1760103543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5ChM7xYZbIcJhJhkgKHyrsGnApdkThlCNMDyu2wV38=;
        b=232FwJFjEvhUbHrAWt2593KmQDUhtg1IAhHRJBrhAGoC9pcyuE5s2vZrVWkRS/owwn
         6auLscGPF9mhFkF6LHISHei3rBJMQnCJ3+VR7TnmTHxqIrxxQsqSEm6pctEEjKB0unIL
         H18imi6tTIwqwtPt6bsTLtLaNk3mhd5kR7PbfVyFnHE7pIO65dAzbSHUkYB6RtG0oBl9
         SHTV/KbRdV8c99L++UIqONrLgeBNa7FUmMGPs+JNKtqd23ezH1U5Ni9Q1RSR4gUJO6tO
         hoZeU1r4U8WdpCZbwFXaKxlXWUvJpU/tJZc3vWl+2pF8IU5JEc5lFQ675+feDtvYPqNu
         ACDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498743; x=1760103543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d5ChM7xYZbIcJhJhkgKHyrsGnApdkThlCNMDyu2wV38=;
        b=f3Usd2YLtTFkj81r9DWNpYiMHuw7U+WxPglhNGx5nQHbTFWOhUjE1GjCXKH0Hlqn1q
         H5KYn6kB7WbjUsYWMPCoBNo8Nl0vPPNQU86DLpxqFsvhliIVMa6w5tKqJU21Pr1qwrg8
         xZsAZeo0evpsweoKHQo1QFuoc/F4UE0+UkXPqxhq4cWaKX/kWW66jFZGf+pKAev8sP8d
         aQxc8TtemIh32f/aWGvT4v73TiPobpxDRAKgCeDNQ6QaJDJoxXUABn6hASLDvy5+iJqF
         zxKTBeuY7LhSjL0jjrBTTvbWNqERP7BX84GiY8Ypagtf83bgnuv35164alDBDzUgo3Ji
         nFMg==
X-Forwarded-Encrypted: i=1; AJvYcCXVSXcr+Y6K1yHWx3z6aza9GzewxRGKevzM6F/O/sNSP+wMEOdLd9lmDE9Fb83GcR/6eyCn0CSFtSq1+C6KyuuQ8Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyccjQHaE84izuRnWeGv+et6zZIGb1WA2lkbugE3VMS+2rQ149N
	KVi2MlWTTgdGMc34N1u8TCUIHyVp/znZPvTsSPHWmnEWLkaij+y/iypcCmZvo6vfi9D8zYSdYy2
	7aapsH9nQMq1vRhiecb+NcQ==
X-Google-Smtp-Source: AGHT+IGEKVUnoX9TtZqLBT0f/tik6zhh9b91Brx6pOn/31k484u2FIJbEyDbYJWN7r7k8vY/aCKrmMghs8AZJmNC
X-Received: from wmcn6.prod.google.com ([2002:a05:600c:c0c6:b0:45d:d522:48a9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3d90:b0:46e:3d5a:d15d with SMTP id 5b1f17b1804b1-46e7114dea1mr21903175e9.26.1759498743037;
 Fri, 03 Oct 2025 06:39:03 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:03 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-7-vdonnefort@google.com>
Subject: [PATCH v7 06/28] tracing: Add reset to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow to reset the trace remote buffer by writing to the Tracefs "trace"
file. This is similar to the regular Tracefs interface.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
index feb3433c2128..55754ef78104 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -18,6 +18,8 @@
  *			remote to allow writing.
  * @swap_reader_page:	Called when Tracefs consumes a new page from a
  *			ring-buffer. It is expected from the remote to isolate a
+ * @reset:		Called on `echo 0 > trace`. It is expected from the
+ *			remote to reset all ring-buffer pages.
  *			new reader-page from the @cpu ring-buffer.
  */
 struct trace_remote_callbacks {
@@ -25,6 +27,7 @@ struct trace_remote_callbacks {
 	void	(*unload_trace_buffer)(struct trace_buffer_desc *desc, void *priv);
 	int	(*enable_tracing)(bool enable, void *priv);
 	int	(*swap_reader_page)(unsigned int cpu, void *priv);
+	int	(*reset)(unsigned int cpu, void *priv);
 };
 
 /**
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 3d76a4d7d5f5..abf83ff75df5 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -63,6 +63,7 @@ static int trace_remote_load(struct trace_remote *remote)
 	rb_remote->desc = remote->trace_buffer_desc;
 	rb_remote->swap_reader_page = remote->cbs->swap_reader_page;
 	rb_remote->priv = remote->priv;
+	rb_remote->reset = remote->cbs->reset;
 	remote->trace_buffer = ring_buffer_alloc_remote(rb_remote);
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
@@ -411,6 +427,26 @@ static const struct file_operations trace_pipe_fops = {
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
@@ -441,7 +477,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	    !trace_create_file("buffer_size_kb", TRACEFS_MODE_WRITE, remote_d, remote,
 			       &buffer_size_kb_fops) ||
 	    !trace_create_file("trace_pipe", TRACEFS_MODE_READ, remote_d, remote,
-			       &trace_pipe_fops))
+			       &trace_pipe_fops) ||
+	    !trace_create_file("trace", TRACEFS_MODE_WRITE, remote_d, remote,
+			       &trace_fops))
 		goto err;
 
 	percpu_d = tracefs_create_dir("per_cpu", remote_d);
@@ -463,7 +501,9 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 		}
 
 		if (!trace_create_cpu_file("trace_pipe", TRACEFS_MODE_READ, cpu_d, remote, cpu,
-					   &trace_pipe_fops))
+					   &trace_pipe_fops) ||
+		    !trace_create_cpu_file("trace", TRACEFS_MODE_WRITE, cpu_d, remote, cpu,
+					   &trace_fops))
 			goto err;
 	}
 
-- 
2.51.0.618.g983fd99d29-goog

