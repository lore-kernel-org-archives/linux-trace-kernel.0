Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1F35028D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389706; cv=none; b=EkUv0t9KL4Umz5AboW8Hdqm2AQYJzKlT5f0KIrQEKPCZ9aa/WCDN28W8M8s+8BliXEnnqSPeiJAuk5Nvw2T/ldIeY0QYHdZvFuXCpULp5+XTz/ZHvX7hp3qHS5ufW57VYVtS+PO2dKkViYpMeRWUWYIonq9hLCNTslYoTUmsGfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389706; c=relaxed/simple;
	bh=5UaTixk5+x4U0NcM9cE2zcQMjse+41inFOmMjIWiOss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=eLAay1ZUf6pxv/eHZhd/CBl1jA0aSXvWNtDgmBVtutNzeEnDy0le+eVelKgPkjVMhOicdq49PPITmAcmfdXcrc9K/7smbIqVq9pvgxsoKHwVM+7+ekcjVlSziAyU8yDcVT3T4hIvuAu3sVuEaffx+QQjcXJ1nVehCjbjTU1mTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PQNLrbSq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQNLrbSq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782389701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K1GhLa/POT1Bj/adjblvL4JtfB6Z3zwGMXow9p+oO2k=;
	b=PQNLrbSqNeYM6VHVnrRT4zEY52L/9k8lxw4FGawP04INVkTjkrfcpOiY0n2uni9++2UjXp
	5L24WNlR24d43Adz0ow0pCriOfQfmTSI0d5MgtdTs/QVYNESWy5IytXzS3XkLRB1agQyBv
	GhsSweQZW95mSKLundt1QATWucEy8gY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-fP7j-uNuPhy1FPMATgGuMQ-1; Thu,
 25 Jun 2026 08:14:58 -0400
X-MC-Unique: fP7j-uNuPhy1FPMATgGuMQ-1
X-Mimecast-MFC-AGG-ID: fP7j-uNuPhy1FPMATgGuMQ_1782389697
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D09811953971;
	Thu, 25 Jun 2026 12:14:56 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E96030002E0;
	Thu, 25 Jun 2026 12:14:54 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 03/17] verification/rvgen: Improve rv_dir discovery in RVGenerator
Date: Thu, 25 Jun 2026 14:14:25 +0200
Message-ID: <20260625121440.116317-4-gmonaco@redhat.com>
In-Reply-To: <20260625121440.116317-1-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: t6RPR2yddu6rQMlg44e9GeqBvIdwoZ4ntG_FcXZXR10_1782389697
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The RVGenerator class can find the RV directory (kernel/trace/rv) in the
kernel tree to do some auto patching. This works by assuming PWD is
either the kernel tree or tools/verification, which isn't always the
case (e.g. when running from selftests).

Make discovery more robust by relying on the absolute path of the
current script and traversing backwards the right number of times.
This should work from any location if rvgen is in the kernel tree.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/generator.py | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 56f3bd8db8..b7ab0c70d4 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -25,13 +25,10 @@ class RVGenerator:
             self.__fill_rv_kernel_dir()
 
     def __fill_rv_kernel_dir(self):
-
-        # first try if we are running in the kernel tree root
-        if os.path.exists(self.rv_dir):
-            return
-
-        # offset if we are running inside the kernel tree from verification/dot2
-        kernel_path = os.path.join("../..", self.rv_dir)
+        # find the kernel tree root relative to this file's location
+        current_dir = os.path.dirname(os.path.abspath(__file__))
+        kernel_root = os.path.abspath(os.path.join(current_dir, "../../../.."))
+        kernel_path = os.path.join(kernel_root, self.rv_dir)
 
         if os.path.exists(kernel_path):
             self.rv_dir = kernel_path
-- 
2.54.0

