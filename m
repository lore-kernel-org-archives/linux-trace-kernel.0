Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BDC1C943E;
	Thu, 22 Aug 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337411; cv=none; b=DqQvGH8Uzn2Zi32faDu4T8yNdJZedX1h1lbtwbkGj6vfQIn8VNlTKSqj2h6rRBB7rC52rlCRRp8n/UZomEw4jxmpXbCUwSIKHXBQVj8CCnYEsD4Tg+ZlwWa2NXGh4i0EMGY83xMT5APnFZ5uL2MZOc4EWaj3MY5wXSQPYL3cUMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337411; c=relaxed/simple;
	bh=GngTIWVjEdQQRJqZqgEd2ZI2YXyq+Zxg5qyDCTYyz2E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ccfcNMeZGMBA7Xts36+DWjf3jjq8ofIAzRFkAJxRpInFFmvuyasjuR2+dY2DZSASbsWw4V2vS5MoIeTG1v2RJm4OFp9IRuLKi6u5cWN5FPnG6lhelK5uisYUhmcRXfRPWF4YuTs/Q8aq1CcsVPtvMh+MNRZh6J7SJM7tppqVRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803ECC32782;
	Thu, 22 Aug 2024 14:36:50 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:37:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <20240822103721.1e2eb074@gandalf.local.home>
In-Reply-To: <20240822103202.130cf0df@gandalf.local.home>
References: <20240820130001.124768-1-tglozar@redhat.com>
	<20240821160316.02c03c44@gandalf.local.home>
	<CAP4=nvRTH5VxSO3VSDCospWcZagawTMs0L9J_kcKdGSkn7xT_Q@mail.gmail.com>
	<20240822103202.130cf0df@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 10:32:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Yeah, it seems there might be multiple bugs in the user workload
> > handling, the other NULL pointer dereference and refcount warning
> > above might be related (but I have yet to reproduce it on an upstream
> > kernel). I'm also going to look at the code and will post any findings
> > here.  
> 
> Yes that is the second bug and it is related to the that this addresses.

There's nothing protecting the clearing of the kthreads and calling
put_task_struct(). Here's the fix to the second bug:

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 66a871553d4a..53de719f35cb 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2106,7 +2106,9 @@ static int osnoise_cpu_init(unsigned int cpu)
  */
 static int osnoise_cpu_die(unsigned int cpu)
 {
+	mutex_lock(&interface_lock);
 	stop_kthread(cpu);
+	mutex_unlock(&interface_lock);
 	return 0;
 }
 
@@ -2239,8 +2241,11 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
 	 */
 	mutex_lock(&trace_types_lock);
 	running = osnoise_has_registered_instances();
-	if (running)
+	if (running) {
+		mutex_lock(&interface_lock);
 		stop_per_cpu_kthreads();
+		mutex_unlock(&interface_lock);
+	}
 
 	mutex_lock(&interface_lock);
 	/*
@@ -2355,8 +2360,11 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	 */
 	mutex_lock(&trace_types_lock);
 	running = osnoise_has_registered_instances();
-	if (running)
+	if (running) {
+		mutex_lock(&interface_lock);
 		stop_per_cpu_kthreads();
+		mutex_unlock(&interface_lock);
+	}
 
 	mutex_lock(&interface_lock);
 	/*
@@ -2951,7 +2960,9 @@ static void osnoise_workload_stop(void)
 	 */
 	barrier();
 
+	mutex_lock(&interface_lock);
 	stop_per_cpu_kthreads();
+	mutex_unlock(&interface_lock);
 
 	osnoise_unhook_events();
 }


With both of these fixes, the bug goes away.

I'll add this fix (after enabling lockdep and making sure I didn't screw up
the locking). Can you resend this patch with just not calling cancel if
kthread is NULL. No need to exit out early. I still like to make sure the
clean up happens, and not assume it will already be done.

-- Steve
