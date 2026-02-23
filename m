Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE7219ABC6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863958; cv=none; b=DNfREBZat7SjrqIBDLH/o81YpWNJkj+3OVVjMVvjPeSMZMR1yS++HE5rFc494lw9ewa6QdjhHLCHSYUj8DCgOBbgar09tWehh5PML6B+TSETXf0GppVyvG2fIvq0gIzjpbn4eGk3BYybgjYzAFZz2CWsgv3IHUfCimlSxCba6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863958; c=relaxed/simple;
	bh=ktZs/oReU8TuKEe4kJTZBKFlXLAtDnmWnm7XzJL2g8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=Wd3cp8XelJzvaJr3RcROOzSl9ubtxNThQ+GdT89f87BwKwO9svNa+klhGRcOL4LTlUdALfS136fJ7QmZ+SK+dwDmaGC+hmiRzowB9ZEJZczZDylBKyQBXvTgVy8TyFoqN/KNFjtoYgZZCsH5lbHop/EzQu6lmzHeWL3DcX/Xmfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O54Gvc8Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O54Gvc8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771863955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhMtnK5rUYRMnC5b1qkWK5XScEQOjsKc5cOJAnZqE9U=;
	b=O54Gvc8ZDdOueVsZtbnyt3NApMYD2KsR5uJ17hxafnO6Om2bSKyQDMuTUauLlkQ6hopAWk
	Mikh+qc4WKHyHpqohzhYfWW0HFg8QYWWigQEvooMPpfyO3daznASwXTySfO/GtVP67NjL/
	6njnm9xLMNnIWOZC4xLENc0ulCzhJtU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-UP2JIAwvP2O6dMN-9VRiiA-1; Mon,
 23 Feb 2026 11:25:51 -0500
X-MC-Unique: UP2JIAwvP2O6dMN-9VRiiA-1
X-Mimecast-MFC-AGG-ID: UP2JIAwvP2O6dMN-9VRiiA_1771863950
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 730881956052;
	Mon, 23 Feb 2026 16:25:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.88.94])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E5BC180066A;
	Mon, 23 Feb 2026 16:25:48 +0000 (UTC)
From: Wander Lairson Costa <wander@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org (open list:RUNTIME VERIFICATION (RV)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 02/19] rv/rvgen: remove bare except clauses in generator
Date: Mon, 23 Feb 2026 13:17:45 -0300
Message-ID: <20260223162407.147003-3-wander@redhat.com>
In-Reply-To: <20260223162407.147003-1-wander@redhat.com>
References: <20260223162407.147003-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 8zkB4ZfeHi5eXZzlqutyJOvdwEXO1P_RzXxh76T6XGE_1771863950
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

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
Reviewed-by: Nam Cao <namcao@linutronix.de>
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/verification/rvgen/rvgen/generator.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 571093a92bdc8..a2391a4c21ed6 100644
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
2.53.0

