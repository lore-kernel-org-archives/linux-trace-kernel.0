Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AE2F7444
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768856372; cv=none; b=W+aMkNJyiae5qQ+JIfOL7663oNb8oSBNabqwHI/+0PZfuOdjtILboGaDkbYoYd5a8yaofvHj1Q6OUQxuE4VWqG1GcGxUXv7N6dXVBCjsfXuMQ4PdYwSN/B/4BxqQYvUh9Nmhxv1wfo2bGxcGtnTDDAdTDvDIC+LeWoyWUYxwETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768856372; c=relaxed/simple;
	bh=40ZPEGMN0sob0b5iK6GGaA2xvJRMYv29Ms5s8ro22F0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMcq7TdyKrBVJTSl2d6kP3D+mlgu09W4gnCHj0WPSKEUHHgIjQw6vMNaN6mFeHdf9YqJACr4EfyFp8ZczWRl5EWscQXQHXoISXXUipyjasaxZiUTwrwTgrDx7hU3UcZvco6H5bVSN0Y/+tjWxKJ+zcS7KhZXFAVJx1A3ybKk4tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeKaeK+q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeKaeK+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768856370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfhqJrr+RjCAEt1YCTrD+2mUFPkkTKYcoUT83FMXRFs=;
	b=PeKaeK+q0kO8tFkMo3RxA9XfMtcQssurorX0Ae9H+HSGEQViPkPPnIhgJV52SLVASwyeUR
	xqnsRMQfNhGK8qSKDW2/kaxrMb37zM32YQYy6S+tZ8IeToRSwNM3/YQqR5VOFSwXUU4WQN
	EAaZKSTO2JR/mHnIOCeF9HJn4NT1kPw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-wDgUvgwfMI2Al32Fs_H9AQ-1; Mon,
 19 Jan 2026 15:59:26 -0500
X-MC-Unique: wDgUvgwfMI2Al32Fs_H9AQ-1
X-Mimecast-MFC-AGG-ID: wDgUvgwfMI2Al32Fs_H9AQ_1768856365
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0A7019560A1;
	Mon, 19 Jan 2026 20:59:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E4E019560AB;
	Mon, 19 Jan 2026 20:59:22 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV))
Subject: [PATCH 02/26] rv/rvgen: remove bare except clauses in generator
Date: Mon, 19 Jan 2026 17:45:38 -0300
Message-ID: <20260119205601.105821-3-wander@redhat.com>
In-Reply-To: <20260119205601.105821-1-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Remove bare except clauses from the generator module that were
catching all exceptions including KeyboardInterrupt and SystemExit.
This follows the same exception handling improvements made in the
previous AutomataError commit and addresses PEP 8 violations.

The bare except clause in __create_directory was silently catching
and ignoring all errors after printing a message, which could mask
serious issues. For __write_file, the bare except created a critical
bug where the file variable could remain undefined if open() failed,
causing a NameError when attempting to write to or close the file.

These methods now let OSError propagate naturally, allowing callers
to handle file system errors appropriately. This provides clearer
error reporting and allows Python's exception handling to show
complete stack traces with proper error types and locations.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
---
 tools/verification/rvgen/rvgen/generator.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index a7bee6b1ea70c..af1662e2c20a7 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -198,17 +198,10 @@ obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o
             os.mkdir(path)
         except FileExistsError:
             return
-        except:
-            print("Fail creating the output dir: %s" % self.name)
 
     def __write_file(self, file_name, content):
-        try:
-            file = open(file_name, 'w')
-        except:
-            print("Fail writing to file: %s" % file_name)
-
+        file = open(file_name, 'w')
         file.write(content)
-
         file.close()
 
     def _create_file(self, file_name, content):
-- 
2.52.0

