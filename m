Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA891E2614;
	Wed, 10 Jun 2026 00:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781052696; cv=none; b=NFH7F7LLh6htMNhjCzEAGeYcOS3qvgDb9AZvbdez1dAdHzFW14udZxQFm15+Fx4k2Y51P2h88Y5lPl6bA4rz/5gyYzckxVb+euFmT0/UxikPonKlsWBonTRSd6/wrmXMV/Q9uoXzdquwibGMuPrBdh26MH8Ss5sQ2Ljyn4Z9Yww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781052696; c=relaxed/simple;
	bh=ux+Vj4a9RVv/T7RkTGA4Fc5HiUsaYkg0bx3SGujbAtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vEdeal4gP4D3wXje58zD1j4uu2swQUmTzfGFU6k8dTEUtf/PrKuNfQgbun1T2fn7Brglgis/HvRnQHPWx4YSsfrw0Ie/LQhlI2Sf5IrEBIvlLu09jewAbCRkVPGaX9FGJ+iN54eNGJZ+EJIFEiqbiLXh0mY3QbLGTEnOFksRrys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8xUuMDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8xUuMDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 691671F00893;
	Wed, 10 Jun 2026 00:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781052695;
	bh=Yt6LFFFvByJCF1OwfjjRamlOXs3Ul6OrpTvVnwrf35k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8xUuMDF2XiPeUPiQpPpWkRb4kSreC7NyLWXnK9puuyoz059YpVyp+umom8VHfZDC
	 TdLEsLfQ6SHF3ZbrKcvaSY/YuxXBK23kNBD3p13iCx/XHfDeUiWb61D+K3QgCqDRI8
	 1+ISkeWURUAeWOJQRAQU8BulvY3UvmMyXwcXo0tyK5V19uRFi900rHAauZiHWqheEN
	 FzehgTOcahIZssM7lrUtasPSLGoo1LCBVbP9WSSNBjxp6Lt6uMxwaI4Cw1a/jDDEWL
	 J1lHblRXS78B3FW0ouEHBwhCnun1wVVX1fNOGCEmelVTBsIZuYvT4Yica0JVcn9HFO
	 4xakgEdrE+rNw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 1/7] tracing/events: Fix to check the simple_tsk_fn creation
Date: Wed, 10 Jun 2026 09:51:31 +0900
Message-ID: <178105269138.21760.8826408959205173784.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178105268094.21760.13668249930524377840.stgit@devnote2>
References: <178105268094.21760.13668249930524377840.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko pointed that this sample code does not correctly handle the
failure of thread creation because kthread_run() can return -errno.

This removes the counter-based thread creation/stops but just
checking the simple_tsk_fn is correctly initialized (created) or not.

Link: https://sashiko.dev/#/patchset/178092865666.163648.10457567771536160909.stgit%40devnote2

Fixes: 9cfe06f8cd5c ("tracing/events: add trace-events-sample")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 samples/trace_events/trace-events-sample.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/samples/trace_events/trace-events-sample.c b/samples/trace_events/trace-events-sample.c
index ecc7db237f2e..b61766864b54 100644
--- a/samples/trace_events/trace-events-sample.c
+++ b/samples/trace_events/trace-events-sample.c
@@ -92,12 +92,11 @@ static int simple_thread_fn(void *arg)
 }
 
 static DEFINE_MUTEX(thread_mutex);
-static int simple_thread_cnt;
 
 int foo_bar_reg(void)
 {
 	mutex_lock(&thread_mutex);
-	if (simple_thread_cnt++)
+	if (!IS_ERR_OR_NULL(simple_tsk_fn))
 		goto out;
 
 	pr_info("Starting thread for foo_bar_fn\n");
@@ -115,14 +114,11 @@ int foo_bar_reg(void)
 void foo_bar_unreg(void)
 {
 	mutex_lock(&thread_mutex);
-	if (--simple_thread_cnt)
-		goto out;
-
-	pr_info("Killing thread for foo_bar_fn\n");
-	if (simple_tsk_fn)
+	if (!IS_ERR_OR_NULL(simple_tsk_fn)) {
+		pr_info("Killing thread for foo_bar_fn\n");
 		kthread_stop(simple_tsk_fn);
-	simple_tsk_fn = NULL;
- out:
+		simple_tsk_fn = NULL;
+	}
 	mutex_unlock(&thread_mutex);
 }
 
@@ -139,7 +135,7 @@ static void __exit trace_event_exit(void)
 {
 	kthread_stop(simple_tsk);
 	mutex_lock(&thread_mutex);
-	if (simple_tsk_fn)
+	if (!IS_ERR_OR_NULL(simple_tsk_fn))
 		kthread_stop(simple_tsk_fn);
 	simple_tsk_fn = NULL;
 	mutex_unlock(&thread_mutex);

